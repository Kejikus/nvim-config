return {
  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').add {
        { '<leader>b', group = '[B]uffer' },
        { '<leader>c', group = '[C]ode' },
        -- { '<leader>d', group = '[D]ocument' },
        { '<leader>g', group = '[G]it' },
        { '<leader>h', group = 'Git [H]unk' },
        { '<leader>l', group = '[L]SP' },
        { '<leader>o', group = '[O]pen' },
        { '<leader>p', group = '[P]roject' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>w', group = '[W]orkspace' },

        { '<leader>pv', group = '[P]roject [V]irtualenv' },

        -- Visual mode
        { '<leader>h', desc = 'Git [H]unk', mode = 'v' },
        { '<leader>h_', hidden = true, mode = 'v' },

        -- { '<leader>b_', hidden = true },
        -- { '<leader>c_', hidden = true },
        -- { '<leader>d_', hidden = true },
        -- { '<leader>g_', hidden = true },
        -- { '<leader>h_', hidden = true },
        -- { '<leader>o_', hidden = true },
        -- { '<leader>p_', hidden = true },
        -- { '<leader>r_', hidden = true },
        -- { '<leader>s_', hidden = true },
        -- { '<leader>t_', hidden = true },
        -- { '<leader>w_', hidden = true },
      }
    end,
  },
}
