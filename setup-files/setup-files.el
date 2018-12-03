;; file commands keymap
(setq my-file-prefix (concat my-prefix "f"))
;; Bind file commands
(bind-keys :map global-map
           :prefix-map my-file-map
           :prefix my-file-prefix
           ("c" . copy-file)
           ("s" . save-buffer))
(which-key-add-key-based-replacements
  my-file-prefix "file")

(provide 'setup-files)
