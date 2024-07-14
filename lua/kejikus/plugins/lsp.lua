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
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          require('kejikus.config.remaps').set_lsp_keymaps(event)

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            require('kejikus.config.autocommands').enable_lsp_highlight(event)
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

      -- Enable the following language servers
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --

        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                diagnosticSeverityOverrides = {
                  reportAny = false,
                  reportInvalidCast = false,
                  reportUnusedCallResult = false,
                  reportImplicitOverride = false,
                  reportIgnoreCommentWithoutRule = false,
                  reportMatchNotExhaustive = 'information',
                  reportUntypedFunctionDecorator = 'information',
                  reportUnusedFunction = 'information',
                  reportImplicitStringConcatenation = 'information',
                  reportMissingTypeStubs = 'information',
                  reportUnknownMemberType = 'information',
                  reportUnknownVariableType = 'information',
                  reportUnknownParameterType = false,
                  reportMissingParameterType = false,
                  reportMissingTypeArgument = false,
                },
              },
            },
          },
        },

        -- pylsp has plugins that are not installed by default
        -- Use :PylspInstall to install them
        pylsp = {
          settings = {
            pylsp = {
              configurationSources = { 'flake8' },
              plugins = {
                -- formatters
                black = { enabled = true },
                autopep8 = { enabled = false },
                yapf = { enabled = false },

                -- linters
                flake8 = {
                  enabled = true,
                  maxLineLength = 120,
                  indentSize = 4,
                },
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },

                -- type checkers
                pyre = { enabled = true },
                mypy = { enabled = true },

                -- autocompletion
                jedi_completion = { fuzzy = true },
                rope_autoimport = {
                  enabled = true,
                  memory = true,
                },

                -- import sorter
                pyls_isort = { enabled = true },
              },
            },
          },
        },

        pyre = {
          root_dir = function(filename, _)
            -- see :h lspconfig-root-detection
            local root_files = {
              'pyproject.toml',
              'requirements.txt',
            }
            return require('lspconfig').util.root_pattern(unpack(root_files))(filename)
          end,
        },

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        stylua = {}, -- Used to format Lua code
      }

      local disabled_servers = {
        -- 'basedpyright',
        'pyre',
      }

      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            if vim.tbl_contains(disabled_servers, server_name) then
              return
            end
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
