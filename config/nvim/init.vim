set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

call plug#begin('~/.vim/plugged')

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'


Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

Plug 'keith/swift.vim'
" Syntax highlighting is broken with this plugin
" Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
Plug 'morhetz/gruvbox'

Plug 'voldikss/vim-floaterm'

Plug 'vim-test/vim-test'

Plug 'mfussenegger/nvim-dap'

call plug#end()

source ~/.config/nvim/lua/_telescope.lua
source ~/.config/nvim/lua/_nvim-lspconfig.lua
source ~/.config/nvim/lua/compe_config.lua

colorscheme gruvbox
" autocmd vimenter * ++nested colorscheme gruvbox

let mapleader = ","

nnoremap <C-p> <cmd>Telescope find_files<cr>
nmap <leader>lg <cmd>Telescope live_grep<cr>

" floaterm hotkeys
tnoremap <leader>t <cmd>FloatermToggle<cr>
nnoremap <leader>t <cmd>FloatermNew --height=0.98 --width=1.0 --wintype=float --title=lazygit --name=lazygitterm --disposable lazygit<cr>

" edit vimrc
nnoremap <silent> <leader>ev :e $MYVIMRC<cr>

" vim-test mappings
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>


autocmd BufNewFile,BufRead *.leaf set filetype=html
autocmd BufNewFile,BufRead Podfile,*.podspec set filetype=ruby
