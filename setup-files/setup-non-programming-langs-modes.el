;; Yaml
(use-package yaml-mode
  :ensure t
  :mode ("\\.yaml" . yaml-mode))

;; Markdown
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md'" . gfm-mode)
         ("\\.md'" . markdown-mode)
         ("\\.markdown'" . markdown-mode)))


;; systemd mode
(use-package systemd
  :ensure t)
  ;; :mode
  ;; ("\\.service\\'" "\\.timer\\'" "\\.target\\'" "\\.mount\\'"
  ;;  "\\.automount\\'" "\\.slice\\'" "\\.socket\\'" "\\.path\\'"
  ;;  "\\.netdev\\'" "\\.network\\'" "\\.link\\'"))

;; Protocol Buffer
(use-package protobuf-mode
  :ensure t
  :mode ("\\.proto" . protobuf-mode))

(provide 'setup-non-programming-langs-modes)
