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

-- java
vim.lsp.enable('jdtls')

-- kotlin
vim.lsp.enable('kotlin_language_server')

-- rust
vim.lsp.enable('rust_analyzer')
