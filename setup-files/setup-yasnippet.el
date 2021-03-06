;; a collection of yasnippet snippets for many languages
;; https://github.com/AndreaCrotti/yasnippet-snippets
(use-package yasnippet-snippets
  :ensure t)

(use-package yasnippet
  :diminish yas-minor-mode
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

(provide 'setup-yasnippet)
