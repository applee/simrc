"-------------------------------------------------------------
" Options
"-------------------------------------------------------------

" 1 important
set nocompatible
set nopaste

" 2 moving around, searching and patterns
set startofline
set incsearch
set magic
set ignorecase
set smartcase
set whichwrap+=<,>,h,l

" 3 tags

" 4 displaying text
set scrolloff=8
set sidescrolloff=10
set fillchars=
set number
set nowrap
set showmatch
set matchtime=2

" 5 syntax, highlighting and spelling
syntax on
set background=dark
set hlsearch
set cursorline

" 6 multiple windows
set laststatus=2
set hidden

" 7 multiple tab pages

" 8 terminal
if !has('nvim')
    set term=xterm-256color
endif
set ttyfast

" 9 using the mouse
set mouse-=a

" 10 printing

" 11 messages and info
set shortmess=atIq
set showcmd
set showmode
set ruler
set report=0

" 12 selecting text
set clipboard=unnamed

" 13 editing text
set undolevels=1024
set noundofile
set backspace=indent,eol,start
set matchpairs=(:),{:},[:]

" 14 tabs and indenting
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set shiftround
set expandtab
set autoindent
set smartindent

" 15 folding
" 16 diff mode
" 17 mapping

" 18 reading and writing files
set write
set writebackup
set nobackup
set noautowrite
set nowriteany
set autoread
set fsync

" 19 the swap file
set noswapfile

" 20 command line editing
set history=1024
set wildignore=*.o,*.obj,*.swp,*.pyc,*.bak,*.tmp
set wildmenu

" 21 executing external commands
" 22 running make and jumping to errors
" 23 language specific

" 24 multi-byte characters
set encoding=utf-8
set ambiwidth=single

" 25 various
set loadplugins
if !has('nvim')
    set viminfo='64,\"128,:64,%,n~/.viminfo
endif

" terms options
set t_vb=
set t_ti=
set t_te=
set ffs=unix,dos,mac
set visualbell
set scrolljump=5

" gui options
set guifont=Hasklig:h14
set guioptions=
set guicursor+=a:blinkon0

"-------------------------------------------------------------
" KeyMaps
"-------------------------------------------------------------

let mapleader = ','
filetype plugin indent on

" Key Maps
nnoremap <Leader>w <Esc>:w<CR>
nnoremap <Leader>q <Esc>:q<CR>

inoremap <C-a> <Esc><S-i>
nnoremap <C-a> <Esc><S-i>
cnoremap <C-a> <Home>
inoremap <C-e> <Esc><S-a>
nnoremap <C-e> <Esc><S-a>
cnoremap <C-e> <End>

inoremap <C-f> <Right>
inoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>

inoremap <C-o> <Esc>o
inoremap <C-j> <Esc>O

vnoremap > >gv
vnoremap < <gv
xnoremap p pgvy

" 快速命令行模式
nnoremap ; :!
noremap H ^
noremap L $
nnoremap U <C-r>
" 去掉搜索高亮
nnoremap <Leader>/ :nohls<CR>

" 关闭方向键, 强迫自己用 hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" kj 替换 Esc
inoremap kj <Esc>

" 切换前后buffer
nnoremap [b :bprevious<cr>
nnoremap ]b :bnext<cr>
" 使用方向键切换buffer
noremap <left> :bp<CR>
noremap <right> :bn<CR>

" 分屏窗口移动, Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" F1 - F6 设置

" F1 废弃这个键,防止调出系统帮助
" I can type :help on my own, thanks.  Protect your fat fingers from the evils of <F1>
noremap <F1> <Esc>"

" F2 行号开关，用于鼠标复制代码用
" 为方便复制，用<F2>开启/关闭行号显示:
function! HideNumber()
  if(&relativenumber == &number)
    set relativenumber! number!
  elseif(&number)
    set number!
  else
    set relativenumber!
  endif
  set number?
endfunc
nnoremap <F2> :call HideNumber()<CR>
" F3 显示可打印字符开关
nnoremap <F3> :set list! list?<CR>
" F4 换行开关
nnoremap <F4> :set wrap! wrap?<CR>

" F6 语法开关，关闭语法可以加快大文件的展示
nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

" when in insert mode, press <F5> to go to
" paste mode, where you can paste mass data
" that won't be autoindented
set pastetoggle=<F5

