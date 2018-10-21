(setq user-full-name "Zaid Alshathry")
(setq user-mail-address "zmzshathry@gmail.com")

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
;; Ask "y" or "n" instead of "yes" or "no". Yes, laziness is great.
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight corresponding parentheses when cursor is on one
(show-paren-mode t)

;; Highlight currentline
(global-hl-line-mode 1)

;; Set locale to UTF8
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(set-face-attribute 'default nil :font "Monaco" :height 120)

;; Use spaces for indentations
(setq-default indent-tabs-mode nil)

;; Set default indentation size
(setq-default tab-width 4)

;; In UNIX every file ends with newline
(setq-default require-final-newline t)

;; Add padding to window edges
(set-fringe-mode 3)

;; Set My-prefix
(setq my-prefix "C-c ")

;; Use ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-display-line-numbers-mode)

;; Initialize package
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)

;; use-package
(unless (package-installed-p 'use-package)
  (progn
    (package-refresh-contents)
    (package-install 'use-package)))

(require 'use-package)

;; Dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

;; hydra: tie related commands into a family of short bindings with a common
;; prefix - a Hydra
;; https://github.com/abo-abo/hydra
(use-package hydra
  :config (hydra-add-font-lock))

;; ripgrep
(use-package ripgrep
  :ensure t)

;; ag for searching in code files
(use-package ag
  :ensure t
  :config
  (add-hook 'ag-mode-hook 'toggle-truncate-lines)
  (setq ag-highlight-search t)
  (setq ag-reuse-buffers 't))

;; ivy
(use-package ivy
  :ensure t
  :bind (("C-s" . swiper))
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (ivy-mode 1))

(use-package counsel
  :ensure t
  :bind
  ("M-x" . counsel-M-x)
  ("C-x C-f" . counsel-find-file)
  ("<f6>" . ivy-resume)
  ("<f1> f" . counsel-describe-function)
  ("<f1> v" . counsel-describe-variable)
  ("<f1> l" . counsel-find-library)
  ("<f1> i" . counsel-info-lookup-symbol)
  ("<f1> u" . counsel-unicode-char)
  ("M-y" . counsel-yank-pop)
  ("C-c i" . counsel-imenu))

(use-package smex
  :ensure t
  :config
  (setq smex-history-length 10))

;; projectile command keymap
(setq my-project-prefix (concat my-prefix "p"))

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

(which-key-add-key-based-replacements
  my-project-prefix "project")

(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-mode))

;;treemacs
(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs              (if (executable-find "python") 3 0)
          treemacs-deferred-git-apply-delay   0.5
          treemacs-display-in-side-window     t
          treemacs-file-event-delay           5000
          treemacs-file-follow-delay          0.2
          treemacs-follow-after-init          t
          treemacs-follow-recenter-distance   0.1
          treemacs-goto-tag-strategy          'refetch-index
          treemacs-indentation                2
          treemacs-indentation-string         " "
          treemacs-is-never-other-window      nil
          treemacs-no-png-images              nil
          treemacs-project-follow-cleanup     nil
          treemacs-persist-file               (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-recenter-after-file-follow nil
          treemacs-recenter-after-tag-follow  nil
          treemacs-show-hidden-files          t
          treemacs-silent-filewatch           nil
          treemacs-silent-refresh             nil
          treemacs-sorting                    'alphabetic-desc
          treemacs-space-between-root-nodes   t
          treemacs-tag-follow-cleanup         t
          treemacs-tag-follow-delay           1.5
          treemacs-width                      35)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null (executable-find "python3"))))
      (`(t . t)
       (treemacs-git-mode 'extended))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

;; Company
(use-package company
  :ensure t
  :bind
  (("M-/" . hippie-expand) ;; replace `dabbrev-expand' with `hippie-expand' which does a lot more
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

(use-package flycheck
  :ensure t
  :config
  (flycheck-mode t))


;; a collection of yasnippet snippets for many languages
;; https://github.com/AndreaCrotti/yasnippet-snippets
(use-package yasnippet-snippets
  :ensure t)

(use-package yasnippet
  :commands (yas-minor-mode-on yas-expand yas-expand-snippet yas-lookup-snippet
             yas-insert-snippet yas-new-snippet yas-visit-snippet-file)
  :requires yasnippet-snippets
  :hook ((text-mode prog-mode snippet-mode) . yas-minor-mode-on)
  :init
  ;; Ensure `yas-reload-all' is called as late as possible. Other modules could
  ;; have additional configuration for yasnippet. For example, file-templates.
  ;; (add-transient-hook! 'yas-minor-mode-hook (yas-reload-all))
  :config
  (setq yas-triggers-in-field t) ; Enable nested triggering of snippets
  (setq yas-prompt-functions '(yas-completing-prompt))
  (add-hook 'snippet-mode-hook '(lambda () (setq-local require-final-newline nil)))
  ;; No need to be so verbose
  (setq yas-verbosity 1)
  ;; Wrap around region
  (setq yas-wrap-around-region t)
  ;; Jump to end of snippet definition
  (define-key yas-keymap (kbd "C-j") 'yas-exit-all-snippets)
  ;; yasnippet command keymap
  (bind-key "C-c y"
            (defhydra hydra-yas (:color blue
                                        :hint nil)
              "
_i_nsert    _n_ew       _v_isit     aya _c_reate
_r_eload    e_x_pand    _?_ list    aya _e_xpand
"
              ("i" yas-insert-snippet)
              ("n" yas-new-snippet)
              ("v" yas-visit-snippet-file)
              ("r" yas-reload-all)
              ("x" yas-expand)
              ("c" aya-create)
              ("e" aya-expand)
              ("?" yas-describe-tables)
              ("q" nil "cancel" :color blue))))

;;;; magit
(use-package magit
  :ensure t
  :defer t
  :bind (("C-c g" . magit-status)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; C/C++ ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; lsp-mode:  Emacs client/library for the Language Server Protocol
;; https://github.com/emacs-lsp/lsp-mode
(use-package lsp-mode
  :config
  (setq lsp-rust-rls-command '("rustup" "run" "nightly" "rls"))
  (add-to-list 'lsp-project-blacklist "^/Users/zaid/Library/Caches/Homebrew/emacs--git/$")
  (add-to-list 'lsp-project-blacklist "^/Users/zaid/\\.emacs\\.d/$"))

;; company-lsp: Company completion backend for lsp-mode.
;; https://github.com/tigersoldier/company-lsp/
(use-package company-lsp
  :config
  (push 'company-lsp company-backends))

;; lsp-ui: This contains all the higher level UI modules of lsp-mode, like flycheck support and code lenses.
;; https://github.com/emacs-lsp/lsp-ui
(use-package lsp-ui
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (setq lsp-ui-sideline-enable nil
        lsp-ui-doc-enable nil
        lsp-ui-flycheck-enable t
        lsp-ui-imenu-enable t
        lsp-ui-sideline-ignore-duplicate t))

;; cmake-font-lock: emacs font lock rules for CMake
;; https://github.com/Lindydancer/cmake-font-lock
(use-package cmake-font-lock
  :ensure t
  :config
  (autoload 'cmake-font-lock-activate "cmake-font-lock" nil t)
  (add-hook 'cmake-mode-hook 'cmake-font-lock-activate))

;; adds font-lock highlighting for modern C++ upto C++17
;; https://github.com/ludwigpacifici/modern-cpp-font-lock
(use-package modern-cpp-font-lock
  :ensure t
  :hook (c++-mode . modern-c++-font-lock-mode))
;; ccls: Emacs client for ccls, a C/C++ language server
;; https://github.com/MaskRay/emacs-ccls
(use-package ccls
  :commands (lsp-css-enable)
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
  (setq ccls-sem-highlight-method 'font-lock)

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

(use-package cc-mode :ensure nil
  :hook (((c++-mode c-mode) . (lambda ()
                                (ccls//enable)
                                (lsp-ui-mode)
                                (eldoc-mode)
                                (lsp-ui-sideline-mode)
                                (flycheck-mode)
                                ;; (smart-dash-mode)
                                (company-mode)
                                (yas-minor-mode))))

  :config

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
       t)))

  ;; (sp-with-modes '(c-mode c++-mode)
  ;;   (sp-local-pair "/*" "*/" :post-handlers '(("||\n[i]" "RET") ("| " "SPC")))
  ;;   ;; Doxygen blocks
  ;;   (sp-local-pair "/**" "*/" :post-handlers '(("||\n[i]" "RET") ("||\n[i]" "SPC")))
  ;;   (sp-local-pair "/*!" "*/" :post-handlers '(("||\n[i]" "RET") ("[d-1]< | " "SPC"))))
)
;; (use-package srefactor
;;   :ensure t
;;   :bind (:map c-mode-map
;;               ("M-RET" . srefactor-refactor-at-point))
;;   :bind (:map c++-mode-map
;;         ("M-RET" . srefactor-refactor-at-point)))

(use-package cmake-mode
  :mode (("CMakeLists\\.txt" . cmake-mode)
         ("\\.cmake" . cmake-mode)))

(use-package company-cmake
  :requires company cmake-mode
  :config
  (push 'company-cmake company-backends))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Golang
(use-package go-mode
  :ensure t
  :config
  (add-hook 'before-save #'gofmt-before-save)
  (use-package company-go
    :ensure t
    :config
    :hook (go-mode . (lambda ()
                            (add-to-list 'company-backends 'company-go)))))

;; Yaml
(use-package yaml-mode
  :ensure t
  :mode "\\.yaml"
  :bind (:map yaml-mode-map
              ("<return>" . newline-and-indent)))

;; Markdown
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md'" . gfm-mode)
         ("\\.md'" . markdown-mode)
         ("\\.markdown'" . markdown-mode)))

;; systemd mode
(use-package systemd
  :ensure t
  :config
  :mode (("\\.service" . systemd-mode)
         ("\\.timer" . systemd-mode)
         ("\\.path" . systemd-mode)
         ("\\.target" . system-mode)))

;; dash
(use-package dash
  :ensure t
  :defer t)
;; Multiple-cursors
(use-package multiple-cursors
  :ensure t
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C-<" . mc/mark-all-like-this))

(use-package ace-window
  :ensure t)

(defun my/split-window-right-and-move()
  "Split window to the right and move to it"
  (interactive)
  (split-window-right)
  (windmove-right))

(defun my/split-window-below-and-move()
  "Split window to the below and move to it"
  (interactive)
  (split-window-below)
  (windmove-down))

;; windows command keymap
(setq my-window-prefix (concat my-prefix "w"))
;; Bind window commands
(bind-keys :map global-map
           :prefix-map my-window-map
           :prefix my-window-prefix
           ("f n" . make-frame)
           ("f d" . delete-frame)
           ("f D" . delete-other-frames)
           ("f o" . other-frame)
           ("s" . split-window-below)
           ("v" . split-window-right)
           ("S" . my/split-window-below-and-move)
           ("V" . my/split-window-right-and-move)
           ("d" . delete-window)
           ("D" . ace-delete-window)
           ("o" . ace-window)
           ("M" . ace-swap-window)
           ("h" . windmove-left)
           ("j" . windmove-down)
           ("k" . windmove-up)
           ("l" . windmove-right))

(which-key-add-key-based-replacements
  my-window-prefix "windows"
  (concat my-window-prefix "S") "split-window-below-and-move"
  (concat my-window-prefix "V") "split-window-right-and-move"
  (concat my-window-prefix "d") "delete-current-window"
  (concat my-window-prefix "D") "delete-window"
  (concat my-window-prefix "o") "other-window"
  (concat my-window-prefix "M") "swap-window")

;; search command keymap
(setq my-search-prefix (concat my-prefix "s"))
;; Bind search commands
(bind-keys :map global-map
           :prefix-map my-search-map
           :prefix my-search-prefix
           ("s" . swiper)
           ("a" . counsel-ag)
           ("r" . counsel-rg))
(which-key-add-key-based-replacements
  my-search-prefix "search")

;; file commands keymap
(setq my-file-prefix (concat my-prefix "f"))
;; Bind file commands
(bind-keys :map global-map
           :prefix-map my-file-map
           :prefix my-file-prefix
           ("c" . copy-file)
           ("s" . save-buffer))
(which-key-add-key-based-replacements
  my-file-prefix "file")

;; undo-tree
(use-package undo-tree
  :ensure t
  :bind ("C-c u" . undo-tree-visualize)
  :config
  (global-undo-tree-mode))

;; Smartparens ()
(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode t))

;; doom-theme
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-vibrant t)
  (doom-themes-visual-bell-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config)
  (set-face-attribute 'region nil :background "#666")
  (setq nlinum-highlight-current-line t))

(use-package doom-modeline
      :ensure t
      :defer t
      :hook (after-init . doom-modeline-init)
      :config
      (setq mode-line-modes t))


;; Dimmer: visually highlight the selected window
(use-package dimmer
  :ensure t
  :config
  (setq dimmer-fraction 0.20)
  (dimmer-mode))

(use-package smooth-scrolling
  :ensure t
  :config
  (smooth-scrolling-mode))

;; bring up help for key bindings
(use-package which-key
  :ensure t
  :config
  (setq which-key-enable-extended-define-key t)
  (which-key-mode))

;; Org-bullets
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda ()
                             (org-bullets-mode 1))))

(use-package popwin
  :ensure t
  :bind ("C-h e" . popwin:messages)
  :bind-keymap ("C-z" . popwin:keymap)
  :config
  (push '("*Help*" :noselect nil) popwin:special-display-config)
  (push '("*Apropos*" :noselect nil) popwin:special-display-config)
  (push '("*Macroexpansion*" :noselect nil :stick t :dedicated t) popwin:special-display-config)
  (popwin-mode 1))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (modern-cpp-font-lock cmake-font-lock yasnippet-snippets yaml-mode which-key use-package undo-tree treemacs-projectile systemd smooth-scrolling smex smartparens ripgrep popwin org-bullets multiple-cursors magit lsp-ui doom-themes doom-modeline dimmer dashboard cquery counsel-projectile company-lsp company-go ccls ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
