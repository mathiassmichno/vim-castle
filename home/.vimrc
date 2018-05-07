set nocompatible
filetype indent plugin on "file specific indentation rules

let g:python_host_prog = '/Users/michno/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/michno/.pyenv/versions/neovim3/bin/python'

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

" Colors
Plug 'mhartington/oceanic-next'

" Convenience
Plug 'kopischke/vim-stay'
Plug 'tpope/vim-sensible'
Plug 'easymotion/vim-easymotion'

" Language IDE-ish stuff
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'w0rp/ale'
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-clang'
" Plug 'davidhalter/jedi-vim'
Plug 'lepture/vim-jinja'
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'rhysd/vim-grammarous'

" Syntactic sugar
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'godlygeek/tabular'
Plug 'editorconfig/editorconfig-vim'

" Integration
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'

" Interface
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
" Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'sjl/gundo.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()

augroup FileSpecific
    autocmd!
    "TeX
    autocmd FileType tex setlocal spell

    "Markdown
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd FileType markdown setlocal spell
    autocmd BufRead,BufNewFile *.md setlocal textwidth=72

    "Git commits
    autocmd FileType gitcommit setlocal textwidth=72
    autocmd FileType gitcommit setlocal spell

    "CSS
    autocmd FileType css,scss,sass setlocal iskeyword+=-

    " Fugitive
    autocmd User fugitive
                \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
                \   nnoremap <buffer> .. :edit %:h<CR> |
                \ endif
    autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim stuff:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
let maplocalleader=",,"

set tabstop=4 "set tab size
set softtabstop=4 "set spaces in tabs
set shiftwidth=4 "once again tabstop
set expandtab
autocmd FileType make setlocal noexpandtab
set showtabline=1 "Show tab lines when it's at least two deep
set autoindent
set hidden "Let you hide buffers with changes
set magic
set list
set gdefault "Default to global substitution on line

set foldenable "enable folding
set foldlevelstart=10 "unfold must stuff
set foldnestmax=10 "no folds over 10
set foldmethod=indent "Fold based on indentation

set viewoptions=cursor,folds,slash,unix

set nobackup
set nowritebackup
set noswapfile

map <leader>gf :e <cfile><cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if (has("termguicolors"))
 set termguicolors
endif

colorscheme OceanicNext

let g:lightline = {
      \ 'colorscheme': 'oceanicnext',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
" let g:airline_powerline_fonts=1
" let g:airline_theme='oceanicnext'
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#ale#enabled = 1
set noshowmode
set laststatus=2 "Always display the statusline
set linebreak
set showtabline=2 "Always display the tabline
set showmatch "show matching parens
set matchtime=15
set cursorline "highlight current line
set number "show gutter with numbers
set numberwidth=5
highlight VertSplit ctermfg=244 ctermbg=NONE cterm=bold

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EasyMotion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" `s{char}{char}{label}`
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffer tabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader><Tab> :bnext<CR>
nnoremap gt :bnext<CR>
nnoremap g<S-t> :bprev<CR>
nnoremap <leader>w :bdelete<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase
set smartcase
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

let g:ale_python_flake8_executable = "python3"
let g:ale_python_flake8_options = "-m flake8 --ignore=E501"
let g:ale_python_pylint_executable = "python3"
let g:ale_python_pylint_options = "-m pylint"
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Deoplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" deoplete options
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" Disable the candidates in Comment/String syntaxes.
call deoplete#custom#source('_',
            \ 'disabled_syntaxes', ['Comment', 'String'])

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Jedi
" let g:jedi#completions_enabled = 0
" let g:jedi#use_tabs_not_buffers = 1

let g:deoplete#sources#clang#libclang_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header = '/Library/Developer/CommandLineTools/usr/lib/clang'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc. config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" move vertically by visual line
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Better move between splits
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

nnoremap <CR><CR> i<CR><ESC>

" toggle gundo
noremap <leader>u :GundoToggle<CR>

" Copy/paste to system clipboard
set clipboard=unnamed

cnoremap w!! w !sudo tee %

set diffopt+=vertical


" Ultisnips
let g:UltiSnipsUsePythonVersion = 3

" Remove trailing whitespace when saving
autocmd BufWritePre * :%s/\s\+$//e

" Grammarous
let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
    nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
    nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
    nmap <buffer><C-f> <Plug>(grammarous-fixit)
endfunction

function! g:grammarous#hooks.on_reset(errs) abort
    nunmap <buffer><C-n>
    nunmap <buffer><C-p>
    nunmap <buffer><C-f>
endfunction

" Vimtex
let g:tex_flavor = "latex"
let g:vimtex_enable = 1
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'skim'
let g:vimtex_quickfix_open_on_warning = 0
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
if !exists('g:deoplete#omni#functions')
    let g:deoplete#omni#functions = {}
endif
let g:deoplete#omni#input_patterns.tex =
            \   '\\(?:'
            \  .   '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
            \  .  '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
            \  .  '|hyperref\s*\[[^]]*'
            \  .  '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
            \  .  '|(?:include(?:only)?|input)\s*\{[^}]*'
            \  .')'
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
            \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
            \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Convenient ncommand to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
            \ | wincmd p | diffthis
endif

highlight clear SignColumn
highlight GitGutterChange ctermbg=NONE ctermfg=Yellow
highlight GitGutterAdd ctermbg=NONE ctermfg=DarkGreen
highlight GitGutterDelete ctermbg=NONE ctermfg=Red
highlight GitGutterChangeDelete ctermbg=NONE ctermfg=Blue

"Shell command to open cmd output in scratch buffer
function! s:ExecuteInShell(command)
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . command . '$')
    silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!'. command
    silent! execute 'resize ' . line('$')
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
    echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)



