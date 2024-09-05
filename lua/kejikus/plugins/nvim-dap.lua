return {
  'mfussenegger/nvim-dap',
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'nvim-neotest/nvim-nio',
    },
    -- config = true,
    config = function()
      require('dapui').setup()

      require('kejikus.config.remaps').set_dap_keymaps()
      -- dap.listeners.before.attach.dapui_config = function()
      --   dapui.open()
      -- end
      -- dap.listeners.before.launch.dapui_config = function()
      --   dapui.open()
      -- end
      -- dap.listeners.before.event_terminated.dapui_config = function()
      --   dapui.close()
      -- end
      -- dap.listeners.before.event_exited.dapui_config = function()
      --   dapui.close()
      -- end
    end,
  },
  {
    'mfussenegger/nvim-dap-python',
    config = function()
      -- Install debugpy dependency if it does not exist in host interpreter
      local ret = vim.system({ vim.g.python3_host_prog, '-c', 'import debugpy' }):wait()
      if ret.code ~= 0 then
        vim.system({ vim.g.python3_host_prog, '-m', 'pip', 'install', 'debugpy' }, {}, function()
          vim.print('Debugpy installed to ' + vim.g.python3_host_prog)
        end)
      end
      require('dap-python').setup()
      require('dap').adapters.python = {
        type = 'executable',
        command = vim.g.python3_host_prog,
        args = { '-m', 'debugpy.adapter' },
      }
    end,
  },
}
