return {
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    depends = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    enabled = true,
    version = false,
    build = ':TSUpdate',
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    event = { "VeryLazy" },
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          'bash',
          'c',
          'cpp',
          'dockerfile',
          'go',
          'lua',
          'markdown',
          'python',
          'sql',
          'terraform',
          'tsx',
          'vim',
          'vimdoc'
        },
        -- Don't install missing parsers when entering buffer.
        auto_install = false,
        -- Left to quiet LSP.
        ignore_install = {},
        -- Left to quiet LSP.
        modules = {},
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },
}
