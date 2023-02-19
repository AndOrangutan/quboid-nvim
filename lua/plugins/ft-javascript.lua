local quboid = require('quboid')

return {
    { 'barrett-ruth/import-cost.nvim',
        -- TODO: Extract javascript package manager
        -- build = 'sh install.sh '..quboid.quboid_ft_javascript_package_manager,
        build = 'sh install.sh yarn',
        config = function() require('import-cost').setup() end,
    }
    -- { 'yardnsm/vim-import-cost',
    --     -- TODO: Extract javascript package manager
    --     -- build = 'sh install.sh '..quboid.quboid_ft_javascript_package_manager,
    --     build = 'npm install --prodction',
    --     --config = function() require('import-cost').setup() end,
    -- }
}
