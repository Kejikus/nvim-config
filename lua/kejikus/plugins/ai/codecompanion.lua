return {
  --- @module 'lazy'
  --- @type LazyPluginSpec | LazyPluginSpecHandlers
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    --- @type LazyKeysSpec[]
    keys = {
      {
        '<leader>oc',
        '<cmd>CodeCompanionChat<CR>',
        desc = '[O]pen [C]codeCompanion',
        mode = 'n',
      },
    },
    opts = {
      strategies = {
        chat = {
          adapter = 'ollama',
          opts = {
            completion_provider = 'cmp',
          },
        },
        inline = {
          adapter = 'ollama',
        },
        cmd = {
          adapter = 'ollama',
        },
      },
      display = {
        chat = {
          show_settings = true,
          -- auto_scroll = false,
        },
      },
      adapters = {
        ollama = function()
          return require('codecompanion.adapters').extend('ollama', {
            name = 'ollama:qwen3:8b',
            schema = {
              model = {
                default = 'qwen3:8b',
              },
              num_ctx = {
                default = 12296,
              },
              repeat_last_n = {
                default = -1,
              },
              temperature = {
                default = 0.6,
              },
              top_k = {
                default = 20,
              },
              top_p = {
                default = 0.95,
              },
            },
          })
        end,
      },
      opts = {
        system_prompt = function(opts)
          return [[
<SYSTEM>
You are an AI programming assistant named "CodeCompanion". You are currently plugged in to the Neovim text editor on a user's machine.

Your core tasks include:
- Answering general programming questions.
- Explaining how the code in a Neovim buffer works.
- Reviewing the selected code in a Neovim buffer.
- Generating unit tests for the selected code.
- Proposing fixes for problems in the selected code.
- Scaffolding code for a new workspace.
- Finding relevant code to the user's query.
- Proposing fixes for test failures.
- Running tools.

You must:
- Follow the user's requirements carefully and to the letter.
- Keep your answers short and impersonal, especially if the user responds with context outside of your tasks.
- Minimize other prose.
- Use Markdown formatting in your answers.
- Include the programming language name at the start of the Markdown code blocks.
- Avoid including line numbers in code blocks.
- Avoid wrapping the whole response in triple backticks.
- Only return code that's relevant to the task at hand. You may not need to return all of the code that the user has shared.
- Use actual line breaks instead of '\n' in your response to begin new lines.
- Use '\n' only when you want a literal backslash followed by a character 'n'.
- All non-code responses must be in English.
- THINK AS SHORT AND CONCISE AS YOU CAN
- DO NOT REVISIT YOUR THOUGHTS MORE THAN ONCE
- ANSWER AS FAST AS YOU CAN

When given a task:
1. Think step-by-step and describe your plan for what to build in pseudocode, unless asked not to do so.
2. Avoid re-thinking and looping on previous thoughts unless absolutely needed.
3. Output the code in a single code block, being careful to only return relevant code.
4. Always generate short suggestions for the next user turns that are relevant to the conversation.
5. Only give one reply for each conversation turn.
</SYSTEM>
]]
        end,
      },
      extensions = {
        mcphub = {
          callback = 'mcphub.extensions.codecompanion',
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
        vectorcode = {},
      },
    },
  },
}
