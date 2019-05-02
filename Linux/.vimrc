syntax on
"colorscheme http__modified
colorscheme onedark

set nocompatible
set nofoldenable
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'thinca/vim-quickrun'
Plugin 'Raimondi/delimitMate'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
call vundle#end()
filetype plugin indent on

let g:vim_markdown_math=1
let g:vim_markdown_folding_disabled=1

let g:quickrun_config = {
\	"_":{
\		"outputter": "message",
\	},
\}
let g:quickrun_config.markdown = {
\	"command": "pandoc",
\	"exec": "%c %s -t latex -o %s:p:r.pdf",
\}
let g:quickrun_config.rmd = {
\	"exec": "cmd.exe /c Rscript -e \"rmarkdown::render('%S:p:.', encoding = 'UTF-8')\"; rm -R %S:p:r_files"
\}
let g:quickrun_config.r = {
\	"exec": "cmd.exe /c Rscript %s:p:."
\}
let g:quickrun_no_default_key_mappings=1
nmap <leader>r <Plug>(quickrun)
map <F10> :QuickRun<CR>

let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_key_list_select_comlpetion=['<Enter>', '<Down>']
let g:ycm_key_list_select_comlpetion=['<Up>']
let g:ycm_key_list_stop_completion=['<Enter>']
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_python_binary_path='python'
let g:ycm_max_num_candidates=7
let g:ycm_max_num_identifier_candidates=7
let g:ycm_complete_in_comments=1
let g:ycm_complete_in_strings=1
let g:ycm_collect_identifiers_from_comments_and_strings=1
let g:ycm_path_to_python_interpreter='/usr/bin/python'
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
map <leader> g:YcmCompleter GoToDefinitionElseDeclaration<CR>

set tabstop=4
set nu
set ic
set mouse=a
set hlsearch
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,GB2312,big5
set cursorline
set autoindent
set smartindent
set vb
set scrolloff=4
set showmatch

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let python_hight_all=1
au Filetype python set tabstop=4
au Filetype python set softtabstop=4
au Filetype python set shiftwidth=4
au Filetype python set expandtab
au Filetype python set autoindent
au Filetype python set fileformat=unix
autocmd Filetype python set foldmethod=indent
autocmd Filetype python set foldlevel=99

map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
		exec "w"
		if &filetype == 'python'
				exec "!echo \"/*---------------------------------*/\" && echo \"/*---------------------------------*/\" && time /mnt/d/Applications/Anaconda_Linux/bin/python %"
		elseif &filetype == 'R'
				exec "!echo \"/*---------------------------------*/\" && echo \"/*---------------------------------*/\" && time cmd.exe /c Rscript.exe %"
		elseif &filetype == 'tex'
				exec "!echo \"/*---------------------------------*/\" && echo \"/*---------------------------------*/\" && time bash /usr/bin/texpdf.sh %"
		elseif &filetype == 'rmd'
				exec "!echo \"/*---------------------------------*/\" && echo \"/*---------------------------------*/\" && time Rscript -e \"rmarkdown::render('%')\""
		endif
endfunct

if (empty($TMUX))
		if (has("nvim"))
				let $NVIM_TUI_ENABLE_TRUE_COLOR=1
		endif
		if (has("termguicolors"))
				set termguicolors
		endif
endif
