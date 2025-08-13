return {
  { 'folke/tokyonight.nvim' },
  { 'EdenEast/nightfox.nvim' },
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'sainnhe/everforest',
    enabled = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.g.everforest_background = 'hard'
      vim.g.everforest_better_performance = 1
      vim.cmd.colorscheme 'everforest'

      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    enabled = true,
    init = function()
      require('kanagawa').setup {
        commentStyle = {},
        keywordStyle = {},
        transparent = true,
        -- wave, dragon or lotus
        theme = 'wave',
        background = {
          dark = 'wave',
        },
      }
      vim.cmd.colorscheme 'kanagawa'
    end,
  },
  {
    'everviolet/nvim',
    name = 'evergarden',
    priority = 1000,
    enabled = false,
    init = function()
      require('evergarden').setup {
        theme = {
          variant = 'spring',
          accent = 'green',
        },
        editor = {
          transparent_background = true,
        },
        style = {
          comment = {},
          keyword = {},
        },
      }
      vim.cmd.colorscheme 'evergarden'
    end,
  },
}
