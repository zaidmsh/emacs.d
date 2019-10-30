;;;; magit
(use-package magit
  :ensure t
  :defer t
  :bind (("C-x g s" . magit-status)
         ("C-x g c" . magit-clone)
         ("C-x g b" . magit-branch)
         ("C-x g B" . magit-blame)
         ("C-x g f" . magit-pull)
         ("C-x g l" . magit-log)
         ("C-x g t" . magit-tag)
         ("C-x g p" . magit-push)))

(provide 'setup-magit)
