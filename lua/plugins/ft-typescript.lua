return {
    { 'barrett-ruth/import-cost.nvim',
        build = 'sh install.sh '..require('quboid').ft_javascript_package_manager,
        config = true,
    },
    { 'jose-elias-alvarez/typescript.nvim',
        config = function ()

            local config = require('lsp').gen_config()
            -- config['on_attach'] = function (client, bufnr)
            --     vim.lsp.buf.inlay_hint(bufnr, true)
            --     require('lsp').call_on_attach(client, bufnr)
            -- end

            require('typescript').setup({
                go_to_source_definition = {
                    fallback = true, -- fall back to standard LSP definition on failure
                },
                server = config,
                -- settings = {
                --     -- specify some or all of the following settings if you want to adjust the default behavior
                --     javascript = {
                --         inlayHints = {
                --             includeInlayEnumMemberValueHints = true,
                --             includeInlayFunctionLikeReturnTypeHints = true,
                --             includeInlayFunctionParameterTypeHints = true,
                --             includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                --             includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                --             includeInlayPropertyDeclarationTypeHints = true,
                --             includeInlayVariableTypeHints = true,
                --         },
                --     },
                --     typescript = {
                --         inlayHints = {
                --             includeInlayEnumMemberValueHints = true,
                --             includeInlayFunctionLikeReturnTypeHints = true,
                --             includeInlayFunctionParameterTypeHints = true,
                --             includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                --             includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                --             includeInlayPropertyDeclarationTypeHints = true,
                --             includeInlayVariableTypeHints = true,
                --         },
                --     },
                -- },
            })
        end,
    },
}
