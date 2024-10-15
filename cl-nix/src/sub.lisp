(uiop:define-package :mypkg/sub
  (:use :cl)
  (:export :add))
(in-package :mypkg/sub)

(defun add (a b)
  (+ a b))
