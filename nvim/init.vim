call plug#begin()
Plug 'tomasr/molokai'
Plug 'NLKNguyen/papercolor-theme'
Plug 'kyoz/purify', { 'rtp': 'nvim' }
Plug 'xero/sourcerer.vim'
Plug 'AlessandroYorba/Sierra'
Plug 'mhartington/oceanic-next'
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/seoul256.vim'

Plug 'preservim/nerdtree'
Plug 'Pocco81/AutoSave.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'kevinhwang91/nvim-hlslens'
call plug#end()

" toggle tree
nmap <C-n> :NERDTreeToggle<CR>
" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
" autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
" autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" commenting set up
lua require('Comment').setup()

" autosave 

" vimscript
noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap * *<Cmd>lua require('hlslens').start()<CR>
noremap # #<Cmd>lua require('hlslens').start()<CR>
noremap g* g*<Cmd>lua require('hlslens').start()<CR>
noremap g# g#<Cmd>lua require('hlslens').start()<CR>

" use : instead of <Cmd>
nnoremap <silent> <leader>l :noh<CR>

" nvim 
set number
let g:seoul256_background = 233
colo seoul256


