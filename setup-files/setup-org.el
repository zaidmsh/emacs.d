;; Org-bullets
(use-package org-bullets
  :ensure t
  :hook (org-mode-hook . org-bullets-mode)
  :config
  (setq org-hide-leading-stars t))

(provide 'setup-org)
