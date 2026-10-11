return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      -- nvim-tree watcher ignore
      filesystem_watchers = {
      ignore_dirs = {
        "node_modules"
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  -- Mason plugin
{
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "codelldb",
      }
    }
  },
  -- These are some examples, uncomment them if you want to see them work!
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "pyright" },
        },
        config = function(_, opts)
            -- On initialise mason-lspconfig avec nos options
            require("mason-lspconfig").setup(opts)

            -- C'est ici que la magie opère de manière moderne :
            -- On utilise le handler par défaut de mason-lspconfig
            require("mason-lspconfig").setup_handlers({
                -- Ce handler par défaut s'occupe de configurer automatiquement
                -- chaque serveur installé avec les paramètres de base de nvim-lspconfig
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,

                -- Si vous avez besoin d'une config spécifique pour un serveur (ex: pyright)
                ["pyright"] = function()
                    require("lspconfig").pyright.setup({
                        settings = {
                            python = {
                                analysis = {
                                    autoSearchPaths = true,
                                    useLibraryCodeForTypes = true,
                                },
                            },
                        },
                    })
                end,
            })
        end,
    },
    {
        -- On utilise nvim-lspconfig uniquement pour ses définitions de serveurs (les configs par défaut)
        "neovim/nvim-lspconfig",
        config = function()
            -- 1. Récupérer la configuration par défaut de Pyright fournie par le plugin
            local pyright_config = require("lspconfig.configs.pyright")

            -- 2. L'enregistrer ou la lier via la nouvelle API native vim.lsp.config
            if vim.lsp.config then
                -- On définit le serveur dans le core de Neovim
                vim.lsp.config("pyright", {
                    cmd = pyright_config.default_config.cmd,
                    filetypes = pyright_config.default_config.filetypes,
                    root_markers = { ".git", "pyproject.toml", "setup.py" },
                    settings = {
                        python = {
                            analysis = {
                                autoSearchPaths = true,
                                useLibraryCodeForTypes = true,
                                diagnosticMode = "workspace",
                            },
                        },
                    },
                })

                -- 3. Activer automatiquement le serveur pour les fichiers correspondants
                vim.lsp.enable("pyright")
            else
                -- Fallback si votre version de Neovim n'a pas encore vim.lsp.config stable
                require("lspconfig").pyright.setup({})
            end

            -- Mappings de touches natifs
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Aller à la définition" })
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Afficher la doc" })
        end,
    },
  
 -- Debug Adapter Protocol
  {
    "mfussenegger/nvim-dap",
    --config = function(_, _)
    --  require("core.utils").load_mappings("dap")
    --end
  },
  -- DAP ui
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      local dap = require ("dap")
      local dapui = require ("dapui")
      dapui.setup ()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap. listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners. before.event_exited["dapui_config"] = function()
        dapui.close ()
      end
    end
  },
  -- Mason nvim DAP
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap"
    },
    opts = {
      handlers = {},
      ensure_installed = {
        "codelldb",
      },
    },
  },
  -- markdown-preview install with yarn or npm
  {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "cdelledonne/vim-cmake"
  },
  {
      "nvzone/floaterm",
      dependencies = "nvzone/volt",
      opts = {},
      cmd = "FloatermToggle",
  },
  {
    "madskjeldgaard/faust-nvim",
    dependencies = {
      "vijaymarupudi/nvim-fzf",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      require("faust-nvim")
      require("faust-nvim").load_snippets()
    end,
    -- build = require("faust-nvim").post_install, -- equivalent of packer's "run"
  },
 -- {
 --   "salkin-mada/sapf",
 --   config = function()
 --     local sapf = require('sapf')
 --     local map = sapf.map

 --     sapf.setup {
 --     lang = {
 --       executable = "~/Sandbox/sapf/sapf",
 --       prelude = '~/Sandbox/sapf/sapf-prelude.txt'
 --     },
 --     window = {
 --       size = 0.35,
 --       wrap = true
 --     },
 --     keymaps = {
 --       ['<leader>st'] = map(sapf.start, 'n', {desc ="sapf start"}),
 --       ['<leader>sq'] = map(sapf.quit, 'n', {desc ="sapf quit"}),
 --         ['<C-e>'] = {
 --           map('editor.send_block', {'i', 'n'}, {desc ="sapf evaluate block/line"}),
 --           map('editor.send_selection', 'x', {desc ="sapf evaluate selection"}),
 --         },
 --         ['<M-e>'] = map('editor.send_line', {'n', 'x', 'i'}, {desc = "sapf evaluate line"}),
 --         ['<C-s>'] = map('lang.stop', {'n', 'i'}, {desc ="sapf stop"}),
 --         ['<C-k>'] = map('help.word', {'n', 'i'}, {desc ="show help for word under cursor"}),
 --         ['<M-h>'] = map('help.all', 'n', {desc ="list help for all built-ins"}),
 --         ['<leader>cc'] = map('lang.clear', {'n', 'i'}, {desc = "sapf clear"}),
 --         ['<leader>cd'] = map('lang.cleard', {'n', 'i'}, {desc = "sapf cleard"}),
 --       },
 --     documentation = {
 --       bif_examples = '~/Sandbox/sapf/sapf-bif-examples.txt',
 --       examples = '~/Sandbox/sapf/sapf-examples.txt',
 --     },
 --   }
 --   end
 -- }
  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },
{
  "nvim-treesitter/nvim-treesitter",
  branch = "main", -- master is archived and broken on nvim 0.12
  lazy = false,
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "lua", "luadoc", "printf", "vim", "vimdoc", -- NvChad defaults (this list replaces theirs)
      "markdown", "markdown_inline",
      "python", "javascript", "java", "typescript", "c", "cpp", "c_sharp", "haskell", -- Add your languages here
    },
  },
  config = function(_, opts)
    -- treesitter add custom parser (main branch API)
    vim.api.nvim_create_autocmd("User", {
      pattern = "TSUpdate",
      callback = function()
        require("nvim-treesitter.parsers").tzpl = {
          install_info = {
            path = vim.fn.expand("~/.tree-sitter/tree-sitter-tzpl"), -- Replace with your actual path
          },
        }
      end,
    })

    -- highlighting is enabled by NvChad's FileType autocmd (vim.treesitter.start)
    require("nvim-treesitter").install(opts.ensure_installed)
  end,
},
{
  'mrcjkb/haskell-tools.nvim',
  -- To avoid being surprised by breaking changes,
  -- I recommend you set a version range
  version = '^10',
  -- This plugin implements proper lazy-loading (see :h lua-plugin-lazy).
  -- No need for lazy.nvim to lazy-load it.
  lazy = false,
},

}
