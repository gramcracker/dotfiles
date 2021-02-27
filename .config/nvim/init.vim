" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'

syntax on
set tabstop=4 softtabstop=4
set smartindent
set rnu
set nowrap
set noswapfile
set incsearch
set undodir=~/nvim/undodir

"map leader needs to be done before plugins are loaded
let mapleader = "\<Space>"

call plug#begin('~/.local/share/nvim/plugged')

Plug 'sirver/ultisnips'
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

Plug 'lervag/vimtex'
    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
    let g:vimtex_quickfix_mode=0

"Plug 'KeitaNakamura/tex-conceal.vim'
"   set conceallevel=1
"   let g:tex_conceal='abdmg'
"   hi Conceal ctermbg=none

Plug '907th/vim-auto-save' 
    let g:auto_save = 0
    augroup ft_tex
      au!
      au FileType tex let b:auto_save = 1
    augroup END

Plug 'morhetz/gruvbox'

Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }


Plug 'itchyny/lightline.vim'
Plug 'vifm/vifm.vim'
Plug 'mbbill/undotree'
Plug 'jpalardy/vim-slime', { 'for': 'python' }
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
Plug 'valloric/youcompleteme'
Plug 'octol/vim-cpp-enhanced-highlight'

Plug 'Luxed/ayu-vim'    " or other package manager
"...
set termguicolors       " enable true colors support

set background=light    " for light version of theme
set background=dark     " for either mirage or dark version.

let g:ayucolor="mirage" " for mirage version of theme
"let g:ayucolor="dark"   " for dark version of theme
" NOTE: g:ayucolor will default to 'dark' when not set. 

colorscheme ayu

" Initialize plugin system
call plug#end()


nnoremap <leader>rv :source ~/.config/nvim/init.vim<CR>

nnoremap <leader>u :UndotreeShow<CR>

"remap save to leader s
nnoremap <C-s> :w<CR>
inoremap <C-s> <C-c>:w<CR>

"remap bol and eol to leader h and l
nnoremap <leader>1 <C-c>0
nnoremap <leader>0 <C-c>$
"vnoremap <leader>1 <C-c>0 "needs to turn of v0 and v$
"vnoremap <leader>0 <C-c>$
inoremap <C-1> <C-c>0i
inoremap <C-0> <C-c>$i

"remap leader u to redo
nnoremap <leader>u <C-r>

"remap crtl+backspace and leader+backspace to delete one word back
inoremap <C-BS> <C-c>diWi
nnoremap <leader><BS> diW

"remap crtl+d to duplicate above line
inoremap <C-d> <C-c>kYpa

let g:firenvim_config = { 
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'content': 'text',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
        \ },
    \ }
\ }

if exists('g:started_by_firenvim')
 set guifont=FiraCode-regular:h10
 set noshowmode
 set noruler
 
 "makes movements work in wrap mode
 noremap <silent> <leader>w :call ToggleWrap()<CR>
function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    noremap <silent> k gk
    noremap <silent> j gj
    noremap <silent> 0 g0
    noremap <silent> $ g$

    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
  endif
endfunction
 set laststatus=0
 set noshowcmd
 inoremap <C-e> <C-c>:wq<ENTER>
 nnoremap <C-e> <C-c>:wq<ENTER>
endif


