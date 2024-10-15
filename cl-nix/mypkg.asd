(defsystem "mypkg"
  :class :package-inferred-system
  :author "Comamoca"
  :depends-on("mypkg/mypkg")
  :pathname "src"
  :build-operation "program-op"
  :build-pathname "mypkg"
  :entry-point "mypkg/mypkg:main"
  :in-order-to ((test-op (test-op "mypkg/tests"))))

(defsystem "mypkg/tests"
  :author "Comamoca"
  :depends-on ("mypkg/tests/main"
               "mypkg"
               "rove")
  :class :package-inferred-system
  :perform (test-op (op c) (symbol-call :rove :run c)))
