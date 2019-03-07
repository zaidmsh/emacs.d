(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode t))

;; Multiple-cursors
(use-package multiple-cursors
  :ensure t
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C-<" . mc/mark-all-like-this))

;; undo-tree
(use-package undo-tree
  :ensure t
  :bind ("C-c u" . undo-tree-visualize)
  :init (global-undo-tree-mode)
  :config
  (setq undo-tree-visualizer-timestamps t
        undo-tree-visualizer-diff t))


(provide 'setup-editing-tools)

