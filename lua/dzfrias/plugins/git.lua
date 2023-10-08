return {
  -- Git in signcolumn
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      {
        'gp',
        function()
          require('gitsigns').preview_hunk()
        end,
        desc = 'Git preview hunk',
      },
      {
        'gr',
        function()
          require('gitsigns').reset_hunk()
        end,
        desc = 'Git reset hunk',
      },
      {
        'g]',
        function()
          require('gitsigns').next_hunk()
        end,
        desc = 'Go to next diff hunk',
      },
      {
        'g[',
        function()
          require('gitsigns').prev_hunk()
        end,
        desc = 'Go to previous diff hunk',
      },
    },
    opts = {
      attach_to_untracked = false,
      trouble = false,
    },
  },

  {
    'sindrets/diffview.nvim',
    keys = {
      {
        'gD',
        function()
          if vim.bo.filetype == 'DiffviewFiles' then
            vim.cmd 'DiffviewClose'
            return
          end
          vim.cmd 'DiffviewOpen'
        end,
        desc = 'Toggle the diff view',
      },
    },
  },

  {
    'tpope/vim-fugitive',
    keys = {
      {
        '<leader>g',
        function()
          if vim.bo.filetype == 'fugitive' then
            vim.api.nvim_win_close(0, false)
            return
          end
          vim.cmd 'Git'
        end,
        desc = 'Toggle fugitive',
      },
    },
  },
}
