(set-keyboard-coding-system nil)
(global-font-lock-mode t)

;; Add default Fortran90/95 highlighting
(setq auto-mode-alist
      (append
       '(("\\.F90" . f90-mode))
       auto-mode-alist)
)

;; ELPA - org-mode package
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(org-agenda-files (quote ("~/org/main.org")))
 '(org-todo-keywords
   (quote
    ((sequence "TODO(t)" "WAITING(w)" "SOMEDAY(s)" "DONE(d)")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
