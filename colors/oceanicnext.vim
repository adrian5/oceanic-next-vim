" ==============================================================================
" Name: Oceanic Next
" Description: Adaptation of the Oceanic Next color palette for (Neo)Vim
" Repository: https://github.com/adrian5/oceanic-next-vim
" License: MIT
" ==============================================================================

" ==============================================================================
" ***** Setup ******************************************************************
" ==============================================================================
" {{{

" ----- Init --------------------------------------------------------------- {{{

highlight clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "oceanicnext"
set background=dark

" }}}

" ----- Config ------------------------------------------------------------- {{{

let s:config = {}
let s:config.gutter_like_bg = get(g:, "oceanic_gutter_like_bg", 0)
let s:config.italic_comments = get(g:, "oceanic_italic_comments", 0)
let s:config.transparent_bg = get(g:, "oceanic_transparent_bg", 0)
if get(g:, "oceanic_bold", 1)
  let s:bold = "bold,"
  " NOTE: vim gracefully handles trailing commas in assigned values
else
  let s:bold = ""
endif

" }}}

" ----- Highlight Function ------------------------------------------------- {{{

" NOTE: A different function is used based on terminal support. This simplifies
" logic and evades potential issues with `guisp` support. Arguments are
" positional; setting `gui` or `guisp` requires setting all preceding arguments!
"
" Usage: s:HL(target, fg[2], bg[2], gui, guisp[2])

if (has("termguicolors") && &termguicolors) || has("gui_running")
  function! s:HL(target, fg, ...) abort
    let hls = [
      \ "hi", a:target,
      \ "guifg=" . a:fg[0]
    \ ]

    " Background
    if a:0 >= 1
      call add(hls, "guibg=" . a:1[0])
    else
      call add(hls, "guibg=NONE")
    endif

    " Text-style (see `:h attr-list`)
    if a:0 >= 2 && strlen(a:2)
      call add(hls, "cterm=" . a:2 . " gui=" . a:2)
      " NOTE: `cterm` applies to modern terminals too, `gui` is for true GUIs.
    else
      call add(hls, "cterm=NONE gui=NONE")
    endif

    " Coloring of undercurl/line
    if a:0 >= 3
      call add(hls, "guisp=" . a:3[0])
    endif

    execute join(hls, " ")
  endfunction
else " 256-color term (assume no `guisp` support)
  function! s:HL(target, fg, ...) abort
    let hls = [
      \ "hi", a:target,
      \ "ctermfg=" . a:fg[1]
    \ ]

    " Background
    if a:0 >= 1
      call add(hls, "ctermbg=" . a:1[1])
    else
      call add(hls, "ctermbg=NONE")
    endif

    " Text-style
    if a:0 >= 2 && strlen(a:2)
      call add(hls, "cterm=" . a:2)
    else
      call add(hls, "cterm=NONE")
    endif

    execute join(hls, " ")
  endfunction
endif

" }}}

" ========================================================================== }}}



" ==============================================================================
" ***** Oceanic Colors *********************************************************
" ==============================================================================
" {{{

" ----- Oceanic Color Palette ---------------------------------------------- {{{

" Foreground shades
let s:fg1 = ["#405860", 239]
let s:fg2 = ["#4d616b", 240]
let s:fg3 = ["#65737e", 242]
let s:fg4 = ["#adb5c0", 249]
let s:fg5 = ["#d8dee9", 253]
let s:fg  = s:fg5

" Background shades
let s:bg1 = ["#17262e", 233]
let s:bg2 = ["#192932", 234]
let s:bg3 = ["#1b2b34", 235]
let s:bg4 = ["#223642", 236]
let s:bg5 = ["#29414f", 237]
let s:bg  = s:bg3

" Vivid base colors
let s:red    = ["#ec5f67", 167]
let s:orange = ["#f99157", 209]
let s:yellow = ["#fac863", 221]
let s:green  = ["#99c794", 108]
let s:aqua   = ["#5fb3b3",  73]
let s:blue   = ["#6699cc",  68]
let s:lilac  = ["#c594c5", 176]
let s:brown  = ["#ab7967", 138]

" Vivid dark colors
let s:daqua  = ["#4b8a8d", 66]

" Reset
let s:none = ["NONE", "NONE"]

" }}}

" ----- Oceanic Highlight Groups ------------------------------------------- {{{

