;; yasnippet
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/mysnippet"
        "~/.emacs.d/yasnippet"
        ))

;; ;; helm interface
;; (eval-after-load "helm-config"
;;   '(progn
;;      (defun my-yas/prompt (prompt choices &optional display-fn)
;;        (let* ((names (loop for choice in choices
;;                            collect (or (and display-fn (funcall display-fn choice))
;;                                        choice)))
;;               (selected (helm-other-buffer
;;                          `(((name . ,(format "%s" prompt))
;;                             (candidates . names)
;;                             (action . (("Insert snippet" . (lambda (arg) arg))))))
;;                          "*helm yas/prompt*")))
;;          (if selected
;;              (let (((not) (position selected names :test 'equal)))
;;                (nth n choices))
;;            (signal 'quit "user quit!"))))
;;      (custom-set-variables '(yas/prompt-functions '(my-yas/prompt)))))
;; (define-key anything-map (kbd "y") 'yas/insert-snippet)

;; ;; helm-c-yas ;;戦犯(=入れたらhelmが死ぬ)
;; (require 'yasnippet)
;; (require 'helm-c-yasnippet)
;; (setq helm-yas-space-match-any-greedy t)
;; (global-set-key (kbd "C-c y") 'helm-yas-complete)
;; (push '(".emacs.d/yasnippet/" . snippet-mode) auto-mode-alist)

;;M-x yas-describe-tables
;;(custom-set-variables '(yas-trigger-key (kbd C-tab)))


;; key-bindings
;; 既存スニペットを挿入する
(unbind-key "C-x i")
(bind-key* "C-x i i" 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
(bind-key* "C-x i n" 'yas-new-snippet)
;; 既存スニペットを閲覧・編集する
(bind-key* "C-x i v" 'yas-visit-snippet-file)


(yas-global-mode 1)


