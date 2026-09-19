-- Colorscheme: chroma
--
-- Palette from dots/README.md.
--   base00-base07  monochromatic UI
--   base08-base0F  semantic
--
-- Design: monochromatic base for code and UI, `accent` for strings and
-- selected UI, semantic colors where they convey information
-- (diagnostics, diff, git, search).

local base = {
	base00 = "#000000",
	base01 = "#0a0a0a",
	base02 = "#1e1e1e",
	base03 = "#434343",
	base04 = "#858585",
	base05 = "#b2b2b2",
	base06 = "#cfcfcf",
	base07 = "#ffffff",
	base08 = "#ca6789",
	base09 = "#da8472",
	base0A = "#eab532",
	base0B = "#6e9a5d",
	base0C = "#59aa90",
	base0D = "#088eaf",
	base0E = "#6f5fc3",
	base0F = "#a47fc6",
}

local function hex(c)
	return tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16)
end

-- mix(base, color, t): 0 => base, 1 => color
local function mix(c1, c2, t)
	local r1, g1, b1 = hex(c1)
	local r2, g2, b2 = hex(c2)
	local function lerp(a, b)
		return math.floor(a + (b - a) * t + 0.5)
	end
	return string.format("#%02x%02x%02x", lerp(r1, r2), lerp(g1, g2), lerp(b1, b2))
end

local function palette(bg)
	local p = {
		red = base.base08,
		orange = base.base09,
		yellow = base.base0A,
		green = base.base0B,
		cyan = base.base0C,
		blue = base.base0D,
		violet = base.base0E,
		magenta = base.base0F,
	}

	if bg == "light" then
		p.bg = base.base07
		p.surface = base.base06
		p.selection = base.base05
		p.fg = base.base02
		p.fg_secondary = base.base03
		p.fg_highlight = base.base01
		p.fg_max = base.base00
		p.muted = base.base04
		p.accent = base.base0D
	else
		p.bg = base.base00
		p.surface = base.base01
		p.selection = base.base02
		p.fg = base.base05
		p.fg_secondary = base.base04
		p.fg_highlight = base.base06
		p.fg_max = base.base07
		p.muted = base.base03
		p.accent = base.base0A
	end

	p.subtle = mix(p.bg, p.fg, 0.30)
	p.tint_red = mix(p.bg, p.red, 0.12)
	p.tint_orange = mix(p.bg, p.orange, 0.12)
	p.tint_green = mix(p.bg, p.green, 0.12)
	p.tint_accent = mix(p.bg, p.accent, 0.14)

	return p
end

local plugin_groups

