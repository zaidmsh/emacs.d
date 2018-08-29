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

;; smart-mode-line
(use-package smart-mode-line-powerline-theme
  :ensure t
  :config
  (setq sml/no-confirm-load-theme t)
  (sml/setup))

;; zenburn-theme
(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))

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
  (which-key-mode))

;; Org-bullets
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; Ido
(setq ido-everywhere t)
(ido-mode)

;; helm
(use-package helm
  :bind
  ("C-c h" . helm-command-prefix)
  ("M-x" . helm-M-x)
  ("C-x C-f" . helm-find-files)
  ("M-y" . helm-show-kill-ring)
  ("C-x b" . helm-mini)
  :config
  (setq helm-M-x-fuzzy-match t)
  (setq helm-buffers-fuzzy-matching t)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent 
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
  (define-key helm-map (kbd "C-z") 'helm-select-action) ; list actions using C-z
  (helm-autoresize-mode))

;; Projectile
(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)

  (setq projectile-completion-system 'helm
        projectile-file-exists-remote-cache-expire nil)

  (projectile-load-known-projects)
  (use-package helm-projectile
    :ensure t
    :config
    (helm-projectile-on)))

(bind-keys :map global-map
           :prefix-map my-projectile-map
           :prefix (concat my-prefix "p")
           ("p" . helm-projectile-switch-project)
           ("b" . helm-projectile-switch-to-buffer)
           ("f" . helm-projectile-find-file)
           ("d" . helm-projectile-find-dir)
           ("D" . projectile-dired)
           ("c" . projectile-compile-project)
           ("g" . helm-projectile-grep))

  
;; Smartparens ()
(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode t))

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


;; Bind window commands
(bind-keys :map global-map
           :prefix-map my-window-map
           :prefix (concat my-prefix "w")
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

;; Bind file commands
(bind-keys :map global-map
           :prefix-map my-file-map
           :prefix (concat my-prefix "f")
           ("f" . helm-find-files)
           ("c" . copy-file)
           ("s" . save-buffer))

;; Company
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.0
        company-minimum-prefix-length 2
        company-dabbrev-downcase nil)
  (add-to-list 'company-backends 'company-keywords)
  (global-company-mode))

(use-package flycheck
  :ensure t)
 
(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)
  :config
  (use-package yasnippet-snippets
    :ensure t))

;; C/C++
(use-package irony
  :ensure t
  :mode (("\\.c'" . c-mode)
         ("\\.h'" . c-mode)
         ("\\.cpp'" . c++-mode)
         ("\\.hpp'" . c++-mode))
  :hook ((c-mode c++-mode) . irony-mode)
  :config
  (defun my-irony-mode-hook ()
    (define-key irony-mode-map [remap completion-at-point]
      'irony-completion-at-point-async)
    (define-key irony-mode-map [remap complete-symbol]
      'irony-completion-at-point-async))
 
  (add-hook 'irony-mode-hook 'my-irony-mode-hook)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  
  (use-package company-irony
	:requires company
	:after irony
    :hook irony-mode)

  (use-package company-irony-c-headers
	:requires company
	:after company-irony
    :hook irony-mode)

  (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
  (add-to-list 'company-backends '(company-irony-c-headers company-irony company-yasnippet))

  (use-package irony-eldoc
    :after irony
    :hook irony-mode)

  (use-package flycheck-irony
    :after irony
    :hook  (irony-mode . flycheck-mode)
    :config
    (flycheck-irony-setup)))

(use-package cmake-mode
  :mode (("CMakeLists\\.txt" . cmake-mode)
         ("\\.cmake" . cmake-mode))
  :config
  (use-package company-cmake
    :requires company
    :after cmake-mode)
  (add-to-list 'company-backends '(company-cmake company-yasnippet)))

(use-package rtags
  :commands rtags-start-process-unless-running
  :mode (("\\.c'" . c-mode)
         ("\\.h'" . c-mode)
         ("\\.cpp'" . c++-mode)
         ("\\.hpp'" . c++-mode))
  :hook ((c-mode c++-mode) . irony-mode)
  :bind ([remap imenu] . rtags-imenu)
  :config
  (use-package company-rtags
    :requires company rtags)
  (use-package helm-rtags
    :ensure t
    :requires helm rtags
    :hook rtags-mode)

  (setq rtags-completions-enabled t
        rtags-autostart-diagnostics t
        rtags-use-bookmarks nil
        rtags-completions-enabled nil
        rtags-results-buffer-other-window t
        rtags-jump-to-first-match nil
        rtags-display-result-backend 'helm)
  (rtags-enable-standard-keybindings))

(use-package cmake-ide
  :ensure t
  :config
  (cmake-ide-setup)
  ;; (cmake-ide-falgs-c)
  ;; (cmake-ide-flags-c++)
  (setq cmake-ide-build-pool-dir "/home/zaid/build")
  (setq cmake-ide-build-pool-use-persistent-naming t))

;; Golang
(use-package go-mode
  :ensure t
  :config
  (add-hook 'before-save-hook
            (lambda ()
              (when (string= major-mode "go-mode")
                (gofmt-before-save))))
  
  (use-package company-go
    :ensure t
    :config
    (add-hook 'go-mode-hook
              (lambda ()
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


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(package-selected-packages
   (quote
    (helm-rg helm-ag cmake-ide company-yasnippet company-rtags helm-rtags rtags irony-eldoc flycheck-irony yasnippet-snippets yasnippet company-irony-c-headers company-irony irony zenburn-theme yaml-mode which-key use-package sublimity solarized-theme smooth-scrolling smooth-scroll smartparens smart-mode-line-powerline-theme org-bullets multiple-cursors minimap markdown-mode helm-projectile flycheck evil dimmer dashboard counsel company-go auto-complete ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
