-- [nfnl] Compiled from fnl/paq.fnl by https://github.com/Olical/nfnl, do not edit.
defn(__fnl_global__add_2dplugin, {name, path, config, setup, branch, commit, optional, command, requires, filetype, event, after, disable, description, as}, "Add plugin to config-local plugin-store.", table.insert(_G.config.plugins, {name = name, path = path, config = config, setup = setup, branch = branch, commit = commit, optional = optional, command = command, requires = requires, filetype = filetype, event = event, after = after, disable = disable, description = description, as = as, ["trigger-keys"] = __fnl_global__trigger_2dkeys, opts = opts}))
local plugin_config = {name = name, path = path, config = nil, setup = nil, branch = nil, commit = nil, optional = nil, command = nil, requires = nil, filetype = nil, event = nil, after = nil, disable = nil, description = description, as = nil, ["trigger-keys"] = nil}
for i = 1, #{...}, 2 do
  local key = ({...})[i]
  local value = ({...})[(1 + i)]
  plugin_config[key] = value
end
local _1_
if (plugin_config.branch == nil) then
  plugin_config["branch"] = "main"
  _1_ = nil
else
  _1_ = nil
end
local _3_
if (plugin_config.optional == nil) then
  plugin_config["optional"] = false
  _3_ = nil
else
  _3_ = nil
end
local _5_
if (plugin_config.disable == nil) then
  plugin_config["disable"] = false
  _5_ = nil
else
  _5_ = nil
end
local _7_
if not (plugin_config.config == nil) then
  if (plugin_config.config == true) then
    plugin_config["config"] = true
    _7_ = nil
  else
    local function _8_()
      return plugin_config.config
    end
    plugin_config["config"] = _8_
    _7_ = nil
  end
else
  _7_ = nil
end
local _11_
if not (plugin_config.setup == nil) then
  local function _12_()
    return plugin_config.setup
  end
  plugin_config["setup"] = _12_
  _11_ = nil
else
  _11_ = nil
end
defn(__fnl_global__paq_2dadd, {name, description, path, ...}, nil, nil, _1_, _3_, _5_, _7_, _11_, table.insert(config.plugins, plugin_config))
local packer = require("packer")
for _, plugin in ipairs(config.plugins) do
  packer.use({plugin.path, config = plugin.config, setup = plugin.setup, branch = plugin.branch, commit = plugin.commit, opt = plugin.optional, cmd = plugin.command, requires = plugin.requires, ft = plugin.filetype, event = plugin.event, after = plugin.after, disable = plugin.disable, as = plugin.as})
end
defn(__fnl_global__init_2dpacker, {}, __fnl_global__paq_2dadd("packer", "Plugin manager", "wbthomason/packer.nvim", "branch", "master", "commit", "dcd2f380bb49ec2dfe208f186236dd366434a4d5", "optional", false, "command", {"PackerSync"}), nil, packer.init({config = {compile_path = (vim.fn.stdpath("config") .. "/lua/packer_compiled.lua")}}), nil)
local lazy = require("lazy")
local lazy_plugins = {}
for _, plugin in ipairs(config.plugins) do
  local lazy_plugin = {plugin.path, init = plugin.setup, config = plugin.config, branch = plugin.branch, commit = plugin.commit, lazy = plugin.optional, cmd = plugin.command, dependencies = plugin.requires, ft = plugin.filetype, event = plugin.event, disable = plugin.disable, name = plugin.as, keys = plugin["trigger-keys"], opts = plugin.opts}
  table.insert(lazy_plugins, lazy_plugin)
end
return defn(__fnl_global__init_2dlazy, {}, __fnl_global__paq_2dadd("lazy", "Plugin manager", "folke/lazy.nvim", "branch", "main", "commit", "dac844ed617dda4f9ec85eb88e9629ad2add5e05", "optional", false), nil, nil, nil, lazy.setup(lazy_plugins))
