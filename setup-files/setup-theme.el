;; Dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))

(use-package telephone-line
  :ensure t
  :config
  (setq telephone-line-lhs
        '((evil   . (telephone-line-evil-tag-segment))
          (accent . (telephone-line-vc-segment
                     telephone-line-erc-modified-channels-segment
                     telephone-line-process-segment))
          (nil    . (telephone-line-minor-mode-segment
                     telephone-line-buffer-segment))))
  (setq telephone-line-rhs
        '((nil    . (telephone-line-misc-info-segment))
          (accent . (telephone-line-major-mode-segment))
          (evil   . (telephone-line-airline-position-segment))))
  (telephone-line-mode 1))


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
