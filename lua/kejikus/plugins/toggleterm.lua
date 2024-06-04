return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('kejikus.config.remaps').set_toggleterm_keymaps()
      require('toggleterm').setup {}
    end,
  },
}
