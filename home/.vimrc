" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

" Colors
Plug 'mhartington/oceanic-next'

Plug 'tpope/vim-sensible'
" Syntax
Plug 'tpope/vim-surround'
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
    Plug 'zchee/deoplete-jedi'
Plug 'benekastah/neomake'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Integration
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'lervag/vimtex'

" Interface
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-commentary'
Plug 'ryanoasis/vim-devicons'

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
filetype indent on "file specific indentation rules

set tabstop=4 "set tab size
set softtabstop=4 "set spaces in tabs
set shiftwidth=4 "once again tabstop
set expandtab
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

set nobackup
set nowritebackup
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if (has("termguicolors"))
 set termguicolors
endif

colorscheme OceanicNext

let g:airline_powerline_fonts=1
let g:airline_theme='oceanicnext'
let g:airline#extensions#tabline#enabled = 1
set noshowmode
set laststatus=2 "Always display the statusline

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

" Deoplete
let g:deoplete#enable_at_startup = 1
" use tab to cycle thorugh suggestions
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" Ultisnips
let g:UltiSnipsUsePythonVersion = 3

" Neomake
autocmd! BufWritePost * Neomake

" Remove trailing whitespace when saving
autocmd BufWritePre * :%s/\s\+$//e

" Vimtex
let g:tex_flavor = "latex"
let g:vimtex_enable = 1
if !exists('g:ycm_semantic_triggers')
        let g:ycm_semantic_triggers = {}
          endif
            let g:ycm_semantic_triggers.tex = [
                    \ 're!\\[A-Za-z]*(ref|cite)[A-Za-z]*([^]]*])?{([^}]*, ?)*'
                    \ ]

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
