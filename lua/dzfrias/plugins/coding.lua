return {
  {
    'dzfrias/arena.nvim',
    dev = true,
    event = 'BufWinEnter',
    opts = {
      ignore_current = true,
      devicons = true,
    },
    keys = {
      {
        '<leader>f',
        function()
          require('arena').toggle()
        end,
        desc = 'Toggle the arena',
      },
    },
  },

  {
    'stevearc/oil.nvim',
    init = function()
      if vim.fn.isdirectory(vim.api.nvim_buf_get_name(0)) == 1 then
        require('lazy').load { plugins = { 'oil.nvim' } }
      end
    end,
    keys = {
      {
        '-',
        function()
          require('oil').open()
        end,
        desc = 'Open oil',
      },
    },
    opts = {
      keymaps = {
        ['<C-v>'] = 'actions.select_vsplit',
        ['<C-x>'] = 'actions.select_split',
        ['<C-h>'] = false,
        ['<C-l>'] = false,
        ['q'] = 'actions.close',
      },
    },
  },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = 'nvim-lua/plenary.nvim',
    keys = {
      {
        '<leader>m',
        function()
          require('harpoon'):list():add()
        end,
      },
      {
        '<leader>o',
        function()
          local harpoon = require 'harpoon'
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
      },
    },
  },

  {
    'airblade/vim-rooter',
    config = function()
      vim.g.rooter_patterns = { '.git' }
      vim.g.rooter_silent_chdir = true
    end,
  },

  {
    'folke/trouble.nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    cmd = 'Trouble',
    keys = {
      {
        '<leader>x',
        '<Cmd>Trouble diagnostics toggle<CR>',
        desc = 'Open Trouble',
      },
    },
    config = true,
  },

  'christoomey/vim-tmux-navigator',

  {
    'chrisgrieser/nvim-various-textobjs',
    keys = {
      { 'iS', mode = 'o' },
      { 'aS', mode = 'o' },
      { 'ii', mode = 'o' },
      { 'ai', mode = 'o' },
      { 'aI', mode = 'o' },
      { 'iI', mode = 'o' },
      { 'R', mode = 'o' },
      { 'r', mode = 'o' },
      { 'gG', mode = 'o' },
      { 'n', mode = 'o' },
      { 'i_', mode = 'o' },
      { 'a_', mode = 'o' },
      { '|', mode = 'o' },
      { 'av', mode = 'o' },
      { 'iv', mode = 'o' },
      { 'ik', mode = 'o' },
      { 'ak', mode = 'o' },
      { 'in', mode = 'o' },
      { 'an', mode = 'o' },
      { '!', mode = 'o' },
      { 'iz', mode = 'o' },
      { 'az', mode = 'o' },
      { 'im', mode = 'o' },
      { 'am', mode = 'o' },
      { 'gw', mode = 'o' },
      { 'gW', mode = 'o' },
    },
    opts = {
      useDefaultKeymaps = true,
      disabledKeymaps = {
        '%',
        'gc',
        'L',
      },
    },
  },

  {
    'matze/vim-move',
    keys = {
      { '<A-k>', mode = { 'v', 'n' }, desc = 'Move up' },
      { '<A-j>', mode = { 'v', 'n' }, desc = 'Move down' },
      { '<A-l>', mode = { 'v', 'n' }, desc = 'Move left' },
      { '<A-h>', mode = { 'v', 'n' }, desc = 'Move right' },
    },
  },

  {
    'haya14busa/is.vim',
    keys = {
      { '/', desc = 'Search' },
      { '?', desc = 'Search backwards' },
      { 'n', desc = 'Next match' },
      { 'N', desc = 'Previous match' },
      { '*', desc = 'Search word under cursor' },
      { '#', desc = 'Search word under cursor backwards' },
    },
  },

  {
    'mbbill/undotree',
    keys = {
      {
        '<leader>T',
        function()
          vim.cmd.UndotreeToggle()
        end,
        desc = 'Toggle the undo tree',
      },
    },
  },

  -- Surround text
  {
    'tpope/vim-surround',
    keys = {
      { 'ys', desc = 'Surround' },
      { 'S', mode = 'v', desc = 'Surround' },
      { 'ds', desc = 'Delete surrounding' },
      { 'cs', desc = 'Change surrounding' },
    },
  },

  -- Better movement with f and t
  {
    'rhysd/clever-f.vim',
    keys = {
      { 'f', mode = { 'n', 'o' }, desc = 'Motion to character' },
      { 'F', mode = { 'n', 'o' }, desc = 'Motion to character backwards' },
      { 't', mode = { 'n', 'o' }, desc = 'Motion to behind character' },
      {
        'T',
        mode = { 'n', 'o' },
        desc = 'Motion to behind character backwards',
      },
    },
    config = function()
      -- Do not use f over multiple lines
      vim.g.clever_f_across_no_line = 1
      -- Show the places that can be directly jumped to
      vim.g.clever_f_mark_direct = 1
    end,
  },

  { 'tpope/vim-sleuth', event = 'VeryLazy' },

  -- Better clipboard control
  {
    'svermeulen/vim-easyclip',
    keys = {
      { 'y', mode = { 'n', 'v' }, desc = 'Yank' },
      { 'p', mode = { 'n', 'v' }, desc = 'Paste' },
      { 'P', mode = { 'n', 'v' }, desc = 'Past above' },
      { 'Y', mode = { 'n', 'v' }, desc = 'Yank until end of line' },
      { 'm', mode = { 'n', 'v' }, desc = 'Cut' },
      { 'd', mode = { 'n', 'v' }, desc = 'Delete' },
      { 'D', mode = { 'n', 'v' }, desc = 'Delete until end of line' },
      { 'c', mode = { 'n', 'v' }, desc = 'Change' },
      { 'C', mode = { 'n', 'v' }, desc = 'Change until end of line' },
    },
    dependencies = 'tpope/vim-repeat',
  },

  -- Auto pairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function(_, options)
      local npairs = require 'nvim-autopairs'
      local Rule = require 'nvim-autopairs.rule'

      npairs.setup(options)

      local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
      npairs.add_rules {
        Rule(' ', ' '):with_pair(function(opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({
            brackets[1][1] .. brackets[1][2],
            brackets[2][1] .. brackets[2][2],
            brackets[3][1] .. brackets[3][2],
          }, pair)
        end),
      }
      for _, bracket in pairs(brackets) do
        npairs.add_rules {
          Rule(bracket[1] .. ' ', ' ' .. bracket[2])
            :with_pair(function()
              return false
            end)
            :with_move(function(opts)
              return opts.prev_char:match('.%' .. bracket[2]) ~= nil
            end)
            :use_key(bracket[2]),
        }
      end
    end,
  },
}
