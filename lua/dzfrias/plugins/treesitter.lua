return {
  -- Tree sitter
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      ensure_installed = {
        'python',
        'vim',
        'go',
        'lua',
        'json',
        'regex',
        'rust',
        'query',
        'toml',
        'markdown',
      },

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'markdown' },
      },

      autotag = {
        enable = true,
      },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@call.outer',
            ['ic'] = '@call.inner',
            ['ia'] = '@parameter.inner',
            ['aa'] = '@parameter.outer',
          },
        },

        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']]'] = '@function.outer',
            [')'] = '@parameter.inner',
          },
          goto_previous_start = {
            ['[['] = '@function.outer',
            ['('] = '@parameter.inner',
          },
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
    build = ':TSUpdate',
  },
}
