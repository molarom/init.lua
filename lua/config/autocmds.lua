local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Create autogroup.
local molaromAG = augroup('molarom', { clear = true })

autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = molaromAG,
  desc = "Highlight when yanking",
  pattern = '*',
})

autocmd({ "VimEnter" }, {
  callback = function()
    local ok, _ = pcall(require, "nvim-tree")
    if(not ok) then
      vim.print("Nvim-Tree is not installed or setup correctly.")
    else
      require("nvim-tree.api").tree.open()
    end
  end,
  group = molaromAG,
  desc = "Open Nvim-Tree when vim opens.",
})

autocmd("VimResized", {
  callback = function()
    vim.cmd "wincmd ="
  end,
  group = molaromAG,
  desc = "Equalize Splits",
})

autocmd("TermOpen", {
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.cmd "startinsert!"
  end,
  group = molaromAG,
  desc = "Terminal Options",
})
