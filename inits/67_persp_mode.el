(require 'persp-mode)
(require 'helm)

(with-eval-after-load "persp-mode"
  (substitute-key-definition #'switch-to-buffer #'persp-switch-to-buffer global-map)
  (substitute-key-definition #'kill-buffer #'persp-kill-buffer global-map))

;; (setq persp-add-on-switch-or-display t) ;バッファを切り替えたら見えるようにする

;; (defun persp-register-buffers-on-create ()
;;   (interactive)
;;   (dolist (bufname (condition-case _
;;                        (helm-comp-read
;;                         "Buffers: "
;;                         (mapcar 'buffer-name (buffer-list))
;;                         :must-match t
;;                         :marked-candidates t)
;;                      (quit nil)))
;;     (persp-add-buffer (get-buffer bufname))))
;; (add-hook 'persp-mode-hook 'persp-register-buffers-on-create)

;; (persp-mode 1)


;;; hogehoge

;; (with-eval-after-load "persp-mode"
;;   (with-eval-after-load "helm-mode"
;;     (defun helm-buffers-toggle-persp-filter ()
;;       (interactive)
;;       (with-helm-alive-p
;;         (let ((filter-attrs (helm-attr 'candidate-transformer
;;                                        helm-source-persp-buffers)))
;;           (if (memq #'helm-persp-buffers-filter-transformer filter-attrs)
;;               (progn
;;                 (helm-attrset 'candidate-transformer
;;                               (delq #'helm-persp-buffers-filter-transformer
;;                                     filter-attrs)
;;                               helm-source-persp-buffers t)
;;                 (helm-attrset 'name
;;                               "Buffers"
;;                               helm-source-persp-buffers t)
;;                 (setq helm-persp-filtered-buffers-cache nil))
;;             (helm-attrset 'candidate-transformer
;;                           (cons #'helm-persp-buffers-filter-transformer
;;                                 filter-attrs)
;;                           helm-source-persp-buffers t)
;;             (helm-attrset 'name
;;                           "Current perspective buffers"
;;                           helm-source-persp-buffers t))
;;           (helm-force-update))))
;;     (put 'helm-buffers-toggle-persp-filter 'helm-only t)
;;     (define-key helm-buffer-map
;;       persp-toggle-read-persp-filter-keys #'helm-buffers-toggle-persp-filter)
;;     (defvar helm-persp-filtered-buffers-cache nil)
;;     (defun helm-persp-buffers-filter-transformer (candidates)
;;       (setq helm-persp-filtered-buffers-cache nil)
;;       (let* ((persp (get-current-persp))
;;              (ret
;;               (cl-remove-if-not #'(lambda (bn)
;;                                     (let* ((ret (persp-contain-buffer-p (get-buffer bn) persp)))
;;                                       (unless ret
;;                                         (push bn helm-persp-filtered-buffers-cache))
;;                                       ret))
;;                                 candidates)))
;;         ret))
;;     (defclass helm-persp-buffers-source (helm-source-buffers)
;;       ((buffer-list
;;         :initarg :buffer-list
;;         :initform #'(lambda () (mapcar #'buffer-name (buffer-list)))
;;         :custom function
;;         :documentation
;;         " A function with no arguments to create buffer list.")
;;        (cleanup :initform #'(lambda () (setq helm-persp-filtered-buffers-cache nil
;;                                         helm-buffers-list-cache nil)))
;;        (candidate-transformer :initform '(helm-persp-buffers-filter-transformer))))
;;     (defvar helm-source-persp-buffers
;;       (helm-make-source "Current perspective buffers"
;;           'helm-persp-buffers-source
;;         :fuzzy-match t))
;;     (defclass helm-persp-filtered-buffers-source (helm-source-buffers)
;;       ((candidates :initform #'(lambda ()
;;                                  (if helm-persp-filtered-buffers-cache
;;                                      helm-persp-filtered-buffers-cache
;;                                    (setq helm-persp-filtered-buffers-cache
;;                                          (mapcar #'buffer-name (persp-buffer-list-restricted nil 1))))))
;;        (cleanup :initform #'(lambda () (setq helm-persp-filtered-buffers-cache nil)))))
;;     (defvar helm-source-persp-filtered-buffers
;;       (helm-make-source "Other buffers"
;;           'helm-persp-filtered-buffers-source
;;         :fuzzy-match t))
;;     (defun helm-persp-buffer-list-bridge
;;         (prompt _collection &optional test _require-match init hist default _inherit-im name buffer)
;;       (let ((dflt (or default ""))
;;             (cbuf (current-buffer))
;;             helm-candidate-number-limit)
;;         (or
;;          (helm :sources (cond
;;                          ((eq this-command 'persp-add-buffer) '(helm-source-persp-filtered-buffers))
;;                          ((eq this-command 'persp-remove-buffer) '(helm-source-persp-buffers))
;;                          (t '(helm-source-persp-buffers helm-source-persp-filtered-buffers)))
;;                :fuzzy-match helm-mode-fuzzy-match
;;                :prompt prompt
;;                :buffer buffer
;;                :input init
;;                :history hist
;;                :resume 'noresume
;;                :keymap helm-buffer-map
;;                :truncate-lines helm-buffers-truncate-lines
;;                :default dflt
;;                :preselect #'(lambda ()
;;                               (if (and (eq this-command 'persp-temporarily-display-buffer)
;;                                        (persp-contain-buffer-p cbuf))
;;                                   (helm-next-source)
;;                                 (helm-mark-current-line)
;;                                 (let ((buffer-name-truncated-regexp (helm-buffers--quote-truncated-buffer cbuf))
;;                                       (start (point)) mp)
;;                                   (helm-awhile (re-search-forward buffer-name-truncated-regexp nil t)
;;                                     (when (helm-pos-header-line-p) (forward-line 1))
;;                                     (helm-mark-current-line)
;;                                     (when (eq cbuf (helm-get-selection)) (cl-return (setq mp it))))
;;                                   (goto-char (or mp start))
;;                                   (helm-mark-current-line)))))
;;          (helm-mode--keyboard-quit))))
;;     (defvar helm-persp-mini-default-sources
;;       (cons 'helm-source-persp-buffers
;;             (cons 'helm-source-persp-filtered-buffers
;;                   (remove 'helm-source-buffers-list helm-mini-default-sources))))
;;     (defun helm-persp-mini ()
;;       (interactive)
;;       (let* ((cbuf (current-buffer))
;;              (cbuf-name (buffer-name cbuf))
;;              helm-candidate-number-limit)
;;         (or
;;          (helm :sources helm-persp-mini-default-sources
;;                :ff-transformer-show-only-basename nil
;;                :fuzzy-match helm-mode-fuzzy-match
;;                :buffer "*helm persp mini*"
;;                :keymap helm-buffer-map
;;                :truncate-lines helm-buffers-truncate-lines
;;                :default cbuf-name
;;                :preselect #'(lambda ()
;;                               (let ((buffer-name-truncated-regexp (helm-buffers--quote-truncated-buffer cbuf))
;;                                     (start (point)) mp)
;;                                 (helm-awhile (re-search-forward buffer-name-truncated-regexp nil t)
;;                                   (when (helm-pos-header-line-p) (forward-line 1))
;;                                   (helm-mark-current-line)
;;                                   (when (eq cbuf (helm-get-selection)) (cl-return (setq mp it))))
;;                                 (goto-char (or mp start))
;;                                 (helm-mark-current-line))))
;;          (helm-mode--keyboard-quit))))
;;     (global-set-key (kbd "C-x b") #'helm-persp-mini)
;;     (setq helm-completing-read-handlers-alist
;;           (append '((switch-to-buffer                 . helm-persp-buffer-list-bridge)
;;                     (persp-switch-to-buffer           . helm-persp-buffer-list-bridge)
;;                     (kill-buffer                      . helm-persp-buffer-list-bridge)
;;                     (persp-kill-buffer                . helm-persp-buffer-list-bridge)
;;                     (persp-temporarily-display-buffer . helm-persp-buffer-list-bridge)
;;                     (persp-add-buffer                 . helm-persp-buffer-list-bridge)
;;                     (persp-remove-buffer              . helm-persp-buffer-list-bridge))
;;                   helm-completing-read-handlers-alist))))




;;; hogehoge

(with-eval-after-load "persp-mode"
  (with-eval-after-load "helm-mode"

    (defvar helm-mini-tail-sources (cdr helm-mini-default-sources))
    (defvar helm-persp-completing-read-handlers
      '((switch-to-buffer                 . helm-persp-buffer-list-bridge)
        (kill-buffer                      . helm-persp-buffer-list-bridge)
        (persp-kill-buffer                . helm-persp-buffer-list-bridge)
        (persp-temporarily-display-buffer . helm-persp-buffer-list-bridge)
        (persp-add-buffer                 . helm-persp-buffer-list-bridge)
        (persp-remove-buffer              . helm-persp-buffer-list-bridge)))

    (defclass helm-persp-free-buffers-source (helm-source-buffers)
      ((buffer-list
        :initarg :buffer-list
        :initform #'(lambda () (mapcar #'buffer-name (persp-buffer-list-restricted nil 3)))
        :custom function
        :documentation
        "  A function with no arguments to create buffer list.")))

    (defvar helm-source-persp-free-buffers
      (helm-make-source "Free buffers"
          'helm-persp-free-buffers-source
        :fuzzy-match t))


    (defun helm-persp-buffers-list--init ()
      (let* ((buffers (funcall (helm-attr 'buffer-list)))
             (result (cl-loop for b in buffers
                              maximize (length b) into len-buf
                              maximize (length (with-current-buffer b
                                                 (format-mode-line mode-name)))
                              into len-mode
                              finally return (cons len-buf len-mode))))
        (unless (default-value 'helm-buffer-max-length)
          (helm-set-local-variable 'helm-buffer-max-length (car result)))
        (unless (default-value 'helm-buffer-max-len-mode)
          (helm-set-local-variable 'helm-buffer-max-len-mode (cdr result)))
        (helm-attrset 'candidates buffers)))

    (defclass helm-persp-buffers-source (helm-source-buffers)
      ((buffer-list
        :initarg :buffer-list
        :initform #'(lambda () (mapcar #'buffer-name (persp-buffers (helm-attr 'persp))))
        :custom function
        :documentation
        "  A function with no arguments to create buffer list.")
       (persp
        :initarg :persp
        :initform (get-current-persp))
       (init :initform #'helm-persp-buffers-list--init)))

    (defvar helm-persp-sources-list '(helm-source-persp-free-buffers))
    (defvar helm-persp-source-name-prefix "helm-source-persp-buffers-list-")

    (defmacro persp-helm--liftup-source (source-name)
      `(progn
         (setq helm-persp-sources-list
               (cons ,source-name
                     (cl-delete ,source-name helm-persp-sources-list)))
         (setq helm-mini-default-sources
               (append helm-persp-sources-list
                       helm-mini-tail-sources))))

    (defmacro persp-helm--soure-name-from-persp-name (pn)
      `(intern (concat helm-persp-source-name-prefix ,pn)))

    (add-hook 'persp-created-functions
              #'(lambda (p ph)
                  (when (and (eq ph *persp-hash*) p)
                    (let* ((pn (persp-name p))
                           (source-name (persp-helm--soure-name-from-persp-name pn)))
                      (eval
                       `(defvar ,source-name
                          (helm-make-source ,(concat pn " buffers")
                              'helm-persp-buffers-source :persp ,p)))
                      (setq helm-persp-sources-list
                            (append helm-persp-sources-list (list source-name))))
                    (setq helm-mini-default-sources
                          (append helm-persp-sources-list
                                  helm-mini-tail-sources)))))

    ;; (add-hook 'persp-before-switch-functions
    ;;           #'(lambda (next-pn)
    ;;               (let ((p (get-current-persp)))
    ;;                 (when p
    ;;                   (persp-helm--liftup-source 'helm-source-persp-free-buffers)))))

    ;; (add-hook 'persp-activated-hook
    ;;           #'(lambda ()
    ;;               (let ((p (get-current-persp)))
    ;;                 (when p
    ;;                   (let* ((pn (persp-name p))
    ;;                          (source-name (intern (concat helm-persp-source-name-prefix pn))))
    ;;                     (persp-helm--liftup-source source-name))))))

    (add-hook 'persp-before-kill-functions
              #'(lambda (p)
                  (when p
                    (let* ((pn (persp-name p))
                           (source-name (persp-helm--soure-name-from-persp-name pn)))
                      (setq helm-persp-sources-list
                            (cl-delete source-name helm-persp-sources-list))
                      (setq helm-mini-default-sources
                            (append helm-persp-sources-list
                                    helm-mini-tail-sources))
                      (makunbound source-name)))))

    (add-hook 'persp-mode-hook #'(lambda ()
                                   (if persp-mode
                                       (persp-helm-setup-bridge)
                                     (persp-helm-destroy-bridge))))

    (defun helm-persp-mini ()
      (interactive)
      (persp-helm--liftup-source 'helm-source-persp-free-buffers)
      (let* ((cbuf (current-buffer))
             (cbn (buffer-name cbuf)))
        (let ((persp (get-current-persp)))
          (when (and persp (persp-contain-buffer-p cbuf persp))
            (let ((source-name (persp-helm--soure-name-from-persp-name (persp-name persp))))
              (persp-helm--liftup-source source-name))))
        (or
         (helm :sources helm-mini-default-sources
               :ff-transformer-show-only-basename nil
               :fuzzy-match helm-mode-fuzzy-match
               :buffer "*helm persp mini*"
               :keymap helm-buffer-map
               :truncate-lines helm-buffers-truncate-lines
               :default cbn
               :preselect (substring cbn 0 (min (string-width cbn) helm-buffer-max-length)))
         (helm-mode--keyboard-quit))))

    (defun helm-persp-buffer-list-bridge
        (prompt _collection &optional test _require-match init hist default _inherit-im name buffer)
      (persp-helm--liftup-source 'helm-source-persp-free-buffers)
      (let ((persp (get-current-persp)))
        (when (and persp (persp-contain-buffer-p (current-buffer) persp))
          (let ((source-name (persp-helm--soure-name-from-persp-name (persp-name persp))))
            (persp-helm--liftup-source source-name))))
      (let ((deflt (or default "")))
        (or
         (helm :sources helm-persp-sources-list
               :fuzzy-match helm-mode-fuzzy-match
               :prompt prompt
               :buffer buffer
               :input init
               :history hist
               :resume 'noresume
               :keymap helm-buffer-map
               :truncate-lines helm-buffers-truncate-lines
               :default deflt
               :preselect (substring deflt 0 (min (string-width deflt) helm-buffer-max-length)))
         (helm-mode--keyboard-quit))))

    (defun persp-helm-setup-bridge ()
      (setq helm-completing-read-handlers-alist
            (append helm-persp-completing-read-handlers
                    helm-completing-read-handlers-alist))
      (global-set-key (kbd "C-x b") #'helm-persp-mini))
    (defun persp-helm-destroy-bridge ()
      (setq helm-mini-default-sources
            (cons
             'helm-source-buffers-list
             helm-mini-tail-sources))
      (dolist (it helm-persp-completing-read-handlers)
        (setq helm-completing-read-handlers-alist
              (delete it helm-completing-read-handlers-alist)))
      (global-set-key (kbd "C-x b") #'helm-mini))

    (when (bound-and-true-p persp-mode)
      (persp-helm-setup-bridge))))
