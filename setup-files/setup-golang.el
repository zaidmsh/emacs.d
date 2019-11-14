;; Golang
(use-package go-mode
  :commands go-mode
  :mode (("\\.go?\\'" . go-mode))
  :defer t
  :hook (lsp-format-buffer)
  :config
  (setq indent-tabs-mode nil)
  (setq c-basic-offset 4)
  (setq tab-width 4))

;; (use-package company-go
;;     :ensure t
;;     :config
;;     :hook (go-mode . (lambda ()
;;                             (add-to-list 'company-backends 'company-go))))

;; (use-package go-eldoc
;;   :ensure t)

;; (use-package go-snippets
;;   :ensure t)

(provide 'setup-golang)
