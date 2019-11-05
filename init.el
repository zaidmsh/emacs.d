(setq user-full-name "Zaid Alshathry")
(setq user-mail-address "zmzshathry@gmail.com")

;; set home and emacs directories
(defvar user-home-directory (concat (getenv "HOME") "/"))
(setq user-emacs-directory (concat user-home-directory ".emacs.d/"))
;; Initialize package
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

;; use-package
(unless (package-installed-p 'use-package)
  (progn
    (package-refresh-contents)
    (package-install 'use-package)))

(require 'use-package)

(use-package dired
  :config
  (when (string= system-type "darwin")
    (setq dired-use-ls-dired nil)))

(global-set-key (kbd "C-x C-b") 'ibuffer)

;; load directory for configuration files for emacs
(add-to-list 'load-path (concat user-emacs-directory "setup-files/"))

(require 'setup-environment)
(require 'setup-key-binding-tools)
(require 'setup-ivy)
(require 'setup-projectile)
(require 'setup-windows)
(require 'setup-search)
(require 'setup-magit)
(require 'setup-treemacs)
(require 'setup-flycheck)
(require 'setup-yasnippet)
(require 'setup-company)
(require 'setup-eldoc)
(require 'setup-lsp)
(require 'setup-editing)
(require 'setup-cc)
(require 'setup-golang)
(require 'setup-python)
(require 'setup-rust)
(require 'setup-org)
(require 'setup-non-programming-langs-modes)
(require 'setup-theme)
