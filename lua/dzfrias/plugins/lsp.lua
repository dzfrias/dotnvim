return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'mason.nvim',
    },
    config = function()
      -- Remove semantic token highlighting for parameters
      vim.api.nvim_set_hl(0, '@lsp.type.parameter', {})
      -- Remove special highlighting for builtin methods and functions in Rust
      vim.api.nvim_set_hl(0, '@lsp.typemod.method.defaultLibrary.rust', {})
      vim.api.nvim_set_hl(0, '@lsp.typemod.function.defaultLibrary.rust', {})

      -- Key bindings
      local default_on_attach = function(_, bufnr)
        vim.api.nvim_set_option_value(
          'omnifunc',
          'v:lua.vim.lsp.omnifunc',
          { buf = bufnr }
        )

        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', '<s-k>', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', '<leader>n', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)
        vim.keymap.set(
          { 'n', 'v' },
          '<leader>a',
          vim.lsp.buf.code_action,
          bufopts
        )
      end

      -- Format on save
      local format = vim.api.nvim_create_augroup('format', {})
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = format,
        pattern = '*',
        command = 'lua vim.lsp.buf.format { async = true }',
      })

      -- Setup lspconfig capabilities
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Setting up servers
      local lspconfig = require 'lspconfig'
      local default_install = { 'pyright', 'gopls', 'svelte', 'sourcekit' }
      for _, lsp in ipairs(default_install) do
        lspconfig[lsp].setup {
          on_attach = default_on_attach,
          capabilities = capabilities,
        }
      end

      lspconfig.clangd.setup {
        on_attach = default_on_attach,
        capabilities = capabilities,
        cmd = { '/opt/homebrew/opt/llvm/bin/clangd' },
      }

      lspconfig.cssls.setup {
        on_attach = default_on_attach,
        capabilities = capabilities,
        init_options = {
          provideFormatter = false,
        },
      }

      lspconfig.yamlls.setup {
        on_attach = default_on_attach,
        capabilities = capabilities,
        settings = {
          yaml = {
            schemas = {
              ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
            },
          },
        },
      }

      lspconfig.ltex.setup {
        settings = {
          ltex = {
            additionalRules = {
              enablePickyRules = true,
            },
          },
        },
        on_attach = function(client, bufnr)
          require('ltex_extra').setup {
            path = vim.fn.expand '~' .. '/.config/nvim/ltex',
          }
          default_on_attach(client, bufnr)
        end,
        filetypes = { 'markdown', 'text', 'tex', 'gitcommit' },
        flags = { debounce_text_changes = 300 },
      }

      lspconfig.lua_ls.setup {
        on_attach = function(client, bufnr)
          default_on_attach(client, bufnr)
          -- Do not format code
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { 'vim', 'hs' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      }

      lspconfig.tsserver.setup {
        on_attach = function(client, bufnr)
          -- Formatting done with prettier via null-ls
          client.server_capabilities.documentFormattingProvider = false
          default_on_attach(client, bufnr)
        end,
        capabilities = capabilities,
      }

      local configs = require 'lspconfig.configs'
      configs.ast_grep = {
        default_config = {
          cmd = { 'sg', 'lsp' },
          filetypes = { 'cs' },
          single_file_support = true,
          root_dir = require('lspconfig.util').root_pattern(
            '.git',
            'sgconfig.yml'
          ),
        },
      }

      lspconfig.ast_grep.setup {}
    end,
  },

  -- Generic language server
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'mason.nvim' },
    opts = function()
      local null_ls = require 'null-ls'
      return {
        sources = {
          -- Use black python formatter
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.swift_format,
          null_ls.builtins.diagnostics.swiftlint,
          -- Basic zsh linting
          null_ls.builtins.diagnostics.zsh,
          -- Lua autoformatting
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.formatting.prettier.with {
            extra_args = { '--prose-wrap', 'always' },
          },
          null_ls.builtins.diagnostics.mypy.with {
            extra_args = { '--python-executable', './venv/bin/python' },
          },
        },
      }
    end,
  },

  -- LSP installer
  {
    'williamboman/mason.nvim',
    dependencies = { 'williamboman/mason-lspconfig.nvim', config = true },
    cmd = 'Mason',
    build = ':MasonUpdate',
    config = true,
  },

  {
    'barreiroleo/ltex_extra.nvim',
    ft = { 'markdown', 'text', 'tex', 'gitcommit' },
    dependencies = { 'neovim/nvim-lspconfig' },
  },
}
