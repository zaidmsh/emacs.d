(use-package c-mode
  :interpreter "C"
  :bind (:map c-mode-base-map
         ("C-x c" . compile))
  :hook (c-mode-common . (lambda ()
                            (c-set-style "linux")
                            (setq tab-width 4)
                            (setq c-base-offset 4))))

(use-package c++-mode
  :interpreter "C++"
  :bind (:map c++-mode-base-map
         ("C-x c" . compile))
  :hook (c++-mode-common . (lambda ()
                            (setq tab-width 4)
                            (setq c-base-offset 4))))

(use-package ccls
  :custom
  (ccls-executable "/root/.local/usr/bin/ccls")
  (ccls-sem-highlight-method 'font-lock)
  :config
  :hook ((c-mode c++-mode) .
         (lambda () (require 'ccls) (lsp))))

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
