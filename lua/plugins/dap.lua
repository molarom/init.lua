return {
  {
    'mfussenegger/nvim-dap',
    enabled = true,
    keys = {
      { '<leader>db', "<cmd> DapToggleBreakpoint <CR>", desc = 'Debugger: [db] Set Breakpoint at line'},
      { '<leader>dus', function ()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end, desc = 'Debugger: [dus] Open debugging ui sidebar'},
    }
  },
  {
    "dreamsofcode-io/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
    end,
  },
}
