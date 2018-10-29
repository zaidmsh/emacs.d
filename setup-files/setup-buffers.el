;; Use ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)


;; buffers command keymap
(setq my-buffer-prefix (concat my-prefix "b"))
;; Bind window commands
(bind-keys :map global-map
           :prefix-map my-buffer-map
           :prefix my-buffer-prefix
           ("k" . kill-buffer-and-window)
           ("n" . next-buffer)
           ("p" . previous-buffer))

(which-key-add-key-based-replacements
  my-buffer-prefix "buffer"
  (concat my-buffer-prefix "D") "kill-buffer-and-window"
  (concat my-buffer-prefix "n") "next-buffer"
  (concat my-buffer-prefix "p") "previous-buffer")

(provide 'setup-buffers)
