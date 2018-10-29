;; Add padding to window edges
(set-fringe-mode 3)

(use-package ace-window
  :ensure t)

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
(setq my-window-prefix (concat my-prefix "w"))
;; Bind window commands
(bind-keys :map global-map
           :prefix-map my-window-map
           :prefix my-window-prefix
           ("f n" . make-frame)
           ("f d" . delete-frame)
           ("f D" . delete-other-frames)
           ("f o" . other-frame)
           ("s" . split-window-below)
           ("v" . split-window-right)
           ("S" . my/split-window-below-and-move)
           ("V" . my/split-window-right-and-move)
           ("d" . delete-window)
           ("D" . ace-delete-window)
           ("o" . ace-window)
           ("M" . ace-swap-window)
           ("h" . windmove-left)
           ("j" . windmove-down)
           ("k" . windmove-up)
           ("l" . windmove-right))

(which-key-add-key-based-replacements
  my-window-prefix "windows"
  (concat my-window-prefix "S") "split-window-below-and-move"
  (concat my-window-prefix "V") "split-window-right-and-move"
  (concat my-window-prefix "d") "delete-current-window"
  (concat my-window-prefix "D") "delete-window"
  (concat my-window-prefix "o") "other-window"
  (concat my-window-prefix "M") "swap-window")

(provide 'setup-windows)
