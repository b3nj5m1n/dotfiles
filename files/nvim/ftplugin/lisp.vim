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
    " Loop over each packagename found and try to quickload it
    for package in package_names
        call add(result, "--eval")
        call add(result, "(ql:quickload :" . package . ")")
    endfor
    return result
endfunction