call s:HL("OcFg", s:fg)
call s:HL("OcFgBold", s:fg, s:none, s:bold)
call s:HL("OcFg1", s:fg1)
call s:HL("OcFg2", s:fg2)
call s:HL("OcFg4", s:fg4)
call s:HL("OcFg4Bold", s:fg4, s:none, s:bold)

call s:HL("OcRed", s:red)
call s:HL("OcRedBold", s:red, s:none, s:bold)
call s:HL("OcOrange", s:orange)
call s:HL("OcOrangeBold", s:orange, s:none, s:bold)
call s:HL("OcYellow", s:yellow)
call s:HL("OcYellowBold", s:yellow, s:none, s:bold)
call s:HL("OcGreen", s:green)
call s:HL("OcGreenBold", s:green, s:none, s:bold)
call s:HL("OcAqua", s:aqua)
call s:HL("OcAquaBold", s:aqua, s:none, s:bold)
call s:HL("OcBlue", s:blue)
call s:HL("OcBlueBold", s:blue, s:none, s:bold)
call s:HL("OcLilac", s:lilac)
call s:HL("OcLilacBold", s:lilac, s:none, s:bold)
call s:HL("OcBrown", s:brown)
call s:HL("OcBrownBold", s:brown, s:none, s:bold)

call s:HL("OcDarkAqua", s:daqua)
call s:HL("OcDarkAquaBold", s:daqua, s:none, s:bold)

" Common Signals
hi! link OcError OcRed
hi! link OcWarning OcYellow
hi! link OcInfo OcBlue
hi! link OcHint OcLilac

" }}}

" ========================================================================== }}}



" ==============================================================================
" ***** Builtin Highlights *****************************************************
" ==============================================================================
" {{{

" ----- Builtin (Editor/UI) ------------------------------------------------ {{{

" See `:help highlight-groups` for reference

if s:config.transparent_bg
  call s:HL("Normal", s:fg)
  call s:HL("Terminal", s:fg)
  call s:HL("EndOfBuffer", s:bg5)
  call s:HL("Folded", ["#4d708c", 24])
  call s:HL("LineNr", s:fg1)
  call s:HL("CursorLineNr", s:fg4)
else
  call s:HL("Normal", s:fg, s:bg)
  call s:HL("Terminal", s:fg, s:bg)
  call s:HL("EndOfBuffer", s:bg5, s:bg)
  call s:HL("Folded", ["#4d708c", 24], ["#1e313b", 235])

  if s:config.gutter_like_bg
    call s:HL("LineNr", s:fg1, s:bg)
    call s:HL("CursorLineNr", s:fg4, s:bg)
  else
    call s:HL("LineNr", s:fg1, s:bg2)
    call s:HL("CursorLineNr", s:fg4, s:bg2)
  endif
endif
hi! link FoldColumn LineNr
hi! link SignColumn LineNr
call s:HL("ColorColumn", s:none, s:bg2)
hi! link Conceal OcLilac
call s:HL("Cursor", s:fg, s:none, "inverse")
hi! link vCursor Cursor
hi! link iCursor Cursor
hi! link lCursor Cursor
hi! link CursorIM Cursor
call s:HL("CursorLine", s:none, s:bg4)
hi! link CursorColumn CursorLine
call s:HL("DiffAdd", s:none, ["#2d4a46", 22])
call s:HL("DiffChange", s:none, ["#29445a", 23])
call s:HL("DiffDelete", s:none, ["#45353e", 52])
call s:HL("DiffText", s:none, s:bg, "inverse")
hi! link Directory OcBlue
hi! link ErrorMsg OcRed
hi! link WarningMsg OcYellow
call s:HL("ModeMsg", s:fg)
hi! link MoreMsg ModeMsg
call s:HL("Search", s:none, s:bg, "inverse")
call s:HL("MatchParen", s:none, ["#3c5f73", 66])
call s:HL("Whitespace", s:bg5)
hi! link NonText Whitespace
hi! link SpecialKey OcAqua
call s:HL("Pmenu", s:fg, s:bg4)
hi! link PmenuSbar Pmenu
call s:HL("PmenuSel", s:bg, s:blue)
call s:HL("PmenuThumb", s:none, s:bg5)
hi! link WildMenu PmenuSel
hi! link Question OcBlue
call s:HL("SpellBad", s:red, s:none, "undercurl", s:red)
call s:HL("SpellCap", s:yellow, s:none, "undercurl", s:yellow)
call s:HL("SpellLocal", s:blue, s:none, "undercurl", s:blue)
call s:HL("SpellRare", s:lilac, s:none, "undercurl", s:lilac)
call s:HL("StatusLine", s:fg, s:bg1)
hi! link StatusLineTerm StatusLine
call s:HL("StatusLineNC", s:fg1, s:bg1)
hi! link StatusLineTermNC StatusLineNC
call s:HL("TabLine", s:fg2, s:bg1, s:bold)
call s:HL("TabLineFill", s:fg4, s:bg1, s:bold)
call s:HL("TabLineSel", ["#bdc2cc", 250], s:bg, s:bold)
call s:HL("VertSplit", s:bg, s:bg1)
call s:HL("Visual", s:none, ["#2f4c5c", 238])
hi! link VisualNOS Visual

