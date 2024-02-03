local csName = "tokyonight"

require("config")
require("plugin-loader")

local ok, _ = pcall(require, "plugins.themes." .. csName)
if(not ok) then
  error("Unable to load theme: " .. csName .. " double check the lua/plugins/themes module.")
else
  vim.cmd.colorscheme(csName)
end

