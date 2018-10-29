;; adds font-lock highlighting for modern C++ upto C++17
;; https://github.com/ludwigpacifici/modern-cpp-font-lock
(use-package modern-cpp-font-lock
  :ensure t
  :hook (c++-mode . modern-c++-font-lock-mode))
;; ccls: Emacs client for ccls, a C/C++ language server
;; https://github.com/MaskRay/emacs-ccls
(use-package ccls
  :commands (lsp-ccls-enable)
  :init
;;;###autoload
  (defvar +ccls-path-mappings [])

;;;###autoload
  (defvar +ccls-initial-blacklist [])
  (setq ccls-executable (executable-find "/Users/zaid/workspace/ccls/Release/ccls"))
  (setq
   ccls-extra-init-params
   `(:clang (:pathMappings ,+ccls-path-mappings)
            :completion
            (:includeBlacklist
             ("^/usr/(local/)?include/c\\+\\+/[0-9\\.]+/(bits|tr1|tr2|profile|ext|debug)/"
              "^/usr/(local/)?include/c\\+\\+/v1/"
              ))
            :index (:initialBlacklist ,+ccls-initial-blacklist :trackDependency 1)))
  :config
  ;; enable ccls semantic highlighting
  (setq ccls-sem-highlight-method 'overlay)

  (with-eval-after-load 'projectile
    (add-to-list 'projectile-globally-ignored-directories ".ccls-cache"))

 ;; https://github.com/MaskRay/Config/blob/master/home/.config/doom/modules/private/my-cc/autoload.el#L10
  (defun ccls/callee ()
    (interactive)
    (lsp-ui-peek-find-custom 'callee "$ccls/call" '(:callee t)))
  (defun ccls/caller ()
    (interactive)
    (lsp-ui-peek-find-custom 'caller "$ccls/call"))
  (defun ccls/vars (kind)
    (lsp-ui-peek-find-custom 'vars "$ccls/vars" `(:kind ,kind)))
  (defun ccls/base (levels)
    (lsp-ui-peek-find-custom 'base "$ccls/inheritance" `(:levels ,levels)))
  (defun ccls/derived (levels)
    (lsp-ui-peek-find-custom 'derived "$ccls/inheritance" `(:levels ,levels :derived t)))
  (defun ccls/member (kind)
    (lsp-ui-peek-find-custom 'member "$ccls/member" `(:kind ,kind)))
  ;; The meaning of :role corresponds to https://github.com/maskray/ccls/blob/master/src/symbol.h

  ;; References w/ Role::Address bit (e.g. variables explicitly being taken addresses)
  (defun ccls/references-address ()
    (interactive)
    (lsp-ui-peek-find-custom
     'address "textDocument/references"
     (plist-put (lsp--text-document-position-params) :context
                '(:role 128))))

  ;; References w/ Role::Dynamic bit (macro expansions)
  (defun ccls/references-macro ()
    (interactive)
    (lsp-ui-peek-find-custom
     'address "textDocument/references"
     (plist-put (lsp--text-document-position-params) :context
                '(:role 64))))

  ;; References w/o Role::Call bit (e.g. where functions are taken addresses)
  (defun ccls/references-not-call ()
    (interactive)
    (lsp-ui-peek-find-custom
     'address "textDocument/references"
     (plist-put (lsp--text-document-position-params) :context
                '(:excludeRole 32))))

  ;; References w/ Role::Read
  (defun ccls/references-read ()
    (interactive)
    (lsp-ui-peek-find-custom
     'read "textDocument/references"
     (plist-put (lsp--text-document-position-params) :context
                '(:role 8))))

  ;; References w/ Role::Write
  (defun ccls/references-write ()
    (interactive)
    (lsp-ui-peek-find-custom
     'write "textDocument/references"
     (plist-put (lsp--text-document-position-params) :context
                '(:role 16)))))

(defun ccls//enable ()
  "Enable lsp-ccls"
  (condition-case nil
      (lsp-ccls-enable)
    (user-error nil)))

(use-package clang-format
  :ensure t)

(use-package cc-mode :ensure nil
  :hook (((c++-mode c-mode) . (lambda ()
                                (ccls//enable)
                                (lsp-ui-mode)
                                (eldoc-mode)
                                (lsp-ui-sideline-mode)
                                (flycheck-mode)
                                ;; (smart-dash-mode)
                                (company-mode))))
  :config
  (add-hook 'before-save-hook
            (lambda ()
              (when (string= major-mode "c++-mode")
                (clang-format-buffer))))
  
  (defun my-cc-common-mode-hook()
    (set (make-local-variable 'company-backends)
         '((company-lsp company-files :with company-yasnippet)
           (company-dabbrev-code company-dabbrev))))
  (add-hook 'c++-mode-hook #'my-cc-common-mode-hook)
  (add-hook 'c-mode-hook #'my-cc-common-mode-hook)

  (add-hook 'c++-mode-hook (lambda ()
                             (setq-local company-transformers nil)
                             (setq-local company-lsp-async t)
                             (setq-local company-lsp-cache-candidates nil)))
  (add-hook 'c-mode-hook (lambda ()
                           (setq-local company-transformers nil)
                           (setq-local company-lsp-async t)
                           (setq-local company-lsp-cache-candidates nil)))

  ;;;###autoload
  (defun +cc|fontify-constants ()
    "Better fontification for preprocessor constants"
    (when (memq major-mode '(c-mode c++-mode))
      (font-lock-add-keywords
       nil '(("\\<[A-Z]*_[A-Z_]+\\>" . font-lock-constant-face)
             ("\\<[A-Z]\\{3,\\}\\>"  . font-lock-constant-face))
       t))))

(provide 'setup-cc)
