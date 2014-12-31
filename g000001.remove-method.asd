;;;; g000001.remove-method.asd -*- Mode: Lisp;-*- 

(cl:in-package :asdf)


(defsystem :g000001.remove-method
  :serial t
  :depends-on (:fiveam
               :closer-mop)
  :components ((:file "package")
               (:file "g000001.remove-method")
               (:file "test")))


(defmethod perform ((o test-op) (c (eql (find-system :g000001.remove-method))))
  (load-system :g000001.remove-method)
  (or (flet (($ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
        (let ((result (funcall ($ :fiveam :run) ($ :g000001.remove-method.internal :g000001.remove-method))))
          (funcall ($ :fiveam :explain!) result)
          (funcall ($ :fiveam :results-status) result)))
      (error "test-op failed") ))


;;; *EOF*
