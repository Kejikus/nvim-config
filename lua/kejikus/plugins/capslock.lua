return {
  {
    'barklan/capslock.nvim',
    config = function()
      require('capslock').setup()
      require('kejikus.config.remaps').set_capslock_keymaps()
    end,
  },
}
