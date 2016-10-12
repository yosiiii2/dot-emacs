;; yes no to y/n
(fset 'yes-or-no-p 'y-or-n-p)


;;;; 保存時に末尾のスペースをいい感じに消してくれる
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;region可視化
(setq transient-mark-mode t)


;;regionまとめて削除
(delete-selection-mode t)


;;タブ幅指定
(setq-default tab-width 4)


;;タイトルバーにフルパスを表示
(setq frame-title-format (format "%%f - Emacs@%s" (system-name)))
(add-hook
 'shell-mode-hook
 '(lambda ()
    (set-buffer-process-coding-system 'utf-8 'utf-8)))


;;円マークを\とする
(define-key global-map [165] [92])


;;C-c cでコンパイルする
(define-key mode-specific-map "c" 'compile)


;;行表示
(global-linum-mode t)


;; 行番号フォーマット
(setq linum-format "%4d")


;;起動時のメッセージ非表示
(setq inhibit-startup-message t)


;;現在行を目立たせる
(defface hlline-face
  '((((class color)
	  (background dark))
	 (:background "dark slate gray"))
	(((class color)
	  (background light))
	 (:background "color-18"))
	(t
	 ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)


;; 対応する括弧を強調
(show-paren-mode t)
(setq show-paren-style 'mixed)


;;常に最終行に一行追加する
(setq require-final-newline t)


;;右端で折り返す
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)


;;バッファが外部編集されたときに自動で再読み込み
(global-auto-revert-mode 1)


;;スクロール幅を変更
(setq scroll-conservatively 1)


;;バッファの同一ファイル名を区別する
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)


;;バックアップは作らない
(setq make-backup-files nil)
(setq delete-auto-save-files t)


;; 補完時に大文字小文字を区別しない
(setq eshell-cmpl-ignore-case t)
