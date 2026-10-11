vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

-- Tabulation config
vim.opt.expandtab = true   -- Transforme les tabulations en espaces
vim.opt.shiftwidth = 4    -- Nombre d'espaces pour une indentation automatique
vim.opt.tabstop = 4       -- Nombre d'espaces qu'une tabulation représente
vim.opt.softtabstop = 4   -- Nombre d'espaces insérés quand on appuie sur Tab

-- Exemple pour forcer 2 espaces sur le HTML, CSS et JavaScript
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "css", "javascript", "typescript" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- Toggle treesitter context on/off with <leader>tc
vim.keymap.set("n", "<leader>tc", ":TSContextToggle<CR>", { silent = true, desc = "Toggle Treesitter Context" })


-- add tzpl filetype
vim.filetype.add({
  extension = {
    x = 'tzpl',
  }
})


local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { import = "plugins" },
  {
    "cdelledonne/vim-cmake",
    lazy = false,
  },
  {
   "iamcco/markdown-preview.nvim",
    lazy = false,
  },
   {
    "nvzone/floaterm",
    lazy = false,
  },
  {
    'madskjeldgaard/faust-nvim',
    lazy = true,
  },
  {
    "salkin-mada/sapf",
    lazy = false,
  },
  {
    "lambdalisue/vim-suda",
    lazy = false,
  }
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)
-- Location of faust examples
vim.g.faust_examples_dir = "/usr/local/share/faust/examples"
-- Location of faust binaries
vim.g.faust2appls_dir = "/usr/local/bin/"
-- Location of faust libraries
vim.g.faustlib_dir = "/usr/local/share/faust/"