" :checkhealth
hi! link healthError OcRedBold
hi! link healthWarning OcYellowBold
hi! link healthSuccess OcGreenBold

" }}}

" ----- Builtin (Syntax) --------------------------------------------------- {{{

" See `:help group-name` for reference

if s:config.italic_comments
  call s:HL("Comment", s:fg3, s:none, "italic")
  call s:HL("SpecialComment", ["#a5abb8", 248], s:none, "italic")
  call s:HL("Todo", s:fg4, s:bg5, s:bold . "italic")
else
  call s:HL("Comment", s:fg3)
  call s:HL("SpecialComment", ["#a5abb8", 248])
  call s:HL("Todo", s:fg4, s:bg5, s:bold)
endif

call s:HL("Underlined", s:none, s:none, "underline")
hi! link Boolean OcRed
hi! link Character String
hi! link Conditional Statement
hi! link Constant OcAqua
hi! link Debug OcYellow
hi! link Define OcLilac
hi! link Delimiter Special
hi! link Error OcError
hi! link Exception OcAqua
hi! link Float OcOrange
hi! link Function OcBlue
hi! link Identifier OcLilac
hi! link Include OcLilac
hi! link Keyword Statement
hi! link Label Statement
hi! link Macro PreProc
hi! link Number OcOrange
hi! link Operator OcAqua
hi! link PreCondit OcBrown
hi! link PreProc OcAqua
hi! link Repeat Statement
hi! link Special OcAqua
hi! link SpecialChar Special
hi! link Statement OcLilac
hi! link StorageClass OcLilac
hi! link String OcGreen
hi! link Structure Type
hi! link Tag OcRed
hi! link Title OcBlueBold
hi! link Type OcYellow
hi! link Typedef OcAqua

" }}}

" ----- Builtin (nvim-lsp) ------------------------------------------------- {{{

" See `:help lsp-highlight` for reference

if has("nvim")

" Highlights for vim.lsp.buf.document_highlight()
hi! link LspReferenceText Visual
hi! link LspReferenceRead Visual
hi! link LspReferenceWrite Visual

" Other LSP highlights link to these by default (except Underline)
hi! link LspDiagnosticsDefaultError OcError
hi! link LspDiagnosticsDefaultWarning OcWarning
hi! link LspDiagnosticsDefaultInformation OcInfo
hi! link LspDiagnosticsDefaultHint OcHint

" Diagnostic messages placed as virtual text
hi! link LspDiagnosticsVirtualTextError OcError
hi! link LspDiagnosticsVirtualTextWarning OcWarning
hi! link LspDiagnosticsVirtualTextInformation OcInfo
hi! link LspDiagnosticsVirtualTextHint OcHint

" Underline of text causing diagnostic message
call s:HL("LspDiagnosticsUnderlineError", s:red, s:none, "undercurl")
call s:HL("LspDiagnosticsUnderlineWarning", s:yellow, s:none, "undercurl")
call s:HL("LspDiagnosticsUnderlineInformation", s:blue, s:none, "undercurl")
call s:HL("LspDiagnosticsUnderlineHint", s:lilac, s:none, "undercurl")

" Diagnostic messages in floating window
call s:HL("LspDiagnosticsFloatingError", s:fg)
call s:HL("LspDiagnosticsFloatingWarning", s:fg)
call s:HL("LspDiagnosticsFloatingInformation", s:fg)
call s:HL("LspDiagnosticsFloatingHint", s:fg)

