return {
  {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
      'nvim-telescope/telescope.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      workspaces = {
        {
          name = 'personal',
          path = function()
            local path = vim.g.obsidian_vault_path
            if path then
              return path
            end

            vim.notify('vim.g.obsidian_vault_path is not set', vim.log.levels.INFO)
            return vim.fn.expand '~'
          end,
        },
        {
          name = 'no-vault',
          path = function()
            return assert(vim.fn.getcwd())
          end,
          overrides = {
            notes_subdir = vim.NIL,
            new_notes_location = 'current_dir',
            templates = {
              folder = vim.NIL,
            },
            disable_frontmatter = true,
          },
        },
      },
    },
  },
}
