local M = {}

function M.set_common_keymaps()
  -- Move selected text up and down, re-indent it and keep selection
  -- vim.keymap.set('v', 'J', "<cmd>m '>+1<CR>gv=gv", { desc = 'Move selected lines up' })
  -- vim.keymap.set('v', 'K', "<cmd>m '<-2<CR>gv=gv", { desc = 'Move selected lines down' })

  -- Stay at the same spot on line join using local mark "z"
  vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines without moving' })

  -- Search will stay at the center of the screen
  vim.keymap.set('n', 'n', 'nzz', { desc = 'Next search hit, stay at the center' })
  vim.keymap.set('n', 'N', 'Nzz', { desc = 'Previous search hit, stay at the center' })

  -- Scroll will stay at the center of the screen
  vim.keymap.set('n', '<C-d>', 'zz<C-d>zz', { desc = 'Scroll down half-screen, stay at the center' })
  vim.keymap.set('n', '<C-u>', 'zz<C-u>zz', { desc = 'Scroll up half-screen, stay at the center' })
  vim.keymap.set('n', '<C-b>', 'zz<C-d><C-d>zz', { desc = 'Scroll up (backwards) one screen, stay at the center' })
  vim.keymap.set('n', '<C-f>', 'zz<C-d><C-d>zz', { desc = 'Scroll down (forward) one screen, stay at the center' })

  -- Paste over without losing what you're pasting
  vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste over preserving register' })

  -- Yank into system clipboard
  vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Yank into clipboard' })
  vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Yank selection into clipboard' })
  vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Yank into clipboard' })

  -- Delete into void
  vim.keymap.set('n', '<leader>d', '"_d', { desc = 'Delete into void' })
  vim.keymap.set('v', '<leader>d', '"_d', { desc = 'Delete selection into void' })

  -- Clear search highlight on Esc in Normal mode
  -- vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- Diagnostic keymaps
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  -- is not what someone will guess without a bit more experience.
  --
  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  vim.keymap.set('t', '<C-]>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- Keybinds to make split navigation easier.
  --  Use CTRL+<hjkl> to switch between windows
  --
  --  See `:help wincmd` for a list of all window commands
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  vim.keymap.set('n', '<A-,>', '<C-w><', { desc = 'Reduce window width' })
  vim.keymap.set('n', '<A-->', '<C-w>-', { desc = 'Reduce window height' })
  vim.keymap.set('n', '<A-=>', '<C-w>+', { desc = 'Increase window height' })
  vim.keymap.set('n', '<A-.>', '<C-w>>', { desc = 'Increase window width' })

  -- Toggle Commands
  vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm 1<CR>', { desc = 'Toggle Terminal 1' })

  -- Open Commands
  vim.keymap.set('n', '<leader>of', '<cmd>Neotree toggle<CR>', { desc = '[O]pen [F]ile Tree' })
  vim.keymap.set('n', '<leader>ou', '<cmd>UndotreeToggle<CR>', { desc = '[O]pen [U]ndotree' })
  vim.keymap.set('n', '<leader>ot', ':ToggleTerm ', { desc = '[O]pen [T]erminal...' })
  vim.keymap.set('n', '<leader>ow', '<cmd>Telescope workspaces<CR>', { desc = '[O]pen [W]orkspace' })
  vim.keymap.set('n', '<leader>on', '<cmd>Neotest summary<CR>', { desc = '[O]pen [N]eotest panel' })

  -- Project Commands
  vim.keymap.set('n', '<leader>pvs', '<cmd>VenvSelect<cr>', { desc = '[P]roject [V]irtualenv [S]elect' })

  -- Tab Commands
  vim.keymap.set('n', '<leader>rt', function()
    local tab_name = require 'tabby.feature.tab_name'
    return '<cmd>silent Tabby rename_tab ' .. vim.fn.input('New tab name: ', tab_name.get(0)) .. '<CR>'
  end, { desc = '[R]ename [T]ab' })

  -- Noice commands
  vim.keymap.set('n', '<leader>nd', '<cmd>NoiceDismiss<cr>', { desc = '[N]oice [D]ismiss' })
end

function M.set_telescope_keymaps()
  local telescope = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>sh', telescope.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', telescope.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', telescope.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>ss', telescope.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set('n', '<leader>sw', telescope.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', telescope.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', telescope.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', telescope.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>sc', telescope.commands, { desc = '[S]earch [C]ommands' })
  vim.keymap.set('n', '<leader>sb', telescope.buffers, { desc = '[S]earch [B]uffers' })

  vim.keymap.set('n', '<leader>s.', function()
    telescope.oldfiles { only_cwd = true }
  end, { desc = '[S]earch Recent Files ("." for repeat)' })

  vim.keymap.set('n', '<leader>/', function()
    telescope.current_buffer_fuzzy_find { previewer = false }
  end, { desc = '[/] Fuzzily search in current buffer' })

  -- It's also possible to pass additional configuration options.
  --  See `:help telescope.builtin.live_grep()` for information about particular keys
  -- vim.keymap.set('n', '<leader>s/', function()
  --   builtin.live_grep {
  --     grep_open_files = true,
  --     prompt_title = 'Live Grep in Open Files',
  --   }
  -- end, { desc = '[S]earch [/] in Open Files' })

  -- Shortcut for searching your Neovim configuration files
  vim.keymap.set('n', '<leader>sn', function()
    telescope.find_files { cwd = vim.fn.stdpath 'config' }
  end, { desc = '[S]earch [N]eovim files' })
end

-- This function is called at LspAttach event in callback
-- Assumes that telescope is installed
function M.set_lsp_keymaps(event)
  local map = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
  end

  local telescope = require 'telescope.builtin'

  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  map('gd', telescope.lsp_definitions, '[G]oto [D]efinition')

  -- Jump to type definition of a symbol under your cursor
  map('gD', telescope.lsp_type_definitions, '[G]oto Type [D]efinition')

  -- Find references for the word under your cursor.
  map('gr', telescope.lsp_references, '[G]oto [R]eferences')

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  map('gI', telescope.lsp_implementations, '[G]oto [I]mplementation')

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  map('<leader>sds', telescope.lsp_document_symbols, '[S]earch [D]ocument [S]ymbols')

  -- Fuzzy find all the symbols in your current workspace.
  --  Similar to document symbols, except searches over your entire project.
  map('<leader>sws', telescope.lsp_dynamic_workspace_symbols, '[S]earch [W]orkspace [S]ymbols')

  -- Rename the variable under your cursor.
  --  Most Language Servers support renaming across files, etc.
  map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  -- Opens a popup that displays documentation about the word under your cursor
  --  See `:help K` for why this keymap.
  map('K', vim.lsp.buf.hover, 'Hover Documentation')

  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    map('<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
    end, '[T]oggle Inlay [H]ints')
  end
end

function M.set_toggleterm_keymaps()
  local function _lazygit_toggle()
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new {
      cmd = 'lazygit',
      hidden = true,
      direction = 'float',
      on_close = function(term)
        term.on_close = nil
        term:shutdown()
      end,
    }
    lazygit:open()
  end

  vim.keymap.set('n', '<leader>og', _lazygit_toggle, { desc = '[O]pen Lazy[G]it' })
end

function M.set_dap_keymaps()
  local dap, dapui = require 'dap', require 'dapui'
  vim.keymap.set('n', '<leader>tD', dapui.toggle, { desc = '[T]oggle [D]AP UI' })
  vim.keymap.set('n', '<leader>tB', function()
    dap.toggle_breakpoint()
  end, { desc = '[T]oggle [B]reakpoint' })
end

function M.set_dbee_keymaps()
  local dbee = require 'dbee'
  vim.keymap.set('n', '<leader>od', dbee.toggle, { desc = '[O]pen [D]bee UI' })
end

function M.set_capslock_keymaps()
  local capslock = require 'capslock'
  local function get_toggle(mode)
    return function()
      capslock.toggle(mode)
    end
  end
  vim.keymap.set('n', '<leader>tl', get_toggle 'n', { desc = '[T]oggle soft Caps[L]ock' })
  vim.keymap.set('i', '<C-j>', get_toggle 'i', { desc = 'Toggle soft CapsLock' })
  vim.keymap.set('c', '<C-j>', get_toggle 'c', { desc = 'Toggle soft CapsLock' })
end

return M
