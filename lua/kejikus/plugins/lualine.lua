local IS_WIDE = function()
  return vim.o.columns > 150
end

local IS_START = function()
  return vim.opt.filetype:get() == 'alpha'
end

return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      sections = {
        lualine_a = {
          {
            'mode',
            fmt = function(m)
              return IS_WIDE() and m or m:sub(1, 1)
            end,
            cond = function()
              return not IS_START()
            end,
          },
        },
        lualine_b = { 'branch' },
        lualine_c = {
          {
            'diff',
            symbols = {
              modified = '~',
              removed = '-',
              added = '+',
            },
          },
          -- add empty section to center filename
          {
            '%=',
            separator = '',
          },
          -- A hack to change the path type if the window gets too short. Lualine doesn't accept a function for the
          -- `path` option, so just swap out the entire component
          {
            'filename',
            path = 1, -- full file path
            color = { fg = '#ffffff', gui = 'bold' },
            shorting_target = 30,
            cond = function()
              return IS_WIDE() and not IS_START()
            end,
          },
          {
            'filename',
            path = 0, -- just the filename
            color = { fg = '#ffffff', gui = 'bold' },
            shorting_target = 30,
            cond = function()
              return not IS_WIDE() and not IS_START()
            end,
          },
        },
        lualine_x = {},
        lualine_y = {
          {
            function()
              local msg = 'No Active Lsp'
              local clients = vim.lsp.get_clients { bufnr = vim.fn.bufnr() }
              if next(clients) == nil then
                return msg
              end

              local client_names = {}
              for _, client in ipairs(clients) do
                if not client_names[client.name] then
                  client_names[client.name] = 1
                end
              end

              local names = {}
              for name, _ in pairs(client_names) do
                table.insert(names, name)
              end
              return table.concat(names, ', ')
            end,
            icon = ' LSP:',
            color = { gui = 'bold' },
            cond = function()
              return IS_WIDE() and not IS_START()
            end,
          },
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            sections = { 'error', 'warn', 'info', 'hint' },
            -- diagnostics_color = {
            --   error = { fg = '#AF0000' },
            --   warn = { fg = '#D75F00' },
            --   info = { fg = '#0087AF' },
            --   hint = { fg = '#008700' },
            -- },
            symbols = {
              error = ' ',
              warn = ' ',
              info = ' ',
              hint = ' ',
            },
          },
        },
        lualine_z = {
          { 'location' },
          {
            'filetype',
            cond = function()
              return not IS_START()
            end,
          },
        },
      },
      -- tabline = {
      --   lualine_a = {
      --     {
      --       'tabs',
      --       mode = 2,
      --       symbols = {
      --         modified = '[+]',
      --       },
      --     },
      --   },
      --   lualine_b = {},
      --   lualine_c = {},
      --   lualine_x = {},
      --   lualine_y = {},
      --   lualine_z = {
      --     {
      --       'buffers',
      --       mode = 0, -- name only
      --       max_length = vim.o.columns / 3,
      --       cond = function()
      --         return not IS_START()
      --       end,
      --       use_mode_colors = true,
      --     },
      --   },
      -- },
      options = {
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        theme = 'tokyonight',
        globalstatus = true,
      },
      extensions = {
        'aerial',
        'fugitive',
        'lazy',
        'man',
        'neo-tree',
        'quickfix',
        'toggleterm',
        'mason',
      },
    },
  },
}
