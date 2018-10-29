;; bring up help for key bindings
(use-package which-key
  :ensure t
  :config
  (setq which-key-enable-extended-define-key t)
  (which-key-mode))

(provide 'setup-which-key)
