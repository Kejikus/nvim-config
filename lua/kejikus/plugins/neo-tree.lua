return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    opts = {
      source_selector = {
        winbar = true,
      },
      filesystem = {
        bind_to_cwd = true,
        hijack_netrw_behavior = 'open_default',
        use_libuv_file_watcher = true,
        follow_current_file = {
          enabled = true,
        },
      },
      window = {
        win_options = {
          foldcolumn = '0',
          foldenable = false,
        },
      },
      default_component_configs = {
        git_status = {
          symbols = {
            -- Change type
            added = ' ',
            deleted = ' ',
            -- modified = ' ',
            modified = '',
            renamed = ' ',
            -- Status type
            untracked = ' ',
            ignored = ' ',
            unstaged = ' ',
            staged = ' ',
            conflict = '',
          },
        },
      },
    },
    config = function(_, opts)
      require('neo-tree').setup(opts)

      local function remove_italics(hl_name)
        -- Function to remove italic formatting from highlight group
        local hl = vim.api.nvim_get_hl(0, { name = hl_name })
        hl.italic = nil
        ---@diagnostic disable-next-line: param-type-mismatch
        vim.api.nvim_set_hl(0, hl_name, hl)
      end

      remove_italics 'NeoTreeRootName'
      remove_italics 'NeoTreeGitUntracked'
      remove_italics 'NeoTreeGitConflict'
    end,
  },
}
