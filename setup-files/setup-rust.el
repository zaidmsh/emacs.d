;; Rust Programming Language
(use-package rust-mode
  :ensure t
  :commands rust-mode
  :hook (cargo-minor-mode)
  :defer t)

(use-package cargo
  :ensure t)

(provide 'setup-rust)
