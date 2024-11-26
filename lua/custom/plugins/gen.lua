return {
  'David-Kunz/gen.nvim',
  config = function()
    require('gen').setup {
      model = 'llama3.2', -- The default model to use.
      quit_map = 'q', -- Keymap to close the response window.
      retry_map = '<c-r>', -- Keymap to re-send the current prompt.
      accept_map = '<c-cr>', -- Keymap to replace the previous selection with the last result.
      host = 'localhost', -- The host running the Ollama service.
      port = '11434', -- The port on which the Ollama service is listening.
      display_mode = 'float', -- The display mode. Options: "float", "split", "horizontal-split".
      show_prompt = false, -- Show the prompt submitted to Ollama.
      show_model = false, -- Display which model you are using at the beginning of your chat session.
      no_auto_close = false, -- Never close the window automatically.
      file = false, -- Write the payload to a temporary file to keep the command short.
      hidden = false, -- Hide the generation window (requires Neovim >= 0.10).
      init = function(options)
        pcall(io.popen, 'ollama serve > /dev/null 2>&1 &') -- Initialize Ollama.
      end,
      command = function(options)
        local body = { model = options.model, stream = true }
        return 'curl --silent --no-buffer -X POST http://' .. options.host .. ':' .. options.port .. '/api/chat -d $body'
      end,
      debug = false, -- Print errors and the command being run.
      keys = {
        vim.keymap.set('n', '<leader>mg', ':Gen<cr>', { desc = 'AI gen' }),
      },
    }
  end,
}
