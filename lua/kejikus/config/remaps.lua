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

  -- vim.keymap.set('n', '<A-h>', '<C-w><', { desc = 'Reduce window width' })
  -- vim.keymap.set('n', '<A-j>', '<C-w>-', { desc = 'Reduce window height' })
  -- vim.keymap.set('n', '<A-k>', '<C-w>+', { desc = 'Increase window height' })
  -- vim.keymap.set('n', '<A-l>', '<C-w>>', { desc = 'Increase window width' })

  -- Plugin Mappings
  vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm 1<CR>', { desc = 'Toggle Terminal 1' })

  -- Open Commands
  vim.keymap.set('n', '<leader>of', '<cmd>Neotree toggle<CR>', { desc = '[O]pen [F]ile Tree' })
  vim.keymap.set('n', '<leader>ou', '<cmd>UndotreeToggle<CR>', { desc = '[O]pen [U]ndotree' })
  vim.keymap.set('n', '<leader>ot', ':ToggleTerm ', { desc = '[O]pen [T]erminal...' })
  vim.keymap.set('n', '<leader>ow', '<cmd>Telescope workspaces<CR>', { desc = '[O]pen [W]orkspace' })

  -- Project Commands
  vim.keymap.set('n', '<leader>pva', function()
    vim.cmd.PoetvActivate()
    vim.cmd.LspRestart()
  end, { desc = '[P]roject [V]irtualenv [A]ctivate' })
  vim.keymap.set('n', '<leader>pvd', function()
    vim.cmd.PoetvDeactivate()
    vim.cmd.LspRestart()
  end, { desc = '[P]roject [V]irtualenv [D]eactivate' })

  -- Tab Commands
  vim.keymap.set('n', '<leader>rt', function()
    local tab_name = require 'tabby.feature.tab_name'
    return '<cmd>silent Tabby rename_tab ' .. vim.fn.input('New tab name: ', tab_name.get(0)) .. '<CR>'
  end, { desc = '[R]ename [T]ab' })
end

function M.set_telescope_keymaps()
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
  vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

  vim.keymap.set('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find { previewer = false }
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
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
  end, { desc = '[S]earch [N]eovim files' })
end

-- This function is called at LspAttach event in callback
-- Assumes that telescope is installed
function M.set_lsp_keymaps(event)
  local map = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
  end

  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

  -- Find references for the word under your cursor.
  map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

  -- Fuzzy find all the symbols in your current workspace.
  --  Similar to document symbols, except searches over your entire project.
  map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- Rename the variable under your cursor.
  --  Most Language Servers support renaming across files, etc.
  map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  -- Opens a popup that displays documentation about the word under your cursor
  --  See `:help K` for why this keymap.
  map('K', vim.lsp.buf.hover, 'Hover Documentation')

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header.
  map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    map('<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
    end, '[T]oggle Inlay [H]ints')
  end
end

function M.set_toggleterm_keymaps()
  local Terminal = require('toggleterm.terminal').Terminal
  local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float' }

  local function _lazygit_toggle()
    lazygit:toggle()
  end

  vim.keymap.set('n', '<leader>og', _lazygit_toggle, { desc = '[O]pen Lazy[G]it' })
end

return M
