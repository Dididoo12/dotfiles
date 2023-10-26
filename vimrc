"" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2017 Sep 20
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

" if &t_Co > 2 || has("gui_running")
"   " Switch on highlighting the last used search pattern.
"   set hlsearch
" endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" -----------------------------------------------------
" Functions
" -----------------------------------------------------
" Trim trailing whitespace

function! <SID>TrimTrailingWhitespaces()
    let l=line(".")
    let c=col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Toggle between relative and absolute numbers
function! s:LineNumberToggle() abort
  if (&relativenumber==1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunction

" -----------------------------------------------------
" Aucommands
" -----------------------------------------------------
" Trim trailing whitespace on save
autocmd BufWritePre *.rb,*.c,*.java,*.js,*.tsx :call <SID>TrimTrailingWhitespaces()

" autocmd BufWritePre * %s/\s\+$//e

" autocmd BufReadPost * normal `"

" -----------------------------------------------------
" Command maps
" -----------------------------------------------------
" Toggle between absolute linenumbers and hybrid line numbers
command! LineNumberToggle call s:LineNumberToggle()

" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

if (has("termguicolors"))
  set termguicolors
endif

filetype plugin on
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set relativenumber
se nu
set background=dark
colorscheme PaperColor
" colorscheme jellybeans

" set background=light
set background=dark
syntax on
let mapleader = "\<Space>"

" esc in insert mode
inoremap kj <esc>

" esc in command mode
cnoremap kj <C-C>

vnoremap kj <C-C>
" Note: In command mode mappings to esc run the command for some odd
" historical vi compatibility reason. We use the alternate method of
" exiting which is Ctrl-C

nnoremap <silent> <leader>n :LineNumberToggle<cr>

" Initially set it to "dark" or "light" according to your default
let s:mybg = "dark"
function! BgToggleSol()
    if (s:mybg ==? "light")
       set background=dark
       let s:mybg = "dark"
       " colorscheme jellybeans
    else
       set background=light
       let s:mybg = "light"
       " colorscheme papercolor
    endif
endfunction

nnoremap <silent> <leader>bg :call BgToggleSol()<cr>
" noremap <Leader>bg :let &background = ( &background == "dark" ? "light" : "dark" )<CR> <bar> :execute ( g:colors_name == "jellybeans" ? "colorscheme papercolor" : "colorscheme jellybeans" ) <CR>

nnoremap <silent> <leader>m :noh<cr>

nnoremap <leader>j  <C-W><C-J>
nnoremap <leader>k  <C-W><C-K>
nnoremap <leader>h  <C-W><C-H>
nnoremap <leader>l  <C-W><C-L>

" nmap <leader>e :CocCommand explorer<cr>

nnoremap U <C-R>
set clipboard=unnamed

imap ,/ </<C-X><C-O>


set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" " COC Readme
" " TextEdit might fail if hidden is not set.
" set hidden

" " Some servers have issues with backup files, see #649.
" set nobackup
" set nowritebackup

" " Give more space for displaying messages.
" set cmdheight=2

" " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" " delays and poor user experience.
" set updatetime=300

" " Don't pass messages to |ins-completion-menu|.
" set shortmess+=c

" " Always show the signcolumn, otherwise it would shift the text each time
" " diagnostics appear/become resolved.
" set signcolumn=yes

" " Use tab for trigger completion with characters ahead and navigate.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" " " Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" " position. Coc only does snippet and additional edit on confirm.
" if has('patch8.1.1068')
"   " Use `complete_info` if your (Neo)Vim version supports it.
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif

" " Use `[g` and `]g` to navigate diagnostics
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

" " GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" " Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction

" " Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" " Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)

" " Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder.
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" " Applying codeAction to the selected region.
" " Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap keys for applying codeAction to the current line.
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)

" " Introduce function text object
" " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap if <Plug>(coc-funcobj-i)
" omap af <Plug>(coc-funcobj-a)

" " Use <TAB> for selections ranges.
" " NOTE: Requires 'textDocument/selectionRange' support from the language server.
" " coc-tsserver, coc-python are the examples of servers that support it.
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" " Add `:Format` command to format current buffer.
" command! -nargs=0 Format :call CocAction('format')

" " Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" " Add `:OR` command for organize imports of the current buffer.
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" " Add (Neo)Vim's native statusline support.
" " NOTE: Please see `:h coc-status` for integrations with external plugins that
" " provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" " Mappings using CoCList:
" " Show all diagnostics.
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR> ==================================
" " ==================================
" " coc config
" let g:coc_global_extensions = [
"   \ 'coc-git',
"   \ 'coc-pairs',
"   \ 'coc-explorer',
"   \ 'coc-highlight',
"   \ 'coc-yank',
"   \ 'coc-lists',
"   \ ]
  " \ 'coc-tsserver',
  " \ 'coc-eslint', 
  " \ 'coc-prettier', 
  " \ 'coc-json', 


call plug#begin('~/.vim/plugged')

Plug 'nathanaelkane/vim-indent-guides'    " Visual Indent
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors=0
hi IndentGuidesEven ctermbg=238
hi IndentGuidesOdd ctermbg=236
Plug 'scrooloose/nerdtree'    " File Tree
map <C-o> :NERDTreeToggle<CR>
" function! StartUp()
"     if 0 == argc()
"         NERDTree
"     end
" endfunction
" autocmd VimEnter * call StartUp()

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'    " Fuzzy File Finder

nnoremap <silent> <leader>f :Files<cr>
" nnoremap <silent> <leader>t :Tags<cr>
" let g:fzf_preview_window = 'right:60%'
" let g:fzf_preview_window = 'right:70%:hidden'

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%', '?'),
      \   <bang>0)
" command! -bang -nargs=? -complete=dir Files
"     \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)

nnoremap <silent> <leader>r :Rg<cr>

Plug 'terryma/vim-multiple-cursors'    " Highlight while searching, c / i / a for change, insert at start and append to end
Plug 'vim-airline/vim-airline'
Plug 'mbbill/undotree'  " Undo Tree
nnoremap <F5> :UndotreeToggle<cr>
Plug 'haya14busa/incsearch.vim'  " Better search highlighting
Plug 'rafi/awesome-vim-colorschemes'    " Collection of Colour Schemes
Plug 'airblade/vim-gitgutter'    " Visual git diff in vim

Plug 'tpope/vim-surround' " Vim Surround (ds delete, cs change, ys add)
Plug 'tpope/vim-commentary' " Commenting (gc for 'go comment')
Plug 'tpope/vim-repeat' " Plugin repetition with .
Plug 'vim-scripts/ReplaceWithRegister' " Replace selection with contents of register (gr for 'go replace')
Plug 'kana/vim-textobj-user' " Text object base
Plug 'kana/vim-textobj-indent' " Text object for indented block (ii for 'inner indent')
Plug 'kana/vim-textobj-entire' " Text object for whole file (ae)
Plug 'kana/vim-textobj-line' " Text object for lines, excluding whitespace (il for 'inner line')
Plug 'nelstrom/vim-textobj-rubyblock' " Text object for ruby blocks (ar for 'a ruby' block)

" Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'sheerun/vim-polyglot'

Plug 'majutsushi/tagbar'
nmap <leader>t :TagbarToggle<CR>
let g:tagbar_autoclose = 1
nnoremap <leader>g :grep! "\<<cword>\>" . -r<CR>:copen<CR>

Plug 'ryanoasis/vim-devicons'
set encoding=UTF-8

Plug 'NLKNguyen/papercolor-theme'
call plug#end()
