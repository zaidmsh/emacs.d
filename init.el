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
  (ivy-mode))

;; Counsel
(use-package counsel
  :ensure t)

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
(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))
;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ivy zenburn-theme zenburn-them smartparens org-bullets which-key use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
