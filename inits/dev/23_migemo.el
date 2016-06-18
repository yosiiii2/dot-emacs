;;; package --- summary

;;; Commentary:

;;

;;; Code:

;; migemo
(require 'migemo)
(setq migemo-command "cmigemo")
;; (setq migemo-options '("-q" "--emacs"))
(setq migemo-options '("-q" "--emacs" "-i" "\g"))

(setq migemo-dictionary "/usr/local/Cellar/cmigemo/20110227/share/migemo/utf-8/migemo-dict")

(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
;; charset encoding
(setq migemo-coding-system 'utf-8)

(load-library "migemo")

(migemo-init)

;; (setq migemo-toggle-isearch-enable 1)
