;; Dashboard
(use-package dashboard
  :diminish t
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t)
  (setq dashboard-banner-logo-title "Welcome Back")
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  (setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5))))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t)
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (doom-themes-visual-bell-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(use-package doom-modeline
  :ensure t
  :config
  :hook (after-init . doom-modeline-mode))

;; ;; Dimmer: visually highlight the selected window
;; (use-package dimmer
;;   :ensure t
;;   :config
;;   (setq dimmer-fraction 0.50)
;;   (dimmer-mode))

(use-package smooth-scrolling
  :ensure t
  :config
  (smooth-scrolling-mode))

;; dash
(use-package dash
  :ensure t
  :defer t)

(provide 'setup-theme)
