local function complete_packages(match)
  return vim.iter(vim.pack.get())
    :map(function(pack) return pack.spec.name end)
    :filter(function(pack) return pack:find(match) end)
    :totable()
end

-- PackAdd: Add plugins
vim.api.nvim_create_user_command("PackAdd", function(opts)
	vim.pack.add(opts.fargs)
end, { nargs = "+", desc = "Add plugins (:PackAdd user/repo)" })

-- PackDel: Delete plugins
vim.api.nvim_create_user_command("PackDel", function(opts)
	vim.pack.del(opts.fargs)
end, {
	nargs = "+",
	desc = "Delete plugins (:PackDel plugin1 plugin2)",
	complete = complete_packages
})

-- PackUpdate: Update all plugins or specific ones
vim.api.nvim_create_user_command("PackUpdate", function(opts)
	-- checks if any argument is passed
	if opts.args:match("%S") then
		-- update specific plugins
		local plugins = vim.split(opts.args, "%s+", { trimempty = true })
		vim.pack.update(plugins)
	else
		-- update all
		vim.pack.update()
	end
end, {
	nargs = "*",
	desc = "Update all plugins or specific ones",
	complete = complete_packages
})
