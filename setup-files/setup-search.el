;; ripgrep
(use-package rg
  :ensure t
  )

;; ag for searching in code files
(use-package ag
  :ensure t
  :config
  (add-hook 'ag-mode-hook 'toggle-truncate-lines)
  (setq ag-highlight-search t)
  (setq ag-reuse-buffers 't))

;; search command keymap
(setq my-search-prefix (concat my-prefix "s"))
;; Bind search commands
(bind-keys :map global-map
           :prefix-map my-search-map
           :prefix my-search-prefix
           ("s" . swiper)
           ("a" . counsel-ag)
           ("r" . counsel-rg))
(which-key-add-key-based-replacements
  my-search-prefix "search")

(provide 'setup-search)
