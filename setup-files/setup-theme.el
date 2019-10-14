;; Dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

;; Zenburn theme
(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))

;; Dimmer: visually highlight the selected window
(use-package dimmer
  :ensure t
  :config
  (setq dimmer-fraction 0.50)
  (dimmer-mode))

(use-package smooth-scrolling
  :ensure t
  :config
  (smooth-scrolling-mode))

;; dash
(use-package dash
  :ensure t
  :defer t)

(provide 'setup-theme)
