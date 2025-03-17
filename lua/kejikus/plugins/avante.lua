return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-telescope/telescope.nvim',
      'hrsh7th/nvim-cmp',
      'nvim-tree/nvim-web-devicons',
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
    build = 'make',
    opts = {
      provider = 'ollama',
      auto_suggestions_provider = 'ollama',
      ollama = {
        -- model = 'qwen2.5-coder:7b-instruct-q8_0',
        model = 'deepseek-r1',
        -- endpoint = 'http://127.0.0.1:11434',
        -- max_tokens = 32000,
        -- timeout = 10000,
        -- options = {
        --   temperature = 0,
        --   num_ctx = 32000,
        -- },
      },
      vendors = {
        ollama_suggestions = {
          __inherited_from = 'ollama',
          model = 'qwen2.5-coder:3b-instruct-q8_0',
          max_tokens = 32000,
        },
      },

      suggestion = {
        debounce = 600,
        throttle = 300,
      },

      behaviour = {
        auto_suggestions = false,
        enable_cursor_planning_mode = true,
      },
    },
  },
}
