return {
  {
    'jeangiraldoo/codedocs.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    keys = {
      {
        '<leader>cd',
        function()
          require('codedocs').insert_docs()
        end,
        mode = 'n',
        desc = 'Insert [C]ode [D]ocs',
      },
    },
    opts = {
      default_styles = {
        python = 'Numpy',
      },
    },
  },
}
