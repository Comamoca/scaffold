(uiop:define-package :mypkg/mypkg
  (:nicknames)
  (:use :cl :mypkg/sub) 
  (:export :main))

(in-package :mypkg/mypkg)

(defun main ()
  (format t "Hello!~%1 + 2 = ~a~%" (add 1 2)))
