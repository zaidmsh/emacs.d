;; lsp-mode:  Emacs client/library for the Language Server Protocol
;; https://github.com/emacs-lsp/lsp-mode
(use-package lsp-mode
  :ensure t
  :hook ((sh-mode go-mode c-mode c++-mode python-mode rust-mode yaml-mode) . lsp-deferred)
  :commands (lsp lsp-deferred)
  :config
  (require 'lsp-clients)
  ;; lsp-ivy
  (use-package helm-lsp
    :ensure t
    :bind ("C-c f" . helm-lsp-workspace-symbol))
  ;; lsp-ui
  (use-package lsp-ui
    :ensure t
    :hook (lsp-mode . lsp-ui-mode)
    :custom
    ;; debug
    (lsp-print-io nil)
    (lsp-trace nil)
    (lsp-print-performance nil)
    ;; general
    (lsp-auto-guess-root t)
    (lsp-document-sync-method 'incremental) ;; none, full, incremental, or nil
    (lsp-response-timeout 10)
    (lsp-prefer-flymake nil) ;; t(flymake), nil(lsp-ui), or :none
    ;; lsp-ui-doc
    (lsp-ui-doc-enable nil)
    (lsp-ui-doc-header t)
    (lsp-ui-doc-include-signature nil)
    (lsp-ui-doc-position 'at-point) ;; top, bottom, or at-point
    (lsp-ui-doc-max-width 120)
    (lsp-ui-doc-max-height 30)
    (lsp-ui-doc-use-childframe t)
    (when (display-graphic-p)
      (lsp-ui-doc-use-webkit t))
    ;; lsp-ui-flycheck
    (lsp-ui-flycheck-enable t)
    ;; lsp-ui-sideline
    (lsp-ui-sideline-enable nil)
    (lsp-ui-sideline-ignore-duplicate t)
    (lsp-ui-sideline-show-symbol t)
    (lsp-ui-sideline-show-hover t)
    (lsp-ui-sideline-show-diagnostics nil)
    (lsp-ui-sideline-show-code-actions nil)
    ;; lsp-ui-imenu
    (lsp-ui-imenu-enable t)
    (lsp-ui-imenu-kind-position 'top)
    ;; lsp-ui-peek
    (lsp-ui-peek-enable t)
    (lsp-ui-peek-peek-height 20)
    (lsp-ui-peek-list-width 50)
    (lsp-ui-peek-fontify 'on-demand) ;; never, on-demand, or always
    :preface
    (defun my/toggle-lsp-ui-doc ()
      (interactive)
      (if lsp-ui-doc-mode
          (progn
            (lsp-ui-doc-mode -1)
            (lsp-ui-doc--hide-frame))
        (lsp-ui-doc-mode 1)))
    :bind
    ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
    ([remap xref-find-references] . lsp-ui-peek-find-references)
    (:map lsp-mode-map
          ("C-c i"   . lsp-ui-peek-find-implementation)
          ("C-c s"   . lsp-ui-sideline-mode)
          ("C-c d"   . my/toggle-lsp-ui-doc)))
    

    ;; company-lsp
    (use-package company-lsp
      :custom
      (company-lsp-cache-candidates t) ;; auto, t(always using a cache), or nil
      (company-lsp-async t)
      (company-lsp-enable-snippet t)
      (company-lsp-enable-recompletion t)))

(use-package lsp-treemacs
  :ensure t
  :commands
  (lsp-treemacs-errors-list))

(use-package dap-mode
  :ensure t
  :config
  (dap-mode 1)
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  (require 'dap-gdb-lldb)
  (require 'dap-go))

(provide 'setup-lsp)
