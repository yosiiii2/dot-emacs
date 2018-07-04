(require 'auto-complete)
(require 'bind-key)

;;; Code:
;; ;;scheme-mode *******************************************************************
;; (setq scheme-program-name "java -jar /Users/admin/Desktop/programing/progen/jakld.jar")


;; ;;run-geiser ********************************************************************
;; (setq geiser-racket-binary "/Applications/Racket v6.5/bin/gracket-text")
;; (setq geiser-active-implementations '(racket))

;; ;;racket-mode *******************************************************************
;; (setq racket-program-mode "racket")
;; (setq geiser-active-implementations '(racket))

;; C-c C-a で実行


;; ;; smalltalk-mode *******************************************************************

;; (push (cons "\\.star\\'"
;; 			(catch 'archive-mode
;; 			  (dolist (mode-assoc auto-mode-alist 'archive-mode)
;; 				(and (string-match (car mode-assoc) "Starfile.zip")
;; 					 (functionp (cdr mode-assoc))
;; 					 (throw 'archive-mode (cdr mode-assoc))))))
;;       auto-mode-alist)

;; (autoload 'smalltalk-mode "smalltalk-mode.elc" "" t)
;; (autoload 'gst "gst-mode.elc" "" t)

;; (push '("\\.st\\'" . smalltalk-mode) auto-mode-alist)

;; (push "\\.star\\'" inhibit-local-variables-regexps)

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
(bind-key "C-c h" 'run-haskell haskell-mode-map)

(add-hook 'interactive-haskell-mode-hook 'ac-haskell-process-setup)
(add-hook 'haskell-interactive-mode-hook 'ac-haskell-process-setup)
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'haskell-interactive-mode))

;; ;; ;; Coq-mode *****************************************************************
;; (load "~/.emacs.d/lisp/PG/generic/proof-site")
;; (add-hook 'coq-mode-hook #'company-coq-mode) ;; company-coqとの連携



;; ;; Scala-mode *****************************************************************
(require 'scala-mode)

(add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))
(add-to-list 'auto-mode-alist '("\\.scala.html$" . scala-mode))
(add-hook 'scala-mode-hook 'hs-minor-mode)


;;; Use auto-complete for ensime
(require 'ensime)
(setq ensime-completion-style 'auto-complete)

(defun scala/enable-eldoc ()
  "Show error message or type name at point by Eldoc."
  (setq-local eldoc-documentation-function
              #'(lambda ()
                  (when (ensime-connected-p)
                    (let ((err (ensime-print-errors-at-point))) err))))
  (eldoc-mode +1))

(bind-key* "C-t" 'ensime-type-at-point scala-mode-map)
(bind-key "C-@" 'hs-toggle-hiding scala-mode-map)

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
(setq ensime-startup-notification nil)


(add-hook 'ensime-mode-hook #'scala/enable-eldoc)
;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(add-hook 'scala-mode-hook 'flycheck-mode)


(setq ensime-use-helm t)


;;; ruby-mode

(add-to-list 'load-path "Enhanced-Ruby-Mode") ; must be added after any path containing old ruby-mode
(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

;; (add-to-list 'auto-mode-alist
;;              '("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))


;; (autoload 'ruby-mode "ruby-mode"
;;   "Mode for editing ruby source files" t)
;; (add-to-list 'auto-mode-alist '("\\.rb$latex " . ruby-mode))
;; (add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
(setq ruby-electric-expand-delimiters-list nil)

;; smart-compile
(require 'smart-compile)
(define-key ruby-mode-map (kbd "C-c c") 'smart-compile)
(define-key ruby-mode-map (kbd "C-c C-c") (kbd "C-c c C-m"))
(setq compilation-window-height 15) ;; default window height is 15

;; ruby-block.el --- highlight matching block
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)



;; python-mode ;;;;;;;
(require 'python-mode)
(require 'jedi)
(require 'py-autopep8)
(require 'flycheck-pyflakes)

(jedi:setup)
(define-key jedi-mode-map (kbd "<C-tab>") nil) ;;C-tabはウィンドウの移動に用いる
(setq jedi:complete-on-dot t)
(setq ac-sources
	  (delete 'ac-source-words-in-same-mode-buffers ac-sources)) ;;jediの補完候補だけでいい
(add-to-list 'ac-sources 'ac-source-filename)
(add-to-list 'ac-sources 'ac-source-jedi-direct)

(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))

(define-key python-mode-map "\C-ct" 'jedi:goto-definition)
(define-key python-mode-map "\C-cb" 'jedi:goto-definition-pop-marker)
(define-key python-mode-map "\C-cr" 'helm-jedi-related-names)

(setq py-autopep8-options '("--max-line-length=200"))
(setq flycheck-flake8-maximum-line-length 200)
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)

;; ;; ocaml-mode
;; (add-hook 'tuareg-mode-hook
;; 		  ;; Turn on auto-fill minor mode.
;; 		  (lambda () (auto-fill-mode 1)))

;; (add-to-list 'auto-mode-alist '("\\.ml[iylp]?" . tuareg-mode))
;; ;; (autoload 'tuareg-mode "tuareg" "Major mode for editing OCaml code" t)
;; ;; (autoload 'tuareg-run-ocaml "tuareg" "Run an inferior OCaml process." t)
;; ;; (autoload 'ocamldebug "ocamldebug" "Run the OCaml debugger" t)


;; ;; go-lang-mode
;; (add-to-list 'exec-path (expand-file-name "~/homebrew/bin"))
;; (add-to-list 'exec-path (expand-file-name "~/dev/go-workspace/bin"))
;; (add-hook 'before-save-hook 'gofmt-before-save)
;; (add-hook 'go-mode-hook (lambda ()
;;                           (local-set-key (kbd "M-.") 'godef-jump)))
