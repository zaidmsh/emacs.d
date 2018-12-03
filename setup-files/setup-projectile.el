;; Projectile
(use-package projectile
  :ensure t
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :config
  (projectile-global-mode)
  (setq projectile-mode-line
        '(:eval (format " [%s]" (projectile-project-name)))
        projectile-remember-window-configs t
        projectile-completion-system 'ivy
        projectile-file-exists-remote-cache-expire nil)
  (projectile-load-known-projects))

;; projectile command keymap
(setq my-project-prefix (concat my-prefix "p"))

(which-key-add-key-based-replacements
  my-project-prefix "project")

(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-mode))

(provide 'setup-projectile)
