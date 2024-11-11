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

-- obsidian
vim.keymap.set('n', '<leader>on', ':ObsidianNew <cr>', { desc = '[O]bsidian [N]ew Note' })
vim.keymap.set('n', '<leader>oo', ':ObsidianOpen <cr>', { desc = '[O]bsidian [O]pen Note' })
vim.keymap.set('n', '<leader>os', ':ObsidianSearch <cr>', { desc = '[O]bsidian [S]earch Note' })
-- vim.keymap.set('n', '<leader>ot', ':ObsidianToday <cr>', { desc = '[O]bsidian [T]oday Note' })
vim.keymap.set('n', '<leader>or', ':ObsidianRename <cr>', { desc = '[O]bsidian [R]ename Note' })

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
local function remove_python_comments()
  -- Remove single-line comments
  vim.cmd [[%s/^\s*#.*//g]]
  -- Remove multi-line comments with '''
  vim.cmd [[silent! %s/\v(''')[\s\S]+%1//g]]
  -- Remove multi-line comments with """
  vim.cmd [[silent! %s/\v(""")[\s\S]+%1//g]]
end

-- Map the function to a key combination in normal mode
-- vim.api.nvim_set_keymap('n', '<leader>cs', '<cmd>lua remove_python_comments()<CR>', { noremap = true, silent = true })
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

-- Replaces the word I'm currently on, opens a terminal so that I start typing the new word
-- It replaces the word globally across the entire file
vim.keymap.set('n', '<leader>su', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "[P]Replace word I'm currently on GLOBALLY" })

-- Replaces the current word with the same word in uppercase, globally
vim.keymap.set(
  'n',
  '<leader>sU',
  [[:%s/\<<C-r><C-w>\>/<C-r>=toupper(expand('<cword>'))<CR>/gI<Left><Left><Left>]],
  { desc = "[P]GLOBALLY replace word I'm on with UPPERCASE" }
)

-- Replaces the current word with the same word in lowercase, globally
vim.keymap.set(
  'n',
  '<leader>sL',
  [[:%s/\<<C-r><C-w>\>/<C-r>=tolower(expand('<cword>'))<CR>/gI<Left><Left><Left>]],
  { desc = "[P]GLOBALLY replace word I'm on with lowercase" }
)

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
-- ############################################################################

-- Open image under cursor in the Preview app (macOS)
vim.keymap.set('n', '<leader>io', function()
  local function get_image_path()
    -- Get the current line
    local line = vim.api.nvim_get_current_line()
    -- Pattern to match image path in Markdown
    local image_pattern = '%[.-%]%((.-)%)'
    -- Extract relative image path
    local _, _, image_path = string.find(line, image_pattern)

    return image_path
  end
  -- Get the image path
  local image_path = get_image_path()
  if image_path then
    -- Check if the image path starts with "http" or "https"
    if string.sub(image_path, 1, 4) == 'http' then
      print "URL image, use 'gx' to open it in the default browser."
    else
      -- Construct absolute image path
      local current_file_path = vim.fn.expand '%:p:h'
      local absolute_image_path = current_file_path .. '/' .. image_path

      -- Construct command to open image in Preview
      local command = 'open -a Preview ' .. vim.fn.shellescape(absolute_image_path)
      -- Execute the command
      local success = os.execute(command)

      if success then
        print('Opened image in Preview: ' .. absolute_image_path)
      else
        print('Failed to open image in Preview: ' .. absolute_image_path)
      end
    end
  else
    print 'No image found under the cursor'
  end
end, { desc = '[P](macOS) Open image under cursor in Preview' })

-- ############################################################################

-- Open image under cursor in Finder (macOS)
--
-- THIS ONLY WORKS IF YOU'RE NNNNNOOOOOOTTTTT USING ABSOLUTE PATHS,
-- BUT INSTEAD YOURE USING RELATIVE PATHS
--
-- If using absolute paths, use the default `gx` to open the image instead
vim.keymap.set('n', '<leader>if', function()
  local function get_image_path()
    -- Get the current line
    local line = vim.api.nvim_get_current_line()
    -- Pattern to match image path in Markdown
    local image_pattern = '%[.-%]%((.-)%)'
    -- Extract relative image path
    local _, _, image_path = string.find(line, image_pattern)

    return image_path
  end
  -- Get the image path
  local image_path = get_image_path()
  if image_path then
    -- Check if the image path starts with "http" or "https"
    if string.sub(image_path, 1, 4) == 'http' then
      print "URL image, use 'gx' to open it in the default browser."
    else
      -- Construct absolute image path
      local current_file_path = vim.fn.expand '%:p:h'
      local absolute_image_path = current_file_path .. '/' .. image_path
      -- Open the containing folder in Finder and select the image file
      local command = 'open -R ' .. vim.fn.shellescape(absolute_image_path)
      local success = vim.fn.system(command)
      if success == 0 then
        print('Opened image in Finder: ' .. absolute_image_path)
      else
        print('Failed to open image in Finder: ' .. absolute_image_path)
      end
    end
  else
    print 'No image found under the cursor'
  end
end, { desc = '[P](macOS) Open image under cursor in Finder' })

