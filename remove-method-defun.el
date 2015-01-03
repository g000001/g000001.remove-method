(require 'slime)


(defface remove-method-flush
    '((t (:foreground "yellow"
          :background "red"
          :bold nil
          :underline t
        )))
  "remove mehtod"
  :group 'font-lock-highlighting-faces)


(defun slime-flash-region2 (start end &optional timeout)
  "Temporarily highlight region from START to END."
  (let ((overlay (make-overlay start end)))
    (overlay-put overlay 'face 'remove-method-flush)
    (run-with-timer (or timeout 0.2) nil 'delete-overlay overlay)))


(define-key slime-mode-map [C-M-delete]
  (defun slime-remove-method-defun ()
    (interactive)
    (let ((form (slime-defun-at-point)))
      (save-excursion
        (slime-beginning-of-defun)
        (slime-flash-region2 (point)
                             (+ (point)
                                (length form))))
      (slime-interactive-eval
       (format
        "(cl:eval (g000001.remove-method:make-remove-method-form-from-defmethod-form '%s))"
        form)))))


;;; *EOF*


