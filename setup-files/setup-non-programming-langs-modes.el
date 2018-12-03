;; Yaml
(use-package yaml-mode
  :ensure t
  :mode "\\.yaml"
  :bind (:map yaml-mode-map
              ("<return>" . newline-and-indent)))

;; Markdown
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md'" . gfm-mode)
         ("\\.md'" . markdown-mode)
         ("\\.markdown'" . markdown-mode)))

;; systemd mode
(use-package systemd
  :ensure t
  :config
  :mode (("\\.service" . systemd-mode)
         ("\\.timer" . systemd-mode)
         ("\\.path" . systemd-mode)
         ("\\.target" . system-mode)))


(provide 'setup-non-programming-langs-modes)
