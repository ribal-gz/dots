-- lua
vim.lsp.config('lua_ls', {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".git" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        -- Don't prompt about third-party libraries.
        checkThirdParty = false,
        -- Teach the server about Neovim's Lua API so it knows about `vim.*`.
        library = { vim.env.VIMRUNTIME }
      },
    },
  },
})

vim.lsp.enable('lua_ls')

-- c
vim.lsp.enable('clangd')

-- go
vim.lsp.enable('gopls')

-- java
vim.lsp.enable('jdtls')

-- kotlin
vim.lsp.enable('kotlin_language_server')

-- rust
vim.lsp.enable('rust_analyzer')

-- slint
vim.lsp.enable('slint_lsp')

-- css
vim.lsp.enable('cssls')

-- html
vim.lsp.enable('html')

-- typescript
vim.lsp.enable('tsc')

-- typst
vim.lsp.enable('tinymist')

-- svelte
vim.lsp.enable('svelte')

-- markdown-oxide
local capabilities = vim.lsp.protocol.make_client_capabilities()
vim.lsp.config('markdown_oxide', {
	capabilities = vim.tbl_deep_extend(
		'force',
		capabilities,
		{
			workspace = {
				didChangeWatchedFiles = {
					dynamicRegistration = true,
				},
			},
		}
	),

	on_attach = function(client, bufnr)
		vim.api.nvim_buf_create_user_command(bufnr, 'Daily', function(args)
			client:exec_cmd({
				title = 'Markdown-Oxide-Daily',
				command = 'jump',
				arguments = { args.args },
			}, { bufnr = bufnr })
		end, {
			desc = 'Open daily note',
			nargs = '*',
		})
	end
})
vim.lsp.enable('markdown_oxide')

-- codelens
vim.lsp.codelens.enable(true)
