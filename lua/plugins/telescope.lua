-- Fuzzy finder (file, lsp, etc.)
return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    keys = {
      { '<leader>?', "<cmd> Telescope oldfiles<CR>", desc = 'Telescope: [?] Find recently opened files' },
      { '<leader><space>', "<cmd> Telescope buffers<CR>", desc = 'Telescope: [ ] Find existing buffers' },
      { '<leader>/', "<cmd> Telescope current_buffer_fuzzy_find<CR>", desc = 'Telescope: [/] Fuzzily search in current buffer' },
      { '<leader>gf', "<cmd> Telescope git_files<CR>", desc = 'Telescope: Search [G]it [F]iles' },
      { '<leader>sf', "<cmd> Telescope find_files<CR>", desc = 'Telescope: [S]earch [F]iles' },
      { '<leader>sh', "<cmd> Telescope help_tags<CR>", desc = 'Telescope: [S]earch [H]elp' },
      { '<leader>sw', "<cmd> Telescope grep_string<CR>", desc = 'Telescope: [S]earch current [W]ord' },
      { '<leader>sg', "<cmd> Telescope live_grep<CR>", desc = 'Telescope: [S]earch by [G]rep' },
      { '<leader>sd', "<cmd> Telescope diagnostics<CR>", desc = 'Telescope: [S]earch [D]iagnostics' },
      { '<leader>sr', "<cmd> Telescope resume<CR>", desc = 'Telescope: [S]earch [R]esume' },

    },
    config = function()
      local ts = require('telescope')
      local actions = require("telescope.actions")

      ts.setup({
        defaults = {
          winblend = 10,
          path_display = { 'smart' },
          mappings = {
            i = {
              ['<esc>'] = actions.close,
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
      })
      ts.load_extension('fzf')

    end,
  },
}
