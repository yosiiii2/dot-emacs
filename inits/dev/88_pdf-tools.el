(setq load-path (cons "~/.emacs.d/elpa/" load-path))

(require 'pdf-tools)
(add-to-list 'auto-mode-alist (cons "\\.pdf$" 'pdf-view-mode))
(add-hook 'pdf-view-mode-hook
		  (lambda ()
			(pdf-misc-size-indication-minor-mode)
			(pdf-links-minor-mode)
			(pdf-isearch-minor-mode)
			(bind-key "C-s" 'pdf-occur)
			(pdf-view-auto-slice-minor-mode)
			(pdf-annot-minor-mode)
			(unbind-key "C-a")
			(bind-key "C-a" 'pdf-annot-add-text-annotation)
			
			)
)

;; pdf-annot-list-annotations

;; (setq pdf-info-epdfinfo-program "~/.emacs.d/elpa/pdf-tools-20151224.1159/epdfinfo")
