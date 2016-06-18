;;buffer間の移動
(setq load-path (cons "~/.emacs.d/elpa/" load-path))
(bind-key* "C-c <left>" 'windmove-left)
(bind-key* "C-c <down>" 'windmove-down)
(bind-key* "C-c <up>" 'windmove-up)
(bind-key* "C-c <right>" 'windmove-right)
(bind-key* "C-c n" 'windmove-down)
(bind-key* "C-c p" 'windmove-up)
(bind-key* "C-c b" 'windmove-left)
(bind-key* "C-c f" 'windmove-right)


;;カーソル移動
(unbind-key "M-l")
(bind-key* "M-l" 'move-to-window-line-top-bottom)
(bind-key* "C-<left>" 'move-beginning-of-line)
(bind-key* "C-<right>" 'move-end-of-line)
(bind-key* "M-<up>" 'backward-paragraph)
(bind-key* "M-<down>" 'forward-paragraph)
(bind-key* "s-<left>" 'backward-list)
(bind-key* "s-<right>" 'forward-list)
(bind-key* "M-n" 'forward-paragraph)
(bind-key* "M-p" 'backward-paragraph)


;;コメントアウトをいじろう
(unbind-key "C-c C-c")
(bind-key* "C-c C-c" 'comment-or-uncomment-region)

;;eval-buffer
(bind-key "<f2> e" 'eval-buffer)

;; shellでの強制終了
(eval-after-load 'shell '(bind-key "C-c x" 'comint-interrupt-subjob shell-mode-map))

;;kill-whole-line
(bind-key "C-S-K" 'kill-whole-line)
(bind-key "M-k" 'copy-whole-line)

(bind-key "C-c s" 'eshell)
(bind-key "C-c g" 'goto-line)
(bind-key "C-c C-c" 'comment-or-uncomment-region)

;; word region
(unbind-key "C-@")
(bind-key "C-@" 'mark-word*)



