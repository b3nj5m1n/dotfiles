local Path = require "plenary.path"
local root_dir = vim.fs.dirname(vim.fs.find({'.gradlew', '.git', 'mvnw'}, { upward = true })[1])

local project_name = vim.fn.fnamemodify(dir_root, ':p:h:t')

local workspace_dir = Path:new(os.getenv('XDG_DATA_HOME'), "jdtls_workspaces", project_name)

--[[ local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', '/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', '/usr/share/java/jdtls/config_linux',
    '-data', tostring(workspace_dir)
  },

  root_dir = tostring(dir_root),
  capabilities = require("cmp_nvim_lsp").default_capabilities()
} ]]

local config = {
    cmd = {'jdtls'},
    root_dir = root_dir,
    capabilities = require("cmp_nvim_lsp").default_capabilities()
}

local extendedClientCapabilities = require'jdtls'.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
config.init_options = {
    extendedClientCapabilities = extendedClientCapabilities;
}


require('jdtls').start_or_attach(config)
