;; Org-bullets
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda ()
                             (org-bullets-mode 1))))

(provide 'setup-org)
