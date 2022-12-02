local telescope = require('telescope')
telescope.setup {
  pickers = {
    find_files = {
      hidden = true
    }
  },
  extensions = {
    repo = {
      settings = {
        auto_lcd = true,
      },
      list = {
        fd_opts = {
          "--no-ignore-vcs",
        },
        search_dirs = {
          "~/dev",
          "~/Dotfiles",
        },
      },
    },
  },
}
telescope.load_extension('fzf')
telescope.load_extension('repo')
vim.g['rooter_cd_cmd'] = 'lcd'
vim.g.rooter_patterns = { '.git', 'Makefile', '*.sln' }

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },

})
