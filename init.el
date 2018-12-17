(setq user-full-name "Zaid Alshathry")
(setq user-mail-address "zmzshathry@gmail.com")

;; set home and emacs directories
(defvar user-home-directory (concat (getenv "HOME") "/"))
(setq user-emacs-directory (concat user-home-directory ".emacs.d/"))
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

;; Set My-prefix
(setq my-prefix "C-c ")

; load directory for configuration files for emacs
(add-to-list 'load-path (concat user-emacs-directory "setup-files/"))

(require 'setup-key-binding-tools)
(require 'setup-ivy)
(require 'setup-projectile)
(require 'setup-buffers)
(require 'setup-files)
(require 'setup-windows)
(require 'setup-search)
(require 'setup-magit)
(require 'setup-treemacs)
(require 'setup-flycheck)
(require 'setup-yasnippet)
(require 'setup-company)
(require 'setup-lsp)
(require 'setup-editing-tools)
(require 'setup-cc)
(require 'setup-golang)
(require 'setup-org)
(require 'setup-non-programming-langs-modes)
(require 'setup-theme)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
;; Ask "y" or "n" instead of "yes" or "no". Yes, laziness is great.
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight corresponding parentheses when cursor is on one
(show-paren-mode t)

;; Highlight currentline
(global-hl-line-mode 1)

;; Set locale to UTF-8
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(set-face-attribute 'default nil :font "Monaco" :height 120)

;; Use spaces for indentations
(setq-default indent-tabs-mode nil)

;; Set default indentation size
(setq-default tab-width 4)

;; In UNIX every file ends with newline
(setq-default require-final-newline t)

(global-display-line-numbers-mode)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (go-snippets spinner clang-format ccls rg lsp-mode modern-cpp-font-lock cmake-font-lock yasnippet-snippets yaml-mode which-key use-package undo-tree treemacs-projectile systemd smooth-scrolling smex smartparens popwin org-bullets multiple-cursors magit lsp-ui doom-themes doom-modeline dimmer dashboard cquery counsel-projectile company-lsp company-go ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
