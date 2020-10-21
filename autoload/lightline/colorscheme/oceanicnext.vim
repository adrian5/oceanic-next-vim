" ==============================================================================
" Name: Oceanic Next (lightline theme)
" Description: Addon to supply the lightline plugin with Oceanic Next colors
" Repository: https://github.com/adrian5/oceanic-next-vim
" License: MIT
" ==============================================================================

" ----- Config ------------------------------------------------------------- {{{

if get(g:, "oceanic_bold", 1)
  let s:bold = "bold"
else
  let s:bold = ""
endif

" }}}

" ----- Colors ------------------------------------------------------------- {{{

" Oceanic foreground shades
let s:fg1 = ["#405860", "239"]
let s:fg3 = ["#adb5c0", "249"]
let s:fg4 = ["#d8dee9", "253"]
let s:fg  = s:fg4

" Oceanic background  shades
let s:bg1 = ["#17262e", "233"]
let s:bg3 = ["#1b2b34", "235"]
let s:bg  = s:bg3

" Oceanic vivid base colors
let s:red    = ["#ec5f67", "167"]
let s:orange = ["#f99157", "209"]
let s:yellow = ["#fac863", "221"]
let s:green  = ["#99c794", "108"]
let s:lilac  = ["#c594c5", "176"]

" Custom shades for lightline
let s:b1 = ["#243945", "236"]
let s:b2 = ["#2d4857", "237"]
let s:b3 = ["#355466", "239"]

" Custom shades for inactive (unfocused) lightline
let s:ib1 = ["#1d2f39", "234"]
let s:ib2 = ["#20343f", "236"]
let s:ib3 = ["#233845", "237"]
let s:ib4 = ["#767c84", "244"]
let s:ib5 = ["#5e666f", "241"]

" Custom blues for insert mode
let s:blue1 = ["#295a8a",  "25"]
let s:blue2 = ["#224b73",  "24"]
let s:blue3 = ["#86add5", "110"]

" }}}

" ----- Lightline ---------------------------------------------------------- {{{

let s:p = {"normal": {}, "inactive": {}, "insert": {}, "replace": {},
  \ "visual": {}, "command": {}, "tabline": {}}

let s:p.normal.left     = [[s:b1, s:green, s:bold], [s:fg, s:b2]]
let s:p.normal.middle   = [[s:fg3, s:b1]]
let s:p.normal.right    = [[s:fg, s:b3], [s:fg, s:b2]]
let s:p.normal.error    = [[s:b1, s:red]]
let s:p.normal.warning  = [[s:b1, s:yellow]]

let s:p.inactive.left   = [[s:ib4, s:ib1], [s:ib4, s:ib2]]
let s:p.inactive.middle = [[s:ib5, s:ib1]]
let s:p.inactive.right  = [[s:ib4, s:ib3], [s:ib4, s:ib2]]

let s:p.insert.left     = [[s:blue2, s:fg, s:bold], [s:fg, s:blue1]]
let s:p.insert.middle   = [[s:blue3, s:blue2]]
let s:p.insert.right    = [[s:blue2, s:fg], [s:fg, s:blue1]]

" Inherits from 'insert', hence the 'normal' copy/override
let s:p.replace.left    = [[s:b1, s:red, s:bold], [s:fg, s:b2]]
let s:p.replace.middle  = copy(s:p.normal.middle)
let s:p.replace.right   = copy(s:p.normal.right)

let s:p.visual.left     = [[s:b1, s:orange, s:bold], [s:fg, s:b2]]

let s:p.command.left    = [[s:b1, s:lilac, s:bold], [s:fg, s:b2]]

let s:p.tabline.left    = [[s:fg1, s:bg1, s:bold]] " hl-TabLine
let s:p.tabline.tabsel  = [[["#bdc2cc", "250"], s:bg, s:bold]] " hl-TabLineSel
let s:p.tabline.middle  = [[s:fg3, s:bg1], s:bold] " hl-TabLineFill
let s:p.tabline.right   = [[s:fg3, s:bg, s:bold]] " Close button

let g:lightline#colorscheme#oceanicnext#palette
  \ = lightline#colorscheme#flatten(s:p)

" }}}

" vim: sw=2 ts=2 sts=2 tw=80 cc=81 ft=vim fdm=marker fmr={{{,}}}
