;; Rust Programming Language
(use-package rust-mode
  :commands rust-mode
  :mode ("\\.rs?\\'" . rust-mode)
  :init
  (add-hook 'rust-mode-hook #'lsp)
  :hook (cargo-minor-mode)
  :defer t
  :config
  (add-hook 'before-save-hook 'lsp-format-buffer))

(use-package cargo
  :ensure t)

(provide 'setup-rust)
