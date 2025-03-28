-- [[ Setting options ]]
-- vim.g.tundra_biome = 'artic'
-- FOR OBSIDIAN.NVIM
vim.opt.conceallevel = 1

vim.opt.foldmethod = 'indent'
vim.opt.foldlevelstart = 99
-- for highlight plugin
vim.opt.termguicolors = true

-- Make line numbers default
vim.opt.number = true

-- Relative line numbers
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 15

-- Disable in-line LSP Diagnostics. Shows Diagonostics only on hover
-- Disabling diagnostics to avoid LSP_Lines duplication
vim.diagnostic.config { virtual_text = false }
-- TODO: Might need to keymap the following:
-- Disable LSP_LINES WITH:
vim.diagnostic.config { virtual_lines = false }

-- Show line diagnostics automatically in hover window
-- vim.o.updatetime = 250
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- Hide deprecation warnings
vim.g.deprecation_warnings = false

-- oil auto shows buffer
vim.api.nvim_create_autocmd('User', {
  pattern = 'OilEnter',
  callback = vim.schedule_wrap(function(args)
    local oil = require 'oil'
    if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
      oil.open_preview()
    end
  end),
})
-- if vim.fn.has 'nvim-0.10' == 1 then
--   vim.opt.smoothscroll = true
--   vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
--   vim.opt.foldmethod = 'expr'
--   vim.opt.foldtext = ''
-- else
--   vim.opt.foldmethod = 'indent'
--   vim.opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
-- end
-- vim: ts=2 sts=2 sw=2 et
