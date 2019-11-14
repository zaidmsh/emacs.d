(setq user-full-name "Zaid Alshathry")
(setq user-mail-address "zmzshathry@gmail.com")

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin:$HOME/.cargo/bin/"))
(setq exec-path (append exec-path '("/usr/local/bin" "$HOME/.cargo/bin")))

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
    (setq dired-use-ls-dired nil))
  (setq dired-listing-switches "-alh"
        dired-recursive-deletes 'always))

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-lsp-async t)
 '(company-lsp-cache-candidates t)
 '(company-lsp-enable-recompletion t)
 '(company-lsp-enable-snippet t)
 '(lsp-auto-guess-root t)
 '(lsp-document-sync-method (quote incremental))
 '(lsp-log-io nil)
 '(lsp-prefer-flymake nil)
 '(lsp-print-io nil)
 '(lsp-print-performance nil)
 '(lsp-response-timeout 10)
 '(lsp-trace nil t)
 '(lsp-ui-doc-enable nil t)
 '(lsp-ui-doc-header t t)
 '(lsp-ui-doc-include-signature nil t)
 '(lsp-ui-doc-max-height 30 t)
 '(lsp-ui-doc-max-width 120 t)
 '(lsp-ui-doc-position (quote at-point) t)
 '(lsp-ui-doc-use-childframe t t)
 '(lsp-ui-flycheck-enable t t)
 '(lsp-ui-imenu-enable t t)
 '(lsp-ui-imenu-kind-position (quote top) t)
 '(lsp-ui-peek-enable t t)
 '(lsp-ui-peek-fontify (quote on-demand) t)
 '(lsp-ui-peek-list-width 50 t)
 '(lsp-ui-peek-peek-height 20 t)
 '(lsp-ui-sideline-enable nil t)
 '(lsp-ui-sideline-ignore-duplicate t t)
 '(lsp-ui-sideline-show-code-actions nil t)
 '(lsp-ui-sideline-show-diagnostics nil t)
 '(lsp-ui-sideline-show-hover t t)
 '(lsp-ui-sideline-show-symbol t t)
 '(package-selected-packages
   (quote
    (lsp-ivy lsp-mode lua-mode zenburn-theme yasnippet-snippets yaml-mode xcscope which-key use-package undo-tree uncrustify-mode treemacs-projectile systemd smooth-scrolling smex smartparens rg python-mode protobuf-mode popwin org-bullets multiple-cursors magit lsp-ui lsp-treemacs lsp-p4 ivy-xref ivy-rich helm-lsp go-mode flycheck eldoc-eval doom-themes doom-modeline dimmer diminish dashboard dap-mode counsel-projectile company-lsp company-box cmake-project cmake-font-lock ccls cargo ag)))
 '(when t t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