local function groups(v)
	local h = {}

	-- Editor UI -----------------------------------------------------------
	h.Normal = { fg = v.fg, bg = v.bg }
	h.NormalNC = { fg = v.fg, bg = v.bg }
	h.NormalFloat = { fg = v.fg, bg = v.surface }
	h.FloatBorder = { fg = v.muted, bg = v.surface }
	h.FloatTitle = { fg = v.accent, bg = v.surface, bold = true }
	h.FloatFooter = { fg = v.muted, bg = v.surface }

	h.Cursor = { fg = v.bg, bg = v.fg }
	h.TermCursor = { link = "Cursor" } h.lCursor = { link = "Cursor" }
	h.CursorIM = { link = "Cursor" }

	h.CursorLine = { bg = v.surface }
	h.CursorColumn = { bg = v.surface }
	h.CursorLineNr = { fg = v.accent, bold = true }
	h.LineNr = { fg = v.muted }
	h.LineNrAbove = { fg = v.selection }
	h.LineNrBelow = { fg = v.selection }

	h.SignColumn = { bg = v.bg }
	h.FoldColumn = { fg = v.muted, bg = v.bg }
	h.Folded = { fg = v.fg_secondary, bg = v.surface }
	h.ColorColumn = { bg = v.surface }
	h.WinSeparator = { fg = v.selection, bg = v.bg }
	h.VertSplit = { link = "WinSeparator" }

	h.WinBar = { fg = v.fg_secondary, bg = v.bg }
	h.WinBarNC = { fg = v.muted, bg = v.bg }

	h.StatusLine = { fg = v.fg_secondary, bg = v.surface }
	h.StatusLineNC = { fg = v.muted, bg = v.surface }
	h.TabLine = { fg = v.fg_secondary, bg = v.surface }
	h.TabLineFill = { bg = v.surface }
	h.TabLineSel = { fg = v.fg_max, bg = v.bg, bold = true }

	h.Pmenu = { fg = v.fg, bg = v.surface }
	h.PmenuSel = { fg = v.fg_max, bg = v.selection, bold = true }
	h.PmenuKind = { fg = v.fg_secondary, bg = v.surface }
	h.PmenuExtra = { fg = v.muted, bg = v.surface }
	h.PmenuSbar = { bg = v.selection }
	h.PmenuThumb = { bg = v.fg_secondary }
	h.WildMenu = { link = "PmenuSel" }

	h.Visual = { bg = v.selection }
	h.VisualNOS = { link = "Visual" }

	h.Search = { fg = v.bg, bg = v.accent }
	h.IncSearch = { fg = v.bg, bg = v.orange }
	h.CurSearch = { link = "IncSearch" }
	h.MatchParen = { fg = v.accent, bold = true, underline = true }

	h.QuickFixLine = { bg = v.surface, bold = true }
	h.CursorLineFold = { link = "FoldColumn" }

	h.Directory = { fg = v.accent }
	h.Title = { fg = v.fg_max, bold = true }
	h.ModeMsg = { fg = v.accent, bold = true }
	h.ErrorMsg = { fg = v.red, bold = true }
	h.WarningMsg = { fg = v.orange }
	h.MoreMsg = { fg = v.green }
	h.Question = { fg = v.green }

	h.MsgArea = { fg = v.fg, bg = v.bg }
	h.MsgSeparator = { fg = v.selection, bg = v.bg }

	h.NonText = { fg = v.subtle }
	h.Whitespace = { fg = v.selection }
	h.SpecialKey = { fg = v.subtle }
	h.EndOfBuffer = { fg = v.bg }
	h.Conceal = { fg = v.muted }
	h.Ignore = { fg = v.fg }

	h.SpellBad = { sp = v.red, undercurl = true }
	h.SpellCap = { sp = v.orange, undercurl = true }
	h.SpellRare = { sp = v.cyan, undercurl = true }
	h.SpellLocal = { sp = v.green, undercurl = true }

	h.healthError = { fg = v.red }
	h.healthWarning = { fg = v.orange }
	h.healthSuccess = { fg = v.green }

	-- Diff ----------------------------------------------------------------
	h.DiffAdd = { fg = v.green, bg = v.tint_green }
	h.DiffChange = { fg = v.orange, bg = v.tint_orange }
	h.DiffDelete = { fg = v.red, bg = v.tint_red }
	h.DiffText = { fg = v.fg_max, bg = mix(v.bg, v.orange, 0.30), bold = true }
	h.diffAdded = { fg = v.green }
	h.diffRemoved = { fg = v.red }
	h.diffChanged = { fg = v.orange }
	h.diffFile = { fg = v.fg_secondary }
	h.diffLine = { fg = v.muted }

	h.Added = { fg = v.green }
	h.Changed = { fg = v.orange }
	h.Removed = { fg = v.red }

	-- Standard syntax (monochrome base, accent strings) -------------------
	h.Comment = { fg = v.muted, italic = true }
	h.Constant = { fg = v.fg_highlight }
	h.String = { fg = v.accent }
	h.Character = { fg = v.accent }
	h.Number = { fg = v.fg_highlight }
	h.Float = { link = "Number" }
	h.Boolean = { fg = v.fg_highlight }
	h.Identifier = { fg = v.fg }
	h.Function = { fg = v.fg_highlight, bold = true }
	h.Statement = { fg = v.fg_max, bold = true }
	h.Conditional = { link = "Statement" }
	h.Repeat = { link = "Statement" }
	h.Label = { link = "Statement" }
	h.Exception = { link = "Statement" }
	h.Keyword = { link = "Statement" }
	h.Operator = { fg = v.fg_secondary }
	h.PreProc = { fg = v.fg_highlight }
	h.Include = { link = "PreProc" }
	h.Define = { link = "PreProc" }
	h.Macro = { link = "PreProc" }
	h.PreCondit = { link = "PreProc" }
	h.Type = { fg = v.fg_highlight }
	h.StorageClass = { fg = v.fg_highlight }
	h.Structure = { fg = v.fg_highlight }
	h.Typedef = { link = "Type" }
	h.Special = { fg = v.magenta }
	h.SpecialChar = { link = "Special" }
	h.SpecialComment = { link = "Special" }
	h.Tag = { fg = v.fg_highlight }
	h.Delimiter = { fg = v.fg_secondary }
	h.Underlined = { fg = v.violet, underline = true }
	h.Todo = { fg = v.bg, bg = v.accent, bold = true }
	h.Error = { fg = v.red }
	h.Debug = { fg = v.orange }

	-- Treesitter ----------------------------------------------------------
	h["@comment"] = { link = "Comment" }
	h["@comment.documentation"] = { link = "Comment" }
	h["@comment.error"] = { fg = v.red, bold = true }
	h["@comment.warning"] = { fg = v.orange, bold = true }
	h["@comment.todo"] = { fg = v.accent, bold = true }
	h["@comment.note"] = { fg = v.cyan }

	h["@constant"] = { link = "Constant" }
	h["@constant.builtin"] = { fg = v.magenta }
	h["@constant.macro"] = { link = "Constant" }
	h["@number"] = { link = "Number" }
	h["@number.float"] = { link = "Number" }
	h["@boolean"] = { link = "Boolean" }

	h["@string"] = { link = "String" }
	h["@string.documentation"] = { link = "String" }
	h["@string.escape"] = { fg = v.magenta }
	h["@string.regexp"] = { fg = v.cyan }
	h["@string.special"] = { fg = v.magenta }
	h["@string.special.path"] = { fg = v.violet }
	h["@string.special.url"] = { fg = v.violet, underline = true }
	h["@character"] = { link = "Character" }
	h["@character.special"] = { fg = v.magenta }

	h["@variable"] = { link = "Identifier" }
	h["@variable.builtin"] = { fg = v.magenta }
	h["@variable.parameter"] = { fg = v.fg_secondary }
	h["@variable.member"] = { fg = v.fg }
	h["@property"] = { fg = v.fg }
	h["@field"] = { fg = v.fg }

	h["@function"] = { link = "Function" }
	h["@function.builtin"] = { fg = v.magenta }
	h["@function.call"] = { link = "Function" }
	h["@function.macro"] = { link = "Function" }
	h["@function.method"] = { link = "Function" }
	h["@function.method.call"] = { link = "Function" }
	h["@constructor"] = { fg = v.fg_highlight }

	h["@keyword"] = { link = "Statement" }
	h["@keyword.function"] = { link = "Statement" }
	h["@keyword.operator"] = { link = "Operator" }
	h["@keyword.return"] = { link = "Statement" }
	h["@keyword.conditional"] = { link = "Statement" }
	h["@keyword.repeat"] = { link = "Statement" }
	h["@keyword.exception"] = { link = "Statement" }
	h["@keyword.import"] = { link = "Statement" }
	h["@keyword.directive"] = { link = "PreProc" }
	h["@keyword.directive.define"] = { link = "PreProc" }
	h["@operator"] = { link = "Operator" }

	h["@type"] = { link = "Type" }
	h["@type.builtin"] = { fg = v.magenta }
	h["@type.definition"] = { link = "Type" }
	h["@type.qualifier"] = { link = "Statement" }
	h["@storageclass"] = { link = "Type" }
	h["@attribute"] = { fg = v.fg_highlight }
	h["@attribute.builtin"] = { fg = v.magenta }
	h["@namespace"] = { fg = v.fg_secondary }
	h["@module"] = { fg = v.fg_secondary }
	h["@label"] = { fg = v.fg_highlight }

	h["@punctuation"] = { fg = v.fg_secondary }
	h["@punctuation.delimiter"] = { fg = v.fg_secondary }
	h["@punctuation.bracket"] = { fg = v.fg_secondary }
	h["@punctuation.special"] = { fg = v.fg_secondary }

	h["@tag"] = { link = "Statement" }
	h["@tag.attribute"] = { fg = v.fg_highlight }
	h["@tag.delimiter"] = { fg = v.fg_secondary }

	h["@markup.heading"] = { fg = v.fg_max, bold = true }
	h["@markup.heading.1"] = { fg = v.fg_max, bold = true }
	h["@markup.heading.2"] = { fg = v.fg_max, bold = true }
	h["@markup.heading.3"] = { fg = v.fg_highlight, bold = true }
	h["@markup.heading.4"] = { fg = v.fg_highlight, bold = true }
	h["@markup.italic"] = { italic = true }
	h["@markup.bold"] = { bold = true }
	h["@markup.strikethrough"] = { strikethrough = true }
	h["@markup.underline"] = { underline = true }
	h["@markup.link"] = { fg = v.violet, underline = true }
	h["@markup.link.label"] = { fg = v.violet }
	h["@markup.link.url"] = { fg = v.violet, underline = true }
	h["@markup.raw"] = { fg = v.accent }
	h["@markup.raw.block"] = { fg = v.accent }
	h["@markup.list"] = { fg = v.accent }
	h["@markup.list.checked"] = { fg = v.green }
	h["@markup.list.unchecked"] = { fg = v.fg_secondary }
	h["@markup.quote"] = { fg = v.muted, italic = true }
	h["@markup.math"] = { fg = v.cyan }
	h["@markup.environment"] = { fg = v.fg_highlight }

	h["@diff.plus"] = { fg = v.green }
	h["@diff.minus"] = { fg = v.red }
	h["@diff.delta"] = { fg = v.orange }

	h["@spell"] = {}
	h["@nospell"] = {}

	-- LSP semantic tokens -------------------------------------------------
	h["@lsp.type.class"] = { link = "@type" }
	h["@lsp.type.enum"] = { link = "@type" }
	h["@lsp.type.enumMember"] = { link = "@constant" }
	h["@lsp.type.interface"] = { link = "@type" }
	h["@lsp.type.struct"] = { link = "@type" }
	h["@lsp.type.type"] = { link = "@type" }
	h["@lsp.type.typeParameter"] = { link = "@type" }
	h["@lsp.type.function"] = { link = "@function" }
	h["@lsp.type.method"] = { link = "@function.method" }
	h["@lsp.type.property"] = { link = "@property" }
	h["@lsp.type.parameter"] = { link = "@variable.parameter" }
	h["@lsp.type.macro"] = { link = "@function.macro" }
	h["@lsp.type.modifier"] = { link = "@keyword" }
	h["@lsp.type.variable"] = {}
	h["@lsp.mod.deprecated"] = { strikethrough = true }
	h["@lsp.typemod.variable.readonly"] = { link = "@constant" }

	h.LspReferenceText = { bg = v.surface }
	h.LspReferenceRead = { bg = v.surface }
	h.LspReferenceWrite = { bg = v.surface }
	h.LspSignatureActiveParameter = { fg = v.accent, bold = true }
	h.LspCodeLens = { fg = v.muted, italic = true }
	h.LspCodeLensSeparator = { fg = v.selection }
	h.LspInlayHint = { fg = v.muted, bg = v.surface }

	-- Diagnostics ---------------------------------------------------------
	h.DiagnosticError = { fg = v.red }
	h.DiagnosticWarn = { fg = v.orange }
	h.DiagnosticInfo = { fg = v.cyan }
	h.DiagnosticHint = { fg = v.green }
	h.DiagnosticOk = { fg = v.green }

	h.DiagnosticSignError = { link = "DiagnosticError" }
	h.DiagnosticSignWarn = { link = "DiagnosticWarn" }
	h.DiagnosticSignInfo = { link = "DiagnosticInfo" }
	h.DiagnosticSignHint = { link = "DiagnosticHint" }
	h.DiagnosticSignOk = { link = "DiagnosticOk" }

	h.DiagnosticVirtualTextError = { fg = v.red, bg = v.tint_red }
	h.DiagnosticVirtualTextWarn = { fg = v.orange, bg = v.tint_orange }
	h.DiagnosticVirtualTextInfo = { fg = v.cyan, bg = mix(v.bg, v.cyan, 0.12) }
	h.DiagnosticVirtualTextHint = { fg = v.green, bg = v.tint_green }
	h.DiagnosticVirtualTextOk = { fg = v.green, bg = v.tint_green }

	h.DiagnosticUnderlineError = { sp = v.red, undercurl = true }
	h.DiagnosticUnderlineWarn = { sp = v.orange, undercurl = true }
	h.DiagnosticUnderlineInfo = { sp = v.cyan, undercurl = true }
	h.DiagnosticUnderlineHint = { sp = v.green, undercurl = true }
	h.DiagnosticUnderlineOk = { sp = v.green, undercurl = true }

	h.DiagnosticFloatingError = { link = "DiagnosticError" }
	h.DiagnosticFloatingWarn = { link = "DiagnosticWarn" }
	h.DiagnosticFloatingInfo = { link = "DiagnosticInfo" }
	h.DiagnosticFloatingHint = { link = "DiagnosticHint" }
	h.DiagnosticFloatingOk = { link = "DiagnosticOk" }

	h.DiagnosticUnnecessary = { fg = v.muted }
	h.DiagnosticDeprecated = { strikethrough = true }

	-- Plugins -------------------------------------------------------------
	for name, attr in pairs(plugin_groups(v)) do
		h[name] = attr
	end

	return h
