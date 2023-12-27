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
          for _, bufnr in ipairs(vim.fn.tabpagebuflist()) do
            local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
            if filetype == 'DiffviewFiles' then
              vim.cmd 'DiffviewClose'
              return
            end
          end
          vim.cmd 'DiffviewOpen'
        end,
        desc = 'Toggle the diff view',
      },
    },
    cmd = 'DiffviewOpen',
  },

  {
    'tpope/vim-fugitive',
    keys = {
      {
        '<leader>g',
        function()
          for _, bufnr in ipairs(vim.fn.tabpagebuflist()) do
            local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
            if filetype == 'fugitive' then
              vim.api.nvim_win_close(vim.fn.bufwinid(bufnr), false)
              return
            end
          end
          vim.cmd 'Git'
        end,
        desc = 'Toggle fugitive',
      },
    },
  },
}
