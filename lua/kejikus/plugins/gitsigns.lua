return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        changedelete = { text = '┃' },
        delete = { text = '┃' },
        topdelete = { text = '┃' },
        untracked = { text = '┃' },
        -- add = { text = '▍' },
        -- change = { text = '▍' },
        -- changedelete = { text = '▍' },
        -- delete = { text = '▍' },
        -- topdelete = { text = '▍' },
        -- untracked = { text = '▍' },
        -- delete = { text = '▁' },
        -- topdelete = { text = '▔' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [h]unk [s]tage' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'git [h]unk [r]eset' })
        -- normal mode
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [h]unk [s]tage' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [h]unk [r]eset' })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'git [h]unk [u]nstage' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [h]unk [p]review' })
        map('n', '<leader>gs', gitsigns.stage_buffer, { desc = '[g]it [s]tage buffer' })
        map('n', '<leader>gR', gitsigns.reset_buffer, { desc = '[g]it [r]eset buffer' })
        map('n', '<leader>gb', gitsigns.blame_line, { desc = '[g]it [b]lame line' })
        map('n', '<leader>gd', gitsigns.diffthis, { desc = '[g]it [d]iff against index' })
        map('n', '<leader>gD', function()
          gitsigns.diffthis '@'
        end, { desc = '[g]it [D]iff against last commit' })

        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[t]oggle git show [b]lame line' })
        -- map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[t]oggle git show [D]eleted' })
      end,
    },
  },
}
