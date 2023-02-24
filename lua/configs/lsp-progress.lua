require('lsp-progress').setup({
    --- Spinning icon array.
    spinner = { ' ', ' ', ' ', ' ', ' ', ' ', ' ' },

    --- Spinning update time in milliseconds.
    spin_update_time = 333,

    --- Indicate if there's any lsp server active on current buffer.
    -- Icon: nf-fa-gear(\uf013).
    -- Notice: this config is deprecated.
    sign = " LSP",

    --- Seperate multiple messages in one statusline.
    -- Notice: this config is deprecated.
    seperator = " ",

    --- Last message is cached in decay time in milliseconds.
    -- Messages could be really fast, appear and disappear in an instant, so
    -- here cache the last message for a while for user view.
    decay = 1000,

    --- User event name.
    event = "LspProgressStatusUpdated",

    --- Event update time limit in milliseconds.
    -- Sometimes progress handler could emit many events in an instant, while
    -- refreshing statusline cause too heavy synchronized IO, so limit the
    -- event emit rate to reduce the cost.
    event_update_time_limit = 125,

    --- Max progress string length, by default -1 is unlimit.
    max_size = -1,

})
