return {
  'jubnzv/mdeval.nvim',
  config = function()
    require('mdeval').setup {
      -- Don't ask before executing code blocks
      require_confirmation = false,
      -- Change code blocks evaluation options.
      eval_options = {
        -- Set custom configuration for C++
        cpp = {
          command = { 'clang++', '-std=c++20', '-O0' },
          default_header = [[
            #include <iostream>
            #include <vector>
            using namespace std;
          ]],
        },
        -- Add new configuration for Go
        go = {
          command = { 'go', 'run' }, -- Command to run Go scripts
          language_code = 'go', -- Markdown language code
          exec_type = 'interpreted', -- Go scripts are executed directly
          extension = 'go', -- File extension for temporary files
        },
        -- Add new configuration for Python
        python = {
          command = { 'python3' }, -- Command to run Python scripts
          language_code = 'python', -- Markdown language code
          exec_type = 'interpreted', -- Python is interpreted
          extension = 'py', -- File extension for temporary files
        },
      },
    }
  end,
}
