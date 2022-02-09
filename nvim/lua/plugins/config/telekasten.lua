local home = vim.fn.expand("~/zettelkasten")
require('telekasten').setup({
    home         = home,
    dailies      = home .. '/' .. 'daily',
    weeklies     = home .. '/' .. 'weekly',
    templates    = home .. '/' .. 'templates',

    -- image subdir for pasting
    -- subdir name
    -- or nil if pasted images shouldn't go into a special subdir
	image_subdir = "files",

  -- markdown file extension
  extension    = ".md",

  -- following a link to a non-existing note will create it
  follow_creates_nonexisting = true,
  dailies_create_nonexisting = true,
  weeklies_create_nonexisting = true,

  -- template for new notes (new_note, follow_link)
  -- set to `nil` or do not specify if you do not want a template
  template_new_note = home .. '/' .. 'templates/new_note.md',

  -- template for newly created daily notes (goto_today)
  -- set to `nil` or do not specify if you do not want a template
  template_new_daily = home .. '/' .. 'templates/daily.md',

  -- template for newly created weekly notes (goto_thisweek)
  -- set to `nil` or do not specify if you do not want a template
  template_new_weekly= home .. '/' .. 'templates/weekly.md',

  -- following a link to a non-existing note will create it
  follow_creates_nonexisting = true,
  dailies_create_nonexisting = true,
  weeklies_create_nonexisting = true,

  -- image link style
  -- wiki:     ![[image name]]
  -- markdown: ![](image_subdir/xxxxx.png)
  image_link_style = "markdown",
  template_handling = "smart",

  rename_update_links = true,


    -- integrate with calendar-vim
    -- plug_into_calendar = true,
    -- calendar_opts = {
    --     -- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
    --     weeknm = 4,
    --     -- use monday as first day of week: 1 .. true, 0 .. false
    --     calendar_monday = 1,
    --     -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
    --     calendar_mark = 'left-fit',
    -- }
})
