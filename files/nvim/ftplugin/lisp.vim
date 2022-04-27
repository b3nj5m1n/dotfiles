let g:lisp_file_path = expand('%:p')

let g:vlime_cl_impl = "ros"
function! VlimeBuildServerCommandFor_ros(vlime_loader, vlime_eval)
    let result = ["ros", "run",
                \ "--load", a:vlime_loader,
                \ "--eval", a:vlime_eval]
    call add(result, "--eval")
    " Add current directory to asdf package registry
    call add(result, "(pushnew \"./\" asdf:*central-registry* :test #'equal)")
    " Try to extract the name of the package currently being worked on
    let package_names = systemlist("/bin/find -name \"*.asd\" | xargs cat | grep \"defsystem\" | sed -r 's/^.*#:(\\w*).*$/\\1/'")
    " If in a package, load it, otherwise load the current file
    if len(package_names) != 0
        " Loop over each packagename found and try to quickload it
        for package in package_names
            call add(result, "--eval")
            call add(result, "(ql:quickload :" . package . ")")
        endfor
    else
        let g:lisp_file_path = get(g:, 'lisp_file_path', v:false)
        if g:lisp_file_path != v:false
            call add(result, "--eval")
            call add(result, "(load \"" . g:lisp_file_path . "\")")
        endif
    endif
    return result
endfunction

" Open repl window as vertical split
let g:vlime_window_settings = {'repl': {'vertical': v:true, 'pos': 'botright'}}
" Automatically start swank server when entering file, make sure this only
" happens once, automatically close the window with the buffer in it
" afterwards but keep the buffer around in the background
let g:vlime_server_autostarted = get(g:, 'vlime_server_autostarted', v:false)
if g:vlime_server_autostarted == v:false
    call vlime#server#New(v:true, get(g:, "vlime_cl_use_terminal", v:false))
    exe winnr('$') .. "wincmd w"
    close!
    let g:vlime_server_autostarted = v:true
endif
