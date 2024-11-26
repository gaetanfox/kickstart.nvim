return {
  {
    'Kurama622/markdown-org',
    ft = 'markdown',
    config = function()
      return {
        default_quick_keys = 0,
        vim.api.nvim_set_var('org#style#border', 1),
        vim.api.nvim_set_var('org#style#bordercolor', 'FloatBorder'),
        vim.api.nvim_set_var('org#style#color', 'String'),
        language_path = {
          python3 = 'python3',
          go = 'go',
        },
      }
    end,
    keys = {
      { '<leader>mr', ':MdEval', { desc = 'run and eval code in md files' } },
      { '<leader>ml', ':MdEval', { desc = 'run and eval code in md files' } },
      -- { '<leader>ml', '<cmd>call org#main#runLanguage()<cr>' },
    },
  },
}
