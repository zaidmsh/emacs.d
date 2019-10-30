;; ripgrep
(use-package rg
  :ensure t
  :config
  (rg-enable-default-bindings))

;; ag for searching in code files
(use-package ag
  :ensure t
  :config
  (add-hook 'ag-mode-hook 'toggle-truncate-lines)
  (setq ag-highlight-search t)
  (setq ag-reuse-buffers 't))

(provide 'setup-search)
