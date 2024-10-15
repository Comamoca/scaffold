(defpackage :mypkg/tests/main
  (:use :cl
        :rove
        :mypkg/sub)
  (:shadowing-import-from :rove
                          :*debug-on-error*))
(in-package :mypkg/tests/main)

(deftest example-test
  (ok (= 1 1)))

(deftest sub-add-test
  (ok (= 2 (add 1 1))))

(deftest fail-test
  (ok (= 100 1)))
