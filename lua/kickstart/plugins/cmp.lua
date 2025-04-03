-- lua/kickstart/plugins/cmp.lua (or wherever this file is)

return { -- Autocompletion
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- Make sure lspconfig is listed as a dependency HERE
    'neovim/nvim-lspconfig', -- <<< ADD THIS LINE

    -- Other dependencies remain...
    {
      'zbirenbaum/copilot.lua',
      config = function()
        require('copilot').setup {
          suggestion = { enabled = false },
          panel = { enabled = false },
        }
      end,
    },
    {
      'zbirenbaum/copilot-cmp',
      after = { 'copilot.lua' },
      config = function()
        require('copilot_cmp').setup()
      end,
    },
    {
      'L3MON4D3/LuaSnip',
      build = function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end,
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
    },
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-buffer',
    'habamax/vim-godot', -- Still consider if this is needed alongside LSP
    'onsails/lspkind.nvim',
  },
  config = function()
    -- See :help cmp
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    luasnip.config.setup {}
    local lspkind = require 'lspkind'
    -- No need to require lspconfig here IF it's just for the setup call later

    cmp.setup {
      -- ... (rest of your cmp.setup remains the same) ...
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
      },
      formatting = {
        format = lspkind.cmp_format {
          mode = 'symbol_text',
          maxwidth = 50,
          ellipsis_char = '...',
          symbol_map = { Copilot = '' },
        },
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'copilot' },
        { name = 'luasnip' },
        { name = 'godot' },
        { name = 'path' },
      }, {
        { name = 'buffer', keyword_length = 5 },
        { name = 'cmdline' },
      }),
      preselect = cmp.PreselectMode.None,
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      experimental = {
        -- ghost_text = true,
      },
    } -- End of cmp.setup

    -- Conditional Godot LSP setup
    local function check_is_godot_project()
      local project_file = vim.fn.findfile('project.godot', '.;')
      return project_file and project_file ~= ''
    end

    local is_godot_project = check_is_godot_project()
    if is_godot_project then
      -- Now that nvim-lspconfig is guaranteed to be loaded (due to dependency),
      -- this pcall should find the 'godot' config.
      pcall(function()
        local lspconfig = require 'lspconfig' -- Require it inside the pcall scope
        if lspconfig.godot then
          lspconfig.godot.setup {
            on_attach = function(_, bufnr)
              vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
              local opts = { noremap = true, silent = true, buffer = bufnr }
              vim.keymap.set('n', '<C-CR>', vim.lsp.buf.signature_help, opts)
              -- Add other LSP keymaps here if needed
            end,
          }
          print 'Godot LSP setup attempted.' -- Changed message slightly
        else
          -- This branch shouldn't be hit if lspconfig loaded correctly
          print '[Error] lspconfig.godot still not found after declaring dependency.'
        end
      end)
    end
  end,
}
