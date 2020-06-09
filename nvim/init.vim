
source ~/.config/nvim/general/settings.vim

source ~/.config/nvim/plug-conf/plugins.vim

colorscheme Pinky
let g:airline_theme='pinky_airline'

if executable('rg')
    let g:rg_derive_root='true'
endif

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:ctrlp_use_caching = 0


source ~/.config/nvim/general/mappings.vim


source ~/.config/nvim/plug-conf/nerd-tree.vim

source ~/.config/nvim/plug-conf/quick-scope.vim

source ~/.config/nvim/plug-conf/sneak.vim
