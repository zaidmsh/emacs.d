; adds font-lock highlighting for modern C++ upto C++17
;;https : // github.com/ludwigpacifici/modern-cpp-font-lock
(use-package modern-cpp-font-lock
     :ensure t
     :hook(c++-mode . modern-c++-font-lock-mode))

; ccls: Emacs client for ccls, a C/C++ language server
; https://github.com/MaskRay/emacs-ccls

(use-package ccls
  :ensure t
  :init
  (setq ccls-executable (executable-find "ccls"))
  :config
  (setq ccls-initialization-options '(:index (:comments 2) :completion (:detailedLabel t)))
  (setq ccls-sem-highlight-method 'font-lock)
  (with-eval-after-load 'projectile
    (add-to-list 'projectile-globally-ignored-directories ".ccls-cache"))

  (defun ccls/callee () (interactive) (lsp-ui-peek-find-custom "$ccls/call" '(:callee t)))
  (defun ccls/caller () (interactive) (lsp-ui-peek-find-custom "$ccls/call"))
  (defun ccls/vars (kind) (lsp-ui-peek-find-custom "$ccls/vars" `(:kind ,kind)))
  (defun ccls/base (levels) (lsp-ui-peek-find-custom "$ccls/inheritance" `(:levels ,levels)))
  (defun ccls/derived (levels) (lsp-ui-peek-find-custom "$ccls/inheritance" `(:levels ,levels :derived t)))
  (defun ccls/member (kind) (interactive) (lsp-ui-peek-find-custom "$ccls/member" `(:kind ,kind)))

  ;; (lsp-ui-peek-find-references nil (list :folders (vector (projectile-project-root))))
  (setq company-transformers nil company-lsp-async t company-lsp-cache-candidates nil))

(use-package clang-format
  :ensure t
  :config
  (setq clang-format-style "LLVM"))

(defun ccls-enable ()
  (when buffer-file-name
    (require 'ccls)
      (lsp)))

(use-package cc-mode
  :hook ((c-mode c++-mode) . ccls-enable)
  :init 
  (setq c-basic-offset 4))

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

(provide 'setup-cc)

