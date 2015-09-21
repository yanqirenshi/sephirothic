(in-package :sephirothic)

(defun error* (code &rest args)
  (cond ((eq code :is-empty)
         (apply #'error "~a is empty. value=~S" args))
        ((eq code :alredy-exist)
         (apply #'error "Aledy exist ~a. code=~S" args))
        ((eq code :alredy-exist-env-at-appl)
         (apply #'error "Aledy exist ~a. code=~S appl=~S" args))
        ((eq code :alredy-exist-fruit)
         (apply #'error "Aledy exist fruit. parent=~a, code=~a" args))
        ((eq code :fruit-not-found)
         (apply #'error "Fruit not fount. query=~A" args))))


;; TODO: is not keyword
;; TODO: Bad tree

;; TODO: move upanihsad
;;   - Bad tree-stor
;;   - not start tree
