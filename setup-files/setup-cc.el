(use-package ccls
  :hook ((c-mode c++-mode) .
         (lambda () (require 'ccls) (lsp)))
  :config
  (setq indent-tabs-mode nil)
  (setq c-basic-offset 4)
  (setq tab-width 4)
  (setq company-transformers nil company-lsp-async t company-lsp-cache-candidates nil)
  (setq ccls-sem-highlight-method 'font-lock))

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
