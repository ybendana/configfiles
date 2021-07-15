; Set variables
(column-number-mode t)
(global-eldoc-mode -1)
(global-font-lock-mode 1) ; Enable syntax highlighting
(set-fill-column 80)
(scroll-bar-mode nil)
(show-paren-mode t)
(tool-bar-mode nil)

; Set load path and hooks
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'html-mode-hook 'turn-off-auto-fill)

; Key bindings
(global-set-key (kbd "\C-c g") (lambda () (interactive) (revert-buffer)))
(global-set-key (kbd "\C-c o") (lambda () (interactive) (other-window -1)))
(setq x-super-keysym 'alt) ; Set Windows/Super key to Alt

; Packages
(require 'package)
(add-to-list 'package-archives
             '("melpa stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

;; Install packages
(defvar myPackages
  '(
    use-package
    )
  )

;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)

; ace-window
(use-package ace-window
  :ensure t
  :init
  (global-set-key (kbd "M-o") 'ace-window)
  )

;; CSV mode
(use-package csv-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode))
  (autoload 'csv-mode "csv-mode"
    "Major mode for editing comma-separated value files." t)
  )

;; Elpy
(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  :config
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (setq elpy-modules (delq 'elpy-module-highlight-indentation elpy-modules))
  :hook
  (elpy-mode . flycheck-mode)
  )

;; Flycheck
(use-package flycheck
  :ensure t
  )
(add-hook 'after-init-hook #'global-flycheck-mode)
;(flycheck-check-syntax-automatically (quote (save mode-enabled)))

; Flycheck YAML Lint
(use-package flycheck-yamllint
  :ensure t
  )
(require 'flycheck-yamllint)
(eval-after-load 'flycheck
 '(add-hook 'flycheck-mode-hook 'flycheck-yamllint-setup))

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

;; ; Ivy
;; Hangs when C-x C-f while visiting a *.py (with or without counsel-mode)
;; https://stackoverflow.com/questions/62398175/emacs-26-3-with-ivy-counsel-hangs-on-find-file
;; (use-package counsel
;;   :ensure t
;;   :init
;;   (ivy-mode)
;;   (counsel-mode)
;;   (setq ivy-count-format "")
;;   (setq ivy-use-virtual-buffers t)
;;   )

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
(require 'python-mode)

; Recent files menu
; M-x recentf-open-files
(require 'recentf)
(recentf-mode 1)

;; Saveplace save point location when buffer is killed
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (concat user-emacs-directory "places"))

; sphinx-doc
(use-package sphinx-doc
  :ensure t
  )
(add-hook 'python-mode-hook (lambda() (require 'sphinx-doc) (sphinx-doc-mode t)))

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
 '(custom-enabled-themes (quote (tango-dark)))
 '(package-selected-packages
   (quote
    (magit counsel which-key ace-window projectile use-package sphinx-doc markdown-mode yaml-mode python-mode flycheck-yamllint csv-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line-buffer-id ((t nil))))