" disbale paste mode when leaving insert mode
au InsertLeave * set nopaste


"Treat long lines as break lines (useful when moving around in them)
"se swap之后，同物理行上线直接跳
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

function! BufferCount() abort
    return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction

function! LocationListWindonwToggle() abort
    let buffer_count_before = BufferCount()
    silent! lclose
    silent! lclose

    if BufferCount() == buffer_count_before
        execute "silent! lopen"
    endif
endfunction

nnoremap <Leader>tl :call LocationListWindonwToggle()<CR>
nnoremap <Leader>jj :lnext<CR>
nnoremap <Leader>kk :lpre<CR>

nnoremap <Leader>s :call ToggleErrors()<cr>

"-------------------------------------------------------------
" Events
"-------------------------------------------------------------

augroup highlight_overlength
    autocmd!
    autocmd BufEnter * highlight OverLength ctermbg=15
    autocmd BufEnter,BufWrite,TextChanged,TextChangedI,InsertEnter,InsertLeave * match OverLength /\%<81v.\%>80v/
augroup END

function! RestoreCursor()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup restore_cursor
    autocmd!
    autocmd BufWinEnter * call RestoreCursor()
augroup END

augroup set_tab_2
    autocmd!
    autocmd FileType markdown,yaml,toml,javascript,typescript,html,css,xml set tabstop=2 shiftwidth=2 softtabstop=2
augroup END

"-------------------------------------------------------------
" Plugins
"-------------------------------------------------------------

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

" Efficiency
Plug 'w0rp/ale'
" Plug 'Valloric/YouCompleteMe', {'dir': '~/.vim/bundle/YouCompleteMe', 'do': './install.py --clang-completer'}
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-repeat' | Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'Raimondi/delimitMate'
Plug 'bronson/vim-trailing-whitespace'
Plug 'majutsushi/tagbar'
Plug 'ctrlpvim/ctrlp.vim' | Plug 'tacahiroy/ctrlp-funky'

" Display
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-fugitive' | Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree' | Plug 'jistr/vim-nerdtree-tabs' | Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'kien/rainbow_parentheses.vim'

" Languages
Plug 'fatih/vim-go', {'for': 'go', 'do': ':GoInstallBinaries'}
Plug 'google/yapf', {'rtp': 'plugins/vim', 'for': 'python'}
Plug 'shiyanhui/vim-slash'

call plug#end()

function! AleConfig()
    let g:ale_linters = {
    \   'go': ['gofmt', 'go build'],
    \   'c': ['clang'],
    \}
    let g:ale_sign_error = '>>'
    let g:ale_sign_warning = '>'
    let g:ale_lint_on_text_changed = 'never'
    let g:ale_lint_on_enter = 0
    let g:ale_c_clang_options = "std=c11 -Wno-everything"
    let g:ale_cpp_clang_options = "-std=c++14 -Wno-everything"

    let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

    nnoremap <Leader>ta :ALEToggle<CR>
endfunction

function! DeopleteConfig()
    let g:deoplete#enable_at_startup = 1
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
endfunction

function! FzfConfig()
    nnoremap <Leader>f :Files<CR>
    nnoremap <Leader>b :Buffers<CR>
    nnoremap <Leader>ag :Ag<CR>

    let g:fzf_history_dir = '~/.local/share/fzf-history'
    let g:fzf_layout = { 'down': '~40%' }
    let g:fzf_buffers_jump = 1
    let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
    let g:fzf_tags_command = 'ctags -R'
    let g:fzf_commands_expect = 'alt-enter,ctrl-x'

    command! -bang -nargs=* Ag
    \    call fzf#vim#ag(
    \        <q-args>,
    \        <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'),
    \        <bang>0)

    command! -bang -nargs=* Rg
    \    call fzf#vim#grep(
    \        'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
    \        <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'),
    \        <bang>0)

    command! -bang -nargs=? -complete=dir Files
    \    call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
endfunction

function! NERDCommenterConfig()
    let g:NERDSpaceDelims = 1
    let g:NERDTrimTrailingWhitespace = 1
    let g:NERDToggleCheckAllLines = 1
    let g:NERDCommentEmptyLines = 1
endfunction

function! EasyMotionConfig()
    let g:EasyMotion_smartcase = 1

    map <Leader>h <Plug>(easymotion-linebackward)
    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)
    map <Leader>l <Plug>(easymotion-lineforward)
