
;; hydra: tie related commands into a family of short bindings with a common
;; prefix - a Hydra
;; https://github.com/abo-abo/hydra
(use-package hydra
  :ensure t
  :config (hydra-add-font-lock))

;; bring up help for key bindings
(use-package which-key
  :diminish which-key-mode
  :ensure t
  :config
  (setq which-key-enable-extended-define-key t)
  (which-key-mode)
  )

(provide 'setup-key-binding-tools)
