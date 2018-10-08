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
  :config
  (global-set-key (kbd "M-/") 'company-complete-common-or-cycle)
  (setq company-idle-delay 0
        company-dabbrev-downcase nil)
  (add-to-list 'company-backends '(company-keywords company-elisp company-yasnippet))
  (global-company-mode 1))

(use-package flycheck
  :ensure t
  :config
  (flycheck-mode t))
 
(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)
  :config
  (use-package yasnippet-snippets
    :ensure t))

;;;; magit
(use-package magit
  :ensure t
  :defer t
  :bind (("C-c g" . magit-status)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; C/C++ ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default c-basic-offset 4)
;; cquery + lsp
(use-package lsp-mode
  :ensure t
  :hook (lsp-after-open . lsp-enable-imenu)
  :config
  (require 'lsp-imenu))

(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode)
  :config
   (setq lsp-ui-sideline-enable nil
        lsp-ui-doc-enable t
        lsp-ui-flycheck-enable t
        lsp-ui-imenu-enable t
        lsp-ui-imenu-kind-position 'left
        lsp-ui-sideline-ignore-duplicate t))

(use-package company-lsp
  :requires company lsp-mode
  :ensure t
  :config
  (setq company-lsp-cache-candidates 'auto
        company-lsp-enable-snippet t
        company-lsp-enable-recompletion t)
  (push 'company-lsp company-backends))

(use-package cquery
  :ensure t
  :hook
  ((c-mode c++-mode) . lsp-cquery-enable)
  :config
  (setq cquery-executable "/Users/zaid/workspace/cquery/build/release/bin/cquery")
  (setq cquery-sem-highlight-method 'font-lock)
  (setq cquery-extra-init-params '(:cacheFormat "msgpack" :completion (:detailedLabel t) :xref (:container t))))
  ;; (cquery-use-default-rainbow-sem-highlight))

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
  :requires company cmake
  :hook (cmake-mode . (lambda ()
                        (add-to-list 'company-backends 'company-cmake))))

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
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(package-selected-packages
   (quote
    (ivy-xref doom-modeline spacemacs-theme smex zenburn-theme yasnippet-snippets yaml-mode which-key use-package treemacs-projectile srefactor smooth-scrolling smartparens smart-mode-line-powerline-theme ripgrep popwin org-bullets multiple-cursors magit lsp-ui lsp-rust lsp-go lsp-clangd irony-eldoc flycheck-irony doom-themes dimmer dashboard cquery counsel-projectile company-go cmake-ide ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
