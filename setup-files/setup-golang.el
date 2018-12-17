;; Golang
(use-package go-mode
  :ensure t
  :config
  (add-hook 'before-save #'gofmt-before-save))

(use-package company-go
    :ensure t
    :config
    :hook (go-mode . (lambda ()
                            (add-to-list 'company-backends 'company-go))))

(use-package go-eldoc
  :ensure t)

(use-package go-snippets
  :ensure t)

(provide 'setup-golang)
