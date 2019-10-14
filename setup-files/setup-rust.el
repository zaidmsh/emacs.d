;; Rust Programming Language
(use-package rust-mode
  :commands rust-mode
  :mode ("\\.rs?\\'" . rust-mode)
  :init
  (add-hook 'rust-mode-hook #'lsp)
  :hook (cargo-minor-mode)
  :defer t)

(use-package cargo
  :ensure t)

(provide 'setup-rust)
