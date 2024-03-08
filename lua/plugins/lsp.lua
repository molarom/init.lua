-- LSP configs
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.gofumpt,
          null_ls.builtins.formatting.goimports_reviser,
          null_ls.builtins.formatting.alejandra,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({
              group = augroup,
              buffer = bufnr,
            })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end
      })
    end,
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
      local lspconfig = require("lspconfig")

      local cmp_lsp = require('cmp_nvim_lsp')
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities())

      lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
        capabilities = capabilities,
        on_attach = require("config.lsp_keymaps"),
      })

      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
              diagnostics = {
                  globals = { "vim", "it", "describe", "before_each", "after_each" },
              }
          }
        }
      }
      lspconfig.nixd.setup {}
      lspconfig.gopls.setup {}


      -- this will be removed eventually.
      require('mason-lspconfig').setup({
        ensure_installed = {},
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup {
              capabilities = capabilities,
              on_attach = require("config.lsp_keymaps"),
            }
          end,
        },
     })
    end,
  }
}
