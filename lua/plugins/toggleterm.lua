return {
  {
    'akinsho/toggleterm.nvim',
    enabled = true,
    event = { "VeryLazy" },
    config = function ()
      require("toggleterm").setup{}
    end
  }
}
