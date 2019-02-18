(use-package ace-window
  :ensure t
  :bind
  ("C-x o" . ace-window))

(defun my/split-window-right-and-move()
  "Split window to the right and move to it"
  (interactive)
  (split-window-right)
  (windmove-right))

(defun my/split-window-below-and-move()
  "Split window to the below and move to it"
  (interactive)
  (split-window-below)
  (windmove-down))

;; windows command keymap
(bind-keys ("C-x 4 2" . my/split-window-below-and-move)
           ("C-x 4 3" . my/split-window-right-and-move))

(use-package popwin
  :ensure t
  :bind ("C-h e" . popwin:messages)
  :bind-keymap ("C-z" . popwin:keymap)
  :config
  (push '("*Help*" :noselect nil) popwin:special-display-config)
  (push '("*Apropos*" :noselect nil) popwin:special-display-config)
  (push '("*Macroexpansion*" :noselect nil :stick t :dedicated t) popwin:special-display-config)
  (popwin-mode 1))

(provide 'setup-windows)
