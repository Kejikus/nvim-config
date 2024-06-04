return {
  {
    'luukvbaal/statuscol.nvim',
    config = function()
      local builtin = require 'statuscol.builtin'
      require('statuscol').setup {
        bt_ignore = { 'nofile' },
        relculright = true,
        segments = {
          {
            sign = {
              namespace = { 'gitsigns' },
              colwidth = 1,
              wrap = true,
              auto = true,
            },
            click = 'v:lua.ScSa',
          },
          {
            text = { builtin.foldfunc },
            click = 'v:lua.ScFa',
          },
          -- {
          --   sign = {
          --     name = { 'Diagnostic' },
          --     maxwidth = 2,
          --     auto = true,
          --   },
          --   click = 'v:lua.ScSa',
          -- },
          {
            text = { builtin.lnumfunc },
            click = 'v:lua.ScLa',
          },
          {
            sign = {
              name = { '.*' },
              maxwidth = 3,
              colwidth = 1,
              auto = true,
            },
            click = 'v:lua.ScSa',
          },
          { text = { '│' } },
        },
      }

      vim.api.nvim_create_autocmd('CursorHold', {
        callback = function()
          vim.wo.numberwidth = vim.wo.numberwidth
        end,
      })
    end,
  },
}
