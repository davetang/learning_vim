" Tips
"
" Use Ctrl+P for auto-completion
" Options http://vimdoc.sourceforge.net/htmldoc/options.html
"

" https://github.com/junegunn/vim-plug#installation
" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" install plugins by
" Reloading .vimrc and type :PlugInstall
" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'
Plug 'gabrielelana/vim-markdown'
Plug 'godlygeek/tabular'
Plug 'vim-scripts/groovy.vim'
Plug 'LukeGoodsell/nextflow-vim'
Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" You can clean trailing whitespace with :FixWhitespace.
Plug 'bronson/vim-trailing-whitespace'

Plug 'altercation/vim-colors-solarized'
" show which line changed since your last commit
Plug 'airblade/vim-gitgutter'
" de facto git plugin
Plug 'tpope/vim-fugitive'
Plug 'jalvesaq/Nvim-R'

" Easy align interactive
Plug 'junegunn/vim-easy-align'
" Just select and type Return then space. Type Return many type to change the
" alignments.
" vnoremap <silent> <Enter> :EasyAlign<cr>
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" -- solarized personal conf
" easier to see if you have a black background
set background=dark

" https://www.reddit.com/r/vim/comments/faiy4/conditional_vim_settings/
let hostname = system('hostname')[:-2] " (strip newline from output)
if hostname == 'vt001' || hostname == 'hpcs01'
   try
      colorscheme solarized
   catch
   endtry
else
   try
      syntax enable
"      set termguicolors
"     https://github.com/altercation/vim-colors-solarized/issues/218
      let g:solarized_termcolors=256
      let g:solarized_termtrans=1
      colorscheme solarized
   catch
   endtry
endif
" -- end

" set the window's title
" doesn't work well when using GNU screen
:set title

" highlight the line currently under cursor
:set cursorline

" enable syntax highlighting with Vim default settings
:syntax on

" see 80th column
if (exists('+colorcolumn'))
   set colorcolumn=80
   highlight ColorColumn ctermbg=9
endif

" https://vim.fandom.com/wiki/Insert_current_date_or_time#Automatically_update_timestamps
" insert date
" :nnoremap <F3> "=strftime("%c")<CR>P
" :inoremap <F3> <C-R>=strftime("%c")<CR>
:map <F3> i_Last modified: <C-R>=strftime('%c')<CR>_<ESC>
:map! <F3> _Last modified: <C-R>=strftime('%c')<CR>_

" insert R code block
:nnoremap <C-i> i```{r}<CR><CR>```<ESC>0ki
:inoremap <C-i> ```{r}<CR><CR>```<ESC>0ki

" insert timestamp
:nnoremap <F4> i<C-R>=strftime('%c')<CR><CR><ESC>
:inoremap <F4> <C-R>=strftime('%c')<CR>

" map line wrap
:nnoremap <F5> gqq
:nnoremap <F6> vipJgqq

" If buffer modified, update any 'Last modified: ' in the first 20 lines.
" 'Last modified: ' can have up to 10 characters before (they are retained).
" Restores cursor and window position using save_cursor variable.
function! LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,10}Last modified: \).*#\1' .
          \ strftime('%c') . '_#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfun
autocmd BufWritePre * call LastModified()

" misspelled words will be highlighted
" :set spell spelllang=en_gb
:map <F7> :setlocal spell! spelllang=en_gb<CR>

" spellfile MUST end in .add
" use zg to add to dictionary
:set spellfile=$HOME/.spellfile.add

" c	Auto-wrap comments using textwidth, inserting the current comment leader automatically.
" r	Automatically insert the current comment leader after hitting <Enter> in Insert mode.
" o	Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
:set formatoptions-=cro

" Put Vim in Paste mode. This is useful if you want to cut or copy
" some text from one window and paste it in Vim. This will avoid unexpected effects.
:set paste
:set nopaste

" the 'pastetoggle' option conveniently turns 'paste' on and off with one key
:set pastetoggle=<F2>

" Indent using three spaces 
" Convert tabs to spaces
:set tabstop=3 expandtab

" New lines inherit the indentation of previous lines
" smartindent reacts to the syntax/style of the code you are editing (especially for C). When having it on you also should have autoindent on.
:set autoindent smartindent

" show cursor position and line number
:set ruler number

" When shifting, indent using three spaces
" Put the cursor on first line to shift
" Press V then jj to select lines to shift
" Press > to indent (shift text one 'shiftwidth' to the right), or press < to shift left
:set shiftwidth=3

filetype indent on

" Enable search highlighting
:set hlsearch

" increase the undo limit
:set history=1000

" turn relative line numbers on
:set relativenumber
:set rnu

" Python code completion
filetype plugin on
let g:pydiction_location = "$HOME/github/pydiction/complete-dict"

" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#use-cr-to-confirm-completion
" You have to remap <cr> to make it confirm completion.
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" To make <cr> select the first completion item and confirm the completion when no item has been selected:
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Use <Tab> and <S-Tab> to navigate the completion list:
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" https://github.com/jalvesaq/Nvim-R/blob/master/doc/Nvim-R.txt
" do not convert _ into ->
let R_assign = 0
" do not convert ` into `r`
let R_rmdchunk = 0
