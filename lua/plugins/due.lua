require('due_nvim').setup({
    -- TODO: Extract to quboid.lua
    prescript = '  due in ',             -- prescript to due data
    use_clock_time = true,         -- display also hours and minutes
    use_clock_today = true,        -- do it instead of TODAY
    use_seconds = true,            -- if use_clock_time == true, display seconds
})
