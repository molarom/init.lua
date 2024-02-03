-- Define leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.breakindent = true -- Enable break indent
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menuone,noselect" -- recommended for nvim-cmp
opt.expandtab = true -- Use spaces instead of tabs
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.hlsearch = true -- Set highlight on search
opt.ignorecase = true -- Case-insensitive searching 
opt.mouse = "" -- Disable mouse.
opt.number = true -- Enable line numbers
opt.relativenumber = true -- Enable relative line numbers
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.signcolumn = 'yes' -- Keep signcolumn on by default
opt.smartcase = true -- UNLESS \C or capital in search
-- opt.smartindent = true -- Insert indents automatically
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- Allow fancy colors
opt.timeoutlen = 600 -- Wait time inbetween keys
opt.undofile = true -- Save undo history
opt.updatetime = 250 -- Decrease update time
