-- LSP configs
return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    depends = {
      { "williamboman/mason.nvim" },
    },
  },
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'jay-babu/mason-null-ls.nvim' },
      { 'nvimtools/none-ls.nvim' },
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      lsp_zero.format_on_save({
          format_opts = {
          async = false,
          timeout_ms = 10000,
        },
        servers = {
          ['null-ls'] = {'go', 'sql', 'terraform'},
        },
      })

      lsp_zero.on_attach(function(client, bufnr)
        local bind = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end
        bind('<leader>rn', vim.lsp.buf.rename, 'LSP: [R]e[n]ame')
        bind('<leader>ca', vim.lsp.buf.code_action, 'LSP: [C]ode [A]ction')

        bind('gd', require('telescope.builtin').lsp_definitions, 'LSP: [G]oto [D]efinition')
        bind('gr', require('telescope.builtin').lsp_references, 'LSP: [G]oto [R]eferences')
        bind('gI', require('telescope.builtin').lsp_implementations, 'LSP: [G]oto [I]mplementation')
        bind('<leader>D', require('telescope.builtin').lsp_type_definitions, 'LSP: Type [D]efinition')
        bind('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'LSP: [D]ocument [S]ymbols')
        bind('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'LSP: [W]orkspace [S]ymbols')
        bind('K', vim.lsp.buf.hover, 'LSP: Hover Documentation')
        bind('<C-k>', vim.lsp.buf.signature_help, 'LSP: Signature Documentation')
        bind('gD', vim.lsp.buf.declaration, 'LSP: [G]oto [D]eclaration')
        bind('<leader>wa', vim.lsp.buf.add_workspace_folder, 'LSP: [W]orkspace [A]dd Folder')
        bind('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'LSP: [W]orkspace [R]emove Folder')
        bind('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, 'LSP: [W]orkspace [L]ist Folders')
      end)

      require('mason-lspconfig').setup({
        ensure_installed = {},
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
        }
      })

      local null_ls = require('null-ls')
      local null_opts = lsp_zero.build_options('null-ls', {})

      null_ls.setup({
        on_attach = function(client, bufnr)
          null_opts.on_attach(client, bufnr)
        end,
        sources = {
          null_ls.builtins.diagnostics.actionlint,
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.gofmt,
          null_ls.builtins.formatting.pg_format,
          null_ls.builtins.formatting.terraform_fmt,
        },
      })

      require('mason-null-ls').setup({
        ensure_installed = nil,
        automatic_installation = false,
        automatic_setup = true,
      })
    end
  }
}
