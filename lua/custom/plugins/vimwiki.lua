return {
  {
    'vimwiki/vimwiki',
    init = function()
      -- Disable default mappings to avoid conflicts with custom ones
      vim.g.vimwiki_list = {
        {
          path = '~/vimwiki',
          syntax = 'markdown',
          ext = '.md',
          auto_export = 0,
          auto_toc = 1,
          auto_tags = 1,
          auto_diary_index = 1,
          diary_rel_path = 'journal/',
          syntax = 'markdown',
          template_path = '~/vimwiki/templates/',
          template_default = 'default',
          key_mappings = { all_maps = 0 },
        },
      }
    end,
  },
}
