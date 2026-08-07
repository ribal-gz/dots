vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.cursorline = true     -- Highlight current line
vim.opt.wrap = false          -- Don't wrap lines
vim.opt.scrolloff = 10        -- Keep 10 lines above/below cursor
vim.opt.sidescrolloff = 8     -- Keep 8 columns left/right of cursor

-- Indentation
vim.opt.tabstop = 8           -- Tab width
vim.opt.shiftwidth = 8        -- Indent width
vim.opt.softtabstop = 8       -- Soft tab stop
vim.expandtab = false         -- Don't use spaces instead of tabs
vim.opt.smartindent = true    -- Smart auto-indenting
vim.opt.autoindent = true     -- Copy indent from current line

-- Search
vim.opt.ignorecase = true     -- Ignore case in search
vim.opt.smartcase = true      -- Smart case in search
vim.opt.hlsearch = true       -- Highlight search results
vim.opt.incsearch = true      -- Show matches as you type

-- Visual settings
vim.opt.termguicolors = true  -- Enable true colors
vim.opt.signcolumn = "yes:1"  -- Show the sign column
vim.opt.showmatch = true      -- Highlightmatching brackets
vim.opt.cmdheight = 0         -- Command line height
vim.opt.confirm = true        -- Confirm to save changes before exiting
vim.opt.textwidth = 80
vim.opt.colorcolumn = "80"    -- Highlight column 80
vim.opt.laststatus = 3        -- Single statusline across windows

-- File handling
vim.opt.backup = false        -- Disable backup file
vim.opt.writebackup = false   -- Don't create backup before writing
vim.opt.swapfile = false      -- Disable swap file
vim.opt.undofile = true       -- Persistent undo
vim.opt.undodir = (           -- Undo directory
	vim.fn.stdpath("data") .. "/undodir"
)

-- Behaviour
vim.opt.hidden = true         -- Allow hidden buffers
vim.opt.encoding = "UTF-8"    -- Set encoding

-- Splite
vim.opt.splitbelow = true     -- Horizontal splits go below
vim.opt.splitright = true     -- Vertical splits go right
vim.opt.splitkeep = "screen"
vim.opt.inccommand = "split"

-- Command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"

-- Buffer completion
vim.opt.completeopt = "menuone,noselect,fuzzy,nosort,noinsert"
vim.opt.autocomplete = true   -- Native insert-mode completion
