vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://codeberg.org/mfussenegger/nvim-dap",
	"https://github.com/nvim-neotest/nvim-nio", -- required by nvim-dap-ui
	"https://github.com/rcarriga/nvim-dap-ui",
	"https://github.com/Mathijs-Bakker/godotdev.nvim",
	"https://github.com/nvim-mini/mini.pairs",
	"https://github.com/nvim-treesitter/nvim-treesitter"
})

-- dapui
require("dapui").setup()
vim.keymap.set("n", "<F12>", function()
	require("dapui").toggle({})
end, { desc = "Toggle DAP UI" })

-- godotdev
require("godotdev").setup({
	editor_host = "127.0.0.1",
	editor_port = 6005,
	debug_port = 6006,
	formatter = false,
})

-- mini
require("mini.pairs").setup()
