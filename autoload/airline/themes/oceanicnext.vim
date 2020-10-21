" ==============================================================================
" Name: Oceanic Next (airline theme)
" Description: Addon to supply the vim-airline plugin with Oceanic Next colors
" Repository: https://github.com/adrian5/oceanic-next-vim
" License: MIT
" ==============================================================================

" ----- Config ------------------------------------------------------------- {{{

" NOTE: I haven't been able to transparently override the default boldness
" values of airline elements; the option will be ignored here for the time
" being.

" }}}

" ----- Colors ------------------------------------------------------------- {{{

" Oceanic foreground shades
let s:fg3 = ["#adb5c0", 249]
let s:fg  = ["#d8dee9", 253] " fg4

" Oceanic background  shades
let s:bg = ["#1b2b34", 235] " bg3

" Oceanic vivid base colors
let s:red    = ["#ec5f67", 167]
let s:orange = ["#f99157", 209]
let s:yellow = ["#fac863", 221]
let s:green  = ["#99c794", 108]
let s:aqua   = ["#5fb3b3",  73]
let s:blue   = ["#6699cc",  68]
let s:lilac  = ["#c594c5", 176]

" Custom shades for airline
let s:b1 = ["#243945", 236]
let s:b2 = ["#2d4857", 237]
let s:b3 = ["#355466", 239]

" Custom shades for inactive (unfocused) airline
let s:ib1 = ["#1d2f39", 234]
let s:ib2 = ["#20343f", 236]
let s:ib3 = ["#233845", 237]
let s:ib4 = ["#767c84", 244]
let s:ib5 = ["#5e666f", 241]

" Custom blues for insert mode
let s:blue1 = ["#295a8a",  25]
let s:blue2 = ["#224b73",  24]

" }}}

" ----- Airline ------------------------------------------------------------ {{{

" NOTE: `airline#themes#get_highlight(2)` is quirky to integrate; not worth the
" hassle with an stable theme.

let g:airline#themes#oceanicnext#palette = {}

let s:N1 = [ s:b1[0], s:green[0],  s:b1[1], s:green[1]]
let s:N2 = [ s:fg[0],    s:b3[0],  s:fg[1],    s:b3[1]]
let s:N3 = [s:fg3[0],    s:b1[0], s:fg3[1],    s:b1[1]]
let g:airline#themes#oceanicnext#palette.normal
  \ = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

let s:IA1 = [s:ib4[0], s:ib3[0], s:ib4[1], s:ib3[1]]
let s:IA2 = [s:ib5[0], s:ib2[0], s:ib5[1], s:ib2[1]]
let s:IA3 = [s:ib5[0], s:ib1[0], s:ib5[1], s:ib1[1]]
let g:airline#themes#oceanicnext#palette.inactive
  \ = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)

let s:I1 = [s:blue2[0],    s:fg[0], s:blue2[1],    s:fg[1]]
let s:I2 = [   s:fg[0], s:blue1[0],    s:fg[1], s:blue1[1]]
let s:I3 = [   s:fg[0], s:blue2[0],    s:fg[1], s:blue2[1]]
let g:airline#themes#oceanicnext#palette.insert
  \ = airline#themes#generate_color_map(s:I1, s:I2, s:I3)

let s:R1 = [s:b1[0], s:red[0], s:b1[1], s:red[1]]
let g:airline#themes#oceanicnext#palette.replace
  \ = airline#themes#generate_color_map(s:R1, s:N2, s:N3)

let s:V1 = [s:b1[0], s:orange[0], s:b1[1], s:orange[1]]
let g:airline#themes#oceanicnext#palette.visual
  \ = airline#themes#generate_color_map(s:V1, s:N2, s:N3)

let s:C1 = [s:b1[0], s:lilac[0], s:b1[1], s:lilac[1]]
let g:airline#themes#oceanicnext#palette.commandline
  \ = airline#themes#generate_color_map(s:C1, s:N2, s:N3)

let g:airline#themes#oceanicnext#palette.terminal
  \ = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#oceanicnext#palette.normal.airline_term = s:N1
let g:airline#themes#oceanicnext#palette.terminal.airline_term = s:N1
let g:airline#themes#oceanicnext#palette.visual.airline_term = s:N1

" Color default accents (`:help airline-accents`)
let g:airline#themes#oceanicnext#palette.accents = {
  \ "red":    [    s:red[0], "",    s:red[1], "" ],
  \ "orange": [ s:orange[0], "", s:orange[1], "" ],
  \ "yellow": [ s:yellow[0], "", s:yellow[1], "" ],
  \ "green":  [  s:green[0], "",  s:green[1], "" ],
  \ "blue":   [   s:blue[0], "",   s:blue[1], "" ],
  \ "purple": [  s:lilac[0], "",  s:lilac[1], "" ]
\ }

" In airline theme tradition: ctrlp.vim styling
if get(g:, "loaded_ctrlp", 0)
  let g:airline#themes#oceanicnext#palette.ctrlp
    \ = airline#extensions#ctrlp#generate_color_map(
      \ [s:fg3[0], s:b2[0], s:fg3[1], s:b2[1]],
      \ [ s:fg[0], s:b2[0],  s:fg[1], s:b2[1]],
      \ [ s:bg[0], s:fg[0],  s:bg[1], s:fg[1]]
    \ )
endif

" }}}

" vim: sw=2 ts=2 sts=2 tw=80 cc=81 ft=vim fdm=marker fmr={{{,}}}
