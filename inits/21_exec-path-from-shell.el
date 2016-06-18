;; exec-path-from-shell
;; load environment variables
(setq load-path (cons "~/.emacs.d/elpa/" load-path))
(require 'exec-path-from-shell)
(let ((envs '("PATH" "VIRTUAL_ENV" "GOROOT" "GOPATH")))
  (exec-path-from-shell-copy-envs envs))


