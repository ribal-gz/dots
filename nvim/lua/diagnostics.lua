vim.diagnostic.config({
	underline = true,
	severity_sort = true,
	update_in_insert = false,
	virtual_text = true,

	float = {
		border = "rounded",
		source = true,
	}
})

-- Open floating line diagnostics
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- Open Quickfix List
vim.keymap.set("n", "<leader>dl", function()
	vim.diagnostic.setqflist()
	vim.cmd("copen")
end, { silent = true })
