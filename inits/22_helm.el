;;helm
(require 'helm)
(global-set-key (kbd "C-o") 'helm-for-files)
(bind-key* "C-o" 'helm-for-files)
(bind-key* "C-c y" 'helm-show-kill-ring)
(unbind-key "M-x")
(bind-key* "M-x" 'helm-M-x)
