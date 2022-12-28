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

  -- Editor
  use "matze/vim-move" -- Move lines wiht a-j/k

  use 'RRethy/vim-illuminate' -- highlght current word

  use 'lukas-reineke/indent-blankline.nvim' -- show indent guides

  use 'michaeljsmith/vim-indent-object'

  -- Themes
  use 'nvim-tree/nvim-web-devicons'
  use "gruvbox-community/gruvbox"

  -- Telescope
  use 'airblade/vim-rooter' -- Set root folder on file change
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
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
      }
    end
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

  -- Comment toggeling
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
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
    'petertriho/nvim-scrollbar',
    config = function()
      require("scrollbar").setup()
    end
  }
  use { -- Side bar, showing current git changes
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
      require("scrollbar.handlers.gitsigns").setup()
    end
  }

  -- Tab bar for open buffers at the top
  use {
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons',
    config = function() require("bufferline").setup() end
  }

  -- Wildmenu (command mode preview)
  use {
    'gelguy/wilder.nvim',
    config = function()
      require("wilder").setup({ modes = { ':', '/', '?' } })
    end
  }

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.sumneko_lua.setup {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      }
    end
  }

  use { -- Used to install LSPs
    "williamboman/mason.nvim",
    config = function() require("mason").setup() end
  }
  use {
    "williamboman/mason-lspconfig.nvim",
    config = function() require("mason-lspconfig").setup() end
  }
  use { 'folke/lsp-colors.nvim' } -- Colors in case the theme doesnt support it
  use { -- 'Problems' bar for Nvim
    'folke/trouble.nvim',
    config = function() require("trouble").setup() end
  }
  -- Autocomplete
  use {
    "hrsh7th/nvim-cmp",
    requires = {
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
      require('lspconfig')['sumneko_lua'].setup {
        capabilities = capabilities
      }
    end
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