-- ############################################################################

-- Delete image file under cursor using trash app (macOS)
vim.keymap.set('n', '<leader>id', function()
  local function get_image_path()
    local line = vim.api.nvim_get_current_line()
    local image_pattern = '%[.-%]%((.-)%)'
    local _, _, image_path = string.find(line, image_pattern)
    return image_path
  end
  local image_path = get_image_path()
  if not image_path then
    vim.api.nvim_echo({ { 'No image found under the cursor', 'WarningMsg' } }, false, {})
    return
  end
  if string.sub(image_path, 1, 4) == 'http' then
    vim.api.nvim_echo({ { 'URL image cannot be deleted from disk.', 'WarningMsg' } }, false, {})
    return
  end
  local current_file_path = vim.fn.expand '%:p:h'
  local absolute_image_path = current_file_path .. '/' .. image_path
  -- Check if file exists
  if vim.fn.filereadable(absolute_image_path) == 0 then
    vim.api.nvim_echo({ { 'Image file does not exist:\n', 'ErrorMsg' }, { absolute_image_path, 'ErrorMsg' } }, false, {})
    return
  end
  if vim.fn.executable 'trash' == 0 then
    vim.api.nvim_echo({
      { '- Trash utility not installed. Make sure to install it first\n', 'ErrorMsg' },
      { '- In macOS run `brew install trash`\n', nil },
    }, false, {})
    return
  end
  vim.ui.select({ 'yes', 'no' }, { prompt = 'Delete image file? ' }, function(choice)
    if choice == 'yes' then
      local success, _ = pcall(function()
        vim.fn.system { 'trash', vim.fn.fnameescape(absolute_image_path) }
      end)
      -- Verify if file still exists after deletion attempt
      if success and vim.fn.filereadable(absolute_image_path) == 1 then
        -- Try with rm if trash deletion failed
        -- Keep in mind that if deleting with `rm` the images won't go to the
        -- macos trash app, they'll be gone
        -- This is useful in case trying to delete imaes mounted in a network
        -- drive, like for my blogpost lamw25wmal
        vim.ui.select({ 'yes', 'no' }, { prompt = 'Trash deletion failed. Try with rm command? ' }, function(rm_choice)
          if rm_choice == 'yes' then
            local rm_success, _ = pcall(function()
              vim.fn.system { 'rm', vim.fn.fnameescape(absolute_image_path) }
            end)
            if rm_success and vim.fn.filereadable(absolute_image_path) == 0 then
              vim.api.nvim_echo({
                { 'Image file deleted from disk using rm:\n', 'Normal' },
                { absolute_image_path, 'Normal' },
              }, false, {})
              require('image').clear()
              vim.cmd 'edit!'
              vim.cmd 'normal! dd'
            else
              vim.api.nvim_echo({
                { 'Failed to delete image file with rm:\n', 'ErrorMsg' },
                { absolute_image_path, 'ErrorMsg' },
              }, false, {})
            end
          end
        end)
      elseif success and vim.fn.filereadable(absolute_image_path) == 0 then
        vim.api.nvim_echo({
          { 'Image file deleted from disk:\n', 'Normal' },
          { absolute_image_path, 'Normal' },
        }, false, {})
        require('image').clear()
        vim.cmd 'edit!'
        vim.cmd 'normal! dd'
      else
        vim.api.nvim_echo({
          { 'Failed to delete image file:\n', 'ErrorMsg' },
          { absolute_image_path, 'ErrorMsg' },
        }, false, {})
      end
    else
      vim.api.nvim_echo({ { 'Image deletion canceled.', 'Normal' } }, false, {})
    end
  end)
end, { desc = '[P](macOS) Delete image file under cursor' })

-- ############################################################################

-- Refresh the images in the current buffer
-- Useful if you delete an actual image file and want to see the changes
-- without having to re-open neovim
vim.keymap.set('n', '<leader>ir', function()
  -- First I clear the images
  require('image').clear()
  -- I'm using [[ ]] to escape the special characters in a command
  -- vim.cmd([[lua require("image").clear()]])
  -- Reloads the file to reflect the changes
  vim.cmd 'edit!'
  print 'Images refreshed'
end, { desc = '[P]Refresh images' })

-- ############################################################################

-- Set up a keymap to clear all images in the current buffer
vim.keymap.set('n', '<leader>ic', function()
  -- This is the command that clears the images
  require('image').clear()
  -- I'm using [[ ]] to escape the special characters in a command
  -- vim.cmd([[lua require("image").clear()]])
  print 'Images cleared'
end, { desc = '[P]Clear images' })
