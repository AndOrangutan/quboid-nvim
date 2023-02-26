-- https://github.com/mfussenegger/dotfiles/blob/833d634251ebf3bf7e9899ed06ac710735d392da/vim/.config/nvim/lua/me/lsp/conf.lua
-- https://github.com/mfussenegger/dotfiles/blob/833d634251ebf3bf7e9899ed06ac710735d392da/vim/.config/nvim/ftplugin/java.lua#L1-L149
-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
--
local util = require('util')


local lsp_util = require('lsp-util')
local jdtls_ok, jdtls = pcall(require, 'jdtls')

if not jdtls_ok then
    vim.notify('JDTLS NOT FOUND!! Install it with Mason')
    return
end


local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Determine OS
local workspace_path, os_config
local home = os.getenv("HOME")
if vim.fn.has("mac") == 1 then
    workspace_path = home .. '/workspace/'
    os_config = 'mac'
elseif vim.fn.has("unix") == 1 then
    workspace_path = home .. '/workspace/'
    os_config = 'linux'
else
    vim.notify('Unsupported system')
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = workspace_path .. project_name

-- Find root of project
local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }   -- TODO: extract to quboid?
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == '' then
    return
end

local bundles = {}

-- Create config and extend on_attach with keybinds
local config = lsp_util.new_config(function (client, bufnr)
    -- extend on_attach
    util.keymap('n', '<M-o>', '<Cmd>lua require"jdtls".organize_imports()<CR>', { desc = 'JDTLS [o]rganize Imports', buffer = bufnr })
    util.keymap('n', 'crv','<Cmd>lua require("jdtls").extract_variable()<CR>', { desc = 'JDTLS [cr]eate Extracted Variable', buffer = bufnr })
    util.keymap('v', 'crv', '<Esc><Cmd>lua require("jdtls").extract_variable(true)<CR>', { desc = 'JDTLS [cr]eate Extracted Variable', buffer = bufnr })
    util.keymap('n', 'crc', '<Cmd>lua require("jdtls").extract_constant()<CR>', { desc = 'JDTLS [cr]eate Extracted Constant', buffer = bufnr })
    util.keymap('v', 'crc', '<Esc><Cmd>lua require("jdtls").extract_constant(true)<CR>', { desc = 'JDTLS [cr]eate Extracted Constant', buffer = bufnr })
    util.keymap('v', 'crm', '<Esc><Cmd>lua require("jdtls").extract_method(true)<CR>', { desc = 'JDTLS [cr]eate Extracted Method', buffer = bufnr })
end)

config['cmd'] = {
    'java', -- NOTE: Configuration Required
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    '-jar',
    '/home/vm/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',  -- NOTE: Configuration Required


    '-configuration',
    '/home/vm/.local/share/nvim/mason/packages/jdtls/config_'..os_config,

    -- See `data directory configuration` section in the README
    '-data', workspace_dir
}

config['root_dir'] = root_dir

config['on_init'] = function(client)
    if client.config.settings then
        client.notify('workspace/didChangeConfiguration', {settings = client.config.settings})
    end
end

config['settings'] = {
    java = {
         java = {
            signatureHelp = {
                enabled = true
            },
            saveActions = {
                organizeImports = true
            },
            completion = {
                maxResults = 20,
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*"
                }
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999
                }
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                }
            }
        }
    },
}
-- config.settings = {
--     java = {
--         -- eclipse = {
--         --     downloadSources = true,
--         -- },
--         -- maven = {
--         --     downloadSources = true,
--         -- },
--         -- implementationsCodeLens = {
--         --     enabled = true,
--         -- },
--         -- referencesCodeLens = {
--         --     enabled = true,
--         -- },
--         -- references = {
--         --     includeDecompiledSources = true,
--         -- },
--         inlayHints = {
--             parameterNames = {
--                 enabled = "all", -- literals, all, none
--             },
--         },
--         format = {
--             -- enabled = false,
--             settings = {
--                 url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
--                 profile = "GoogleStyle",
--             },
--         },
--         signatureHelp = { enabled = true },
--         contentProvider = { preferred = "fernflower" }, -- use fernflower to decompile library code
--         completion = {
--             favoriteStaticMembers = {
--                 "org.hamcrest.MatcherAssert.assertThat",
--                 "org.hamcrest.Matchers.*",
--                 "org.hamcrest.CoreMatchers.*",
--                 "org.junit.jupiter.api.Assertions.*",
--                 "java.util.Objects.requireNonNull",
--                 "java.util.Objects.requireNonNullElse",
--                 "org.mockito.Mockito.*",
--             },
--             filteredTypes = {
--                 "com.sun.*",
--                 "io.micrometer.shaded.*",
--                 "java.awt.*",
--                 "jdk.*", "sun.*",
--             },
--         },
--         extendedClientCapabilities = extendedClientCapabilities,
--         sources = {
--             organizeImports = {
--                 starThreshold = 9999,
--                 staticStarThreshold = 9999,
--             },
--         },
--         codeGeneration = {
--             toString = {
--                 template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
--             },
--             useBlocks = true,
--         },
--         configuration = {
--             runtimes = {
--                 -- {
--                 --     name = "JavaSE-17",
--                 --     path = home .. "/.asdf/installs/java/corretto-17.0.4.9.1",
--                 -- },
--                 -- {
--                 --     name = "JavaSE-11",
--                 --     path = home .. "/.asdf/installs/java/corretto-11.0.16.9.1",
--                 -- },
--                 -- {
--                 --     name = "JavaSE-1.8",
--                 --     path = home .. "/.asdf/installs/java/corretto-8.352.08.1"
--                 -- },
--             }
--         },
--     },
-- }

-- config.on_init = function(client)
--     if client.config.settings then
--         client.notify('workspace/didChangeConfiguration', {settings = client.config.settings})
--     end
-- end
    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
config.init_options = {
    bundles = bundles
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)


-- Add Commands
require("jdtls.setup").add_commands()
