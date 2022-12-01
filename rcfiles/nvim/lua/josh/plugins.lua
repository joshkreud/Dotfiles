vim.cmd [[packadd packer.nvim]]

-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

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
    requires = { 'nvim-lua/plenary.nvim', 'cljoly/telescope-repo.nvim' }
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
  use { 'nvim-tree/nvim-tree.lua' }

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
  use "tpope/vim-fugitive"
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup() end
  }

  -- Treesitter

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
end)
