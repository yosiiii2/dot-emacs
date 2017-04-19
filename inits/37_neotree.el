(require 'neotree)
(require 'helm-swoop)

(setq neo-show-hidden-files t)
(setq neo-theme (if (display-graphic-p) 'ascii))
(setq neo-keymap-style 'concise)

(defun helm-neo-tree ()
  "help search neo-tree"
  (interactive)
  (if (neo-global--window-exists-p)
      (neotree-hide)
    (neotree-show)
	(setq helm-swoop-pre-input-function
		  (lambda () ""))
	(helm-swoop)
	(setq helm-swoop-pre-input-function
		  (lambda () (thing-at-point 'symbol)))
    )
  )


(bind-key* "<f8>" 'helm-neo-tree)
