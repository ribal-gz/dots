vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://codeberg.org/mfussenegger/nvim-dap",
	"https://github.com/nvim-neotest/nvim-nio", -- required by nvim-dap-ui
	"https://github.com/rcarriga/nvim-dap-ui",
	"https://github.com/Mathijs-Bakker/godotdev.nvim",
	"https://github.com/nvim-mini/mini.pairs",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/windwp/nvim-ts-autotag",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	{
		src = "https://github.com/nickjvandyke/opencode.nvim",
		version = vim.version.range("*"), -- latest stable release
	}
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

-- autotag
require("nvim-ts-autotag").setup()

-- render-markdown
require("render-markdown").setup()

-- opencode
---@type opencode.Opts
vim.g.opencode_opts = {
	-- custom config
}
vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ") end, { desc = "Ask OpenCode..." })
vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,       { desc = "Select OpenCode..." })
