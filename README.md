# Oceanic Next

Adaptation of the [Sublime Text theme](https://github.com/voronianski/oceanic-next-color-scheme)
for vim.

<img src="https://github.com/adrian5/oceanic-next-vim/blob/master/assets/theme-preview.png"
  width="600">

## Installation

#### [vim-plug](https://github.com/junegunn/vim-plug):

```viml
Plug 'adrian5/oceanic-next-vim'
```

#### [dein](https://github.com/Shougo/dein.vim):

```viml
call dein#add('adrian5/oceanic-next-vim')
```

#### Manually via [vim packages](https://vimhelp.org/repeat.txt.html#packages):

On Linux/macOS:

```sh
# vim
git clone --depth 1 https://github.com/adrian5/oceanic-next-vim \
  ~/.vim/pack/plugins/start/oceanic-next-vim

# nvim
git clone --depth 1 https://github.com/adrian5/oceanic-next-vim \
  ~/.local/share/nvim/site/pack/plugins/start/oceanic-next-vim
```

Finally, add the following to your vimrc and restart vim:

```viml
colorscheme oceanicnext
```

## Configuration

### Options

| option                      | value                                             | default                             |
| --------------------------- | ------------------------------------------------- | ----------------------------------- |
| `g:oceanic_gutter_like_bg`  | **1**: Give gutter same background as file buffer | **0**: Gutter is slightly darker    |
| `g:oceanic_transparent_bg`  | **1**: Make buffer and gutter transparent         | **0**: Use opaque background color  |
| `g:oceanic_bold`            | **0**: Don't use bold text anywhere in theme      | **1**: Make certain text items bold |
| `g:oceanic_italic_comments` | **1**: Comments use italic font (if supported)    | **0**: Comments are not italic      |

Apply any of these before setting the colorscheme, e.g.:

```viml
let g:oceanic_bold = 0
colorscheme oceanicnext
```

### vim-polyglot

If you use [vim-polyglot](https://github.com/sheerun/vim-polyglot), set the following option:

```viml
let g:oceanic_for_polyglot = 1
```

This tweaks syntax highlights for several languages, which can differ considerably from those
shipping with vim.

### lightline

```viml
let g:lightline = { 'colorscheme': 'oceanicnext' }
```

Important: Make sure you don't have [mhartington/oceanic-next](
https://github.com/mhartington/oceanic-next) loaded, or its styling will take precedence!

### vim-airline

Should be loaded automatically when setting `oceanicnext` colorscheme. As with lightline, make sure
you don't have the _other_ Oceanic Next loaded.

To keep using the airline *default* theme, set:

```viml
let g:airline_theme = 'default'
```

## What about [mhartington/oceanic-next](https://github.com/mhartington/oceanic-next) ?

The hartington theme offers its own take on the original, and I found the difference sufficient to
warrant another port.

## Contributing

For feedback and requests, please use the Issue tracker.

* For language requests, include code samples (or links thereto) in your report if possible; the
  more syntax I can check against, the better!
* For plugin requests, consider listing features (commands) I should test, e.g. certain lists or
  menus to open.

If you want to submit a PR, please do so against the `dev` branch! Include a before/after screenshot
if possible, in case I don't have the time to properly vet it. Thanks!
