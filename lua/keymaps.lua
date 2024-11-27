-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>E', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<leader>e', '<CMD>Oil --float<CR>', { noremap = true, silent = true, desc = 'Oil [E]xplorer' })
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('n', '<leader>tt', ':ToggleTerm <cr>', { desc = '[T]oggle [T]erminal' })
vim.keymap.set('n', '<leader>ts', ':ToggleTerm direction=horizontal size=20<cr>', { desc = '[T]oggle [T]erminal' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
vim.keymap.set('t', 'jk', [[<C-\><C-n>]])
vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]])
vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]])
vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]])
vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]])
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]])

-- split resizing
vim.keymap.set('n', '<M-Right>', '<c-w>10<', { desc = '[W]indow increase right' })
vim.keymap.set('n', '<M-Left>', '<c-w>10>', { desc = '[W]indow increase left' })
vim.keymap.set('n', '<M-Down>', '<c-w>5-', { desc = '[W]indow decrease height' })
vim.keymap.set('n', '<M-Up>', '<c-w>5+', { desc = '[W]indow increase height' })

-- obsidian
vim.keymap.set('n', '<leader>on', ':ObsidianNew<cr>', { desc = '[O]bsidian [N]ew Note' })
vim.keymap.set('n', '<leader>oo', ':Toc<cr>', { desc = '[O]bsidian [O]pen TOC' })
vim.keymap.set('n', '<leader>oi', ':InsertNToc<cr>', { desc = '[O]bsidian [O]pen TOC' })
vim.keymap.set('n', '<leader>os', ':ObsidianSearch<cr>', { desc = '[O]bsidian [S]earch Note' })
vim.keymap.set('n', '<leader>ot', ':ObsidianToday<cr>', { desc = '[O]bsidian [T]oday Note' })
vim.keymap.set('n', '<leader>or', ':ObsidianRename<cr>', { desc = '[O]bsidian [R]ename Note' })

-- Remap jj or jk to escape insert mode
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Window Splitting
vim.keymap.set('n', '<leader>wv', ':vsplit<cr>', { desc = '[W]indow [V]ertical Split' })
vim.keymap.set('n', '<leader>wh', ':split<cr>', { desc = '[W]indow [H]orizontal Split' })

-- Window Save & Quit
vim.keymap.set('n', '<leader>wq', ':q<cr>', { desc = '[W]indow [Q]uit' })
vim.keymap.set('n', '<leader>ww', ':w<cr>', { desc = '[W]indow [W]rite' })
vim.keymap.set('n', '<leader>wc', ':bd<cr>', { desc = '[W]indow [C]lose' })
vim.keymap.set('n', '<leader>wn', ':bnext<cr>', { desc = '[W]indow [N]ext' })
vim.keymap.set('n', '<leader>wp', ':bprev<cr>', { desc = '[W]indow [P]rev' })

-- toggle undo tree
vim.keymap.set('n', '<leader>tu', ':UndotreeToggle<cr>', { desc = '[T]oggle [U]ndotree' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
--  TODO: figure out other helpful autocommands

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Define a Lua function to remove comments
function remove_python_comments()
  -- Remove single-line comments
  vim.cmd [[%s/^\s*#.*//g]]
  -- Remove multi-line comments with '''
  vim.cmd [[silent! %s/\v(''')[\s\S]+%1//g]]
  -- Remove multi-line comments with """
  vim.cmd [[silent! %s/\v(""")[\s\S]+%1//g]]
end

-- Map the function to a key combination in normal mode
vim.api.nvim_set_keymap('n', '<leader>cs', '<cmd>lua remove_python_comments()<CR>', { noremap = true, silent = true })
-- vim: ts=2 sts=2 sw=2 et

-- use gh to move to the beginning of the line in normal mode
-- use gl to move to the end of the line in normal mode
vim.keymap.set({ 'n', 'v' }, 'gh', '^', { desc = '[P]Go to the beginning line' })
vim.keymap.set({ 'n', 'v' }, 'gl', '$', { desc = '[P]go to the end of the line' })

-- When jumping with ctrl+d and u the cursors stays in the middle
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<c-u>', '<c-u>zz')

-- Move lines up and down in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = '[P]Move line down in visual mode' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = '[P]Move line up in visual mode' })

-- When you do joins with J it will keep your cursor at the beginning instead of at the end
vim.keymap.set('n', 'J', 'mzJ`z')

-- If this is a .go file, execute it in a tmux pane on the right
-- Using a tmux pane allows me to easily select text
-- Had to include quotes around "%" because there are some apple dirs that contain spaces, like iCloud
vim.keymap.set('n', '<leader>cg', function()
  local file = vim.fn.expand '%' -- Get the current file name
  if string.match(file, '%.go$') then -- Check if the file is a .go file
    local file_dir = vim.fn.expand '%:p:h' -- Get the directory of the current file
    -- local escaped_file = vim.fn.shellescape(file) -- Properly escape the file name for shell commands
    -- local command_to_run = "go run " .. escaped_file
    local command_to_run = 'go run *.go'
    -- `-l 60` specifies the size of the tmux pane, in this case 60 columns
    local cmd = "silent !tmux split-window -h -l 60 'cd "
      .. file_dir
      .. ' && echo "'
      .. command_to_run
      .. '\\n" && bash -c "'
      .. command_to_run
      .. '; echo; echo Press enter to exit...; read _"\''
    vim.cmd(cmd)
  else
    vim.cmd "echo 'Not a Go file.'" -- Notify the user if the file is not a Go file
  end
end, { desc = '[G]OLANG, execute file' })

-- If this is a .go file, execute it in a tmux pane on the right
-- Using a tmux pane allows me to easily select text
-- Had to include quotes around "%" because there are some apple dirs that contain spaces, like iCloud
vim.keymap.set('n', '<leader>cp', function()
  local file = vim.fn.expand '%' -- Get the current file name
  if string.match(file, '%.py$') then -- Check if the file is a .py file
    local file_dir = vim.fn.expand '%:p:h' -- Get the directory of the current file
    local command_to_run = 'py ' .. vim.fn.shellescape(file) -- Run the specific .py file

    -- Correctly format the Tmux command to keep the pane open
    local cmd = "silent !tmux split-window -h -l 60 'cd " .. file_dir .. ' && ' .. command_to_run .. "; echo; echo Press enter to exit...; read -n 1'"
    vim.cmd(cmd)
  else
    vim.cmd "echo 'Not a Python file.'" -- Notify the user if the file is not a Python file
  end
end, { desc = '[P]YTHON, execute file' })

-- Search and replace
vim.keymap.set('n', '<leader>ds', ':s/\\C', { desc = 'search and replace on line' })
vim.keymap.set('n', '<leader>dS', ':%s/\\C', { desc = 'search and replace in file' })

-- search registers in insert mode
vim.keymap.set('i', '<c-p>', function()
  require('telescope.builtin').registers()
end, { remap = true, silent = false, desc = 'Paste register in insert mode' })

-- delete mappings
vim.keymap.set('n', '<leader>df', ':%d_<cr>', { desc = 'delete file content to black hole register' })
