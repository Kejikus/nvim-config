return {
  {
    'luukvbaal/statuscol.nvim',
    config = function()
      local builtin = require 'statuscol.builtin'

      local function foldfunc(args)
        if not vim.wo.foldenable then
          return ''
        end
        return builtin.foldfunc(args)
      end

      local function gitsign(args, fa)
        -- Form a continuous line with gitsigns highlighting
        -- Requires gitsigns to be configured with one character for all signs
        local text = builtin.signfunc(args, fa)
        local nohl_text = string.gsub(string.gsub(text, '%%%*', ''), '%%#.*#', '')
        if nohl_text == ' ' then
          return '┃'
        end
        return text
      end

      require('statuscol').setup {
        bt_ignore = { 'nofile' },
        relculright = true,
        segments = {
          {
            text = { foldfunc },
            click = 'v:lua.ScFa',
          },
          {
            text = { builtin.lnumfunc },
            click = 'v:lua.ScLa',
          },
          {
            sign = {
              namespace = { 'diagnostic/signs' },
              colwidth = 1,
              maxwidth = 1,
              auto = true,
            },
            click = 'v:lua.ScSa',
          },
          {
            sign = {
              name = { '.*' },
              namespace = { '.*' },
              maxwidth = 3,
              colwidth = 1,
              auto = true,
            },
            click = 'v:lua.ScSa',
          },
          {
            text = { gitsign },
            sign = {
              namespace = { 'gitsigns' },
              colwidth = 1,
              wrap = true,
              -- auto = true,
            },
            click = 'v:lua.ScSa',
          },
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
