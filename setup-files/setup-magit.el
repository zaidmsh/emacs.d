;;;; magit
(use-package magit
  :ensure t
  :defer t
  :bind (("C-c g s" . magit-status)
         ("C-c g c" . magit-clone)
         ("C-c g b" . magit-blame)
         ("C-c g f" . magit-pull)
         ("C-c g p" . magit-push)))

(provide 'setup-magit)
