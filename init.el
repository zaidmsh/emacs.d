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

;; bring up help for key bindings
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Ivy
(use-package ivy
  :ensure t
  :config
  (setq ivy-use-virtual-buffers t
	ivy-count-format "%d/%d ")
  (use-package counsel
    :ensure t)
  (ivy-mode))

;; Smartparens ()
(use-package smartparens
  :ensure t
  :config
  (smartparens-mode))

;; Company
(use-package company
  :ensure t
  :config
  (global-company-mode))

;; Org-bullets
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

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

;; minimap
(use-package minimap
  :ensure t
  :config
  (setq minimap-window-location "right")
  (minimap-mode))

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
  :config
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))

;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (multiple-cursors smooth-scroll minimap dashboard dimmer company-go go-mode solarized-theme ivy zenburn-theme zenburn-them smartparens org-bullets which-key use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
