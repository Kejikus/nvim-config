return {
  {
    'Davidyz/VectorCode',
    version = '0.7.7', -- Should be equal to the version in the Mason
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    cmd = 'VectorCode',
    opts = {
      on_setup = {
        update = false,
        lsp = true,
      },
      async_backend = 'lsp',
    },
  },
}
