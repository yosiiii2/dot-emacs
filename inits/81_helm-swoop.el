;; (require 'ido-occasional)
;; (require 'ido-vertical-mode)
;; (require 'helm-swoop)
;; (require 'imenus)
;; (setq ido-enable-flex-matching t)
;; (ido-vertical-mode 1)
;; (setq ido-vertical-define-keys 'C-n-and-C-p-only)


;; ;;; エラー対策
;; (defun imenu-find-default--or-current-symbol (&rest them)
;;   (condition-case nil
;;       (apply them)
;;     (error (thing-at-point 'symbol))))
;; (advice-add 'imenu-find-default :around 'imenu-find-default--or-current-symbol)
;; ;;; なぜか現在のシンボルを取ってくれないから
;; (defun imenus-exit-minibuffer ()
;;   (exit-minibuffer))

;; ;;; ido化: imenus/with-ido imenus-mode-buffers/with-idoを定義
;; (with-ido-completion imenus)

;; ;; C-Sで現在のシンボルをhelm-multi-swoopできるよ！
;; (bind-key "C-S" (with-ido-completion imenus-mode-buffers))

;; ;;; C-M-sで関数呼び出しをhelm-multi-swoopできるようにした
;; (push '(helm-multi-swoop . imenus-helm-multi-swoop) imenus-actions)
;; (defun imenus-helm-multi-swoop (buffers input)
;;   (helm-multi-swoop (replace-regexp-in-string "^.*|" "" input)
;;                     (mapcar 'buffer-name buffers)))
;; (define-key imenus-minibuffer-map (kbd "C-M-s") 'imenus-exit-to-helm-multi-swoop)
;; (defun imenus-exit-to-helm-multi-swoop ()
;;   "Exit from imenu prompt; start `helm-multi-swoop' with the current input."
;;   (interactive)
;;   (setq imenus-exit-status 'helm-multi-swoop)
;;   (imenus-exit-minibuffer))

;; helm from https://github.com/emacs-helm/helm
(require 'helm)

;; Locate the helm-swoop folder to your path
(add-to-list 'load-path "~/.emacs.d/elisp/helm-swoop")
(require 'helm-swoop)

;; Change the keybinds to whatever you like :)
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

;; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
;; From helm-swoop to helm-multi-swoop-all
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
;; When doing evil-search, hand the word over to helm-swoop
;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)

;; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode
(define-key helm-swoop-map (kbd "M-m") 'helm-multi-swoop-current-mode-from-helm-swoop)

;; Move up and down like isearch
(define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
(define-key helm-multi-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)

;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)

;; If this value is t, split window inside the current window
(setq helm-swoop-split-with-multiple-windows nil)

;; Split direcion. 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)

;; If nil, you can slightly boost invoke speed in exchange for text color
(setq helm-swoop-speed-or-color nil)

;; ;; Go to the opposite side of line from the end or beginning of line
(setq helm-swoop-move-to-line-cycle t)

;; Optional face for line numbers
;; Face name is `helm-swoop-line-number-face`
(setq helm-swoop-use-line-number-face t)

;; Match/Search methods (Fuzzy matching, Migemo)
;; If you do not preferr fuzzy, remove it from the list below
(defvar helm-c-source-swoop-match-functions
  '(helm-mm-exact-match
    helm-mm-match
    helm-fuzzy-match
    helm-mm-3-migemo-match))
(setq helm-c-source-swoop-search-functions
      '(helm-mm-exact-search
        helm-mm-search
        helm-candidates-in-buffer-search-default-fn
        helm-fuzzy-search
        helm-mm-3-migemo-search))

;; In addition of above, you need to enable migemo mode if you'd like to
;; (helm-migemo-mode 1)
