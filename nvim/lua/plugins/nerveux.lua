local nerveux = require 'nerveux'
require 'nerveux'.setup {
    --- path to neuron executable (default: neuron in PATH)
    neuron_cmd = "neuron",

    --- no trailing slash, (default: current directory)
    neuron_dir = "~/zettelkasten",

    --- Use the cache, significantly faster (default: false)
    use_cache = true,

    --- start the neuron daemon to keep the cache up to date (default: false)
    start_daemon = true,

    --- show zettel titles inline as virtual text (default: false)
    virtual_titles = true,

    --- Automatically create mappings (default: false)
    create_default_mappings = true,

    --- The Highlight Group used for the inline zettel titles (default: Special)
    virtual_title_hl = "Special",
    virtual_title_hl_folge = "Repeat",

    --- `kill -9` the pid of the daemon at exit (VimPreLeave), only valid is
    -- start_daemon is true (default: false)
    kill_daemon_at_exit = true,

    --- You can overwrite this table partially
    -- and your settings will get merged with the defaults
    -- You can also disable a single mapping by settings it's value to an empty string.
}

nerveux.setup_default_mappings()
