(use-package smartparens
  :diminish smartparens-mode
  :ensure t
  :config
  (smartparens-global-mode t))

;; Multiple-cursors
(use-package multiple-cursors
  :ensure t
  :bind
  ("C-c m e" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c m a" . mc/mark-all-like-this))

;; undo-tree
(use-package undo-tree
  :diminish undo-tree-mode
  :ensure t
  :bind ("C-x u" . undo-tree-visualize)
  :init (global-undo-tree-mode)
  :config
  (setq undo-tree-visualizer-timestamps t
        undo-tree-visualizer-diff t))


(provide 'setup-editing)

