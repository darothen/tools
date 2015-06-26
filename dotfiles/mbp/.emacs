(set-keyboard-coding-system nil)
(global-font-lock-mode t)

;; Add default Fortran90/95 highlighting
(setq auto-mode-alist
      (append
       '(("\\.F90" . f90-mode))
       auto-mode-alist)
)

;; Add some Org mode and Remember stuff
;;(add-to-list 'load-path "~/elisp/remember-1.9")                                  ;; (1)
;;   (require 'remember-autoloads)
;   (require 'remember)
;   (setq org-remember-templates
;      '(("Tasks" ?t "* TODO %?\n  %i\n  %a" "~/org/organizer.org")                      ;; (2)
;        ("Appointments" ?a "* Appointment: %?\n%^T\n%i\n  %a" "~/org/organizer.org")))
;   (setq remember-annotation-functions '(org-remember-annotation))
;   (setq remember-handler-functions '(org-remember-handler))
;   (eval-after-load 'remember
;     '(add-hook 'remember-mode-hook 'org-remember-apply-template))
;   (global-set-key (kbd "C-c r") 'remember)                                         ;; (3)

;   (require 'org)
;   (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))                           ;; (4)
;   (global-set-key (kbd "C-c a") 'org-agenda)                                       ;; (5)
;   (setq org-todo-keywords '("TODO" "STARTED" "WAITING" "DONE"))                    ;; (6)
;   (setq org-agenda-include-diary t)                                                ;; (7)
;   (setq org-agenda-include-all-todo t)                                             ;; (8)

;; Add Marmalade archive
;(add-to-list 'package-archives
;	     '("marmalade" . "http://marmalade-repo.org/packages/"))