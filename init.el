(setq user-full-name "Zaid Alshathry")
(setq user-mail-address "zmzshathry@gmail.com")

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
;; Ask "y" or "n" instead of "yes" or "no". Yes, laziness is great.
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight corresponding parentheses when cursor is on one
(show-paren-mode t)

;; Highlight currentline
(global-hl-line-mode 1)

;; Set locale to UTF8
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Use spaces for indentations
(setq-default indent-tabs-mode nil)

;; Set default indentation size
(setq-default tab-width 4)

;; In UNIX every file ends with newline
(setq-default require-final-newline t)

;; Add padding to window edges
(set-fringe-mode 3)

;; Initialize package
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

;; use-package
(unless (package-installed-p 'use-package)
  (progn
    (package-refresh-contents)
    (package-install 'use-package)))

(require 'use-package)

;; Dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

;; bring up help for key bindings
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Org-bullets
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; Ido
(setq ido-everywhere t)
(ido-mode)

;; helm
(use-package helm
  :bind
  ("M-x" . helm-M-x)
  ("C-x C-f" . helm-find-files)
  :config
  (helm-autoresize-mode))

;; Smartparens ()
(use-package smartparens
  :ensure t
  :config
  (smartparens-mode))

;; Company
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.3
        company-minimum-prefix-length 3
        company-dabbrev-downcase nil)
  (global-company-mode))

;; Solarized-theme
(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-dark t))

;; Golang
(use-package go-mode
  :ensure t
  :config
  (add-hook 'before-save-hook
            (lambda ()
              (when (string= major-mode "go-mode")
                (gofmt-before-save)))))

(use-package company-go
  :ensure t
  :config
  (add-hook 'go-mode-hook
            (lambda ()
              (add-to-list 'company-backends 'company-go))))

;; Dimmer: visually highlight the selected window
(use-package dimmer
  :ensure t
  :config
  (setq dimmer-fraction 0.20)
  (dimmer-mode))

(use-package smooth-scroll
  :ensure t
  :config
  (smooth-scroll-mode))

;; Dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

;; Multiple-cursors
(use-package multiple-cursors
  :ensure t
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C-<" . mc/mark-all-like-this))
  

;; Ace window
(use-package ace-window
  :ensure t
  :config
  (setq aw-dispatch-always t)
  (defvar aw-dispatch-alist
  '((?x aw-delete-window "Delete Window")
	(?m aw-swap-window "Swap Windows")
	(?M aw-move-window "Move Window")
	(?j aw-switch-buffer-in-window "Select Buffer")
	(?n aw-flip-window)
	(?u aw-switch-buffer-other-window "Switch Buffer Other Window")
	(?c aw-split-window-fair "Split Fair Window")
	(?v aw-split-window-vert "Split Vert Window")
	(?h aw-split-window-horz "Split Horz Window")
	(?o delete-other-windows "Delete Other Windows")
	(?? aw-show-dispatch-help))
  "List of actions for `aw-dispatch-default'.")
  (global-set-key (kbd "C-c w") 'ace-window))


;; (which-key-add-key-based-replacements "C-c f" "file")
;; (progn
;;   ;; define a prefix keymap
;;   (define-prefix-command 'my-window-map)
;;   (define-key my-window-map (kbd "d") 'delete-window)
;;   )

;; (global-set-key (kbd "C-c w") my-window-map)
