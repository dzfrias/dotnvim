return {
  -- Colorscheme
  {
    'folke/tokyonight.nvim',
    branch = 'main',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme tokyonight-night]]
    end,
  },

  -- Window separators
  {
    'nvim-zh/colorful-winsep.nvim',
    event = 'WinNew',
    config = true,
  },

  -- Buffer bar
  {
    'romgrk/barbar.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      exclude_ft = { 'oil' },
    },
    keys = {
      { '<C-n>', '<Cmd>BufferNext<CR>' },
      { '<C-p>', '<Cmd>BufferPrevious<CR>' },
      { '<leader>bd', '<Cmd>BufferClose<CR>' },
      { '<leader>bp', '<Cmd>BufferPick<CR>' },
      { '<leader>bP', '<Cmd>BufferPin<CR>' },
    },
  },

  -- Status bar
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    event = 'VeryLazy',
    opts = {
      -- Based on the bubbles theme by lokesh-krishna
      options = {
        globalstatus = true,
        component_separators = '|',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = {
          { 'mode', separator = { left = '' }, right_padding = 2 },
        },
        lualine_b = { 'filename', 'branch', 'diagnostics' },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { 'filetype', 'progress' },
        lualine_z = {
          { 'location', separator = { right = '' }, left_padding = 2 },
        },
      },
      tabline = {},
      extensions = {},
    },
  },

  -- Better UI defaults
  {
    'stevearc/dressing.nvim',
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.input(...)
      end
    end,
  },

  -- Tint inactive windows
  {
    'levouh/tint.nvim',
    event = 'VeryLazy',
    opts = {
      darken = -45,
      saturation = 0.4,
    },
  },

  -- Window animations
  {
    'anuvyklack/windows.nvim',
    event = 'WinNew',
    dependencies = {
      'anuvyklack/middleclass',
      'anuvyklack/animation.nvim',
    },
    config = function()
      vim.o.winwidth = 5
      vim.o.equalalways = false
      require('windows').setup()
    end,
  },
}
