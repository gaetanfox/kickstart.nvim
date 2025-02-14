return {
  'onsails/lspkind-nvim',
  config = function()
    local lspkind = require 'lspkind'
    local cmp = require 'cmp' -- Make sure cmp is required

    cmp.setup {
      formatting = {
        format = lspkind.cmp_format {
          mode = 'symbol',
          maxwidth = {
            menu = 50,
            abbr = 50,
          },
          ellipsis_char = '...',
          show_labelDetails = true,
          before = function(entry, vim_item)
            return vim_item
          end,
        },
      },
    }
  end,
}