endfunction

function! DelimitMateConfig()
    let g:delimitMate_expand_cr = 1
    let g:delimitMate_expand_space = 1
endfunction

function! TrailingWhiteSpaceConfig()
    nnoremap <Leader><Space> :FixWhitespace<CR>
endfunction

function! TagbarConfig()
    nnoremap <Leader>t :TagbarToggle<CR>
endfunction

function! CtrlpConfig()
    let g:ctrlp_map = '<leader>p'
    let g:ctrlp_cmd = 'CtrlP'
    map <leader>f :CtrlPMRU<CR>
    map <leader><space> :CtrlPBuffer<CR>
    let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
        \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
        \ }
    let g:ctrlp_working_path_mode=0
    let g:ctrlp_match_window_bottom=1
    let g:ctrlp_max_height=15
    let g:ctrlp_match_window_reversed=0
    let g:ctrlp_mruf_max=500
    let g:ctrlp_follow_symlinks=1
    " 如果安装了ag, 使用ag
    if executable('ag')
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
    endif

    " ctrlpfunky
    " ctrlp插件1 - 不用ctag进行函数快速跳转
    nnoremap <Leader>fu :CtrlPFunky<Cr>
    " narrow the list down with a word under cursor
    nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
    let g:ctrlp_funky_syntax_highlight = 1
    let g:ctrlp_extensions = ['funky']
endfunction

function! SolarizedConfig()
    silent! colorscheme solarized
    let g:solarized_contrast = "normal"
    let g:solarized_visibility = "normal"

    highlight LineNr ctermbg=NONE guibg=NONE
    highlight SignColumn ctermbg=NONE guibg=NONE
endfunction

function! AirlineConfig()
    let g:airline_powerline_fonts = 1
    let g:airline_solarized_bg = 'dark'
    let g:airline_theme = 'solarized'
    let g:airline_skip_empty_sections = 1
endfunction

function! NERDTreeConfig()
    nnoremap <Leader>n :NERDTreeToggle<CR>
    let g:NERDTreeIgnore = ['.pyc$']
    let g:NERDTreeCascadeSingleChildDir = 0
    let g:NERDTreeSortHiddenFirst = 1
    let g:NERDTreeAutoDeleteBuffer = 1
endfunction

function! RainbowParenthesesConfig()
    let g:rbpt_max = 16
    let g:rbpt_loadcmd_toggle = 0
    let g:rbpt_colorpairs = [
        \ ['brown',       'RoyalBlue3'],
        \ ['Darkblue',    'SeaGreen3'],
        \ ['darkgray',    'DarkOrchid3'],
        \ ['darkgreen',   'firebrick3'],
        \ ['darkcyan',    'RoyalBlue3'],
        \ ['darkred',     'SeaGreen3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['brown',       'firebrick3'],
        \ ['gray',        'RoyalBlue3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['Darkblue',    'firebrick3'],
        \ ['darkgreen',   'RoyalBlue3'],
        \ ['darkcyan',    'SeaGreen3'],
        \ ['darkred',     'DarkOrchid3'],
        \ ['red',         'firebrick3'],
        \ ]

    augroup rainbow_parentheses
        autocmd!
        autocmd VimEnter * silent! RainbowParenthesesToggle
        autocmd Syntax * silent! RainbowParenthesesLoadRound
        autocmd Syntax * silent! RainbowParenthesesLoadSquare
        autocmd Syntax * silent! RainbowParenthesesLoadBraces
    augroup END
endfunction

function! VimGoConfig()
    let g:go_highlight_extra_types = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_function_arguments = 1
    let g:go_highlight_function_calls = 1
    let g:go_highlight_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_generate_tags = 1
    let g:go_highlight_format_strings = 1
    let g:go_fmt_fail_silently = 1
    let g:go_fmt_command = "goimports"
    let g:go_fmt_autosave = 1 

    filetype detect
endfunction

call AleConfig()
call DeopleteConfig()
call FzfConfig()
call NERDCommenterConfig()
call EasyMotionConfig()
call DelimitMateConfig()
call TrailingWhiteSpaceConfig()
call TagbarConfig()
call CtrlpConfig()
call SolarizedConfig()
call AirlineConfig()
call NERDTreeConfig()
call RainbowParenthesesConfig()
call VimGoConfig()
