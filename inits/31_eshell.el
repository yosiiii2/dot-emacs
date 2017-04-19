;;eshell
(setq load-path (cons "~/.emacs.d/elpa/" load-path))
(setq eshell-command-aliases-list
	  (append
	   (list
		(list "ll" "ls -ltr")
		(list "la" "ls -a")
        (list "lal" "ls -a -l")
		(list "o" "xdg-open")
		(list "f" "find-file $1")
		(list "d" "dired .")
		(list "l" "eshell/less $1")
		(list "ca" "cd ~")

		)))

(bind-key "C-c x" 'eshell-kill-process)

;; 補完時に大文字小文字を区別しない
(setq eshell-cmpl-ignore-case t)
