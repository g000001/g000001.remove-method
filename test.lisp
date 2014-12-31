;;;; test.lisp -*- Mode: Lisp;-*- 

(cl:in-package g000001.remove-method.internal)


(def-suite g000001.remove-method)


(in-suite g000001.remove-method)


(test make-remove-method-form
  (Let ((forms '((Defmethod mahalito ((x (Eql 42)) (y list)) 42)
                 (Defmethod mahalito ((x (Eql 1))(y Array)) 1)
                 (Defmethod mahalito ((x list) (y class)) (List x))
                 (Defmethod mahalito :around ((x list) (y class)) (List x)))))
    (Mapc #'Eval forms)
    (is-true (c2cl:generic-function-methods (Ensure-Generic-Function 'mahalito)))
    (Mapc (lambda (f)
            (Eval (make-remove-method-form-from-defmethod-form f)))
          forms)
    (is-true (null (c2cl:generic-function-methods (Ensure-Generic-Function 'mahalito))))))


;;; *EOF*


