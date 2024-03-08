-- LSP message reporting.

return {
  'folke/trouble.nvim',
  cmd = { "TroubleToggle", "Trouble" },
  opts = { use_diagnostic_signs = true },
  enabled = true,
  keys = {
    { '<leader>xx', "<cmd> TroubleToggle document_diagnostics<CR>", desc = 'Trouble: [xx] Show Document Diagnostics' },
    { '<leader>xX', "<cmd> TroubleToggle workspace_diagnostics<CR>", desc = 'Trouble: [xX] Show Workspace Diagnostics' },
    { '<leader>xc', "<cmd> TroubleClose<CR>", desc = 'Trouble: [xc] Close Trouble' },
    { '<leader>xl', "<cmd> TroubleToggle loclist<CR>", desc = 'Trouble: [xl] Show trouble in location list' },
    { '<leader>xq', "<cmd> TroubleToggle quickfix<CR>", desc = 'Trouble: [xq] Show trouble in quickfix' },
    {
      "[q",
      function()
        if require("trouble").is_open() then
          require("trouble").previous({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Previous trouble/quickfix item",
    },
    {
      "]q",
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Next trouble/quickfix item",
    },
  },
}
