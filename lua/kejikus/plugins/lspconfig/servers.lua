return {
  -- clangd = {},
  -- rust_analyzer = {},
  -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
  --
  -- Some languages (like typescript) have entire language plugins that can be useful:
  --    https://github.com/pmizio/typescript-tools.nvim
  --
  -- But for many setups, the LSP (`tsserver`) will work just fine
  -- tsserver = {},
  --

  gopls = {},
  helm_ls = {},
  ['markdownlint-cli2'] = {},
  yamlls = {},
  gitlab_ci_ls = {},
  dockerls = {},
  bashls = {},

  basedpyright = {
    settings = {
      basedpyright = {
        -- disableLanguageServices = true,
        disableOrganizeImports = true,
        analysis = {
          diagnosticSeverityOverrides = {
            reportAny = false,
            reportDeprecated = false,
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
            reportUnknownArgumentType = 'information',
            reportUnknownParameterType = false,
            reportMissingParameterType = false,
            reportMissingTypeArgument = false,
            reportUnannotatedClassAttribute = false,
            reportUnintializedInstanceVariable = 'information',
            reportPrivateUsage = 'information',
            reportExplicitAny = false,
            reportCallIssue = 'information',
          },
        },
      },
    },
  },

  -- pylsp has plugins that are not installed by default
  -- Use :PylspInstall to install them
  pylsp = {
    on_attach = function(client, buffer)
      client.server_capabilities.hoverProvider = false
      client.server_capabilities.renameProvider = false
      client.server_capabilities.signatureHelpProvider = false
    end,
    settings = {
      pylsp = {
        configurationSources = { 'flake8' },
        plugins = {
          -- formatters
          black = { enabled = false },
          autopep8 = { enabled = false },
          yapf = { enabled = false },

          -- linters
          flake8 = { enabled = false },
          pyflakes = { enabled = false },
          pycodestyle = { enabled = false },
          ruff = { enabled = false },

          -- type checkers
          pyre = { enabled = false },
          mypy = { enabled = false },

          -- autocompletion
          jedi_completion = { fuzzy = true },
          rope_autoimport = {
            enabled = false,
            memory = true,
          },
          rope_completion = {
            enabled = true,
          },

          -- LSP services
          jedi_references = { enabled = false },
          jedi_hover = { enabled = false },

          -- import sorter
          pyls_isort = { enabled = false },

          mccabe = { enabled = false },
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
