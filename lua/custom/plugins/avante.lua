return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  lazy = false,
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  opts = {
    ---@alias Provider  "openai" | "gemini"  | "copilot" | "copilot_claude" | string
    provider = 'copilot', -- Using Claude 3.7 Sonnet
    -- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
    -- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
    -- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
    openai = {
      hide_in_model_selector = true,
    },
    vendors = {
      copilot_claude = {
        __inherited_from = 'copilot',
        model = 'claude-3.5-sonnet',
        hide_in_model_selector = true,
      },
    },
    auto_suggestions_provider = 'copilot_claude',
    -- claude = {
    --   endpoint = 'https://api.anthropic.com',
    --   model = 'claude-3-5-sonnet-20241022',
    --   temperature = 0,
    --   max_tokens = 4096,
    -- },
    -- add any opts here
    -- for example
    -- provider = 'openai',
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = 'make',
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    {
      -- support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
