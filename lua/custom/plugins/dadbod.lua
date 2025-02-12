return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    -- DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    -- vim.g.dbs = {
    --   dev = 'postgres://gaetanfox:gaetan070114@localhost:5432/sql_course',
    --   -- staging = 'postgres://postgres:mypassword@localhost:5432/my-staging-db',
    --   -- wp = 'mysql://root@localhost/wp_awesome',
    --   -- production = function()
    --   --   return 'postgres://production_user:secure_password@production-server:5432/production_db'
    --   -- end,
    -- }

    -- Keybind to toggle Dadbod UI
    vim.keymap.set('n', '<Leader>td', ':DBUIToggle<CR>', { desc = '[T]oggle [D]adbod' })
  end,
}
