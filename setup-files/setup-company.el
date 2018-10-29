(use-package company
  :ensure t
  :bind
  (("M-/" . hippie-expand-expand) ;; replace `dabbrev-expand' with `hippie-expand' which does a lot more
   ("C-<tab>" . company-dabbrev))
  (:map company-active-map
        ("M-p" . nil)
        ("M-n" . nil)
        ("C-m" . nil)
        ("C-h" . nil)
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous)
        ("<tab>" . company-complete-common)
        ("C-t" . company-show-doc-buffer))

  :config
  (setq company-tooltip-flip-when-above t)
  (setq company-minimum-prefix-length 3)
  (setq company-idle-delay 0.2)
  (setq company-selection-wrap-around t)
  (setq company-show-numbers t)
  (setq company-require-match 'never)
  (setq company-tooltip-align-annotations t)

  ;; don't downcase results from company-dabbrev
  (setq company-dabbrev-downcase nil)
  ;; use only buffers with same major-mode for company-dabbrev
  (setq company-dabbrev-other-buffers t)
  (global-company-mode))

(provide 'setup-company)
