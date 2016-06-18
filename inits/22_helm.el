
;;helm
(setq load-path (cons "~/.emacs.d/elpa/" load-path))
(global-set-key (kbd "C-o") 'helm-for-files)
(bind-key* "C-o" 'helm-for-files)
(bind-key* "C-c y" 'helm-show-kill-ring)
(unbind-key "M-x")
(bind-key* "M-x" 'helm-M-x)
(unbind-key "C-s")
(bind-key* "C-s" 'helm-swoop)

