;;to load init-loader
(require 'package)
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")
		("marmalade" . "http://marmalade-repo.org/packages/")
		))

(setq load-path (cons "~/.emacs.d/elpa/" load-path))
(setq load-path (cons "~/.emacs.d/elpa/ox-hatena/" load-path))

(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")
;; (init-loader-load "~/.emacs.d/inits/dev")

;; acとyasの連携ってどうなってんの？
;; 自動でなってるならええんやけどどうなんやろ？
;; とりあえず
;; (bind-key* "C-c a" 'auto-complete)

;;困ったらC-h k
;;もっと困ったらM-x help-for-help
;;f1 cとかもあるよ
;;M-x list-packages
;;M-r 画面中央の行へカーソル移動
;;M-<,>でバッファの一番上下

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-search-threshold 1000)
 '(org-agenda-files (quote ("~/Dropbox/org-mode/schedule.org")))
 '(package-selected-packages
   (quote
	(avy helm-swoop neotree undohist undo-tree tab-jump-out smooth-scroll smartparens smart-newline smart-compile ruby-electric ruby-block rainbow-delimiters quickrun python-mode py-autopep8 point-undo php-mode paredit multiple-cursors migemo magit jedi init-loader imenus ido-vertical-mode ido-occasional hlinum helm-flycheck go-snippets go-mode go-autocomplete fuzzy function-args flycheck-pyflakes flycheck-haskell faceup exec-path-from-shell ensime enh-ruby-mode cdb ccc c-eldoc bm bind-key anzu aggressive-indent ace-isearch ac-helm ac-haskell-process)))
 '(recentf-exclude
   (quote
	("Users/Admin/Desctop/programing/keisanki3/kadai*/*")) t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#1B1D1E" :foreground "#F8F8F2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "nil" :family "Ricty"))))
 '(enh-ruby-op-face ((t (:foreground "orange"))))
 '(py-variable-name-face ((t (:foreground "magenta")))))
