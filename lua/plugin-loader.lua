-- Bootstrap lazynvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  concurrency = 10, -- limit the max number of concurrent tasks
  install = {
    missing = true,
    colorscheme = { "habamax", },
  },
  ui = {
     -- a number <1 is a percentage., >1 is a fixed size
     size = { width = 0.8, height = 0.8 },
     -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
     border = "rounded",
     icons = {
       ft = "",
       lazy = "󰒲 ",
       loaded = "",
       not_loaded = "",
       cmd = " ",
       config = "",
       event = "",
       init = " ",
       keys = " ",
       plugin = " ",
       runtime = " ",
       source = " ",
       start = "",
       task = " ",
     },
     throttle = 20, -- how frequently should the ui process render events
  },
  checker = {
    enabled = true,
    concurrency = nil,
    notify = true,
    frequency = 3600, -- check for updates every hour
  },
  change_detection = {
    enabled = true,
    notify = true,
  },
  performance = {
    cache = {
      enabled = true,
      path = vim.fn.stdpath "state" .. "/lazy/cache",
      -- Once one of the following events triggers, caching will be disabled.
      -- To cache all modules, set this to `{}`, but that is not recommended.
      -- The default is to disable on:
      --  * VimEnter: not useful to cache anything else beyond startup
      --  * BufReadPre: this will be triggered early when opening a file from the command line directly
      disable_events = { "UIEnter", "VimEnter", "BufReadPre" },
    },
  },
  reset_packpath = true,
}

local ok, lazy = pcall(require, "lazy")
if(not ok) then
  vim.print("Unable to load lazy.nvim")
  return
end

lazy.setup({
  spec = {
    { import = "plugins" },
  },
  opts
})
