;;;; Common Lisp REPL config


;;; Add the current directory to the central registry of asdf, meaning
;;; you can load the project from the current directory
(pushnew "./" asdf:*central-registry* :test #'equal)
