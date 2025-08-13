return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', enabled = false },

      -- 'lazydev' replaces 'neodev' for nvim >= 0.10
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        dependencies = {
          {
            'hrsh7th/nvim-cmp',
            opts = function(_, opts)
              opts.sources = opts.sources or {}
              table.insert(opts.sources, {
                name = 'lazydev',
                group_index = 0, -- set group index to 0 to skip loading LuaLS completions
              })
            end,
          },
        },
        opts = {
          library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
    },
    config = function()
      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          require('kejikus.config.remaps').set_lsp_keymaps(event)

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            require('kejikus.config.autocommands').enable_lsp_highlight(event)
          end

          -- Disable some capabilities of "pylsp" to remove conflicts with basedpyright
          if client and client.name == 'pylsp' and client.server_capabilities then
            client.server_capabilities.hoverProvider = false
            client.server_capabilities.renameProvider = false
            client.server_capabilities.signatureHelpProvider = nil
            client.server_capabilities.definitionProvider = nil
          end
        end,
      })

      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Add capabilities of nvim-ufo folding plugin
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      --- Setup capabilities to support utf-16, since copilot.lua only works with utf-16
      --- this is a workaround to the limitations of copilot language server
      capabilities = vim.tbl_deep_extend('force', capabilities, {
        offsetEncoding = { 'utf-16' },
        general = {
          positionEncodings = { 'utf-16' },
        },
      })

      -- Enable the following language servers
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = require 'kejikus.plugins.lspconfig.servers'

      local disabled_servers = {
        -- 'basedpyright',
      }

      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      for server_name, server in pairs(servers) do
        if vim.tbl_contains(disabled_servers, server_name) then
          return
        end
        -- This handles overriding only values explicitly passed
        -- by the server configuration above. Useful when disabling
        -- certain features of an LSP (for example, turning off formatting for tsserver)
        server.capabilities = vim.tbl_deep_extend('keep', {}, capabilities, server.capabilities or {})
        vim.lsp.config(server_name, server)
      end

      require('mason-lspconfig').setup()
    end,
  },
}
