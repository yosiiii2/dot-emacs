;;package取得先
(setq load-path (cons "~/.emacs.d/elpa/" load-path))
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; package install時に一度だけコメントはずす
;; (require 'auto-install)
;; (auto-install-compatibilitu-setup)
;; (package-refresh-contents)
(setq load-path (cons "~/.emacs.d/elpa/" load-path))

(defvar my/favorite-packages
  '(
	ac-geiser          
	ac-haskell-process 
	ac-helm            
	ace-isearch        
	ace-jump-mode      
	aggressive-indent  
	anzu               
	async              
	auto-complete      
	avy                
	bind-key           
	ccc                
	cdb                
	dash               
	ddskk              
	epl                
	eshell-z           
	exec-path-from-shell
	faceup             
	flycheck           
	fuzzy              
	geiser             
	haskell-mode       
	helm               
	helm-flycheck      
	helm-swoop         
	hlinum             
	ido-occasional     
	ido-vertical-mode  
	imenus             
	let-alist          
	migemo             
	minimap            
	multi-term         
	multiple-cursors   
	paredit            
	pkg-info           
	point-undo         
	popup              
	rainbow-delimiters 
	s                  
	smartparens
	smooth-scroll      
	tab-jump-out       
	twittering-mode    
	undo-tree          
	undohist           
	yasnippet	
  ))

(dolist (package my/favorite-packages)
  (unless (package-installed-p package)
	(package-install package)))

