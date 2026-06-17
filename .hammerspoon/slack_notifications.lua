-- App notifications as a center-of-screen overlay (Slack by default).
--
-- macOS notification banners are owned by com.apple.notificationcenterui and
-- expose no source bundle id, but the banner group carries:
--   * AXSubrole    = "AXNotificationCenterBanner"
--   * AXDescription = "<AppName>, <title>, <subtitle>, <body>"
--   * child AXStaticText with AXIdentifier "title" / "subtitle" / "body"
-- The app name is the text before the first comma, which is identical on every
-- Mac regardless of workspace/account -- so matching by app name is portable
-- and needs no per-machine configuration.
--
-- Requires Accessibility permission for Hammerspoon (already needed by the key
-- remaps in init.lua). Capture is read-only AX observation; no Full Disk Access.

local M = {}

M.config = {
  apps = { "Slack" },
  duration = 6,
  maxLineChars = 40,
  maxLines = 4,
  iconMap = os.getenv("HOME") .. "/.config/sketchybar/cache/icon_map.sh",
  iconFont = "sketchybar-app-font",
  iconSize = 20,
  iconColor = { red = 0.62, green = 0.74, blue = 1.0, alpha = 1.0 },
  debug = false,
}

local function dbg(...)
  if not M.config.debug then return end
  local parts = {}
  for _, v in ipairs(table.pack(...)) do parts[#parts + 1] = tostring(v) end
  local f = io.open("/tmp/slacknotif.log", "a")
  if f then
    f:write(os.date("%H:%M:%S "), table.concat(parts, " "), "\n")
    f:close()
  end
end

local NC_BUNDLE = "com.apple.notificationcenterui"
local BANNER_SUBROLE = "AXNotificationCenterBanner"
local MAX_DEPTH = 16

M.observers = {}
M.appWatcher = nil

local lastKey = nil
local lastTime = 0
local glyphCache = {}

local function axValue(element, name)
  local ok, value = pcall(function() return element:attributeValue(name) end)
  if ok then return value end
  return nil
end

local function findBanner(element, depth)
  if element == nil or depth > MAX_DEPTH then return nil end
  local subrole = axValue(element, "AXSubrole")
  if subrole and tostring(subrole):find("NotificationCenter") then
    return element
  end
  local children = axValue(element, "AXChildren")
  if type(children) == "table" then
    for _, child in ipairs(children) do
      local found = findBanner(child, depth + 1)
      if found then return found end
    end
  end
  return nil
end

local function appNameFromDescription(description)
  if not description then return nil end
  local desc = tostring(description)
  return desc:match("^(.-),") or desc
end

local function fieldsByIdentifier(element, depth, out)
  out = out or {}
  if element == nil or depth > MAX_DEPTH then return out end
  if axValue(element, "AXRole") == "AXStaticText" then
    local id = axValue(element, "AXIdentifier")
    local value = axValue(element, "AXValue")
    if id and value and out[id] == nil then
      out[id] = value
    end
  end
  local children = axValue(element, "AXChildren")
  if type(children) == "table" then
    for _, child in ipairs(children) do
      fieldsByIdentifier(child, depth + 1, out)
    end
  end
  return out
end

local function appMatches(name)
  if not name then return false end
  for _, app in ipairs(M.config.apps) do
    if name == app then return true end
  end
  return false
end

local function shellQuote(text)
  return "'" .. tostring(text):gsub("'", "'\\''") .. "'"
end

local function glyphForApp(name)
  if glyphCache[name] ~= nil then return glyphCache[name] end
  local result = ""
  if M.config.iconMap and M.config.iconMap ~= "" then
    local cmd = "source " .. shellQuote(M.config.iconMap) .. " 2>/dev/null; "
      .. "__icon_map " .. shellQuote(name) .. '; printf %s "$icon_result"'
    local ok, out = pcall(function() return hs.execute(cmd) end)
    if ok and type(out) == "string" then
      result = out:gsub("%s+$", "")
    end
  end
  glyphCache[name] = result
  dbg("glyph:", name, "->", result == "" and "(none)" or result)
  return result
end

local function tidy(text)
  return (text:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function toChars(text)
  local ok, chars = pcall(function()
    local out = {}
    for _, code in utf8.codes(text) do
      out[#out + 1] = utf8.char(code)
    end
    return out
  end)
  if ok then return chars end
  local out = {}
  for i = 1, #text do out[#out + 1] = text:sub(i, i) end
  return out
end

local function clen(text)
  return utf8.len(text) or #text
end

local function truncateLine(text, width)
  if clen(text) <= width then return text end
  local chars = toChars(text)
  return table.concat(chars, "", 1, width - 1) .. "…"
end

local function normalizeMessage(text)
  text = text:gsub("\r\n", "\n"):gsub("\r", "\n")
  text = text:gsub("[ \t]+", " ")
  text = text:gsub("[ \t]*\n[ \t]*", "\n")
  text = text:gsub("\n\n+", "\n")
  return (text:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function wrapMessage(text)
  local width = M.config.maxLineChars
  local lines = {}
  for paragraph in (normalizeMessage(text) .. "\n"):gmatch("(.-)\n") do
    local current = ""
    for word in paragraph:gmatch("%S+") do
      local pieces = {}
      if clen(word) > width then
        local chars = toChars(word)
        for i = 1, #chars, width do
          pieces[#pieces + 1] = table.concat(chars, "", i, math.min(i + width - 1, #chars))
        end
      else
        pieces = { word }
      end
      for _, piece in ipairs(pieces) do
        if current == "" then
          current = piece
        elseif clen(current) + 1 + clen(piece) <= width then
          current = current .. " " .. piece
        else
          lines[#lines + 1] = current
          current = piece
        end
      end
    end
    if current ~= "" then lines[#lines + 1] = current end
  end

  local maxLines = M.config.maxLines
  if #lines > maxLines then
    local kept = {}
    for i = 1, maxLines do kept[i] = lines[i] end
    kept[maxLines] = truncateLine(kept[maxLines] .. "…", width)
    lines = kept
  end
  return table.concat(lines, "\n")
end

local function styledText(glyph, header, body)
  local hasGlyph = glyph ~= nil and glyph ~= ""
  local ok, styled = pcall(function()
    local iconStyle = {
      font = { name = M.config.iconFont, size = M.config.iconSize },
      color = M.config.iconColor,
    }
    local headerStyle = {
      font = { name = ".AppleSystemUIFontBold", size = 15 },
      color = { red = 0.62, green = 0.74, blue = 1.0, alpha = 1.0 },
    }
    local bodyStyle = {
      font = { name = ".AppleSystemUIFont", size = 19 },
      color = { white = 1.0, alpha = 1.0 },
    }
    local headerLine = hs.styledtext.new(header .. "\n", headerStyle)
    local bodyText = hs.styledtext.new(body, bodyStyle)
    if hasGlyph then
      return hs.styledtext.new(glyph .. "  ", iconStyle) .. headerLine .. bodyText
    end
    return headerLine .. bodyText
  end)
  if ok then return styled end
  local prefix = hasGlyph and (glyph .. "  ") or ""
  return prefix .. header .. "\n" .. body
end

function M.show(glyph, header, body)
  dbg("show:", glyph, "|", header, "|", body)
  local style = {
    fillColor = { red = 0.09, green = 0.09, blue = 0.11, alpha = 0.97 },
    strokeColor = { white = 1.0, alpha = 0.20 },
    strokeWidth = 1,
    radius = 18,
    textColor = { white = 1.0 },
    textSize = 19,
    padding = 22,
    atScreenEdge = 1,
    fadeInDuration = 0.12,
    fadeOutDuration = 0.35,
  }
  local screen = hs.mouse.getCurrentScreen() or hs.screen.mainScreen()
  hs.alert.closeAll(0)
  hs.alert.show(styledText(glyph, header, body), style, screen, M.config.duration)
end

local function handleNotification(element)
  local banner = findBanner(element, 0)
  if not banner then
    dbg("notif: no banner in created element")
    return
  end

  local appName = appNameFromDescription(axValue(banner, "AXDescription"))
  dbg("notif: app=", tostring(appName), "match=", tostring(appMatches(appName)))
  if not appMatches(appName) then return end

  local fields = fieldsByIdentifier(banner, 0)
  local title = fields.title and tidy(fields.title) or ""
  local subtitle = fields.subtitle and tidy(fields.subtitle) or ""
  local body = fields.body or ""

  local key = appName .. "|" .. title .. "|" .. subtitle .. "|" .. body
  local now = hs.timer.secondsSinceEpoch()
  if key == lastKey and (now - lastTime) < 3 then return end
  lastKey, lastTime = key, now

  local header
  if title ~= "" and subtitle ~= "" then
    header = title .. " · " .. subtitle
  elseif subtitle ~= "" then
    header = subtitle
  elseif title ~= "" then
    header = title
  else
    header = appName
  end

  local message = wrapMessage(body ~= "" and body or subtitle)
  if message == "" then return end

  M.show(glyphForApp(appName), truncateLine(header, M.config.maxLineChars), message)
end

function M.startObserver()
  for _, obs in ipairs(M.observers) do
    pcall(function() obs:stop() end)
  end
  M.observers = {}

  local apps = hs.application.applicationsForBundleID(NC_BUNDLE)
  if not apps or #apps == 0 then
    print("[slack_notifications] notification-center process not found")
    return
  end

  for _, app in ipairs(apps) do
    local axApp = hs.axuielement.applicationElement(app)
    if not axApp then
      print("[slack_notifications] no AX access (grant Accessibility to Hammerspoon)")
    else
      local obs = hs.axuielement.observer.new(app:pid())
      obs:callback(function(_, element) pcall(handleNotification, element) end)
      pcall(function() obs:addWatcher(axApp, "AXCreated") end)
      obs:start()
      M.observers[#M.observers + 1] = obs
    end
  end
  dbg("startObserver: NC apps=", apps and #apps or 0, "observers=", #M.observers)
end

function M.test()
  local glyph = glyphForApp("Slack")
  if glyph == "" then glyph = ":slack:" end
  local header = truncateLine("Shopify · #general", M.config.maxLineChars)
  local body = wrapMessage(
    "Bob Smith: standup in 5 minutes 👋\n" ..
    "Can you share the deploy status and the dashboard link before we start? Thanks everyone, really appreciate it!"
  )
  M.show(glyph, header, body)
end

function M.start()
  M.startObserver()

  if M.appWatcher then M.appWatcher:stop() end
  M.appWatcher = hs.application.watcher.new(function(_, event, app)
    if event == hs.application.watcher.launched
        and app and app:bundleID() == NC_BUNDLE then
      M.startObserver()
    end
  end)
  M.appWatcher:start()

  hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "N", function() M.test() end)
  dbg("start: observers=", #M.observers, "hotkey=cmd+alt+ctrl+N")
  return M
end

return M