" Signs placed in sign column
hi! link LspDiagnosticsSignError OcError
hi! link LspDiagnosticsSignWarning OcWarning
hi! link LspDiagnosticsSignInformation OcInfo
hi! link LspDiagnosticsSignHint OcHint

endif

" }}}

" ========================================================================== }}}



" ==============================================================================
" ***** Plugin Highlights ******************************************************
" ==============================================================================
" {{{

" ----- Plugin (barbar) ---------------------------------------------------- {{{

call s:HL("BufferTabpageFill", s:bg4, s:bg1)
call s:HL("BufferTabpages", s:bg4, s:none, s:bold)

hi! link BufferCurrent TabLineSel
hi! link BufferCurrentMod OcGreenBold
hi! link BufferCurrentSign OcAqua

call s:HL("BufferVisible", s:fg4, s:bg1, s:bold)
call s:HL("BufferVisibleMod", s:green, s:bg1, s:bold)
call s:HL("BufferVisibleSign", s:bg4, s:bg1)

hi! link BufferInactive TabLine
call s:HL("BufferInactiveMod", ["#65876d", 65], s:bg1, s:bold)
hi! link BufferInactiveSign BufferTabpageFill

" }}}

" ----- Plugin (Buftabline) ------------------------------------------------ {{{

hi! link BuftablineActive TabLine

" }}}

" ----- Plugin (coc.vim) --------------------------------------------------- {{{

call s:HL("CocErrorHighlight", s:none, s:none, "undercurl", s:red)
call s:HL("CocHintHighlight", s:none, s:none, "undercurl", s:lilac)
call s:HL("CocInfoHighlight", s:none, s:none, "undercurl", s:blue)
call s:HL("CocWarningHighlight", s:none, s:none, "undercurl", s:yellow)
hi! link CocCodeLens OcFg2
hi! link CocErrorSign OcError
hi! link CocHighlightText Visual
hi! link CocHintSign OcHint
hi! link CocHoverRange Visual
hi! link CocInfoSign OcInfo
hi! link CocWarningSign OcWarning

" }}}

" ----- Plugin (fzf) ------------------------------------------------------- {{{

" NOTE: These groups color the statusline, not the prompt!

call s:HL("fzf1", s:fg4, s:bg2)
hi! link fzf2 fzf1
hi! link fzf3 fzf1

" }}}

" ----- Plugin (NERDTree) -------------------------------------------------- {{{

hi! link NERDTreeCWD OcLilacBold
hi! link NERDTreeClosable OcOrange
hi! link NERDTreeDirSlash OcAqua
hi! link NERDTreeExecFile OcYellow
hi! link NERDTreeLinkFile OcAqua
hi! link NERDTreeLinkTarget OcDarkAqua
hi! link NERDTreeUp OcAqua

" }}}

" ----- Plugin (netrw) ----------------------------------------------------- {{{

hi! link netrwClassify OcAqua
hi! link netrwExe OcYellow
hi! link netrwHidePat netrwList
hi! link netrwLink OcDarkAqua
hi! link netrwList OcLilac
hi! link netrwSymLink OcAqua
hi! link netrwVersion OcGreen

" }}}

" ----- Plugin (nvim-treesitter) ------------------------------------------- {{{

hi! link TSError OcError
hi! link TSField OcFg
hi! link TSNamespace OcAqua
hi! link TSParameter OcFg
hi! link TSPunctBracket OcFg
hi! link TSVariableBuiltin OcRed

" }}}

" ----- Plugin (vim-gitgutter) --------------------------------------------- {{{

hi! link GitGutterAdd OcGreen
hi! link GitGutterChange OcBlue
hi! link GitGutterDelete OcRed
hi! link GitGutterChangeDelete OcOrange

" }}}

" ----- Plugin (vim-signify) ----------------------------------------------- {{{

hi! link SignifyLineAdd DiffAdd
hi! link SignifyLineChange DiffChange
hi! link SignifyLineDelete DiffDelete
hi! link SignifySignAdd OcGreen
hi! link SignifySignChange OcBlue
hi! link SignifySignDelete OcRed

" }}}

" ----- Plugin (vim-startify) ---------------------------------------------- {{{

hi! link StartifyBracket OcFg2
hi! link StartifyFile OcLilacBold
hi! link StartifyFooter Comment
hi! link StartifyHeader OcGreen
hi! link StartifyNumber OcOrange
hi! link StartifyPath OcFg4
hi! link StartifySection OcBlueBold
hi! link StartifySelect OcGreenBold
hi! link StartifySlash OcFg2

