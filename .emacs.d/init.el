(setq inhibit-startup-message t)

(scroll-bar-mode -1)						; Disable visible scrollbar
(setq maximum-scroll-margin 0.5
		scroll-margin 99999
		scroll-perserve-screen-position t
		scroll-conservatively 0)		; Scrolloff behaviour
(setq display-line-numbers-type 'relative)
(tool-bar-mode -1)						; Disable toolbar
(tooltip-mode -1)							; Disable tooltips
(set-fringe-mode 10)						; Give some breathing room
(menu-bar-mode -1)						; Disable the menu bar
(save-place-mode 1)						; Open file at last edit
(setq ring-bell-function 'ignore)	; Turn off bell

(set-face-attribute 'default nil :font "Iosevka Custom" :height 110) ; Set font

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Iosevka Custom" :height 110)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height 110 :weight 'regular)

(defvar user-temporary-file-directory
  (concat temporary-file-directory user-login-name "/"))
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist
		`(("." . ,user-temporary-file-directory)
		  (,tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
		(concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
		`((".*" ,user-temporary-file-directory t)))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Move blocks from customize interface to custom file (https://stackoverflow.com/questions/5052088/what-is-custom-set-variables-and-faces-in-my-emacs/5058752)
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
								 ("org" . "https://orgmode.org/elpa/")
								 ("elpa" . "http://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-packages on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package all-the-icons)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 25)))

(use-package doom-themes
  :init (load-theme 'doom-lena t))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package swiper
  :after ivy)

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package general
  :config
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (rune/leader-keys
   "t" '(:ignore t :which-key "toggles")
   "tt" '(counsel-load-theme :which-key "choose theme")))

;;(defun rune/evil-hook ()
;;  (dolist (mode '(custom-mode
;;		  eshell-mode
;;		  git-rebase-mode
;;		  erc-mode
;;		  circe-server-mode
;;		  circe-chat-mode
;;		  circe-query-mode
;;		  sauron-mode
;;		  term-mode))
;;    (add to list 'evil-emacs-state-modes mode)))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-want-fine-undo t)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

;; Tabs
;(define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
(setq-default tab-width 3)
(setq tab-width 3)
(setq-default tab-always-indent nil)

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))


(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(rune/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/")
	 (setq projectile-project-search-path '("~/")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode)	)

(use-package magit)
  ;:custom
  ;(magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;(use-package forge
;  :after magit)

;; Org Mode ----------------------------------

(defun uver/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent nil))

(defun uver/org-font-setup ()
  ;; Replace list hyphens with dots
  (font-lock-add-keywords 'org-mode
								  '(("^ *\\([-]\\) "
									  (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  
 (dolist (face '((org-level-1 . 1.2)
					  (org-level-2 . 1.1)
					  (org-level-3 . 1.05)
					  (org-level-4 . 1.0)
					  (org-level-5 . 1.1)
					  (org-level-6 . 1.1)
					  (org-level-7 . 1.1)
					  (org-level-8 . 1.1)))
	(set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))
  
  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))
  
(use-package org
  :hook (org-mode . uver/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"
		  org-hide-emphasis-markers t)
  (uver/org-font-setup))
	 
(use-package org-bullets
	:after org
	:hook (org-mode . org-bullets-mode)
	:custom
	(org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun uver/org-mode-visual-fill ()
	(setq visual-fill-column-width 100
			visual-fill-column-center-text t)
	(visual-fill-column-mode 1))
  
(use-package visual-fill-column
	 :hook (org-mode . uver/org-mode-visual-fill))
