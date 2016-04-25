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
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
 (when (< emacs-major-version 24)
   ;; For important compatibility libraries like cl-lib
   (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
 (package-initialize)

;; Org mode customization
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("1e3b2c9e7e84bb886739604eae91a9afbdfb2e269936ec5dd4a9d3b7a943af7f" "5999e12c8070b9090a2a1bbcd02ec28906e150bb2cdce5ace4f965c76cf30476" default)))
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

 ;; Display/aesthetic

 ;; Load theme
 (load-theme 'monokai t)

 ;; Font - Source Code Pro
 (set-default-font " -*-Source Code Pro-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