" }}}

" ========================================================================== }}}



" ==============================================================================
" ***** Syntax Highlights ******************************************************
" ==============================================================================
" {{{

" ----- Syntax (C/C++) ----------------------------------------------------- {{{

" NOTE: Poorly supported by vim, and the defaults are sufficient for that;
" Revisit once vim ships with better highlighting!

" }}}

" ----- Syntax (CSS) ------------------------------------------------------- {{{

hi! link cssAtKeyword Include
hi! link cssAtRuleLogical OcAqua
hi! link cssAttr OcAqua
hi! link cssBraces OcFg
hi! link cssClassName cssTagName
hi! link cssClassNameDot cssClassName
hi! link cssIdentifier cssTagName
hi! link cssImportant OcLilac
hi! link cssProp OcYellow
hi! link cssPseudoClassId OcBlue
hi! link cssTagName OcRed

" }}}

" ----- Syntax (CSV) ------------------------------------------------------- {{{

hi! link CSVColumnEven OcGreen
hi! link CSVColumnHeaderEven Title
hi! link CSVColumnHeaderOdd CSVColumnHeaderEven
hi! link CSVColumnOdd OcYellow
hi! link CSVDelimiter OcFg

" }}}

" ----- Syntax (diff) ------------------------------------------------------ {{{

hi! link diffAdded OcGreen
hi! link diffFile OcLilacBold
hi! link diffIndexLine OcFg2
hi! link diffLine OcBlue
hi! link diffRemoved OcRed
hi! link diffSubname OcAqua

" }}}

" ----- Syntax (gitcommit) ------------------------------------------------- {{{

hi! link gitcommitBranch OcFgBold
hi! link gitcommitOverflow OcBrown
hi! link gitcommitSelectedFile OcGreenBold
hi! link gitcommitUntrackedFile OcRed

" }}}

" ----- Syntax (gitconfig) ------------------------------------------------- {{{

hi! link gitconfigSection OcBlueBold
hi! link gitconfigVariable OcYellow
hi! link gitconfigDelim gitconfigString

" }}}

" ----- Syntax (gitrebase) ------------------------------------------------- {{{

hi! link gitrebaseBreak OcBrown
hi! link gitrebaseCommit OcLilacBold
hi! link gitrebaseExec OcBlueBold
hi! link gitrebaseFixup gitrebaseSquash
hi! link gitrebaseHash gitrebaseCommit
hi! link gitrebaseReword OcAqua
hi! link gitrebaseSquash OcAqua

" }}}

" ----- Syntax (HTML) ------------------------------------------------------ {{{

hi! link htmlEndTag htmlTag
hi! link htmlH1 OcFg
hi! link htmlH2 htmlH1
hi! link htmlH3 htmlH1
hi! link htmlH4 htmlH1
hi! link htmlH5 htmlH1
hi! link htmlH6 htmlH1
hi! link htmlLink OcFg
hi! link htmlSpecialChar OcLilac
hi! link htmlSpecialTagName htmlTagName
hi! link htmlTag OcAqua
hi! link htmlTagN htmlTagName
hi! link htmlTagName OcRed
hi! link htmlTitle OcFg

" }}}

" ----- Syntax (nftables) -------------------------------------------------- {{{

hi! link nftablesMask OcGreen
hi! link nftablesSet OcAqua
hi! link nftablesSetEntry nftablesSet

" }}}

" ----- Syntax (JavaScript)------------------------------------------------- {{{

hi! link JavaScriptBraces OcFg
hi! link JavaScriptLabel OcAqua
hi! link JavaScriptIdentifier OcRed

" }}}

" ----- Syntax (JSON) ------------------------------------------------------ {{{

hi! link jsonKeyword OcBlue
hi! link jsonQuote String
hi! link jsonKeywordMatch Operator
hi! link jsonNoise Operator

" }}}

" ----- Syntax (Less) ------------------------------------------------------ {{{

hi! link lessAmpersand lessClass
hi! link lessClass cssClassName
hi! link lessClassCall Function
hi! link lessClassChar lessClass
hi! link lessCssAttribute Operator
hi! link lessFunction Function
hi! link lessId cssIdentifier
hi! link lessIdChar lessId
hi! link lessMedia OcLilac
hi! link less OcLilac

" }}}

" ----- Syntax (Markdown) -------------------------------------------------- {{{

