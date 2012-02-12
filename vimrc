filetype off
call pathogen#infect() 
call pathogen#runtime_append_all_bundles()
call pathogen#helptags() " generate helptags for everything in 'runtimepath'
syntax on
filetype plugin indent on

set nocompatible  "don't try to be vi compatible
set modelines=0   "
" General {
	set nowrap        " don't wrap lines
	"set number        " always show line numbers
	set relativenumber " set the line column display to show how far away from current lines other ones are
	set cursorcolumn
	set cursorline

	"set title         " change the terminal's title
	set laststatus=2  " always show the status bar
	set statusline=%f%m%r%h%w\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [FORMAT=%{&ff}]
	"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L] 
	"set statusline=%F\ %m\ %{fugitive#statusline()}\ %y%=%l,%c\ %P
	"set ruler " show the ruler
	"set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids

	set tabstop=4     " a tab is four spaces
	set shiftwidth=4  " number of spaces to use for autoindenting
	set softtabstop=4 "

	set backspace=indent,eol,start " allow backspacing over everything in insert mode
	set list
	set listchars=tab:▸\ ,eol:¬,trail:.,extends:#,nbsp:.
	"indenting
	set autoindent    " always set autoindenting on
	set copyindent    " copy the previous indentation on autoindenting
	set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
	set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
	set showmatch     " set show matching parenthesis

	set ignorecase    " ignore case when searching
	set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
	set hlsearch      " highlight search terms
	set incsearch     " show search matches as you type

	set scrolljump=3  " lines to scroll when cursor leaves screen
	set scrolloff=3	  " minimum lines to keep above and below cursor

	set gdefault			" apply substitutions globally on a line

"Key remappings{
"use normal regex resembling perl/python
		nnoremap / /\v
		vnoremap / /\v
	"toggle between relative and absolute line numbers
		nnoremap <C-L> :call g:ToggleNuMode()<cr> 
		function! g:ToggleNuMode()
		if(&rnu == 1)
			set nu
		else
			set rnu
		endif
		endfunc
	"use <tab> instead of % to move around matching brackets
		nnoremap <tab> %
		vnoremap <tab> %
	"make <j> and <k> move by screen lines instead of file lines
		nnoremap j gj
		nnoremap k gk
	"reselect text that was just pasted
		nnoremap <leader>v V`]
	"open .vimrc in a vertically split screen 
		nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
	"open a new split window and switch focus to it
		nnoremap <leader>w <C-w>v<C-w>l
	"move around window splits
		nnoremap <C-h> <C-w>h
		nnoremap <C-j> <C-w>j
		nnoremap <C-k> <C-w>k
		nnoremap <C-l> <C-w>l
" }

"Folding settings {
	set foldenable          " auto fold code
	"set nofoldenable        "dont fold by default
	set foldmethod=indent   "fold based on indent
	set foldnestmax=10      "deepest fold is 10 levels
	set foldlevel=1         "this is just what i use
" }
	set visualbell           " don't beep
	set noerrorbells         " don't beep

	set history=1000         " remember more commands and search history
	set undolevels=1000      " use many muchos levels of undo
	set wildignore=*.swp,*.bak,*.pyc,*.class
	set hidden        "hides buffers instead of closing them
	set undofile	  "creates an undo file which allows for previous undo actions even after close and reopen
	set nobackup
	set noswapfile
" }
" Key mappings
	" change the mapleader from \ to ,
	let mapleader=","

" type <leader><spacebar> to clear highlights
	nnoremap <leader><space> :noh<cr> 
	"nmap <silent> ,/ :nohlsearch<CR>

au BufWinLeave * silent! mkview "make vim save view (state) (folds, cursor, etc)
au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)
" }

" tagbar mappings
nmap <F8> :TagbarToggle<CR> 

" Command-t {
	noremap <leader>o <Esc>:CommandT<CR>
	noremap <leader>O <Esc>:CommandTFlush<CR>
	noremap <leader>m <Esc>:CommandTBuffer<CR>
	"let g:CommandTSearchPath = $HOME . '/Code'
" }

"remove all trailing whitespace on all lines
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

if has('autocmd')
    autocmd filetype python set expandtab
    autocmd FileType python runtime! autoload/pythoncomplete.vim
    autocmd filetype html,xml set listchars-=tab:>.
endif

"save on losing focus
"au FocusLost * :wa

colorscheme solarized
set background=dark
let g:solarized_termtrans=1
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"

    " ShowMarks {
        let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        " Don't leave on by default, use :ShowMarksOn to enable
        let g:showmarks_enable = 0
        " For marks a-z
        highlight ShowMarksHLl gui=bold guibg=LightBlue guifg=Blue
        " For marks A-Z
        highlight ShowMarksHLu gui=bold guibg=LightRed guifg=DarkRed
        " For all other marks
        highlight ShowMarksHLo gui=bold guibg=LightYellow guifg=DarkYellow
        " For multiple marks on the same line.
        highlight ShowMarksHLm gui=bold guibg=LightGreen guifg=DarkGreen
    " }
    " Supertab {
        let g:SuperTabDefaultCompletionType = "context"
        let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
    " }
    " OmniComplete {
        "if has("autocmd") && exists("+omnifunc")
            "autocmd Filetype *
                "\if &omnifunc == "" |
                "\setlocal omnifunc=syntaxcomplete#Complete |
                "\endif
        "endif

        " Popup menu hightLight Group
        "highlight Pmenu    ctermbg=13  guibg=DarkBlue
        "highlight PmenuSel ctermbg=7   guibg=DarkBlue      guifg=LightBlue
        "highlight PmenuSbar ctermbg=7  guibg=DarkGray
        "highlight PmenuThumb           guibg=Black

        hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

        " some convenient mappings
        inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
        inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
        inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
        inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
        inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

        " and make sure that it doesn't break supertab
        let g:SuperTabCrMapping = 0
       
        " automatically open and close the popup menu / preview window
        au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        set completeopt=menu,preview,longest
    " }

