;; ivy
(use-package ivy
  :diminish ivy-mode
  :ensure t
  :defer t
  :bind (("C-s" . swiper))
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (ivy-mode t)

  (use-package counsel
    :ensure t
    :bind
    ("M-x" . counsel-M-x)
    ("M-s r" . counsel-rg)
    ("M-s a" . counsel-ag)
    ("C-x C-f" . counsel-find-file)
    ("C-x C-r" . ivy-resume)
    ("C-h a" . counsel-apropos)
    ("C-h f" . counsel-describe-function)
    ("C-h v" . counsel-describe-variable)
    ("C-h l" . counsel-find-library)
    ("C-h i" . counsel-info-lookup-symbol)
    ("C-h u" . counsel-unicode-char)
    ("M-y" . counsel-yank-pop)
    ("C-c C-i" . counsel-imenu))
  (use-package ivy-rich
    :ensure t
    :config
    (ivy-rich-mode t))

  (use-package ivy-xref
    :ensure t
    :init (setq xref-show-xrefs-function #'ivy-xref-show-xrefs))

  (use-package smex
    :ensure t
    :config
    (setq smex-history-length 10)))



(provide 'setup-ivy)
