" pathogen so we can use subdirectories for plugins
execute pathogen#infect()

" not interested in vi compatibility
set nocompatible

" but we are interested in utf-8
set fileencoding=utf-8
set encoding=utf-8

" indentation tweaks
set smartindent
set smarttab
set autoindent
set tabstop=4
set shiftwidth=4
set bs=2
set expandtab

" makefiles require tabs to be formatted correctly
autocmd FileType make set noexpandtab

" buffers can be in the background without being in a window.
" See http://items.sjbach.com/319/configuring-vim-right
set hidden

" Visual things
" syntax highlighting
syntax on
" highlist the last search term
set hlsearch
" usually I'm working via a dark background terminal
set background=dark

" show line numbers as dark grey
highlight LineNr ctermfg=darkgrey
" set number - off by default

" Press i to enter insert mode, and ii to exit.
:imap ii <Esc>

" Top key mappings
map #3 :TlistToggle<CR>

" scrolling
set scrolloff=4

" visually show trailing space
set list listchars=tab:>-,trail:·

" add scss filetype support
au BufRead,BufNewFile *.scss set ft=scss.css

" taglist language extensions
" css
let tlist_css_settings = 'css;c:class;i:id;t:tag;m:media'
" scss
let tlist_scss_settings = 'scss;c:class;i:id;t:tag;m:media;v:variable;m:mixin'

" Relative numbers
set relativenumber
" set number

" Shortcut for sudo saving when we forget to launch vim as sudo
cmap w!! w !sudo tee > /dev/null %

" Highlight current tab in a clearer way
hi TabLineSel ctermfg=Black ctermbg=Grey

" Enable matchit for xml tag matching
filetype plugin on
runtime macros/matchit.vim

" Look for tags file in current dir upwards
set tags=./tags,tags;

"
" Stuff for latex...
"
filetype plugin on

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" automatic indentation as you type.
filetype indent on

" Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" Change the default filetype back to 'tex':
let g:tex_flavor='latex'

autocmd BufRead *.tex,*.md set textwidth=80
autocmd BufRead *.tex,*.md set spell

autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Try use language tool
" let g:languagetool_jar='$HOME/LanguageTool-2.5/languagetool-commandline.jar'

runtime macros/matchit.vim
