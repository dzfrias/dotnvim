return {
  -- Rust
  {
    'simrat39/rust-tools.nvim',
    ft = { 'rust', 'toml' },
    opts = function()
      local rt = require 'rust-tools'
      local data = vim.fn.stdpath 'data'
      -- Path to liblldb, installed with Mason
      local liblldb = data
        .. '/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib'
      -- Path to codelldb, installed with Mason
      local codelldb = data
        .. '/mason/packages/codelldb/extension/adapter/codelldb'
      return {
        tools = {
          inlay_hints = {
            auto = false,
          },
        },

        server = {
          on_attach = function(_, bufnr)
            vim.api.nvim_set_option_value(
              'omnifunc',
              'v:lua.vim.lsp.omnifunc',
              { buf = bufnr }
            )
            local bufopts = { noremap = true, silent = true, buffer = bufnr }

            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', '<leader>n', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)

            vim.keymap.set(
              'n',
              '<s-k>',
              rt.hover_actions.hover_actions,
              bufopts
            )
            vim.keymap.set(
              { 'n', 'v' },
              '<leader>a',
              vim.lsp.buf.code_action,
              bufopts
            )
          end,

          settings = {
            ['rust-analyzer'] = {
              files = {
                excludeDirs = { 'website', 'dist' },
              },
              assist = {
                importEnforceGranularity = true,
                importPrefix = 'crate',
              },
              cargo = {
                allFeatures = true,
              },
            },
          },
        },

        dap = {
          -- Setup for codelldb
          adapter = require('rust-tools.dap').get_codelldb_adapter(
            codelldb,
            liblldb
          ),
        },
      }
    end,
  },

  -- Bacon rust tool integration
  {
    'Canop/nvim-bacon',
    cmd = 'BaconList',
    keys = {
      { '<leader>Bl', '<Cmd>BaconList<CR>', desc = 'Open bacon' },
      {
        '<leader>Bn',
        '<Cmd>BaconLoad<CR><Cmd>BaconNext<CR>',
        desc = 'Go to next bacon result',
      },
      {
        '<leader>Bp',
        '<Cmd>BaconLoad<CR><Cmd>BaconPrev<CR>',
        desc = 'Go to previous bacon result',
      },
    },
  },

  -- Emmet for vim
  { 'mattn/emmet-vim', ft = { 'html', 'htmldjango' } },

  -- Justfile syntax highlights
  { 'vmchale/just-vim', ft = 'just' },

  -- Inline colors
  {
    'rrethy/vim-hexokinase',
    build = 'make hexokinase',
    ft = { 'css', 'scss' },
  },
}
