"----------------------------------------------------------------------------------------------------------------
"----------------------------------------------------------------------------------------------------------------
"=================================================说明==========================================================

"1.按F5可以直接编译并执行C、C++、java代码以及执行shell脚本，按“F8”可进行C、C++代码的调试
"2.自动插入文件头，新建C、C++源文件时自动插入表头：包括文件名、作者、联系方式、建立时间等，读者可根据需求自行更改
"3.映射“Ctrl + A”为全选并复制快捷键，方便复制代码
"4.按“F2”可以直接消除代码中的空行
"5.“F3”可列出当前目录文件，打开树状文件目录
"6. 支持鼠标选择、方向键移动
"7. 代码高亮，自动缩进，显示行号，显示状态行
"8.按“Ctrl + P”可自动补全
"9.[]、{}、()、""、' '等都自动补全
".......
"==================================================================================================================
"------------------------------------------------------------------------------------------------------------------
"------------------------------------------------------------------------------------------------------------------


"================================================基本设置========================================================

" 开启pathogen插件管理
execute pathogen#infect()

"映射leader键
let mapleader=","

" 语法高亮
syntax enable
syntax on
set showcmd         " 输入的命令显示出来，看的清楚些  "
" 高亮显示普通txt文件（需要txt.vim脚本）
"au BufRead,BufNewFile *  setfiletype txt

"侦测文件类型
filetype on

" 打开状态栏标尺
set ruler

" 设置在状态行显示的信息
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\

" 在处理未保存或只读文件的时候，弹出确认
set confirm

"显示魔术
set magic

"搜索忽略大小写
set ignorecase

"搜索逐字符高亮
set hlsearch
set incsearch

" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key

" 高亮显示匹配的括号
set showmatch

" 用浅色高亮当前行
set cursorline
set cursorcolumn


set number	"显示行号

set tabstop=4
set shiftwidth=4

"let g:auto_save=5 	 "每5s自动保存,vim-auto-save插件
" 一键保存
func! SaveFile()
	exec "w"
endfunc
map <leader>s :call SaveFile()<CR>
imap <leader>s <ESC>:call SaveFile()<CR>
vmap <leader>s <ESC>:call SaveFile()<CR>


" 映射全选+复制 ctrl+a
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY
map <F12> gg=G
" 选中状态下 Ctrl+c 复制
vmap <C-c> "+y"


" 设置折叠
set foldmethod=syntax "用语法高亮来定义折叠
set foldlevel=100	"启动vim时不要自动折叠
set foldcolumn=2	"设置折叠栏宽度
"括号补全用auto pairs插件

" 设置tags文件
set tags=tags
set tags+=~/.vim/tags/tags
set tags+=/home/hosea/CODE/C++/tags

"===================================================设置Vundle===============================================
set nocompatible
filetype off
" 下面此项设定vundle的安装目录，就是上面git下载的地址
set rtp+=~/.vim/bundle/Vundle.vim
" 所有的插件地址都要在call vundle#begin()和call vundle#end()之间
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'wesleyche/SrcExpl'
Plugin 'Valloric/YouCompleteMe'
Bundle 'a.vim'
Bundle 'txt.vim'
" All of your Plugins must be added before the following line

call vundle#end()            " required
filetype plugin indent on    " required
"=====================================================完成Vundle设置==========================================




" 设置主题
"set background=dark
"colorscheme murphy


" 设置NerdTree快捷键，F3可显示/隐藏NerdTree区域
map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>


"===================================================设置Taglist===============================================
map <F2> :TlistToggle<CR>
let Tlist_Auto_Open = 0  " 自动打开Tlist
set autochdir

let Tlist_Enable_Fold_Column = 0	" 只显示当前文件的ctags
let Tlist_Show_One_File = 1

let Tlist_WinWidth = 40		" 设置taglist的宽度

let Tlist_Exit_OnlyWindow = 1	" Tlist是最后一个窗口，则退出vim

