(setq user-full-name "Zaid Alshathry")
(setq user-mail-address "zmzshathry@gmail.com")

;; set home and emacs directories
(defvar user-home-directory (concat (getenv "HOME") "/"))
(setq user-emacs-directory (concat user-home-directory ".emacs.d/"))
;; Initialize package
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

;; use-package
(unless (package-installed-p 'use-package)
  (progn
    (package-refresh-contents)
    (package-install 'use-package)))

(require 'use-package)

;; Set locale to UTF-8
(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8-unix)
(set-locale-environment "en_US.UTF-8")
(set-default-coding-systems 'utf-8-unix)
(set-selection-coding-system 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
(set-clipboard-coding-system 'utf-8) ; included by set-selection-coding-system
(set-keyboard-coding-system 'utf-8) ; configured by prefer-coding-system
(set-terminal-coding-system 'utf-8) ; configured by prefer-coding-system
(setq locale-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8) ; utf-8-unix
(setq save-buffer-coding-system 'utf-8-unix) ; nil
(setq process-coding-system-alist
      (cons '("grep" utf-8 . utf-8) process-coding-system-alist))

;; Quiet Startup
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil)

(defun display-startup-echo-area-message ()
  (message ""))

(setq frame-title-format nil)
(setq ring-bell-function 'ignore)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets) ; Show path if names are same
(setq adaptive-fill-regexp "[ t]+|[ t]*([0-9]+.|*+)[ t]*")
(setq adaptive-fill-first-line-regexp "^* *$")
(setq sentence-end "\\([。、！？]\\|……\\|[,.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)
(setq delete-by-moving-to-trash t)    ; Deleting files go to OS's trash folder
(setq make-backup-files nil)          ; Forbide to make backup files
(setq auto-save-default nil)          ; Disable auto save
(setq set-mark-command-repeat-pop t)  ; Repeating C-SPC after popping mark pops it again
(setq track-eol t)			; Keep cursor at end of lines.
(setq line-move-visual nil)		; To be required by track-eol
(setq-default kill-whole-line t)	; Kill line including '\n'
(setq-default indent-tabs-mode nil)   ; use space
(defalias 'yes-or-no-p #'y-or-n-p)

(if window-system
    (progn
      ;; UI parts
      (toggle-scroll-bar 0)
      (tool-bar-mode 0)
      (menu-bar-mode 0)

      ;; Japanese font settings
      (defun set-japanese-font (family)
        (set-fontset-font (frame-parameter nil 'font) 'japanese-jisx0208        (font-spec :family family))
        (set-fontset-font (frame-parameter nil 'font) 'japanese-jisx0212        (font-spec :family family))
        (set-fontset-font (frame-parameter nil 'font) 'katakana-jisx0201        (font-spec :family family)))

      ;; Overwrite latin and greek char's font
      (defun set-latin-and-greek-font (family)
        (set-fontset-font (frame-parameter nil 'font) '(#x0250 . #x02AF) (font-spec :family family)) ; IPA extensions
        (set-fontset-font (frame-parameter nil 'font) '(#x00A0 . #x00FF) (font-spec :family family)) ; latin-1
        (set-fontset-font (frame-parameter nil 'font) '(#x0100 . #x017F) (font-spec :family family)) ; latin extended-A
        (set-fontset-font (frame-parameter nil 'font) '(#x0180 . #x024F) (font-spec :family family)) ; latin extended-B
        (set-fontset-font (frame-parameter nil 'font) '(#x2018 . #x2019) (font-spec :family family)) ; end quote
        (set-fontset-font (frame-parameter nil 'font) '(#x2588 . #x2588) (font-spec :family family)) ; █
        (set-fontset-font (frame-parameter nil 'font) '(#x2500 . #x2500) (font-spec :family family)) ; ─
        (set-fontset-font (frame-parameter nil 'font) '(#x2504 . #x257F) (font-spec :family family)) ; box character
        (set-fontset-font (frame-parameter nil 'font) '(#x0370 . #x03FF) (font-spec :family family)))

      (setq use-default-font-for-symbols nil)
      (setq inhibit-compacting-font-caches t)
      (setq jp-font-family "SF Mono Square")
      (setq default-font-family "FuraCode Nerd Font")

      ;; (set-face-attribute 'default nil :family default-font-family)
      (when (eq system-type 'darwin)
                (set-face-attribute 'default nil :family jp-font-family :height 140))
      (when (eq system-type 'gnu/linux)
                (set-face-attribute 'default nil :family jp-font-family :height 150))
      (set-japanese-font jp-font-family)
      (set-latin-and-greek-font default-font-family)
      (add-to-list 'face-font-rescale-alist (cons default-font-family 0.86))
      (add-to-list 'face-font-rescale-alist (cons jp-font-family 1.0))))

(xterm-mouse-mode t)
;; Set My-prefix
(setq my-prefix "C-c ")

(tool-bar-mode -1)
(menu-bar-mode -1)
;; Ask "y" or "n" instead of "yes" or "no". Yes, laziness is great.
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight corresponding parentheses when cursor is on one
(show-paren-mode t)

;; Highlight currentline
(global-hl-line-mode 1)

;; load directory for configuration files for emacs
(add-to-list 'load-path (concat user-emacs-directory "setup-files/"))

(require 'setup-key-binding-tools)
(require 'setup-ivy)
(require 'setup-projectile)
(require 'setup-buffers)
(require 'setup-files)
(require 'setup-windows)
(require 'setup-search)
(require 'setup-magit)
(require 'setup-treemacs)
(require 'setup-flymake)
(require 'setup-yasnippet)
(require 'setup-company)
(require 'setup-eldoc)
(require 'setup-lsp)
(require 'setup-editing-tools)
(require 'setup-cc)
(require 'setup-golang)
(require 'setup-python)
(require 'setup-rust)
(require 'setup-org)
(require 'setup-non-programming-langs-modes)
(require 'setup-theme)
