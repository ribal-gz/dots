-- chroma colorscheme (docs/colorscheme.md)
-- Monochromatic UI; semantic colors only convey information.
-- Dark variant uses the bright range (base10-17), light uses normal (base08-0F).

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end
vim.g.colors_name = "chroma"

local base = {
	base00 = "#000000",
	base01 = "#0a0a0a",
	base02 = "#1e1e1e",
	base03 = "#434343",
	base04 = "#858585",
	base05 = "#b2b2b2",
	base06 = "#cfcfcf",
	base07 = "#ffffff",
	base08 = "#bc336e",
	base09 = "#a75003",
	base0A = "#807704",
	base0B = "#367702",
	base0C = "#068680",
	base0D = "#036ea6",
	base0E = "#4f5cd1",
	base0F = "#a340a6",
	base10 = "#ffa6c2",
	base11 = "#ffaf7f",
	base12 = "#d3c850",
	base13 = "#99d97c",
	base14 = "#15e1d7",
	base15 = "#89ccfe",
	base16 = "#b2c0fe",
	base17 = "#f3a3f4",
}

local ui, sem
if vim.o.background == "light" then
	ui = {
		bg = base.base07,
		surface = base.base06,
		selection = base.base05,
		fg = base.base02,
		fg_secondary = base.base02,
		fg_highlight = base.base01,
		fg_max = base.base00,
		muted = base.base04,
	}
	sem = {
		red = base.base08,
		orange = base.base09,
		yellow = base.base0A,
		green = base.base0B,
		cyan = base.base0C,
		blue = base.base0D,
		violet = base.base0E,
		magenta = base.base0F,
		accent = base.base0D,
	}
else
	ui = {
		bg = base.base00,
		surface = base.base01,
		selection = base.base02,
		fg = base.base05,
		fg_secondary = base.base04,
		fg_highlight = base.base06,
		fg_max = base.base07,
		muted = base.base03,
	}
	sem = {
		red = base.base10,
		orange = base.base11,
		yellow = base.base12,
		green = base.base13,
		cyan = base.base14,
		blue = base.base15,
		violet = base.base16,
		magenta = base.base17,
		accent = base.base11,
	}
end

