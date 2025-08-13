return {
  {
    'hedyhli/outline.nvim',
    lazy = true,
    cmd = {
      'Outline',
      'OutlineOpen',
    },
    keys = {
      {
        '<leader>oo',
        '<cmd>Outline!<CR>', -- Bang forces outline to not move current focus
        desc = '[O]pen [O]utline',
      },
    },
  },
}