call s:HL("markdownItalic", s:lilac, s:none, s:bold . "italic")
hi! link markdownBold OcYellowBold
hi! link markdownCode OcAqua
hi! link markdownH1 OcBlueBold
hi! link markdownH2 markdownH1
hi! link markdownH3 markdownH1
hi! link markdownH4 markdownH1
hi! link markdownH5 markdownH1
hi! link markdownH6 markdownH1
hi! link markdownHeadingDelimiter markdownH1
hi! link markdownHeadingRule markdownH1
hi! link markdownLinkText OcFgBold
hi! link markdownListMarker OcRed
hi! link markdownRule OcAqua
hi! link markdownUrl OcGreen

" }}}

" ----- Syntax (Python) ---------------------------------------------------- {{{

" NOTE: Revisit once vim ships with better highlighting!

hi! link pythonDecorator OcAqua
hi! link pythonDecoratorName pythonDecorator

" }}}

" ----- Syntax (Ruby) ------------------------------------------------------ {{{

" NOTE: Revisit once vim ships with better highlighting!

hi! link rubyStringDelimiter rubyString

" }}}

" ----- Syntax (Rust) ------------------------------------------------------ {{{

" NOTE: Not satisfied with 'rustLifetime' coloring. If green, it wouldn't have
" touched adjacent other greens, but that color should be reserved for actual
" string literals (data).

hi! link rustAttribute OcAqua
hi! link rustAwait rustFuncCall
hi! link rustCommentLineDoc Comment
hi! link rustDerive rustAttribute
hi! link rustDeriveTrait OcGreen
hi! link rustEnumVariant rustType
hi! link rustIdentifier OcYellowBold
hi! link rustLifetime OcRed
hi! link rustMacro rustFuncCall
hi! link rustModPath OcAqua
hi! link rustModPathSep OcDarkAqua
hi! link rustQuestionMark Operator
hi! link rustSelf OcRed
hi! link rustSigil rustOperator
hi! link rustUnsafeKeyword OcAquaBold

" }}}

" ----- Syntax (SCSS) ------------------------------------------------------ {{{

hi! link sassAmpersand sassClass
hi! link sassClass cssClassName
hi! link sassClassChar sassClass
hi! link sassId cssIdentifier
hi! link sassIdChar sassId
hi! link sassMedia cssAtRule
hi! link sassMediaOperators cssAtRuleLogical
hi! link sassMediaQuery cssMediaType
hi! link sassProperty Type

" }}}

" ----- Syntax (Shell) ----------------------------------------------------- {{{

hi! link shCaseBar shOperator
hi! link shCaseLabel OcFg4
hi! link shCommandSub OcFg
hi! link shDeref OcAqua
hi! link shDerefOp shDeref
hi! link shDerefPattern shDeref
hi! link shDerefSimple shDerefVar
hi! link shDerefVar OcBrown
hi! link shDoubleQuote shQuote
hi! link shFunctionFour shFunction
hi! link shFunctionOne shFunction
hi! link shFunctionThree shFunction
hi! link shFunctionTwo shFunction
hi! link shQuote shString
hi! link shSet OcRed
hi! link shSetList shVariable
hi! link shShellVariables OcAqua
hi! link shSnglCase shOperator
hi! link shTestOpr shOperator
hi! link shVarAssign shOperator
hi! link shVariable OcYellow

" }}}

" ----- Syntax (systemd) --------------------------------------------------- {{{

hi! link sdDocURI String
hi! link sdEnvDef OcBrownBold
hi! link sdEnvDefs sdValue
hi! link sdExecArgs OcAqua
hi! link sdExecFile sdFileName
hi! link sdFileName String
hi! link sdHeader Title
hi! link sdKey OcLilac
hi! link sdOtherSignal OcRed
hi! link sdUnitName OcYellowBold
hi! link sdUser OcYellow
hi! link sdValue OcAqua

hi! link sdAutoMountBlock sdMountBlock
hi! link sdInstallBlock sdValue
hi! link sdMountBlock sdValue
hi! link sdPathBlock sdValue
hi! link sdScopeBlock sdValue
hi! link sdServiceBlock sdValue
hi! link sdSliceBlock sdValue
hi! link sdSocketBlock sdValue
hi! link sdSwapBlock sdValue
hi! link sdTimerBlock sdValue
hi! link sdUnitBlock sdValue

