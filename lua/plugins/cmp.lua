-- Autocompletion
return {
  {
    'hrsh7th/nvim-cmp',
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        dependencies = { "rafamadriz/friendly-snippets" },
      },
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-buffer'},
      {'onsails/lspkind.nvim'},
    },
    config = function()
      -- And you can configure cmp even more, if you want to.
      local cmp = require('cmp')

      require('luasnip.loaders.from_vscode').lazy_load()

      local compare = require('cmp.config.compare')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      require("lspkind").init({
        symbol_map = {
          Copilot = '',
        },
      })

      cmp.setup({
        enabled = function()
          local disabled = false
          disabled = disabled or (vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt')
          disabled = disabled or (vim.fn.reg_recording() ~= '')
          disabled = disabled or (vim.fn.reg_executing() ~= '')
          disabled = disabled or vim.g.cmp_disable
          return not disabled
        end,
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          completion = {
            winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
            col_offset = -3,
            side_padding = 0,
          },
        },
        sources = {
          {name = 'nvim_lsp'},
          {name = 'copilot'},
          {name = 'luasnip'},
          {name = 'path'},
          {name = 'buffer'},
        },
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({
              mode = 'symbol_text',
              maxwidth = 50,
              elipsis_char = '...',
              menu = {
                luasnip = '[Snip]',
                nvim_lsp = '[LSP]',
                nvim_lsp_signature_help = '[Sign]',
                buffer = '[Buf]',
                copilot = '[GHub]',
                path = '[Path]',
              },
            }) (entry, vim_item)
            local strings = vim.split(kind.kind, '%s', { trimempty = true })
            kind.kind = ' ' .. strings[1] .. ' '
            return kind
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-j>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                local entry = cmp.get_selected_entry()
                if not entry then
                  cmp.select_next_item({ behavior = cmp.SelectBehavior.Select})
                end
                cmp.confirm()
              else
                fallback()
              end
            end,
          {
            "i",
            "s",
            "c",
          }),
          ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
        },
        sorting = {
          comparators = {
            compare.offset,
            compare.exact,
            compare.scopes,
            compare.score,
            compare.locality,
            compare.recently_used,
            compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
          },
        },
        view = { entries = { name = 'custom', selection_order = 'near_cursor' } },
        experimental = { ghost_text = true },
      })
    end
  },
}
