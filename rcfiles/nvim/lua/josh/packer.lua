vim.cmd [[packadd packer.nvim]]

-- Automatically install packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'lewis6991/impatient.nvim',
    config = function() require("impatient") end
  }

  -- Themes
  use { 'nvim-tree/nvim-web-devicons' }
  use { "gruvbox-community/gruvbox" }

  use 'airblade/vim-rooter' -- Set root folder on file change

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'cljoly/telescope-repo.nvim' },
    config = function()
      local telescope = require('telescope')
      telescope.setup {
        pickers = {
          find_files = {
            hidden = true
          }
        },
        extensions = {
          repo = {
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
      -- Vim-rooter integration
      vim.g['rooter_cd_cmd'] = 'lcd'
      vim.g.rooter_patterns = { '.git', 'Makefile', '*.sln' }
    end
  }
  use {
    'sudormrfbin/cheatsheet.nvim',
    requires = {
      { 'nvim-lua/popup.nvim' }
    }
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }

  -- File Tree
  use {
    'nvim-tree/nvim-tree.lua',
    config = function()
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
    end
  }

  -- Auto Brace closing
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  -- Powerline
  use {
    'nvim-lualine/lualine.nvim',
    config = function() require('lualine').setup() end
  }

  -- File executor
  use { 'CRAG666/code_runner.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- Git
  use { "tpope/vim-fugitive" }
  use {
      'lewis6991/gitsigns.nvim',
      config = function() require('gitsigns').setup() end
  }

  -- Buffer
  use {
      'akinsho/bufferline.nvim',
      tag = "v3.*",
      requires = 'nvim-tree/nvim-web-devicons',
      config = function() require("bufferline").setup() end
  }

  -- Wildmenu
  use {
      'gelguy/wilder.nvim',
      config = function()
          require("wilder").setup({ modes = { ':', '/', '?' } })
      end
  }

  -- LSP
  use { "neovim/nvim-lspconfig" }
  use {
      "williamboman/mason.nvim",
      config = function() require("mason").setup() end
  }
  use {
      "williamboman/mason-lspconfig.nvim",
      config = function() require("mason-lspconfig").setup() end
  }
  use { 'folke/lsp-colors.nvim' }
  use {
    'folke/trouble.nvim',
    config = function() require("trouble").setup() end
  }

  -- Treesitter
  use {
      'nvim-treesitter/nvim-treesitter',
      run = function()
          require('nvim-treesitter.configs').setup {
              ensure_installed = { "c", "lua", "python", "yaml" },
              auto_install = true,
          }
          local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
          ts_update()
      end,
  }
  if packer_bootstrap then
      require('packer').sync()
  end
end)
