local dap = require('dap')

-- Mason installations:
--   - jdtls
--   - java-test
--   - java-debug-adapter

-- TODO: Finish configuring jaca dap
dap.configurations.java = {
    {
        -- You need to extend the classPath to list your dependencies.
        -- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
        classPaths = {},

        -- If using multi-module projects, remove otherwise.
        -- projectName = "yourProjectName",

        javaExec = "/path/to/your/bin/java",
        mainClass = "your.package.name.MainClassName",

        -- If using the JDK9+ module system, this needs to be extended
        -- `nvim-jdtls` would automatically populate this property
        modulePaths = {},
        name = "Launch YourClassName",
        request = "launch",
        type = "java"
    },
}
