;; Window Configurations

(use-package winner
  :init (winner-mode))

(defun my-scroll-other-window()
  (interactive)
  (scroll-other-window 1))
(defun my-scroll-other-window-down ()
  (interactive)
  (scroll-other-window-down 1))

(use-package ace-window
  :ensure t
  :defer 1
  :bind ("M-o" . ace-window)
  :config
  (set-face-attribute
   'aw-leading-char-face nil
   :foreground "deep sky blue"
   :weight 'bold
   :height 3.0)
  (set-face-attribute
   'aw-mode-line-face nil
   :inherit 'mode-line-buffer-id
   :foreground "lawn green")
  (setq aw-dispatch-always t
        aw-dispatch-alist
        '((?x aw-delete-window "Ace - Delete Window")
          (?c aw-swap-window "Ace - Swap Window")
          (?n aw-flip-window)
          (?v aw-split-window-vert "Ace - Split Vert Window")
          (?h aw-split-window-horz "Ace - Split Horz Window")
          (?m delete-other-windows "Ace - Maximize Window")
          (?g delete-other-windows)
          (?b balance-windows)
          (?u (lambda ()
                (progn
                  (winner-undo)
                  (setq this-command 'winner-undo))))
          (?r winner-redo)))

  (when (package-installed-p 'hydra)
    (defhydra hydra-window-size (:color red)
      "Windows size"
      ("h" shrink-window-horizontally "shrink horizontal")
      ("j" shrink-window "shrink vertical")
      ("k" enlarge-window "enlarge vertical")
      ("l" enlarge-window-horizontally "enlarge horizontal"))
    (defhydra hydra-window-frame (:color red)
      "Frame"
      ("f" make-frame "new frame")
      ("x" delete-frame "delete frame"))
    (defhydra hydra-window-scroll (:color red)
      "Scroll other window"
      ("n" my-scroll-other-window "scroll")
      ("p" my-scroll-other-window-down "scroll down"))
    (add-to-list 'aw-dispatch-alist '(?w hydra-window-size/body) t)
    (add-to-list 'aw-dispatch-alist '(?s hydra-window-scroll/body) t)
    (add-to-list 'aw-dispatch-alist '(?\; hydra-window-frame/body) t))
  (ace-window-display-mode t))

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
