-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true
-- Add relative line numbers, keep absolute number for current line
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
vim.o.laststatus = 3

-- Sync clipboard between OS and Neovim.
-- vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Indenting options
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.softtabstop = 2

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 150

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Show colored wall at 100 chars
vim.opt.colorcolumn = { '100', '120' }

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = false

-- Set search to be incremental (highlight as you type)
vim.opt.incsearch = true

-- Always show tabline
vim.o.showtabline = 2

-- Concealed text is hidden unless there are display character assigned
-- Needed for obsidian.nvim
vim.o.conceallevel = 2

-- Disable timeout for key combinations
-- NOTE: Disabled because of which-key.nvim bug with surround plugins
vim.o.timeout = false

-- [[ Folding ]]
-- vim.opt.foldenable = true
-- vim.opt.foldcolumn = '1'
-- vim.opt.foldlevel = 99
-- vim.opt.foldlevelstart = 99

-- [[ Diagnostics ]]
vim.diagnostic.config {
  severity_sort = { reverse = true },
  virtual_text = { severity = { min = vim.diagnostic.severity.WARN } },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
  },
}

-- [[ Language mapping ]]
local function escape(str)
  -- These chars must be escaped in the langmap
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

-- Shift-modified char sets
local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]
-- Normal char sets
-- Here we don't want to have ',.' to 'бю' remaps to avoid recusive calls
local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]

--  `to` should be first ; `from` should be second
vim.opt.langmap = vim.fn.join({
  escape(ru_shift) .. ';' .. escape(en_shift),
  escape(ru) .. ';' .. escape(en),
}, ',')

-- [[ Providers ]]
-- Disable some default providers
vim.g.loaded_node_provider = 0
-- vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Add binaries installed by mason.nvim to path
local is_windows = vim.fn.has 'win32' ~= 0
vim.env.PATH = vim.fn.stdpath 'data' .. '/mason/bin' .. (is_windows and ';' or ':') .. vim.env.PATH
