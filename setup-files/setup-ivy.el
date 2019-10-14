;; ivy
(use-package ivy
  :ensure t
  :defer t
  :bind (("C-s" . swiper))
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (ivy-mode 1))

(use-package counsel
  :ensure t
  :bind
  ("M-x" . counsel-M-x)
  ("C-x C-f" . counsel-find-file)
  ("C-c C-r" . ivy-resume)
  ("<f1> f" . counsel-describe-function)
  ("<f1> v" . counsel-describe-variable)
  ("<f1> l" . counsel-find-library)
  ("<f1> i" . counsel-info-lookup-symbol)
  ("<f1> u" . counsel-unicode-char)
  ("M-y" . counsel-yank-pop)
  ("C-c i" . counsel-imenu))

(use-package ivy-xref
  :ensure t
  :init (setq xref-show-xrefs-function #'ivy-xref-show-xrefs))

(use-package smex
  :ensure t
  :config
  (setq smex-history-length 10))

(provide 'setup-ivy)
