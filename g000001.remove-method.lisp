;;;; g000001.remove-method.lisp -*- Mode: Lisp;-*- 

(cl:in-package :g000001.remove-method.internal)


(Defmethod make-remove-method-form ((gf Generic-Function) (m Method))
  (Let ((gfname (c2mop:generic-function-name gf))
        (ss     (c2mop:method-specializers m))
        (qs     (Method-Qualifiers m)))
    `(Remove-Method #',gfname
                    (Find-Method #',gfname
                                 ',qs
                                 (list
                                  ,@(Mapcar (Lambda (s)
                                              (if (Typep s 'c2mop:eql-specializer)
                                                  `(c2mop:intern-eql-specializer
                                                    ,(c2mop:eql-specializer-object s))
                                                  `(Find-Class ',(Class-Name s))))
                                            ss))
                                 nil))))


(Defmethod make-remove-method-forms ((gf Generic-Function))
  `(Progn
     ,@(Mapcar (Lambda (m) (make-remove-method-form gf m))
               (c2mop:generic-function-methods gf))))


(Defun make-remove-method-form-from-defmethod-form (form)
  (Check-Type form (Cons (Eql Defmethod) (Cons Symbol *)))
  (make-remove-method-form (Ensure-Generic-Function (Second form))
                           (Eval form)))


;;; *EOF*


