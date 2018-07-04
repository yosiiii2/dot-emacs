(require 'avy)

(unbind-key "M-g M-g")
(bind-key* "M-g M-g" 'avy-goto-line)
(bind-key* "C-." 'avy-goto-char-timer)
