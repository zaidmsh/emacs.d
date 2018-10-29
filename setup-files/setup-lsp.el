;; lsp-mode:  Emacs client/library for the Language Server Protocol
;; https://github.com/emacs-lsp/lsp-mode
(use-package lsp-mode
  :config
  (if system-type 'darwin
    (add-to-list 'lsp-project-blacklist "^/Users/zaid/Library/Caches/Homebrew/emacs--git/$"))
  
  (add-to-list 'lsp-project-blacklist "^/Users/zaid/\\.emacs\\.d/$"))

;; company-lsp: Company completion backend for lsp-mode.
;; https://github.com/tigersoldier/company-lsp/
(use-package company-lsp
  :config
  (push 'company-lsp company-backends))

;; lsp-ui: This contains all the higher level UI modules of lsp-mode, like flycheck support and code lenses.
;; https://github.com/emacs-lsp/lsp-ui
(use-package lsp-ui
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (setq lsp-ui-sideline-enable nil
        lsp-ui-doc-enable t
        lsp-ui-flycheck-enable t
        lsp-ui-imenu-enable t
        lsp-ui-sideline-ignore-duplicate t))

(provide 'setup-lsp)
