(setq load-path (cons "~/.emacs.d/elpa/" load-path))
(global-anzu-mode +1)
(bind-key* "C-c r" 'anzu-replace-at-cursor-thing)
(custom-set-variables
 '(anzu-mode-lighter "")
 '(anzu-deactivate-region t)
 '(anzu-search-threshold 1000))
