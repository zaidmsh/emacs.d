;; Org-bullets
(use-package org-bullets
  :ensure t)

(use-package org-mode
  :hook (org-mode . org-bullets-mode))

(provide 'setup-org)
