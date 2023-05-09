call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'scrooloose/syntastic'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'morhetz/gruvbox'

Plug 'airblade/vim-gitgutter'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'thaerkh/vim-workspace'

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'ziglang/zig.vim'

"Plug 'shougo/deoplete.nvim'
"Plug 'nvim-lua/completion-nvim'

Plug 'neovim/nvim-lspconfig'

"Plug 'hrsh7th/cmp-nvim-lsp'
"Plug 'hrsh7th/cmp-buffer'
"Plug 'hrsh7th/cmp-path'
"Plug 'hrsh7th/cmp-cmdline'
"Plug 'hrsh7th/nvim-cmp'


call plug#end()

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching
set ignorecase              " case insensitive
set hlsearch                " highlight search
set incsearch               " incremental search
set number                  " add line numbers
set relativenumber
set cursorline
set wildmode=longest,list   " get bash-like tab completions
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
set ttyfast                 " Speed up scrolling in Vim
set nocul
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
set backupdir=~/.cache/nvim " Directory to store backup files.
set spell spelllang=en_us
filetype plugin indent on
filetype plugin on

set nofixendofline

set fo+=t
set tw=80
set cinoptions=-(1s
set background=dark
set vb t_vb=

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif

set colorcolumn=95

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_itilic = 1
let g:gruvbox_hls_cursor = 'blue'
let g:gruvbox_number_column = 'bg0'
let g:gruvbox_color_column = 'bg0'
let g:gruvbox_dim_inactive_windows = 1
colorscheme gruvbox
syntax on


let mapleader=" "
let g:netrw_ftp_cmd="ftp -p"


let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#middle_click_preserves_windows = 1


let g:workspace_autocreate = 1
let g:workspace_autosave = 0
let g:workspace_session_directory = $HOME . '/.cache/nvim/sessions/'
let g:workspace_session_disable_on_args = 1
let g:workspace_persist_undo_history = 0


let g:zig_fmt_parse_errors = 0


augroup Mkdir
  autocmd!
  autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END



" These are near gruvbox colors, this changes the bg color for the currently
" active window I needed better signal about which buffer I was currently
" working in :) 
hi ActiveWindow guibg=#1d2021
hi InactiveWindow guibg=#1b1d1f
"hi ActiveWindow guibg=#1b1d1f
"hi InactiveWindow guibg=#1d2021
set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow

augroup FocusedMode
    autocmd!
    "autocmd WinEnter * set cul
    "autocmd WinLeave * set nocul
    autocmd WinEnter * set relativenumber
    autocmd WinLeave * set norelativenumber
    autocmd InsertEnter * set cul
    autocmd InsertLeave * set nocul
augroup END

" I'd like to have auto folding, but it's too distracting currently :/
" augroup vimrc
"   au BufReadPre * setlocal foldmethod=indent
"   au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
" augroup END

"set foldlevel=99


nnoremap <expr> <Leader>s <SID>change_word_under_cursor()
vnoremap <expr> <Leader>s <SID>change_word_under_cursor()
fu! s:change_word_under_cursor() abort
    let word = expand('<cword>')
    let subwords = split(word, word =~# '_' ? '_' : '\ze\u')
    return ':%s/\v' . join(map(subwords, '"(" . v:val . ")"'), word =~# '_' ? '_' : '') . '//g' . "\<Left>\<Left>"
endfu


nnoremap <silent> <Leader>c :s/FIXME<CR>

" Clear some force of habits
vnoremap <C-c> "+y

" nnoremap <C-n>     :tabnew<CR>
" inoremap <C-n>     <Esc>:tabnew<CR>


" FZF
" I may switch back to ff, but I'm trying telescope for a while
" nnoremap <silent> <Leader>f :Files<CR>
" nnoremap <silent> <leader>j :Jumps<CR>
" nnoremap <silent> <Leader>m :Marks<CR>
" nnoremap <silent> <Leader><S-w> :Windows<CR>
" nnoremap <silent> <Leader>h :Helptags<CR>
" nnoremap <silent> <Leader>b :Buffers<CR>
" nnoremap <silent> <Leader>l :BLines<CR>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Happens more than it should
cnoreabbrev W w
"cnoreabbrev q qa

" Custom
nnoremap <expr> <Home> col(".") == match(getline("."), "\\S") + 1 ? '0' : '^'
inoremap <expr> <Home> col(".") == match(getline("."), "\\S") + 1 ? '<C-O>0' : '<C-O>^'
nnoremap Y y$
nnoremap <Leader>v :vs<CR>
nnoremap <Leader>h :vs<CR>
nnoremap <Leader>t 0d$
nnoremap <silent> <Leader>w :write<CR>

" delete bufffer
nnoremap <silent> <Leader>d :bp\|sp\|bn\|bd<CR>

" TRailing spaces
nnoremap <silent> <Leader>tr :%s/\s\+$//e<CR>

" Line Context -or- Line Number
nnoremap <silent> <Leader>lc :let @+ = expand("%").':'.line(".")."  `".getline(".")."`"<CR>
nnoremap <silent> <Leader>ln :let @+ = expand("%").':'.line(".")<CR>

" seriously... fuck you q
nnoremap <silent> q <Nop>

" Quick nav
nnoremap <C-Left> <C-W><Left>
nnoremap <C-Right> <C-W><Right>
nnoremap <C-Up> <C-W><Up>
nnoremap <C-Down> <C-W><Down>

" Suggested LSP config
:lua <<EOF

vim.o.updatetime = 150
--vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
--vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]
vim.diagnostic.config({
  float = false,
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})


local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>Lwa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>Lwr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>Lwl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  debounce_text_changes = 150,
}

require('lspconfig')['pylsp'].setup{
    on_attach = on_attach,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = {'W391'},
                    maxLineLength = 100
                },
                black = {
                    enabled = True
                }
            }
        }
    }
}

require('lspconfig')['clangd'].setup{
    on_attach = on_attach,
    filetypes = { "c", "cpp", "objc", "objcpp" }
}

EOF

source ~/.config/nvim/subl_binds.vim
"source ~/.config/nvim/nvim-cmp-conf.vim
source ~/.config/nvim/zls.vim

