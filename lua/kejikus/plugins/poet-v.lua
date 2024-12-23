return {
  {
    'petobens/poet-v', -- Activate/deactivate Python virtualenv
    enabled = false,
    config = function()
      -- Install pynvim dependency if it does not exist in host interpreter
      local ret = vim.system({ vim.g.python3_host_prog, '-c', 'import pynvim' }):wait()
      if ret.code ~= 0 then
        vim.system({ vim.g.python3_host_prog, '-m', 'pip', 'install', 'pynvim' }, {}, function()
          vim.print('Pynvim installed to ' + vim.g.python3_host_prog)
        end)
      end
    end,
  },
}
