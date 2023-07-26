require 'dzfrias.settings'
require('lazy').setup {
  spec = {
    { import = 'dzfrias/plugins' },
  },

  install = {
    colorscheme = { 'tokyonight' },
  },

  change_detection = {
    notify = false,
  },

  dev = {
    path = '~/code',
  },

  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
}
require 'dzfrias.keymaps'
