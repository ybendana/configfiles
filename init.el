; Set variables
(column-number-mode t)
(global-eldoc-mode -1)
(global-font-lock-mode 1) ; Enable syntax highlighting
(set-fill-column 88)
;(scroll-bar-mode nil)
(show-paren-mode t)
;(tool-bar-mode nil)

; Set load path and hooks
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'html-mode-hook 'turn-off-auto-fill)

; Key bindings
(global-set-key (kbd "\C-c f") 'recentf-open-files)
(global-set-key (kbd "\C-c g") 'revert-buffer)
(global-set-key (kbd "\C-z") 'set-mark-command); Needed for Powershell
(setq x-super-keysym 'alt) ; Set Windows/Super key to Alt

; package and use-package
(add-to-list 'package-archives
             '("melpa stable" . "https://stable.melpa.org/packages/") t)

; ace-window
(use-package ace-window
  :ensure t
  :init
  (global-set-key (kbd "M-o") 'ace-window)
  )

; ag silver searcher
(use-package ag
  :ensure t
  )

;; CSV mode
(use-package csv-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode))
  (autoload 'csv-mode "csv-mode"
    "Major mode for editing comma-separated value files." t)
  )

; Eglot
(require 'eglot)
(add-hook 'python-mode-hook 'eglot-ensure)
(add-to-list 'eglot-stay-out-of 'flymake)

;; ESS
(use-package ess
  :ensure t
  )

;; Flycheck
(use-package flycheck
  :ensure t
  :hook (after-init . global-flycheck-mode)
  :init
  )

; Flycheck YAML Lint
(use-package flycheck-yamllint
  :ensure t
  :after flycheck
  :hook (flycheck-mode . flycheck-yamllint-setup)
  )

; Flymake
(setq python-flymake-command '("ruff" "--quiet" "--stdin-filename=stdin" "-"))

; Groovy
(use-package groovy-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.\\(nf\\|config\\)\\'" . groovy-mode))
  (add-hook 'groovy-mode-hook
            (lambda ()
              (setq indent-tabs-mode nil)
              (setq tab-width 4)))
  )

; Interactively Do Things
(require 'ido)
(ido-mode t)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)
(use-package flx-ido
  :ensure t
  :init
  (flx-ido-mode t)
  ;; disable ido faces to see flx highlights.
  (setq ido-use-faces nil)
  )

;; Javascript
(defun my-js-mode-hook ()
  (setq indent-tabs-mode nil))
(add-hook 'js-mode-hook 'my-js-mode-hook)

; Magit
(use-package magit
  :ensure t
  )

; Markdown
(use-package markdown-mode
  :ensure t
  :init
  (autoload 'markdown-mode "markdown-mode"
    "Major mode for editing Markdown files" t)
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
  )

; Programming
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Projectile
(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
	      ("C-c p" . projectile-command-map))
  )

;; Python
;; Jupyter shell is hanging on remote emacs
;; (defun jupyter-config ()
;;   "Configure Jupyter shell."
;;   (interactive)
;;   (setq python-shell-interpreter "jupyter"
;; 	python-shell-interpreter-args "console --simple-prompt"
;; 	python-shell-prompt-detect-failure-warning nil)
;;   (add-to-list 'python-shell-completion-native-disabled-interpreters
;;                "jupyter")
;;   )
;; (defun python-config ()
;;   "Reset Python shell."
;;   (interactive)
;;   (setq python-shell-interpreter "python"
;; 	python-shell-interpreter-args "-i"
;; 	python-shell-prompt-detect-failure-warning t)
;;   )

; py-isort
(use-package py-isort
  :ensure t
  )

; Recent files menu
; M-x recentf-open-files
(require 'recentf)
(recentf-mode 1)

;; Saveplace save point location when buffer is killed
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (concat user-emacs-directory "places"))

; Snakemake
(use-package snakemake-mode
  :ensure t
  )

; sphinx-doc
(use-package sphinx-doc
  :ensure t
  :hook (python-mode . sphinx-doc-mode)
  )

; Uniquely named buffers
(setq uniquify-buffer-name-style 'forward)
(require 'uniquify)

; which-key
(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  )

; yaml-mode
(use-package yaml-mode
  :ensure t
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tango-dark))
 '(package-selected-packages
   '(ace-window ag csv-mode flycheck flycheck-yamllint magit
		markdown-mode projectile python-mode sphinx-doc
		use-package which-key yaml-mode))
 '(warning-suppress-types '((native-compiler))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line-buffer-id ((t nil))))
