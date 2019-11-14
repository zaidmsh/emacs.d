(use-package cc-mode
  :bind (:map c-mode-base-map
              ("C-x c" . compile))
  :hook ((c-mode-common c++-mode-common) . (lambda ()
                                             (setq-default c-basic-offset 4
                                                           tab-width 4
                                                           indent-tabs-mode nil)))

  :config
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-tramp-connection
                                     "clangd")
                    :major-modes '(c-mode c++-mode)
                    :remote? t
                    :server-id 'clangd-remote)))

;; cmake-font-lock: emacs font lock rules for CMake
;; https://github.com/Lindydancer/cmake-font-lock
(use-package cmake-font-lock
  :ensure t
  :config
  (autoload 'cmake-font-lock-activate "cmake-font-lock" nil t)
  (add-hook 'cmake-mode-hook 'cmake-font-lock-activate))

(use-package cmake-mode
  :mode (("CMakeLists\\.txt" . cmake-mode)
         ("\\.cmake" . cmake-mode)))

(use-package company-cmake
  :requires company cmake-mode
  :config
  (push 'company-cmake company-backends))


(use-package uncrustify-mode
  :ensure t)

(provide 'setup-cc)
