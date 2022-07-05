;; Author:        Reion Wong <reionwong@gmail.com>
;; Maintainer:    Reion Wong <reionwong@gmail.com>
;; Created:       2022-07-05
;; Last-Updated:  2022/07/05 12:45:00
;; Keywords:      eshell
;; Compatibility: GNU Emacs 27

(require 'eshell)

(defvar reshell-buffer-name "*eshell*")
(defvar reshell-mode-func '(lambda () (eshell)))
(defvar reshell-buffer-height 25)

(defvar reshell-last-buffer nil)
(defvar reshell-last-window nil)

(defun reshell ()
  (interactive)
  (if (equal (buffer-name) reshell-buffer-name)
      (reshell-popout)
    (reshell-popup)))

(defun reshell-popup ()
  (let ((w (get-buffer-window reshell-buffer-name)))
    (if w
        (select-window w)
      (progn
        (setq reshell-last-buffer (buffer-name))
        (setq reshell-last-window (selected-window))
        (if (not (eq reshell-buffer-height 100))
            (progn
              (split-window (selected-window)
                            (round (* (window-height) (/ (- 100 reshell-buffer-height) 100.0))))
              (other-window 1)))
        (if (not (get-buffer reshell-buffer-name))
            (funcall (eval reshell-mode-func))
          (switch-to-buffer reshell-buffer-name))))))

(defun reshell-popout ()
  (if (not (eq reshell-buffer-height 100))
      (progn
        (delete-window)
        (select-window reshell-last-window)
        ))
  (switch-to-buffer reshell-last-buffer))

(provide 'reshell)
