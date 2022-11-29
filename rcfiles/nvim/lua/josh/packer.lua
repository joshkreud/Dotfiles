return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use("tpope/vim-fugitive")
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
      }

    use('nvim-tree/nvim-web-devicons')
    use("simrat39/symbols-outline.nvim")

    use("gruvbox-community/gruvbox")

    use("nvim-treesitter/nvim-treesitter")
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    use({
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    })
end)
