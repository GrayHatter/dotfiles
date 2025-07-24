call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'scrooloose/syntastic'

Plug 'morhetz/gruvbox'
Plug 'reedes/vim-colors-pencil'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

Plug 'airblade/vim-gitgutter'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'thaerkh/vim-workspace'

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
set smartcase
set hlsearch                " highlight search
set incsearch               " incremental search
set number                  " add line numbers
set relativenumber
set cursorline
set wildmode=longest,list   " get bash-like tab completions
set mouse=a                 " enable mouse click
"set clipboard=unnamedplus   " using system clipboard
set ttyfast                 " Speed up scrolling in Vim
set nocul
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
set backupdir=~/.cache/nvim " Directory to store backup files.
set spell spelllang=en_us
filetype plugin indent on
filetype plugin on

set nofixendofline
set nowrap

source $VIMRUNTIME/colors/vim.lua
set encoding=utf-8

set fo+=t
set tw=80
set cinoptions=-(1s
set vb t_vb=

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

set colorcolumn=95

set background=dark
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_itilic = 1
let g:gruvbox_hls_cursor = 'blue'
let g:gruvbox_number_column = 'bg0'
let g:gruvbox_color_column = 'bg0'
let g:gruvbox_dim_inactive_windows = 1
colorscheme gruvbox
syntax on

" These are near gruvbox colors, this changes the bg color for the currently
" active window I needed better signal about which buffer I was currently
" working in :)
"hi ActiveWindow guibg=#1a1b1a
"hi InactiveWindow guibg=#1d2021
hi ActiveWindow guibg=#1b1d1f
hi InactiveWindow guibg=#1d2021
set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow

let mapleader=" "
let g:netrw_ftp_cmd="ftp -p"

let g:airline_powerline_fonts = 1
let g:airline_theme="gruvbox"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#middle_click_preserves_windows = 1
let g:airline_skip_empty_sections = 1

"if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
"endif
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'
"
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''


let g:workspace_autocreate = 1
let g:workspace_autosave = 0
let g:workspace_session_directory = $HOME . '/.cache/nvim/sessions/'
let g:workspace_session_disable_on_args = 1
let g:workspace_persist_undo_history = 0

let g:zig_fmt_parse_errors = 1
let g:zig_fmt_autosave = 1

augroup Mkdir
  autocmd!
  autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END

augroup PlzFmt
  autocmd!
  autocmd BufWritePre *.css :normal msgg=G`s
augroup END

augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END


augroup FocusedMode
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
    autocmd WinEnter * set relativenumber
    autocmd WinLeave * set norelativenumber
    "autocmd InsertEnter * set cul
    "autocmd InsertLeave * set nocul
augroup END

" I'd like to have auto folding, but it's too distracting currently :/
" augroup vimrc
"   au BufReadPre * setlocal foldmethod=indent
"   au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
" augroup END

"set foldlevel=99


nnoremap <expr> <Leader>h <SID>change_word_under_cursor()
vnoremap <expr> <Leader>h <SID>change_word_under_cursor()
fu! s:change_word_under_cursor() abort
    let word = expand('<cword>')
    let subwords = split(word, word =~# '_' ? '_' : '\ze\u')
    return ':%s/\v' . join(map(subwords, '"(" . v:val . ")"'), word =~# '_' ? '_' : '') . '//g' . "\<Left>\<Left>"
endfu


nnoremap <silent> <Leader>c :s/FIXME<CR>

nnoremap <C-n>     :enew<cr>
inoremap <C-n>     <C-o>:enew<cr>


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
"nnoremap <Leader>h :vs<CR>
nnoremap <Leader>t 0d$
nnoremap <silent> <Leader>w :write<CR>

"easy search replace
nnoremap <Leader>s :%s/

" delete bufffer
nnoremap <silent> <Leader>dd :bp\|sp\|bn\|bd<CR>

" TRailing spaces
nnoremap <silent> <Leader>tr :%s/\s\+$//e<CR>

" Line Context -or- Line Number
nnoremap <silent> <Leader>lc :let @+ = expand("%").':'.line(".")."  `".getline(".")."`"<CR>
nnoremap <silent> <Leader>ln :let @+ = expand("%").':'.line(".")<CR>

" seriously... fuck you q
"nnoremap <silent> q <Nop>

" Quick nav
nnoremap <C-Left> <C-W><Left>
nnoremap <C-Right> <C-W><Right>
nnoremap <C-Up> <C-W><Up>
nnoremap <C-Down> <C-W><Down>
nnoremap <F11> :bprev<CR>
nnoremap <F12> :bnext<CR>


" Arrows are simple
nnoremap <S-Up> <Up>
nnoremap <S-Down> <Down>
inoremap <S-Up> <Up>
inoremap <S-Down> <Down>


" Suggested LSP config
:lua <<EOF

vim.o.updatetime = 2500
--vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
--vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]
vim.diagnostic.config({
  float = false,
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
vim.diagnostic.setloclist()


vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    -- vim.diagnostic.config({ virtual_text = false })
    vim.diagnostic.reset()
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    --vim.diagnostic.config({ virtual_text = true })
    vim.diagnostic.show()
  end,
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
  debounce_text_changes = 2500,
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

local util = require 'lspconfig.util'
local root_files = {
  'compile_commands.json',
  '.clangd',
  '.clang-tidy',
  '.clang-format',
  'compile_flags.txt',
  'configure.ac', -- AutoTools
}
require('lspconfig')['clangd'].setup{
    on_attach = on_attach,
    filetypes = { "c", "h", "cpp", "hpp", "objc", "objcpp" },
    root_dir = function(fname)
      return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
    end,
    single_file_support = true,
}

EOF

source ~/.config/nvim/subl_binds.vim
source ~/.config/nvim/zls.vim
"source ~/.config/nvim/nvim-cmp-conf.vim
