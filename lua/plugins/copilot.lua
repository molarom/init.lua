-- Copilot lua plugin.
return {
  {
    'zbirenbaum/copilot-cmp',
    enabled = true,
    dependencies = {
      {
        'zbirenbaum/copilot.lua',
        config = function()
          require('copilot').setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
          })
        end
      },
    },
    config = function() require('copilot_cmp').setup() end,
  },
}
