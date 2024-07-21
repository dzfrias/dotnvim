return {
  -- Colorscheme
  {
    'dzfrias/noir.nvim',
    lazy = false,
    dev = true,
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme noir]]
    end,
  },

  -- Window separators
  {
    'nvim-zh/colorful-winsep.nvim',
    event = 'WinNew',
    config = true,
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
        theme = 'iceberg_dark',
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
}
