(require 'auto-complete-clang)

(setq ac-clang-flags '("-w" "-ferror-limit" "1"))

(setq ac-sources (append '(ac-source-clang 
						   ac-source-yasnippet 
						   ac-source-gtags)
						 ac-sources))

(setq-default ac-sources '(ac-source-abbrev 
						   ac-source-dictionary 
						   ac-source-words-in-same-mode-buffers))

