local overseer = require('overseer')

overseer.register_template({
    name = 'Gradle InstallDebug',
    builder = function()
        return {
            cmd = { 'gradle' },
            args = { 'installDebug' },
            components = { { 'on_output_quickfix', open = true }, 'default' },
        }
    end,
    condition = {
        -- filetype = { 'java' },
    },
})
overseer.register_template({
    name = 'Gradle AssembleDebug',
    builder = function()
        return {
            cmd = { 'gradle' },
            args = { 'assembleDebug' },
            components = { { 'on_output_quickfix', open = true }, 'default' },
        }
    end,
    condition = {
        -- filetype = { 'java' },
    },
})
