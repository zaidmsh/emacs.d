;; Python
(use-package python-mode
  :ensure t
  :commands python-mode
  :init
  (add-hook 'python-mode-hook #'lsp)
  :defer t
  :config
  (setq indent-tabs-mode 1)
  (setq c-basic-offset 4)
  (setq tab-width 4)
  ;;(add-hook 'before-save-hook 'lsp-format-buffer)
  )

(provide 'setup-python)
