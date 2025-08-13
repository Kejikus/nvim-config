return {
  {
    'ravitemer/mcphub.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    build = 'bundled_build.lua',
    opts = {
      use_bundled_binary = true,
      extensions = {
        -- avante = {
        --   make_slash_commands = true,
        -- },
      },
    },
  },
}
