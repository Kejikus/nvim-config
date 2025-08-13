return {
  {
    'harrisoncramer/gitlab.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'stevearc/dressing.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      {
        '<leader><leader>gm',
        function()
          require('gitlab').choose_merge_request()
        end,
        mode = 'n',
        desc = '[G]itlab [M]erge Request',
      },
      {
        '<leader><leader>gr',
        function()
          require('gitlab').review()
        end,
        mode = 'n',
        desc = '[G]itlab [R]eview',
      },
    },
    build = function()
      require('gitlab.server').build(true)
    end,
    config = true,
  },
}
