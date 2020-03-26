"============================================================
"Global 配置
"===========================================================
""定义快捷键的前缀，即<Leader>
let mapleader=":"
"开启实时搜索功能
 set incsearch
"" 搜索时大小写不敏感
 set ignorecase
"" 关闭兼容模式
set nocompatible
"" vim 自身命令行模式智能补全
 set wildmenu
""使用鼠标
set mouse=a
""开启语法高亮
syntax on
"检测文件类型
filetype on
""针对不同的文件类型采用不同的缩进格式
filetype indent on
"允许插件
filetype plugin on
"启动自动补全
filetype plugin indent on

"文件修改之后自动载入。
set autoread 
"启动的时候不显示那个援助索马里儿童的提示
set shortmess=atI     
" 关闭vim的beep 声音
set visualbell
set t_vb=
"关闭交换文件
set noswapfile
"color chema
colorscheme default
" 突出显示当前列
set cursorcolumn
" 突出显示当前行
set cursorline
hi CursorLine   cterm=NONE ctermbg=green ctermfg=yellow guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=green ctermfg=yellow guibg=darkred guifg=white

"显示当前的行号列号：
set ruler
"在状态栏显示正在输入的命令
set showcmd
" 左下角显示当前vim模式
set showmode
 
"关闭/打开配对括号高亮
""NoMatchParen
let loaded_matchparen = 1
" 括号配对情况,跳转并高亮一下匹配的括号
 set showmatch

 "显示行号：
set number
""为方便复制，用<F2>开启/关闭行号显示:
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
"打开状态栏
set laststatus=2
"设置状态栏显示的信息
"set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\%{&encoding}\ %c:%l/%L%)\ 
set statusline=%F%m%r%h%w\ [Format=%{&ff}]\ [Encoding=%{&encoding}]\ [Type=%Y]\ [Position(line,column)=%04l,%04v][%p%%]\ [Lines=%L]



" 缩进配置
"打开智能缩进
set smartindent
" 打开自动缩进
set autoindent

" tab相关变更
set expandtab     " 将Tab自动转化成空格    [需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set tabstop=4     " 设置Tab键的宽度        [等同的空格个数]
set shiftwidth=4  " 每一次缩进对应的空格数
set softtabstop=4 " 按退格键时可以一次删掉 4 个空格
"set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set shiftround    " 缩进时，取整 use multiple of shiftwidth when indenting" with '<' and '>'"

" 关闭交换文件
set noswapfile
" 光标跳到上次文件关闭的位置
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"启用paste模式
"":map <F10> :set paste<CR>
"":map <F11> :set nopaste<CR>
"========================================================================
"插件管理
"=========================================================================
""使用pathogen管理插件
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

"python 自动补全
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'
let g:pydiction_menu_height = 3

" UltiSnips自动补齐代码片段，插入代码片段
 let g:UltiSnipsExpandTrigger="<tab>"
 let g:UltiSnipsJumpForwardTrigger="<tab>"
 let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" " YouCompleteMe代码提示补全
 let g:ycm_key_list_select_completion = ['<leader><C-TAB>', '<Down>']
 let g:ycm_key_list_previous_completion = ['<leader><C-S-TAB>', '<Up>']
 let g:ycm_global_ycm_extra_conf = '/home/jenningsl/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

"vim-indent-guides显示缩进层级
let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
 let g:indent_guides_start_level=2
" " 色块宽度
 let g:indent_guides_guide_size=1
" " 快捷键 i 开/关缩进可视化
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle
let g:indent_guides_auto_colors = 0
"hi IndentGuidesOdd  guibg=lightgrey   ctermbg=black
"hi IndentGuidesEven guibg=lightgrey ctermfg=darkgrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey
"" vim-colors-solarized主题插件
set background=dark
colorscheme solarized
let g:solarized_termcolors=256
set t_Co=256
""delimitMate自动补全括号，双引号等，默认配置不用配置

"==========================================
"" FileEncode Settings 文件编码,格式
"==========================================
"" 设置新文件的编码为 UTF-8
set encoding=utf-8
" 自动判断编码时，依次尝试以下编码：
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set helplang=cn
" "set langmenu=zh_CN.UTF-8
" "set enc=2byte-gb18030
" " 下面这句只影响普通模式 (非图形界面) 下的 Vim。
set termencoding=utf-8
"
" " Use Unix as the standard file type
set ffs=unix,dos,mac
"
" " 如遇Unicode值大于255的文本，不必等到空格再折行。
 set formatoptions+=m
" " 合并两行中文时，不在中间加空格：
"设置gui font

set formatoptions+=B
set guifont=Ubuntu\ Mono\ 14
"添加python文件头
function HeaderPython()
    call setline(1, "#!/usr/bin/env python3")
    call append(1, "# -*- coding: utf-8 -*-")
    call append(2, "# Jennings Liu@ " . strftime('%Y-%m-%d %T', localtime()))
    normal G
    normal o
    normal o
endfunction
autocmd bufnewfile *.py call HeaderPython()
"==========================================
"" others 其它设置
"==========================================
"vimrc文件修改之后自动加载。
autocmd! bufwritepost .vimrc source %
"折叠
set foldenable              " 开始折叠
set foldmethod=manual       " 设置语法折叠
set foldcolumn=0            " 设置折叠区域的宽度
setlocal foldlevel=1        " 设置折叠层数为
set foldclose=all           "设置为自动关闭折叠                            
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' :'zo')<CR> " 用空格键来开关折叠


"sudo强制保存
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
