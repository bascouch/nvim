require("nvchad.configs.lspconfig").defaults()

local lspconfig = require("lspconfig")

local servers = { "html", "cssls", "clangd" }
vim.lsp.enable(servers)


-- vim.lsp.config('clangd',{
--   cmd = {
--     "clangd",
--     "--background-index",
--     "--clang-tidy",
--     "--completion-style=detailed",
--     "--cross-file-rename",
--     "--header-insertion=never",
--     "-std=c23"  -- 👈 option que tu veux ajouter
--   },
-- })
-- :help lspconfig-nvim-0.11
-- read :h vim.lsp.config for changing options of lsp servers 

-- vim.print(vim.lsp.config.clangd)
--

-- vim.lsp.config.clangd.setup {
--     init_options = {
--         fallbackFlags = { '--std=c23' }
--     },
-- }
