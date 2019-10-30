(use-package company
  :diminish company-mode
  :defines
  (company-dabbrev-ignore-case company-dabbrev-downcase)
  :bind
  (:map company-active-map
   ("C-n" . company-select-next)
   ("C-p" . company-select-previous)
   ("<tab>" . company-complete-common-or-cycle)
   :map company-search-map
   ("C-p" . company-select-previous)
   ("C-n" . company-select-next))
  :custom
  (company-idle-delay 0)
  (company-echo-delay 0)
  (company-minimum-prefix-length 1)
  :hook
  (after-init . global-company-mode)
  (plantuml-mode . (lambda () (set (make-local-variable 'company-backends)
                            '((company-yasnippet
                               ;; company-dabbrev
                               )))))
  ((go-mode
    python-mode
    rust-mode
    c++-mode
    c-mode
    objc-mode) . (lambda () (set (make-local-variable 'company-backends)
                            '((company-yasnippet
                               company-lsp
                               company-files
                               ;; company-dabbrev-code
                               ))))))

(provide 'setup-company)
