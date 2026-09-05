vim.g.mapleader = " "

vim.o.completeopt = "menuone,noselect,fuzzy"
vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.swapfile = false
vim.o.undofile = true
vim.o.mouse = "a"
vim.o.signcolumn = "yes"
vim.o.wrap = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.clipboard = "unnamedplus"
vim.o.smoothscroll = true
vim.o.confirm = true
vim.o.termguicolors = true
vim.o.winborder = "rounded"

vim.pack.add({
  "https://github.com/catppuccin/nvim",
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/github/copilot.vim",
})

vim.cmd.colorscheme "catppuccin-mocha"

require("mason").setup()
require("mason-lspconfig").setup()
require("mini.icons").setup()
require("mini.statusline").setup()
require("mini.starter").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.files").setup()
require("mini.pick").setup()
require("mini.completion").setup()
require("mini.diff").setup({ view = { style = "sign" } })
require("mini.extra").setup()

vim.keymap.set("n", "<leader><leader>", "<C-^>")

vim.keymap.set("n", "<leader>e", MiniFiles.open)
vim.keymap.set("n", "<leader>f", MiniPick.builtin.files)
vim.keymap.set("n", "<leader>g", MiniPick.builtin.grep_live)
vim.keymap.set("n", "<leader>b", MiniPick.builtin.buffers)
vim.keymap.set("n", "<leader>d", MiniExtra.pickers.git_hunks)

vim.diagnostic.config({ virtual_text = true, severity_sort = true })

vim.treesitter.language.register("json", "jsonl")

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args) pcall(vim.treesitter.start, args.buf) end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args) vim.lsp.buf.format({ bufnr = args.buf }) end,
})
