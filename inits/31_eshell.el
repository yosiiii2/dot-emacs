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
