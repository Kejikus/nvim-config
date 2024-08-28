local M = {}

function M.set_common_autocmd()
  -- Highlight when yanking (copying) text
  -- See `:help vim.highlight.on_yank()`
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
      vim.highlight.on_yank { timeout = 300 }
    end,
  })

  vim.api.nvim_create_autocmd('VimEnter', {
    desc = 'Set cwd if directory was opened on enter',
    group = vim.api.nvim_create_augroup('set-cwd-on-enter', { clear = true }),
    callback = function()
      local entry_dir = vim.fn.expand '%'
      if vim.fn.isdirectory(entry_dir) == 1 then
        vim.fn.chdir(entry_dir)
      end
    end,
  })

  vim.api.nvim_create_autocmd('BufWinEnter', {
    desc = 'Disable foldcolumn for unnecessary buffer types',
    callback = function()
      local buf_types = { 'nofile', 'help', 'terminal' }
      local btype = vim.o.buftype
      if vim.tbl_contains(buf_types, btype) then
        vim.wo.foldenable = false
        vim.wo.foldcolumn = '0'
      end
    end,
  })
end

-- Add documentation highlight on CursorHold
-- Used in LspAttach event callback
function M.enable_lsp_highlight(event)
  -- The following two autocommands are used to highlight references of the
  -- word under your cursor when your cursor rests there for a little while.
  --    See `:help CursorHold` for information about when this is executed
  --
  -- When you move your cursor, the highlights will be cleared (the second autocommand).

  local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    buffer = event.buf,
    group = highlight_augroup,
    callback = vim.lsp.buf.document_highlight,
  })

  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    buffer = event.buf,
    group = highlight_augroup,
    callback = vim.lsp.buf.clear_references,
  })

  vim.api.nvim_create_autocmd('LspDetach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
    callback = function(event2)
      vim.lsp.buf.clear_references()
      vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
    end,
  })
end

return M
