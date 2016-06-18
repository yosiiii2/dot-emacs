;; ;;org-mode *********************************************************************
(require 'ox-latex)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(setq org-startup-folded 'showeverything)
(setq org-latex-default-class "thesis")
(setq org-ditaa-jar-path "~/.emacs.d/ditaa.jar")

(setq org-confirm-babel-evaluate nil)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t)
   (dot . t)))


;;プリアンブル設定
(add-to-list 'org-latex-classes
             '("thesis"
               "\\documentclass{jsarticle}
                [NO-PACKAGES]
                [NO-DEFAULT-PACKAGES]
                \\usepackage[dvipdfmx]{graphicx}
                \\usepackage{listings}
                \\usepackage[top=10truemm,bottom=10truemm,left=25truemm,right=25truemm]{geometry}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
			   ))



(setq org-export-latex-coding-system 'utf-8-unix)
(setq org-latex-pdf-process '("platex %f" "dvipdfmx %b.dvi"))

(bind-key "C-." 'org-table-previous-field)
(bind-key "C-c a" 'org-agenda org-mode-map)

(setq org-src-preserve-indentation t)

;;; \hypersetup{}を表示しない
(setq org-latex-with-hyperref nil)

(setq org-agenda-files '("/Users/admin/Desktop/schedule.org"))

;; (global-set-key "\C-c l" 'org-store-link)
;; (global-set-key "\C-c c" 'org-capture)
;; (global-set-key "\C-c a" 'org-agenda)
;; (global-set-key "\C-c b" 'org-iswitchb)

;; H           どのレベルまでを見出しとし、どのレベル未満をリストとするか (1 〜)
;; num         見出しに番号を付けるかどうか (nil / t)
;; toc         目次を出力するかどうか、どのレベルの見出しまで目次に載せるか (nil / t / 1 〜)
;; ^           '_' を下付き文字列の開始記号とするかどうか (nil / t / {})
;; author      著者情報を出力するかどうか (nil / t)
;; creator     出力ツール (Emacs と Org-mode) 情報を出力するかどうか (nil / t)
;; timestamp   タイムスタンプを出力するかどうか (nil / t)



;; (defconst org-export-options-alist
;;   '((:author "AUTHOR" nil user-full-name t)
;;     (:creator "CREATOR" nil org-export-creator-string)
;;     (:date "DATE" nil nil t)
;;     (:description "DESCRIPTION" nil nil newline)
;;     (:email "EMAIL" nil user-mail-address t)
;;     (:exclude-tags "EXCLUDE_TAGS" nil org-export-exclude-tags split)
;;     (:headline-levels nil "H" org-export-headline-levels)
;;     (:keywords "KEYWORDS" nil nil space)
;;     (:language "LANGUAGE" nil org-export-default-language t)
;;     (:preserve-breaks nil "\\n" org-export-preserve-breaks)
;;     (:section-numbers nil "num" org-export-with-section-numbers)
;;     (:select-tags "SELECT_TAGS" nil org-export-select-tags split)
;;     (:time-stamp-file nil "timestamp" org-export-time-stamp-file)
;;     (:title "TITLE" nil nil space)
;;     (:with-archived-trees nil "arch" org-export-with-archived-trees)
;;     (:with-author nil "author" org-export-with-author)
;;     (:with-clocks nil "c" org-export-with-clocks)
;;     (:with-creator nil "creator" org-export-with-creator)
;;     (:with-date nil "date" org-export-with-date)
;;     (:with-drawers nil "d" org-export-with-drawers)
;;     (:with-email nil "email" org-export-with-email)
;;     (:with-emphasize nil "*" org-export-with-emphasize)
;;     (:with-entities nil "e" org-export-with-entities)
;;     (:with-fixed-width nil ":" org-export-with-fixed-width)
;;     (:with-footnotes nil "f" org-export-with-footnotes)
;;     (:with-inlinetasks nil "inline" org-export-with-inlinetasks)
;;     (:with-latex nil "tex" org-export-with-latex)
;;     (:with-planning nil "p" org-export-with-planning)
;;     (:with-priority nil "pri" org-export-with-priority)
;;     (:with-smart-quotes nil "'" org-export-with-smart-quotes)
;;     (:with-special-strings nil "-" org-export-with-special-strings)
;;     (:with-statistics-cookies nil "stat" org-export-with-statistics-cookies)
;;     (:with-sub-superscript nil "^" org-export-with-sub-superscripts)
;;     (:with-toc nil "toc" org-export-with-toc)
;;     (:with-tables nil "|" org-export-with-tables)
;;     (:with-tags nil "tags" org-export-with-tags)
;;     (:with-tasks nil "tasks" org-export-with-tasks)
;;     (:with-timestamps nil "<" org-export-with-timestamps)
;;     (:with-todo-keywords nil "todo" org-export-with-todo-keywords))
;;   "Alist between export properties and ways to set them.