let Tlist_Use_Right_Window = 1	" 在vim窗口右侧显示taglist窗口
"==================================================完成Taglist设置============================================


"=======================================添加YouCompleteMe的配置=============================================
let g:ycm_server_python_interpreter = '/home/hosea/anaconda3/bin/python'
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
"==================================完成Ycm配置======================================================================


"=======================================================一键编译运行c和c++程序===================================

"---1.按F5可以直接编译并执行C、C++、java代码以及执行shell脚本，按“F8”可进行C、C++代码的调试

" 当新建 .h .c .hpp .cpp .mk .sh等文件时自动调用SetTitle 函数
autocmd BufNewFile *.[ch],*.hpp,*.cpp,Makefile,*.mk,*.sh exec ":call SetTitle()" 
" 加入注释 
func SetComment()
	call setline(1,"/*================================================================") 
	call append(line("."),   "*   Copyright (C) ".strftime("%Y")." Sangfor Ltd. All rights reserved.")
	call append(line(".")+1, "*   ") 
	call append(line(".")+2, "*   文件名称：".expand("%:t")) 
	call append(line(".")+3, "*   创 建 者：Hosea")
	call append(line(".")+4, "*   创建日期：".strftime("%Y年%m月%d日")) 
	call append(line(".")+5, "*   描    述：") 
	call append(line(".")+6, "*")
	call append(line(".")+7, "================================================================*/") 
	call append(line(".")+9, "")
endfunc
" 加入shell,Makefile注释
func SetComment_sh()
	call setline(3, "#================================================================") 
	call setline(4, "#   Copyright (C) ".strftime("%Y")." Sangfor Ltd. All rights reserved.")
	call setline(5, "#   ") 
	call setline(6, "#   文件名称：".expand("%:t")) 
	call setline(7, "#   创 建 者：Hosea")
	call setline(8, "#   创建日期：".strftime("%Y年%m月%d日")) 
	call setline(9, "#   描    述：") 
	call setline(10, "#")
	call setline(11, "#================================================================")
	call setline(12, "")
endfunc 
" 定义函数SetTitle，自动插入文件头 
func SetTitle()
	if &filetype == 'make' 
		call setline(1,"") 
		call setline(2,"")
		call SetComment_sh()
 
	elseif &filetype == 'sh' 
		call setline(1,"#!/system/bin/sh") 
		call setline(2,"")
		call SetComment_sh()
		
	else
		call SetComment()
		if expand("%:e") == 'hpp'
			call append(line(".")+10, "#ifndef _".toupper(expand("%:t:r"))."_H")
			call append(line(".")+11, "#define _".toupper(expand("%:t:r"))."_H")
			call append(line(".")+12, "#ifdef __cplusplus")
			call append(line(".")+13, "extern \"C\"")
			call append(line(".")+14, "{")
			call append(line(".")+15, "#endif")
			call append(line(".")+16, "")
			call append(line(".")+17, "#ifdef __cplusplus")
			call append(line(".")+18, "}")
			call append(line(".")+19, "#endif")
			call append(line(".")+20, "#endif //".toupper(expand("%:t:r"))."_H")
		elseif expand("%:e") == 'h'
			call append(line(".")+10, "#pragma once")
		elseif &filetype == 'c'
			call append(line(".")+10,"#include \"".expand("%:t:r").".h\"")
		elseif &filetype == 'cpp'
			call append(line(".")+10, "#include \"".expand("%:t:r").".h\"")
		endif
	endif
	"新建文件后，自动定位到文件末尾
	"autocmd BufNewFile * normal G
endfunc


" ====================c,c++按F9编译运行==================
map <F9> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "! ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "! ./%<"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!java %<"
   elseif &filetype == 'sh'
	   :!./%
   endif
endfunc
"======================C,C++的调试========================
map	<F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	exec "!g++ % -g -o %<"
	exec "!gdb -q ./%<"
endfunc

"=========================完成一键编译运行c和c++程序=======================