local function hl(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
end

-- Core UI (monochrome)
hl("Normal", { fg = ui.fg, bg = ui.bg })
hl("NormalFloat", { fg = ui.fg, bg = ui.surface })
hl("FloatBorder", { fg = ui.muted, bg = ui.surface })
hl("FloatTitle", { fg = ui.fg_max, bg = ui.surface, bold = true })
hl("SignColumn", { fg = ui.muted, bg = ui.bg })
hl("LineNr", { fg = ui.muted, bg = "NONE" })
hl("LineNrAbove", { fg = ui.muted, bg = "NONE" })
hl("LineNrBelow", { fg = ui.muted, bg = "NONE" })
hl("CursorLine", { bg = ui.surface })
hl("CursorLineNr", { fg = ui.fg_highlight, bg = ui.surface })
hl("CursorColumn", { bg = ui.surface })
hl("ColorColumn", { bg = ui.surface })
hl("Cursor", { fg = ui.bg, bg = ui.fg_max })
hl("Visual", { bg = ui.selection, fg = ui.fg_max })
hl("Pmenu", { fg = ui.fg, bg = ui.surface })
hl("PmenuSel", { fg = ui.fg_max, bg = ui.selection })
hl("PmenuSbar", { bg = ui.surface })
hl("PmenuThumb", { bg = ui.muted })
hl("StatusLine", { fg = ui.fg, bg = ui.surface })
hl("StatusLineNC", { fg = ui.muted, bg = ui.surface })
hl("TabLine", { fg = ui.muted, bg = ui.surface })
hl("TabLineSel", { fg = ui.fg_max, bg = ui.bg })
hl("TabLineFill", { bg = ui.surface })
hl("WinSeparator", { fg = ui.muted, bg = "NONE" })
hl("Folded", { fg = ui.muted, bg = ui.surface })
hl("FoldColumn", { fg = ui.muted, bg = "NONE" })
hl("NonText", { fg = ui.muted, bg = "NONE" })
hl("EndOfBuffer", { fg = ui.muted, bg = "NONE" })
hl("Whitespace", { fg = ui.muted, bg = "NONE" })
hl("SpecialKey", { fg = ui.muted, bg = "NONE" })
hl("Conceal", { fg = ui.muted, bg = "NONE" })
hl("MatchParen", { fg = ui.fg_max, bg = ui.selection, bold = true })
hl("Directory", { fg = sem.violet })
hl("Title", { fg = ui.fg_max, bold = true })
hl("Question", { fg = ui.fg_highlight })
hl("ModeMsg", { fg = ui.fg_highlight })
hl("MoreMsg", { fg = ui.fg_highlight })
hl("Underlined", { fg = sem.violet, underline = true })
hl("Bold", { bold = true })
hl("Italic", { italic = true })

-- Search (warning / accent carry information, like foot's search-box)
hl("Search", { fg = ui.bg, bg = sem.yellow })
hl("IncSearch", { fg = ui.bg, bg = sem.accent })
hl("CurSearch", { link = "IncSearch" })

-- Messages
hl("ErrorMsg", { fg = sem.red })
hl("WarningMsg", { fg = sem.yellow })
hl("Todo", { fg = sem.accent, bold = true })
hl("Comment", { fg = ui.muted, italic = true })

-- Spell
hl("SpellBad", { undercurl = true, sp = sem.red })
hl("SpellCap", { undercurl = true, sp = sem.yellow })
hl("SpellRare", { undercurl = true, sp = sem.violet })
hl("SpellLocal", { undercurl = true, sp = sem.cyan })

-- Diffs (add/remove/change convey information)
hl("DiffAdd", { fg = sem.green, bg = ui.surface })
hl("DiffChange", { fg = sem.yellow, bg = ui.surface })
hl("DiffDelete", { fg = sem.red, bg = ui.surface })
hl("DiffText", { fg = ui.fg_max, bg = ui.selection })
hl("Added", { fg = sem.green })
hl("Removed", { fg = sem.red })
hl("Changed", { fg = sem.yellow })

-- Diagnostics (semantic by definition)
hl("DiagnosticError", { fg = sem.red })
hl("DiagnosticWarn", { fg = sem.yellow })
hl("DiagnosticInfo", { fg = sem.cyan })
hl("DiagnosticHint", { fg = ui.fg_secondary })
hl("DiagnosticOk", { fg = sem.green })
hl("DiagnosticUnderlineError", { undercurl = true, sp = sem.red })
hl("DiagnosticUnderlineWarn", { undercurl = true, sp = sem.yellow })
hl("DiagnosticUnderlineInfo", { undercurl = true, sp = sem.cyan })
hl("DiagnosticUnderlineHint", { undercurl = true, sp = ui.fg_secondary })
hl("DiagnosticUnderlineOk", { undercurl = true, sp = sem.green })
hl("DiagnosticVirtualTextError", { fg = sem.red, bg = ui.surface })
hl("DiagnosticVirtualTextWarn", { fg = sem.yellow, bg = ui.surface })
hl("DiagnosticVirtualTextInfo", { fg = sem.cyan, bg = ui.surface })
hl("DiagnosticVirtualTextHint", { fg = ui.fg_secondary, bg = ui.surface })
hl("DiagnosticVirtualTextOk", { fg = sem.green, bg = ui.surface })
hl("DiagnosticSignError", { fg = sem.red, bg = "NONE" })
hl("DiagnosticSignWarn", { fg = sem.yellow, bg = "NONE" })
hl("DiagnosticSignInfo", { fg = sem.cyan, bg = "NONE" })
hl("DiagnosticSignHint", { fg = ui.fg_secondary, bg = "NONE" })
hl("DiagnosticSignOk", { fg = sem.green, bg = "NONE" })
hl("DiagnosticFloatingError", { fg = sem.red, bg = ui.surface })
hl("DiagnosticFloatingWarn", { fg = sem.yellow, bg = ui.surface })
hl("DiagnosticFloatingInfo", { fg = sem.cyan, bg = ui.surface })
hl("DiagnosticFloatingHint", { fg = ui.fg_secondary, bg = ui.surface })
hl("DiagnosticFloatingOk", { fg = sem.green, bg = ui.surface })

-- LSP
hl("LspReferenceText", { bg = ui.selection })
hl("LspReferenceRead", { bg = ui.selection })
hl("LspReferenceWrite", { bg = ui.selection })
hl("LspSignatureActiveParameter", { fg = ui.fg_max, bold = true })
hl("LspCodeLens", { fg = ui.muted })
hl("LspInlayHint", { fg = ui.muted, bg = ui.surface })

-- Syntax (monochrome by design; only Error uses red)
hl("Constant", { fg = ui.fg })
hl("String", { fg = sem.accent })
hl("Character", { fg = sem.accent })
hl("Number", { fg = ui.fg_highlight })
hl("Boolean", { fg = ui.fg_highlight })
hl("Float", { fg = ui.fg_highlight })
hl("Identifier", { fg = ui.fg })
hl("Function", { fg = ui.fg_max })
hl("Statement", { fg = ui.fg_max })
hl("Keyword", { fg = ui.fg_max })
hl("Conditional", { fg = ui.fg_max })
hl("Repeat", { fg = ui.fg_max })
hl("Label", { fg = ui.fg })
hl("Operator", { fg = ui.fg_secondary })
hl("Exception", { fg = ui.fg_max })
hl("Type", { fg = ui.fg_highlight })
hl("StorageClass", { fg = ui.fg })
hl("Structure", { fg = ui.fg_highlight })
hl("Typedef", { fg = ui.fg_highlight })
hl("Special", { fg = ui.fg_highlight })
hl("SpecialChar", { fg = ui.fg_highlight })
hl("Delimiter", { fg = ui.fg_secondary })
hl("SpecialComment", { fg = ui.muted })
hl("Debug", { fg = ui.fg_secondary })
hl("PreProc", { fg = ui.fg })
hl("Define", { fg = ui.fg })
hl("Macro", { fg = ui.fg })
hl("PreCondit", { fg = ui.fg })
hl("Error", { fg = sem.red })
hl("SnipInsert", { fg = ui.fg_max })

-- Treesitter (monochrome; links keep one definition point)
hl("@comment", { link = "Comment" })
hl("@comment.todo", { link = "Todo" })
hl("@comment.error", { fg = sem.red })
hl("@comment.warning", { fg = sem.yellow })
hl("@comment.note", { fg = ui.fg_highlight })
hl("@string", { link = "String" })
hl("@character", { link = "Character" })
hl("@number", { link = "Number" })
hl("@boolean", { link = "Boolean" })
hl("@float", { link = "Float" })
hl("@constant", { link = "Constant" })
hl("@variable", { fg = ui.fg })
hl("@variable.builtin", { fg = ui.fg_highlight })
hl("@variable.parameter", { fg = ui.fg })
hl("@variable.member", { fg = ui.fg })
hl("@property", { fg = ui.fg })
hl("@field", { fg = ui.fg })
hl("@function", { link = "Function" })
hl("@function.builtin", { link = "Function" })
hl("@function.macro", { link = "Function" })
hl("@method", { link = "Function" })
hl("@constructor", { fg = ui.fg_max })
hl("@keyword", { link = "Keyword" })
hl("@keyword.function", { link = "Keyword" })
hl("@keyword.operator", { link = "Keyword" })
hl("@conditional", { link = "Conditional" })
hl("@repeat", { link = "Repeat" })
hl("@operator", { link = "Operator" })
hl("@type", { link = "Type" })
hl("@type.builtin", { link = "Type" })
hl("@punctuation", { link = "Delimiter" })
hl("@markup.heading", { fg = ui.fg_max, bold = true })
hl("@markup.link", { fg = sem.violet })
hl("@markup.link.url", { fg = sem.violet, underline = true })
hl("@markup.raw", { fg = ui.fg_highlight })
hl("@markup.quote", { fg = ui.muted })
hl("@markup.list", { fg = ui.fg_secondary })
hl("@diff.plus", { link = "Added" })
hl("@diff.minus", { link = "Removed" })
hl("@diff.delta", { link = "Changed" })
hl("@tag", { fg = ui.fg })
hl("@tag.attribute", { fg = ui.fg_secondary })
hl("@tag.delimiter", { fg = ui.muted })
hl("@error", { fg = sem.red })

-- LSP semantic tokens (monochrome; opencode.nvim links here)
hl("@lsp.type.class", { link = "Type" })
hl("@lsp.type.comment", { link = "Comment" })
hl("@lsp.type.decorator", { fg = ui.fg_highlight })
hl("@lsp.type.enum", { link = "Type" })
hl("@lsp.type.enumMember", { link = "Constant" })
hl("@lsp.type.event", { fg = ui.fg })
hl("@lsp.type.function", { link = "Function" })
hl("@lsp.type.interface", { link = "Type" })
hl("@lsp.type.keyword", { link = "Keyword" })
hl("@lsp.type.macro", { link = "Function" })
hl("@lsp.type.method", { link = "Function" })
hl("@lsp.type.modifier", { fg = ui.fg_secondary })
hl("@lsp.type.namespace", { fg = ui.fg })
hl("@lsp.type.number", { link = "Number" })
hl("@lsp.type.operator", { link = "Operator" })
hl("@lsp.type.parameter", { fg = ui.fg })
hl("@lsp.type.property", { link = "@property" })
hl("@lsp.type.regexp", { link = "String" })
hl("@lsp.type.string", { link = "String" })
hl("@lsp.type.struct", { link = "Type" })
hl("@lsp.type.type", { link = "Type" })
hl("@lsp.type.typeParameter", { link = "Type" })
hl("@lsp.type.variable", { link = "@variable" })
hl("@lsp.mod.deprecated", { fg = sem.magenta, strikethrough = true })
hl("@markup", { fg = ui.fg })
hl("@markup.math", { fg = ui.fg_highlight })

-- Completion / snippets
hl("BlinkCmpMenu", { link = "Pmenu" })
hl("BlinkCmpMenuSelection", { link = "PmenuSel" })
hl("CmpItemAbbrMatch", { fg = ui.fg_max, bold = true })
hl("CmpItemAbbrMatchFuzzy", { fg = ui.fg_max })

-- render-markdown.nvim
hl("RenderMarkdownH1", { link = "Title" })
hl("RenderMarkdownH2", { link = "Title" })
hl("RenderMarkdownH3", { link = "Title" })
hl("RenderMarkdownH4", { link = "Title" })
hl("RenderMarkdownH5", { link = "Title" })
hl("RenderMarkdownH6", { link = "Title" })
hl("RenderMarkdownCode", { fg = ui.fg, bg = ui.surface })
hl("RenderMarkdownCodeInline", { fg = ui.fg_highlight, bg = ui.surface })
hl("RenderMarkdownLink", { fg = sem.violet, underline = true })
hl("RenderMarkdownUrl", { fg = sem.violet, underline = true })
hl("RenderMarkdownBullet", { fg = ui.fg_secondary })
hl("RenderMarkdownQuote", { fg = ui.muted })
hl("RenderMarkdownTodo", { link = "Todo" })

-- DAP / DAP-UI
hl("DapBreakpoint", { fg = sem.red })
hl("DapBreakpointCondition", { fg = sem.yellow })
hl("DapBreakpointRejected", { fg = sem.magenta })
hl("DapLogPoint", { fg = sem.cyan })
hl("DapStopped", { fg = sem.green })
hl("DapUIBreakpointsCurrentLine", { fg = sem.green, bold = true })
hl("DapUISource", { link = "Comment" })
hl("DapUIThread", { link = "Title" })
hl("DapUIWatchesValue", { link = "Normal" })
hl("DapUIWatchesEmpty", { link = "Comment" })
hl("DapUIWatchesError", { link = "Error" })

-- Quickfix / netrw (statusline and :find/:grep/:Lexplore flows)
hl("QuickFixLine", { bg = ui.selection, fg = ui.fg_max })
hl("qfFileName", { fg = sem.violet })
hl("qfLineNr", { fg = ui.muted })
hl("netrwDir", { link = "Directory" })
hl("netrwClassify", { fg = ui.muted })

-- Embedded terminal (:terminal) mirrors foot.ini per-variant mapping
if vim.o.background == "light" then
	vim.g.terminal_color_0 = base.base00
	vim.g.terminal_color_1 = base.base08
	vim.g.terminal_color_2 = base.base0B
	vim.g.terminal_color_3 = base.base0A
	vim.g.terminal_color_4 = base.base0D
	vim.g.terminal_color_5 = base.base0E
	vim.g.terminal_color_6 = base.base0C
	vim.g.terminal_color_7 = base.base04
	vim.g.terminal_color_8 = base.base03
	vim.g.terminal_color_9 = base.base08
	vim.g.terminal_color_10 = base.base0B
	vim.g.terminal_color_11 = base.base0A
	vim.g.terminal_color_12 = base.base0D
	vim.g.terminal_color_13 = base.base0E
	vim.g.terminal_color_14 = base.base0C
	vim.g.terminal_color_15 = base.base07
else
	vim.g.terminal_color_0 = base.base00
	vim.g.terminal_color_1 = base.base10
	vim.g.terminal_color_2 = base.base13
	vim.g.terminal_color_3 = base.base12
	vim.g.terminal_color_4 = base.base15
	vim.g.terminal_color_5 = base.base16
	vim.g.terminal_color_6 = base.base14
	vim.g.terminal_color_7 = base.base05
	vim.g.terminal_color_8 = base.base03
	vim.g.terminal_color_9 = base.base10
	vim.g.terminal_color_10 = base.base13
	vim.g.terminal_color_11 = base.base12
	vim.g.terminal_color_12 = base.base15
	vim.g.terminal_color_13 = base.base16
	vim.g.terminal_color_14 = base.base14
	vim.g.terminal_color_15 = base.base07
end
