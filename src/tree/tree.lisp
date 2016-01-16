(in-package :sephirothic)

(defun make-tree (tree-stor)
  (unless tree-stor (error* :is-empty "tree-stor" tree-stor))
  (let ((data-stor tree-stor))
    (make-banshou 'banshou data-stor)))

(defun close-tree (tree &key (auto-commit nil))
  (unless tree
    (error "まだ初まってもいません。"))
  (when auto-commit
    (snapshot tree))
  (close-open-streams tree)
  (setf tree nil))

(defun snapshot (tree) (up:snapshot tree))

(defun restore (tree) (up:restore tree))
