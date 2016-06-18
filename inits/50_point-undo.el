;;point-undo
(require 'point-undo)
(bind-key* "C-," 'point-undo)
(bind-key* "C-<" 'point-redo)
