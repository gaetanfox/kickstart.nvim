return {
  {
    'AckslD/nvim-FeMaco.lua',

    config = function()
      require('femaco').setup {}
      vim.g.markdown_fenced_languages = { 'python', 'cpp', 'go' }
    end,
  },
}