end

plugin_groups = function(v)
	local h = {}

	-- render-markdown.nvim ------------------------------------------------
	h.RenderMarkdownH1 = { fg = v.fg_max, bold = true }
	h.RenderMarkdownH2 = { fg = v.fg_highlight, bold = true }
	h.RenderMarkdownH3 = { fg = v.fg_highlight, bold = true }
	h.RenderMarkdownH4 = { fg = v.fg, bold = true }
	h.RenderMarkdownH5 = { fg = v.fg_secondary, bold = true }
	h.RenderMarkdownH6 = { fg = v.muted, bold = true }

	h.RenderMarkdownH1Bg = { bg = v.tint_accent }
	h.RenderMarkdownH2Bg = { bg = v.surface }
	h.RenderMarkdownH3Bg = { bg = v.surface }
	h.RenderMarkdownH4Bg = { bg = v.surface }
	h.RenderMarkdownH5Bg = { bg = v.surface }
	h.RenderMarkdownH6Bg = { bg = v.surface }

	h.RenderMarkdownCode = { fg = v.fg, bg = v.surface }
	h.RenderMarkdownCodeBorder = { fg = v.selection, bg = v.surface }
	h.RenderMarkdownCodeFallback = { link = "Normal" }
	h.RenderMarkdownCodeInline = { fg = v.fg_highlight, bg = v.surface }
	h.RenderMarkdownCodeInfo = { fg = v.accent, bg = v.surface }
	h.RenderMarkdownCodeLanguage = { fg = v.muted, bg = v.surface }

	h.RenderMarkdownQuote = { fg = v.muted, italic = true }
	h.RenderMarkdownQuote1 = { fg = v.selection }
	h.RenderMarkdownQuote2 = { fg = v.selection }
	h.RenderMarkdownQuote3 = { fg = v.selection }
	h.RenderMarkdownQuote4 = { fg = v.selection }
	h.RenderMarkdownQuote5 = { fg = v.selection }
	h.RenderMarkdownQuote6 = { fg = v.selection }

	h.RenderMarkdownInlineHighlight = { fg = v.fg_max, bg = v.tint_accent }
	h.RenderMarkdownBullet = { fg = v.accent }
	h.RenderMarkdownDash = { fg = v.selection }
	h.RenderMarkdownSign = { bg = v.bg }
	h.RenderMarkdownMath = { fg = v.cyan }
	h.RenderMarkdownIndent = { fg = v.selection }
	h.RenderMarkdownHtmlComment = { fg = v.muted, italic = true }
	h.RenderMarkdownPadding = {}

	h.RenderMarkdownLink = { fg = v.violet, underline = true }
	h.RenderMarkdownLinkTitle = { fg = v.violet }
	h.RenderMarkdownWikiLink = { fg = v.violet, underline = true }

	h.RenderMarkdownUnchecked = { fg = v.fg_secondary }
	h.RenderMarkdownChecked = { fg = v.green }
	h.RenderMarkdownTodo = { fg = v.bg, bg = v.accent, bold = true }

	h.RenderMarkdownTableHead = { fg = v.fg_max, bg = v.surface, bold = true }
	h.RenderMarkdownTableRow = { fg = v.fg }

	h.RenderMarkdownSuccess = { fg = v.green }
	h.RenderMarkdownInfo = { fg = v.cyan }
	h.RenderMarkdownHint = { fg = v.green }
	h.RenderMarkdownWarn = { fg = v.orange }
	h.RenderMarkdownError = { fg = v.red }

	-- nvim-dap-ui ---------------------------------------------------------
	h.DapUINormal = { fg = v.fg, bg = v.surface }
	h.DapUIVariable = { fg = v.fg, bg = v.surface }
	h.DapUIScope = { fg = v.accent, bg = v.surface }
	h.DapUIType = { fg = v.fg_highlight, bg = v.surface }
	h.DapUIValue = { fg = v.fg, bg = v.surface }
	h.DapUIModifiedValue = { fg = v.orange, bg = v.surface, bold = true }
	h.DapUIDecoration = { fg = v.selection, bg = v.surface }
	h.DapUIThread = { fg = v.green, bg = v.surface }
	h.DapUIStoppedThread = { fg = v.orange, bg = v.surface, bold = true }
	h.DapUIFrameName = { fg = v.fg, bg = v.surface }
	h.DapUISource = { fg = v.fg_secondary, bg = v.surface }
	h.DapUILineNumber = { fg = v.muted, bg = v.surface }
	h.DapUIFloatNormal = { fg = v.fg, bg = v.surface }
	h.DapUIFloatBorder = { fg = v.muted, bg = v.surface }
	h.DapUIWatchesEmpty = { fg = v.muted, bg = v.surface }
	h.DapUIWatchesValue = { fg = v.green, bg = v.surface }
	h.DapUIWatchesError = { fg = v.red, bg = v.surface }
	h.DapUIBreakpointsPath = { fg = v.accent, bg = v.surface }
	h.DapUIBreakpointsInfo = { fg = v.fg_secondary, bg = v.surface }
	h.DapUIBreakpointsCurrentLine = { fg = v.accent, bg = v.surface, bold = true }
	h.DapUIBreakpointsLine = { fg = v.muted, bg = v.surface }
	h.DapUIBreakpointsDisabledLine = { fg = v.muted, bg = v.surface }
	h.DapUICurrentFrameName = { fg = v.accent, bg = v.surface, bold = true }
	h.DapUIStepOver = { fg = v.fg, bg = v.surface }
	h.DapUIStepInto = { fg = v.fg, bg = v.surface }
	h.DapUIStepBack = { fg = v.fg, bg = v.surface }
	h.DapUIStepOut = { fg = v.fg, bg = v.surface }
	h.DapUIStop = { fg = v.red, bg = v.surface }
	h.DapUIPlayPause = { fg = v.green, bg = v.surface }
	h.DapUIRestart = { fg = v.green, bg = v.surface }
	h.DapUIUnavailable = { fg = v.selection, bg = v.surface }
	h.DapUIWinSelect = { fg = v.accent, bg = v.surface, bold = true }
	h.DapUIEndOfBuffer = { fg = v.bg, bg = v.surface }

	h.DapUIStepOverNC = { fg = v.muted, bg = v.surface }
	h.DapUIStepIntoNC = { fg = v.muted, bg = v.surface }
	h.DapUIStepBackNC = { fg = v.muted, bg = v.surface }
	h.DapUIStepOutNC = { fg = v.muted, bg = v.surface }
	h.DapUIStopNC = { fg = v.selection, bg = v.surface }
	h.DapUIPlayPauseNC = { fg = v.muted, bg = v.surface }
	h.DapUIRestartNC = { fg = v.muted, bg = v.surface }
	h.DapUIUnavailableNC = { fg = v.selection, bg = v.surface }

	-- opencode.nvim -------------------------------------------------------
	h.OpencodeContextPlaceholder = { fg = v.muted, italic = true }
	h.OpencodeContextValue = { fg = v.fg_highlight }
	h.OpencodeAgent = { fg = v.accent }

	-- godotdev.nvim -------------------------------------------------------
	h.GodotSceneTreeIcon = { fg = v.fg }
	h.GodotSceneTreeHeader = { fg = v.fg_max, bg = v.surface, bold = true }
	h.GodotSceneTreeIconWhite = { fg = v.fg_max }
	h.GodotSceneTreeIconGrey = { fg = v.fg_secondary }
	h.GodotSceneTreeIconBlue = { fg = v.blue }
	h.GodotSceneTreeIconRed = { fg = v.red }
	h.GodotSceneTreeIconGreen = { fg = v.green }
	h.GodotSceneTreeIconPurple = { fg = v.magenta }
	h.GodotSceneTreeIconYellow = { fg = v.yellow }

	return h
end

local function apply()
	local bg = vim.o.background
	local v = palette(bg)
	local h = groups(v)

	for name, attr in pairs(h) do
		vim.api.nvim_set_hl(0, name, attr)
	end
end

local function setup()
	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") == 1 then
		vim.cmd("syntax reset")
	end

	vim.o.termguicolors = true
	vim.g.colors_name = "chroma"

	apply()

	local group = vim.api.nvim_create_augroup("chroma_colorscheme", { clear = true })
	vim.api.nvim_create_autocmd("OptionSet", {
		group = group,
		pattern = "background",
		callback = apply,
	})
end

setup()

return {}
