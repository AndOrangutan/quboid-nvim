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

local config = lsp_util.create_config()

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

config.cmd = {


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

-- This is the default if not provided, you can remove it. Or adjust as needed.
-- One dedicated LSP server & client will be started per unique root_dir
config.root_dir = root_dir

config.on_attach = lsp_util.create_on_attach(function (client, bufnr)
    -- extend on_attach
    util.keymap('n', '<M-o>', '<Cmd>lua require"jdtls".organize_imports()<CR>', { desc = 'JDTLS [o]rganize Imports', buffer = bufnr })
    util.keymap('n', 'crv','<Cmd>lua require("jdtls").extract_variable()<CR>', { desc = 'JDTLS [cr]eate Extracted Variable', buffer = bufnr })
    util.keymap('v', 'crv', '<Esc><Cmd>lua require("jdtls").extract_variable(true)<CR>', { desc = 'JDTLS [cr]eate Extracted Variable', buffer = bufnr })
    util.keymap('n', 'crc', '<Cmd>lua require("jdtls").extract_constant()<CR>', { desc = 'JDTLS [cr]eate Extracted Constant', buffer = bufnr })
    util.keymap('v', 'crc', '<Esc><Cmd>lua require("jdtls").extract_constant(true)<CR>', { desc = 'JDTLS [cr]eate Extracted Constant', buffer = bufnr })
    util.keymap('v', 'crm', '<Esc><Cmd>lua require("jdtls").extract_method(true)<CR>', { desc = 'JDTLS [cr]eate Extracted Method', buffer = bufnr })
end)

-- Here you can configure eclipse.jdt.ls specific settings
-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
-- for a list of options
config.settings = {
    java = {
        eclipse = {
            downloadSources = true,
        },
        configuration = {
            updateBuildConfiguration = "interactive",
        },
        maven = {
            downloadSources = true,
        },
        implementationsCodeLens = {
            enabled = true,
        },
        referencesCodeLens = {
            enabled = true,
        },
        references = {
            includeDecompiledSources = true,
        },
        inlayHints = {
            parameterNames = {
                enabled = "all", -- literals, all, none
            },
        },
        format = {
            enabled = false,
            url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
            profile = "GoogleStyle",
        },
        signatureHelp = { enabled = true },
        completion = {
            favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
            },
        },
        contentProvider = { preferred = "fernflower" },
        extendedClientCapabilities = extendedClientCapabilities,
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
        },
    },
}

config.on_init = function(client)
    if client.config.settings then
        client.notify('workspace/didChangeConfiguration', {settings = client.config.settings})
    end
end
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
