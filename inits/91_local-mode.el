(setq load-path (cons "~/.emacs.d/elpa/" load-path))

;; ;;scheme-mode *******************************************************************
(setq scheme-program-name "java -jar /Users/admin/Desktop/programing/progen/jakld.jar")


;; ;;run-geiser ********************************************************************
(setq geiser-racket-binary "/Applications/Racket v6.5/bin/gracket-text")
(setq geiser-active-implementations '(racket))

;; ;;racket-mode *******************************************************************
(setq racket-program-mode "racket")
(setq geiser-active-implementations '(racket))

;; C-c C-a で実行


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


