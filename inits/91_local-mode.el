(setq load-path (cons "~/.emacs.d/elpa/" load-path))

;; ;;scheme-mode *******************************************************************
(setq scheme-program-name "java -jar /Users/admin/Desktop/programing/progen/jakld.jar")


;;run-geiser ********************************************************************
(setq geiser-racket-binary "/Applications/Racket v6.5/bin/gracket-text")
(setq geiser-active-implementations '(racket))

;;racket-mode *******************************************************************
(setq racket-program-mode "racket")
(setq geiser-active-implementations '(racket))

;; C-c C-a で実行


;; ;; smalltalk-mode *******************************************************************

(push (cons "\\.star\\'"
	    (catch 'archive-mode
	      (dolist (mode-assoc auto-mode-alist 'archive-mode)
		(and (string-match (car mode-assoc) "Starfile.zip")
		     (functionp (cdr mode-assoc))
		     (throw 'archive-mode (cdr mode-assoc))))))
      auto-mode-alist)

(autoload 'smalltalk-mode "smalltalk-mode.elc" "" t)
(autoload 'gst "gst-mode.elc" "" t)

(push '("\\.st\\'" . smalltalk-mode) auto-mode-alist)

(push "\\.star\\'" inhibit-local-variables-regexps)

;; ;; Haskell-mode *****************************************************************
(require 'haskell-mode)
(require 'haskell-cabal)
(add-to-list 'auto-mode-alist '(".hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
(add-to-list 'auto-mode-alist '("\\.cabal\\'" . haskell-cabal-mode))
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

(setq Haskell-program-name "/usr/bin/ghci")
(bind-key "C-c h" 'run-haskell)

(add-hook 'interactive-haskell-mode-hook 'ac-haskell-process-setup)
(add-hook 'haskell-interactive-mode-hook 'ac-haskell-process-setup)
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'haskell-interactive-mode))

;; ;; Coq-mode *****************************************************************
(load "~/.emacs.d/lisp/PG/generic/proof-site")
(add-hook 'coq-mode-hook #'company-coq-mode) ;; company-coqとの連携



;; ;; Scala-mode *****************************************************************
(require 'scala-mode)

;;; Use auto-complete for ensime
(setq ensime-completion-style 'auto-complete)

(defun scala/enable-eldoc ()
  "Show error message or type name at point by Eldoc."
  (setq-local eldoc-documentation-function
              #'(lambda ()
                  (when (ensime-connected-p)
                    (let ((err (ensime-print-errors-at-point))) err))))
  (eldoc-mode +1))

(bind-key "C-t" `ensime-type-at-point scala-mode-map)


(defun scala/completing-dot-company ()
  (cond (company-backend
         (company-complete-selection)
         (scala/completing-dot))
        (t
         (insert ".")
         (company-complete))))

(defun scala/completing-dot-ac ()
  (insert ".")
  (ac-trigger-key-command t))

;; Interactive commands

(defun scala/completing-dot ()
  "Insert a period and show company completions."
  (interactive "*")
  (eval-and-compile (require 'ensime))
  (eval-and-compile (require 's))
  (when (s-matches? (rx (+ (not space)))
                    (buffer-substring (line-beginning-position) (point)))
    (delete-horizontal-space t))
  (cond ((not (and (ensime-connected-p) ensime-completion-style))
         (insert "."))
        ((eq ensime-completion-style 'company)
         (scala/completing-dot-company))
        ((eq ensime-completion-style 'auto-complete)
         (scala/completing-dot-ac))))

;; Initialization
(setq ensime-startup-snapshot-notification nil)

(add-hook 'ensime-mode-hook #'scala/enable-eldoc)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(add-hook 'scala-mode-hook 'flycheck-mode)
