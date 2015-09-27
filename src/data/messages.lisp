(in-package :sephirothic)

(defvar *message-list*
  '((:code :is-empty
     :values ((:language :hiroshima :controller "~a is empty. value=~S"
               :description "")
              (:language :ja        :controller "~a is empty. value=~S"
               :description "")
              (:language :en        :controller "~a is empty. value=~S"
               :description "")))
    (:code :alredy-exist
     :values ((:language :hiroshima :controller "Aledy exist ~a. code=~S"
               :description "")
              (:language :en        :controller "Aledy exist ~a. code=~S"
               :description "")
              (:language :ja        :controller "Aledy exist ~a. code=~S"
               :description "")))
    (:code :alredy-exist-env-at-appl
     :values ((:language :hiroshima :controller "Aledy exist ~a. code=~S appl=~S"
               :description "")
              (:language :en        :controller "Aledy exist ~a. code=~S appl=~S"
               :description "")
              (:language :ja        :controller "Aledy exist ~a. code=~S appl=~S"
               :description "")))
    (:code :alredy-exist-fruit
     :values ((:language :hiroshima :controller "Aledy exist fruit. parent=~a, code=~a"
               :description "")
              (:language :en        :controller "Aledy exist fruit. parent=~a, code=~a"
               :description "")
              (:language :ja        :controller "Aledy exist fruit. parent=~a, code=~a"
               :description "")))
    (:code :fruit-not-found
     :values ((:language :hiroshima :controller "Fruit not fount. query=~A"
               :description "")
              (:language :en        :controller "Fruit not fount. query=~A"
               :description "")
              (:language :ja        :controller "Fruit not fount. query=~A"
               :description "")))))

