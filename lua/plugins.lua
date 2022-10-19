local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Colorscheme
    use {
      "sainnhe/everforest",
      config = function()
        vim.cmd "colorscheme everforest"
      end,
    }

    -- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()
        require("config.alpha").setup()
      end,
    }

    -- Git
    use {
      "TimUntersberger/neogit",
      cmd = "Neogit",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("config.neogit").setup()
      end,
    }

    -- WhichKey
    use {
      "folke/which-key.nvim",
      event = "VimEnter",
      config = function()
        require("config.whichkey").setup()
      end,
    }

    -- IndentLine
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufReadPre",
      -- config = function()
        -- require("config.indentblankline").setup()
      -- end,
    }

    -- Load only when require
    use { "nvim-lua/plenary.nvim", module = "plenary" }

    -- Better icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    }

    -- Better Comment
    use {
      "numToStr/Comment.nvim",
      config = function()
        require("config.comment").setup {}
      end,
    }

    -- Easy hopping
    use {
      "phaazon/hop.nvim",
      cmd = { "HopWord", "HopChar1" },
      config = function()
        require("hop").setup {}
      end,
    }

    -- Markdown
    use {
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      ft = "markdown",
      cmd = { "MarkdownPreview" },
    }

    use {
      'romgrk/barbar.nvim',
      requires = {'kyazdani42/nvim-web-devicons'}
    }

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        require('config.lualine').setup()
      end,
    }

    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
      requires = { {'nvim-lua/plenary.nvim'} },
      config = function()
        require('config.telescope').setup()
      end,
    }

    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icons
      },
      tag = 'nightly', -- optional, updated every week. (see issue #1193)
      config = function()
        require('config.tree').setup()
      end,
    }

    use {
      'christoomey/vim-tmux-navigator'
    }

		use {
			"numToStr/FTerm.nvim",
			config = function()
				require('config.fterm').setup()
			end,
		}

		use {
			"mg979/vim-visual-multi"
		}

    use {
      "jose-elias-alvarez/null-ls.nvim",
      requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"}
    }

    use {
      'VonHeikemen/lsp-zero.nvim',
      requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'saadparwaiz1/cmp_luasnip'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-nvim-lua'},

        -- Snippets
        {'L3MON4D3/LuaSnip'},
        {'rafamadriz/friendly-snippets'},
      },
      config = function()
        local lsp = require('lsp-zero')
        local luasnip = require('luasnip')
        lsp.preset('recommended')

        local lsp_formatting = function(bufnr)
          vim.lsp.buf.format({
            filter = function(client)
              -- apply whatever logic you want (in this example, we'll only use null-ls)
              return client.name == "null-ls"
            end,
            bufnr = bufnr,
          })
        end
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        local null_ls = require('null-ls')
        local null_opts = lsp.build_options('null-ls', {
          on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
              vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                  lsp_formatting(bufnr)
                end,
              })
            end
          end
            -- if client.resolved_capabilities.document_formatting then
            --   vim.api.nvim_create_autocmd("BufWritePre", {
            --     desc = "Auto format before save",
            --     pattern = "<buffer>",
            --     callback = function()
            --       lsp_formatting(bufnr)
            --     end,
            --    })
            -- end
        })

        null_ls.setup({
          on_attach = null_opts.on_attach,
          sources = {
            null_ls.builtins.formatting.prettierd,
            null_ls.builtins.code_actions.eslint_d,
            null_ls.builtins.code_actions.refactoring,
          }
        })

        local cmp = require('cmp')
        local select_opts = {behavior = cmp.SelectBehavior.Insert}
        local check_back_space = function()
          local col = vim.fn.col('.') - 1
          if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
            return true
          else
            return false
          end
        end

        lsp.setup_nvim_cmp({
          preselect = cmp.PreselectMode.None,
          completion = {
            completeopt = 'menu,menuone,noinsert,noselect'
          },
          mapping = lsp.defaults.cmp_mappings({
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item(select_opts)
              -- elseif luasnip.jumpable(1) then
              --   luasnip.jump(1)
              elseif check_back_space() then
                fallback()
              else
                cmp.complete()
              end
            end, {'i', 's'}),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item(select_opts)
              else
                fallback()
              end
            end, {'i', 's'}),
          }),
        })

        lsp.setup()

        -- local lsp = require('lsp-zero')
        --
        -- lsp.preset('recommended')
        -- lsp.setup()
      end,
    }

    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {
      }
      end
    }

    use {
      'nvim-treesitter/nvim-treesitter',
      run = function() pcall(vim.cmd, 'TSUpdate') end,
			config = function()
				require('config.treesitter').setup()
			end,
    }
    
    use { 'nvim-treesitter/nvim-treesitter-textobjects' }

    use {
        "ThePrimeagen/refactoring.nvim",
        requires = {
            {"nvim-lua/plenary.nvim"},
            {"nvim-treesitter/nvim-treesitter"}
        }
    }

    use {
      "windwp/nvim-ts-autotag",
      requires = "nvim-treesitter/nvim-treesitter",
      config = function()
        require("nvim-ts-autotag").setup {
        }
      end
    }

    use { 'wellle/targets.vim' }

    use { 'tpope/vim-surround' }

    use { 'tpope/vim-fugitive' }

    use { 'tpope/vim-repeat' }

    use { 'editorconfig/editorconfig-vim' }


    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
