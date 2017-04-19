;; ;;mac clip-board連携
;; 基本的に24以降ならいらない気もする
;; (setq x-select-enable-promary nil)
;; (setq x-select-enable-clipboard t)

;; (add-hook 'c-mode-commom-hook
;; 		  (lambda ()
;; 			(defun copy-from-osx ()
;; 			  (shell-command-to-string "pbpaste"))
;; 			(defun paste-to-osx (text &optional push)
;; 			  (let ((process-connection-type nil))
;; 				(let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
;; 				  (process-send-string proc text)
;; 				  (process-send-eof proc))))

;; 		  (setq interprogram-cut-function 'paste-to-osx)
;; 		  (setq interprogram-paste-function 'copy-from-osx)
;; 		  ))

;; (defun copy-from-osx ()
;;   (shell-command-to-string "pbpaste"))
;; (defun paste-to-osx (text &optional push)
;;   (let ((process-connection-type nil))
;; 	(let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
;; 	  (process-send-string proc text)
;; 	  (process-send-eof proc))))

;; (setq interprogram-cut-function 'paste-to-osx)
;; (setq interprogram-paste-function 'copy-from-osx)

(setq x-select-enable-clipboard t)
