;; This is a description of the directory structure I use for my backups. The
;; reason for writing it in lisp like this is that it allows me to automatically
;; generate rsync commands, for example. I haven't actually implemented  any of
;; that yet though. So for now, this remains a waste of time.

(defclass tree ()
  ((name     :initarg :name
             :reader name)
   (desc     :initarg :desc
             :accessor desc)
   (sub-trees :initarg :sub-trees
             :accessor sub-trees))
  (:default-initargs
    :sub-trees '()))

(defmethod add-subtree ((root-tree tree) (sub-tree tree))
  (if (null (sub-trees root-tree))
    (push sub-tree (sub-trees root-tree))
    (push sub-tree (cdr (last (sub-trees root-tree))))))

(defmethod render ((root-tree tree))
  (format T "-- FILESYSTEM --~%~%")
  (format T "~A~%" (name root-tree))
  (loop for sub-tree in (sub-trees root-tree) do
    (render-subtree sub-tree 1)))

(defmethod render-subtree ((root-tree tree) (depth integer))
  (format t "~v@{~A~:*~}" depth " ")
  (format t "~A~%" (name root-tree))
  (loop for sub-tree in (sub-trees root-tree) do
    (render-subtree sub-tree (+ 1 depth))))

(defun make-tree (parent &rest body)
  (loop for (name desc sub-trees) on (first body) by #'cdddr do
    (let ((new-tree (make-instance 'tree :name name :desc desc)))
      (add-subtree parent new-tree)
      (when (not (null sub-trees))
        (make-tree new-tree sub-trees)))))

(defvar root (make-instance 'tree :name "ROOT" :desc "Filesystem root"))
(make-tree root
           '(:docs "Non redundant documents"
              (:code "Coding projects / git repositories" nil
               :notes "Notes" nil
               :zotero "Zotero database" nil
               :personal "Personal documents" nil
               :school "School related documents" nil)
             :media "Media"
              (:film "Movies & Series" nil
               :music "Music" nil
               :audiobooks "Audiobooks" nil
               :books "Calibre libary" nil
               :photos "Photos" nil)
             :archive "Archives"
              (:disks "Hard drives of previous installs" nil
               :youtube "Youtube related files" nil
               :takeout "Google takeout files" nil
               :whatsapp "Whatsapp data" nil)
             :redundant "Data that could be fairly easily recovered if necessary" nil))
           

(render root)


; (defmethod tree-part ((depth integer) (last t) (content string))
;   (let ((edge    "├──")
;         (line    "│  ")
;         (corner  "└──")
;         (blank   "   ")
;         (x (list depth last)))
;     (cond
;       ((equal '(0 nil) x) (format nil "~A~%" content))
;       ((equal '(0 T) x) (format nil "~A~%" content))
;       ((equal '(1 nil) x) (format nil "~A ~A~%" edge content))
;       ((equal '(1 T) x) (format nil "~A ~A~%" corner content))
;       ((equal '(2 nil) x) (format nil "~A ~A ~A~%" line edge content))
;       ((equal '(2 T) x) (format nil "~A ~A ~A~%" line corner content))
;       nil)))
      
      