" }}}

" ----- Syntax (VimL) ------------------------------------------------------ {{{

hi! link vimBracket OcDarkAqua
hi! link vimCommand OcRed
hi! link vimCommentTitle OcFg4Bold
hi! link vimContinue OcDarkAqua
hi! link vimEnvvar OcBrown
hi! link vimFuncVar vimVar
hi! link vimFunction Function
hi! link vimHiBang vimHighlight
hi! link vimHighlight OcLilac
hi! link vimMap OcLilac
hi! link vimOption vimVar
hi! link vimSetSep Operator
hi! link vimUserFunc vimFunction
hi! link vimVar OcYellow

" }}}

" ----- Syntax (XML) ------------------------------------------------------- {{{

hi! link xmlAttribPunct Operator
hi! link xmlCdata OcFg4
hi! link xmlCdataCdata OcOrange
hi! link xmlCdataEnd xmlCdataStart
hi! link xmlCdataStart xmlTag
hi! link xmlEndTag xmlTag
hi! link xmlEqual Operator
hi! link xmlProcessingDelim OcBlue
hi! link xmlTag OcAqua
hi! link xmlTagN xmlTagName
hi! link xmlTagName OcRed

" }}}

" ----- Syntax (YAML) ------------------------------------------------------ {{{

hi! link yamlAnchor OcRed
hi! link yamlBlockCollectionItemStart OcAqua
hi! link yamlDocumentStart OcAquaBold
hi! link yamlFlowCollection Operator

" }}}

" ========================================================================== }}}



" ==============================================================================
" ***** Syntax Highlights (vim-polyglot) ***************************************
" ==============================================================================
" {{{

" NOTE: Following are language tweaks for vim-polyglot, whose syntax files
" often diverge considerably from those shipping with vim.

if get(g:, "oceanic_for_polyglot", 0)

" ----- Syntax (C/C++ | polyglot) ------------------------------------------ {{{

hi! link cppCast Operator
hi! link cppSTLexception Error
hi! link cppSTLnamespace OcFg
hi! link cppSTLtype Type

" }}}

" ----- Syntax (JavaScript | polyglot) ------------------------------------- {{{

hi! link jsArrowFunction Operator
hi! link jsClassDefinition OcYellowBold
hi! link jsDot Operator
hi! link jsExport Operator
hi! link jsGlobalObjects OcRed
hi! link jsNull OcAqua
hi! link jsObjectKey Type
hi! link jsTemplateBraces Operator
hi! link jsTemplateExpression OcAqua
hi! link jsThis OcRed

" }}}

" ----- Syntax (Markdown | polyglot) --------------------------------------- {{{

hi! link mkdBold markdownBold
hi! link mkdCode markdownCode
hi! link mkdCodeDelimiter mkdCode
hi! link mkdCodeEnd mkdCode
hi! link mkdCodeStart mkdCode
hi! link mkdDelimiter OcFg
hi! link mkdHeading markdownH1
hi! link mkdInlineUrl markdownURL
hi! link mkdItalic markdownItalic
hi! link mkdLink markdownLinkText
hi! link mkdListItem markdownListMarker
hi! link mkdRule markdownRule
hi! link mkdUrl markdownUrl

" NOTE: The polyglot version defines some Markdown elements as HTML. This makes
" little semantic sense and prevents themes from styling them separately. In
" this case, I opted for prettier Markdown at the cost of HTML.

hi! link htmlBold markdownBold
hi! link htmlItalic markdownItalic
hi! link htmlH1 markdownH1
hi! link htmlH2 markdownH1
hi! link htmlH3 markdownH1
hi! link htmlH4 markdownH1
hi! link htmlH5 markdownH1
hi! link htmlH6 markdownH1

" }}}

" ----- Syntax (Python | polyglot) ----------------------------------------- {{{

hi! link pythonDottedName pythonDecorator
hi! link pythonStrFormatting OcBrown

" }}}

" ----- Syntax (SCSS | polyglot) ------------------------------------------- {{{

hi! link scssAmpersand sassAmpersand
hi! link scssNestedProperty sassProperty
hi! link scssSelectorChar sassClassChar
hi! link scssSelectorName sassClass
hi! link scssSemicolon OcFg

" }}}

endif

" ========================================================================== }}}

" vim: sw=2 ts=2 sts=2 tw=80 cc=81 ft=vim fdm=marker fmr={{{,}}}
