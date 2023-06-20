local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


return require('lazy').setup({
  {
    'lewis6991/impatient.nvim',
    config = function() require("impatient") end
  },

  -- Editor
  "matze/vim-move",        -- Move lines wiht a-j/k

  'RRethy/vim-illuminate', -- highlght current word

  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup({
        show_current_context = true,
        show_current_context_start = true,
      })
    end
  }, -- show indent guides

  'michaeljsmith/vim-indent-object',
  {
    "kylechui/nvim-surround",
    tag = "v2.1.0",
    config = function()
      require("nvim-surround").setup({
      })
    end
  },
  -- Themes
  'nvim-tree/nvim-web-devicons',
  'gruvbox-community/gruvbox',

  -- Telescope
  'airblade/vim-rooter', -- Set root folder on file change
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'cljoly/telescope-repo.nvim' },
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
  },
  {
    'sudormrfbin/cheatsheet.nvim',
    dependencies = {
      { 'nvim-lua/popup.nvim' }
    }
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
      }
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },

  -- File Tree
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          adaptive_size = true,
        },
        renderer = {
          group_empty = true,
        },

      })
    end
  },

  -- Auto Brace closing
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },

  -- Comment toggeling
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  -- Powerline
  {
    'nvim-lualine/lualine.nvim',
    config = function() require('lualine').setup() end
  },
  -- File executor
  { 'CRAG666/code_runner.nvim', dependencies = 'nvim-lua/plenary.nvim' },

  -- Git
  { "tpope/vim-fugitive" },
  {
    'petertriho/nvim-scrollbar',
    config = function()
      require("scrollbar").setup()
    end
  },
  { -- Side bar, showing current git changes
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
      require("scrollbar.handlers.gitsigns").setup()
    end
  },

  -- Tab bar for open buffers at the top
  {
    'akinsho/bufferline.nvim',
    tag = "v4.1.0",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function() require("bufferline").setup() end
  },

  -- Wildmenu (command mode preview)
  {
    'gelguy/wilder.nvim',
    config = function()
      require("wilder").setup({ modes = { ':', '/', '?' } })
    end
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')
    end
  },
  { -- Used to install LSPs
    "williamboman/mason.nvim",
    config = function() require("mason").setup() end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function() require("mason-lspconfig").setup() end
  },
  'folke/lsp-colors.nvim', -- Colors in case the theme doesnt support it
  {                        -- 'Problems' bar for Nvim
    'folke/trouble.nvim',
    config = function() require("trouble").setup() end
  },
  -- Autocomplete
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      'hrsh7th/cmp-nvim-lua',
      'octaltree/cmp-look',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-calc',
      'f3fora/cmp-spell',
      'hrsh7th/cmp-emoji',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        }, {
          { name = 'buffer' },
        })
      })

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })

      -- Set up lspconfig.
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
    end
  },


  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "c", "lua", "python", "yaml" },
        auto_install = true,
      }
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  },
})
