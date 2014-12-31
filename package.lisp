;;;; package.lisp -*- Mode: Lisp;-*- 

(cl:in-package :cl-user)


(defpackage :g000001.remove-method
  (:use)
  (:Export :make-remove-method-form
           :make-remove-method-forms
           :make-remove-method-form-from-defmethod-form))


(defpackage :g000001.remove-method.internal
  (:use :g000001.remove-method :cl :fiveam))

