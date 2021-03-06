(setq-default gc-cons-threshold 100000000)

(run-with-idle-timer
 5 nil
 (lambda ()
  (setq gc-cons-threshold 1000000)
  (message "gc-cons-threshold restored to %S"
           gc-cons-threshold)))

(let ((file-name-handler-alist nil)) '~/.emacs.d/init.el)

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

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

(use-package no-littering)

(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(if (daemonp)
    (add-hook 'after-make-frame-functions
        (lambda (frame)
            (with-selected-frame (or frame (selected-frame))
                (load-theme 'lena t))))
                  (load-theme 'lena t))

(setq inhibit-startup-message t)

(scroll-bar-mode -1)                       ; Disable visible scrollbar
(setq maximum-scroll-margin 0.5            ; Scrolloff behaviour
      scroll-margin 99999
      scroll-perserve-screen-position t
      scroll-conservatively 0)	
(setq display-line-numbers-type 'relative)
(tool-bar-mode -1)                         ; Disable toolbar
(tooltip-mode -1)                          ; Disable tooltips
(set-fringe-mode 10)                       ; Give some breathing room
(menu-bar-mode -1)                         ; Disable the menu bar
(save-place-mode 1)                        ; Open file at last edit
(blink-cursor-mode 0)                      ; Disable blinking cursor
(setq ring-bell-function 'ignore)          ; Turn off bell

;; Move blocks from customize interface to custom file (https://stackoverflow.com/questions/5052088/what-is-custom-set-variables-and-faces-in-my-emacs/5058752)
;; (setq custom-file "~/.emacs.d/custom.el")
;; (load custom-file)

;; Line Numbers
(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(defun uver/set-font-faces ()
  (message "Setting faces!")

  ;; Set the default font
  ;; (set-face-attribute 'default nil :font "Iosevka Custom" :height 110)
  (set-frame-font "Iosevka Custom" nil t)

  ;; Set the fixed pitch face
  ;; (set-face-attribute 'fixed-pitch nil :font "Iosevka Custom" :height 110)
  (set-frame-font 'fixed-pitch "Iosevka Custom")

  ;; Set the variable pitch face
  ;; (set-face-attribute 'variable-pitch nil :font "Cantarell" :height 110 :weight 'regular)
  (set-frame-font 'variable-pitch "Cantarell"))

  ;; add-to-list 'default-frame-alist '(font . "Iosevka Custom"))

  (if (daemonp)
     (add-hook 'after-make-frame-functions
        (lambda (frame)
           (setq doom-modeline-icon t)
           (with-selected-frame frame
              (uver/set-font-faces))))
  (uver/set-font-faces))



;; (use-package colemak-mode
    ;; :straight (colemak-mode :local-repo "~/.emacs.d/colemak/")
    ;; :bind (("C-c c" . colemak-mode)))

;; Make ESC quit prompts
;; (global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "<escape>") 'ryo-enter)

;; Ignore keys
(global-set-key (kbd "<XF86AudioPrev>") 'ignore)
(global-set-key (kbd "<XF86AudioNext>") 'ignore)
(global-set-key (kbd "<XF86VolumeUp>") 'ignore)
(global-set-key (kbd "<XF86VolumeDown>") 'ignore)

;; (use-package general
;;   :config
;;   (general-create-definer uver/leader-keys
;;     :keymaps '(normal insert visual emacs ryo-modal-mode)
;;     :prefix "SPC"
;;     :global-prefix "C-SPC")

;;   (uver/leader-keys
;;    "t" '(:ignore t :which-key "toggles")
;;    "ts" '(hydra-text-scale/body :which-key "scale text")
;;    "tt" '(counsel-load-theme :which-key "choose theme")))

;;(defun uver/evil-hook ()
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

(use-package kakoune
  ;; Having a non-chord way to escape is important, since key-chords don't work in macros
  ;; :bind ("ESC" . ryo-modal-mode)
  :defer t
  :bind ("C-z" . ryo-modal-mode)
  :hook (after-init . uver/kakoune-setup)
  :config
  (defun ryo-enter () "Enter normal mode" (interactive) (ryo-modal-mode 1))
  (defun uver/kakoune-setup ()
   "Call kakoune-setup-keybinds and then add some personal config."
   (kakoune-setup-keybinds)
   (setq ryo-modal-cursor-type 'box)
   (add-hook 'prog-mode-hook #'ryo-enter)
   (define-key ryo-modal-mode-map (kbd "SPC h") 'help-command)
   ;; Access all C-x bindings easily
   (define-key ryo-modal-mode-map (kbd "z") ctl-x-map)
   (ryo-modal-keys
    ;; ("ESC" keyboard-escape-quit)
    ("SPC w" save-buffer)
    ("SPC q" kill-buffer)
    ("SPC ts" hydra-text-scale/body)
    ("n" backward-char)
    ("e" next-line)
    ("i" previous-line)
    ("o" forward-char)
    ("g n" beginning-of-line)
    ("g e" end-of-buffer)
    ("g i" beginning-of-buffer)
    ("g o" end-of-line)
    ("q" backward-word)
    ("Q" backward-word)
    ("L" kakoune-O :exit t)
    ("l" kakoune-o :exit t)
    ("h" kakoune-insert-mode)
    ("H" back-to-indentation :exit t)
    ("b" counsel-ibuffer)
    ("B" ibuffer)
    ("P" counsel-yank-pop)
    ("M-m" mc/edit-lines)
    ("#" comment-or-uncomment-region)
    ("*" mc/mark-all-like-this)
    ("v" er/expand-region)
    ("C-v" set-rectangular-region-anchor)
    ("M-s" mc/split-region)
    (";" kakoune-deactivate-mark)
    ("C-n" windmove-left)
    ("C-e" windmove-down)
    ("C-i" windmove-up)
    ("C-o" windmove-right)
    ("/" swiper)
    ("C-u" scroll-down-command :first '(deactivate-mark))
    ("C-d" scroll-up-command :first '(deactivate-mark)))))

 (setq ryo-modal-cursor-color "#8C56EB")

 (add-hook 'prog-mode-hook #'ryo-modal-mode)
 (add-hook 'text-mode-hook #'ryo-modal-mode)

(use-package visual-regexp
  :ryo
  ("s" vr/mc-mark)
  ("?" vr/replace)
  ("M-/" vr/query-replace))

(use-package phi-search
  :bind (("C-s" . phi-search)
         ("C-r" . phi-search-backward)))

(use-package undo-tree
  :config
  (global-undo-tree-mode)
  :ryo
  ("u" undo-tree-undo)
  ("U" undo-tree-redo)
  ("SPC u" undo-tree-visualize)
  :bind (:map undo-tree-visualizer-mode-map
              ("n" . undo-tree-visualize-switch-branch-left)
              ("e" . undo-tree-visualize-redo)
              ("i" . undo-tree-visualize-undo)
              ("o" . undo-tree-visualize-switch-branch-right)))

;; (use-package evil
;;   :init
;;   (setq evil-want-integration t)
;;   (setq evil-want-keybinding nil)
;;   (setq evil-want-C-u-scroll t)
;;   (setq evil-want-C-i-jump nil)
;;   (setq evil-want-fine-undo t)
;;   :config
;;   (evil-mode 1)
;;   (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)

;;   ;; Use visual line motions even outside of visual-line-mode buffers
;;   (evil-global-set-key 'motion "j" 'evil-next-visual-line)
;;   (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

;;   (evil-set-initial-state 'messages-buffer-mode 'normal)
;;   (evil-set-initial-state 'dashboard-mode 'normal))

;; Tabs
;(define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
(setq-default tab-width 3)
(setq tab-width 3)
(setq-default tab-always-indent nil)

;; (use-package evil-collection
;;   :after evil
;;   :config
;;   (evil-collection-init))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

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

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package swiper
  :after ivy)

;; For showing recently used commands first
;; Check on prescient.el
(use-package smex)

;; Lazy load recent commands
(defun smex-update-after-load (unused)
  (when (boundp 'smex-cache)
    (smex-update)))
(add-hook 'after-load-functions 'smex-update-after-load)

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

;; (load-theme 'lena t)

(use-package all-the-icons)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 25)))

;; (use-package doom-themes
;;   :init (load-theme 'doom-elena t))

;; (setq evil-motion-state-cursor '("white" box)	   ; Evil motion cursor shape
;;       evil-visual-state-cursor '("white" box)	   ; Evil visual cursor shape
;;       evil-normal-state-cursor '("white" box)	   ; Evil normal cursor shape
;;       evil-insert-state-cursor '("white" hbar)   ; Evil insert cursor shape
;;       evil-emacs-state-cursor '("white" bar))	   ; Evil emacs cursor shape

(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("i" text-scale-increase "in")
  ("e" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

;; (uver/leader-keys
  ;; "ts" '(hydra-text-scale/body :which-key "scale text"))

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
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

(defun uver/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1))

  ;; (setq evil-auto-indent nil))

  ;; (with-eval-after-load 'org-indent (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch)))

(use-package org
  :pin org
  :commands (org-capture org-agenda)
  :hook (org-mode . uver/org-mode-setup)
  :config
  ;; (setq org-ellipsis " ▾")
  ;; (setq org-ellipsis " ⤵")
  (setq org-ellipsis " ↴"
        org-hide-emphasis-markers t)
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-agenda-files
     '("~/org-test/tasks.org"
       "~/org-test/habits.org"
       "~/org-test/birthdays.org"))

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)

  (setq org-todo-keywords
     '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
       (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-refile-targets
      '(("archive.org" :maxlevel . 1)
        ("tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (setq org-task-alist
        '((:startgroup)
          ; Put mutually exclusive tags here
          (:endgroup)
          ("@errand" . ?E)
          ("@home" . ?H)
          ("@work" . ?W)
          ("agenda" . ?a)
          ("planning" . ?p)
          ("publish" . ?p)
          ("batch" . ?b)
          ("note" . ?n)
          ("idea" . ?i)))

  ;; Configure custom agenda views
  (setq org-agenda-custom-commands
   '(("d" "Dashboard"
     ((agenda "" ((org-deadline-warning-days 7)))
      (todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))
      (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

    ("n" "Next Tasks"
     ((todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))))

    ("W" "Work Tasks" tags-todo "+work-email")

    ;; Low-effort next actions
    ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
     ((org-agenda-overriding-header "Low Effort Tasks")
      (org-agenda-max-todos 20)
      (org-agenda-files org-agenda-files)))

    ("w" "Workflow Status"
     ((todo "WAIT"
            ((org-agenda-overriding-header "Waiting on External")
             (org-agenda-files org-agenda-files)))
      (todo "REVIEW"
            ((org-agenda-overriding-header "In Review")
             (org-agenda-files org-agenda-files)))
      (todo "PLAN"
            ((org-agenda-overriding-header "In Planning")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "BACKLOG"
            ((org-agenda-overriding-header "Project Backlog")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "READY"
            ((org-agenda-overriding-header "Ready for Work")
             (org-agenda-files org-agenda-files)))
      (todo "ACTIVE"
            ((org-agenda-overriding-header "Active Projects")
             (org-agenda-files org-agenda-files)))
      (todo "COMPLETED"
            ((org-agenda-overriding-header "Completed Projects")
             (org-agenda-files org-agenda-files)))
      (todo "CANC"
            ((org-agenda-overriding-header "Cancelled Projects")
             (org-agenda-files org-agenda-files)))))))

  (setq org-capture-templates
    `(("t" "Tasks / Projects")
      ("tt" "Task" entry (file+olp "~/org-test/tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

      ("j" "Journal Entries")
      ("jj" "Journal" entry
           (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
           "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
           :clock-in :clock-resume
           :empty-lines 1)
      ("jm" "Meeting" entry
           (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
           "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1)

      ("w" "Workflows")
      ("we" "Checking Email" entry (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
           "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)

      ("m" "Metrics Capture")
      ("mw" "Weight" table-line (file+headline "~/Projects/Code/emacs-from-scratch/OrgFiles/Metrics.org" "Weight")
       "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t)))

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

(with-eval-after-load 'org
  (org-babel-do-load-languages
     'org-babel-load-languages
     '((emacs-lisp . t)
       (python . t))))

  ;; (push '("conf-unix" . conf-unix) org-src-lang-modes)

  (setq org-src-tab-acts-natively t)

(with-eval-after-load 'org
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("j" . "src java")))

;; Automatically tangle Emacs.org confile file when saved
(defun uver/org-babel-tangle-config ()
   (when (string-equal (buffer-file-name)
                       (expand-file-name "~/.emacs.d/emacs.org"))
   ;; Dynamic scoping
   (let ((org-config-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'uver/org-babel-tangle-config)))

(use-package hide-mode-line)

(defun uver/presentation-setup ()
    ;; Hide the modeline
    (hide-mode-line-mode 1)

    ;; Display images inline
    (org-display-inline-images)

    ;; Enlarge text
    (setq text-scale-mode-amount 3)
    (text-scale-mode 1))

(defun uver/presentation-end ()
    ;; Reshow the modeline
    (hide-mode-line-mode 0)

    (text-scale-mode 0))

(use-package org-tree-slide
    :hook ((org-tree-slide-play . uver/presentation-setup)
           (org-tree-slide-stop . uver/presentation-end))
    :custom
    (org-image-actual-width nil)
    (org-tree-slide-slide-in-effect t)
    (org-tree-slide-activate-message "Presentation started!")
    (org-tree-slide-deactivate-message "Presentation finished!")
    (org-tree-slide-header t)
    (org-tree-slide-breadcrumbs " ❯ "))

;;(use-package evil-nerd-commenter
;;  :bind ("M-/" . comment-or-uncomment-lines))

(add-to-list 'auto-mode-alist '("\\.*rc$" . conf-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(defun uver/lsp-mode-setup()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . uver/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")    ;; Or 'C-l' or 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  ;;:bind (:map company-active-map
  ;;       ("<tab>" . company-complete-selection))
  ;; (:map lsp-mode-map
  ;;        ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

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
  :config (counsel-projectile-mode))

(use-package magit)
   ;:custom
   ;(magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)

;(use-package forge
;  :after magit)

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first")))
  ;; :config
  ;; (evil-collection-define-key 'normal 'dired-mode-map
    ;; "h" 'dired-single-up-directory
    ;; "l" 'dired-single-buffer))

(use-package dired-single)

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-open
  :config
  (setq dired-open-extensions '(("png" . "feh")
                                ("jpg" . "feh")
                                ("jpeg" . "feh") 
                                ("mp4" . "mpv")
											 ("webm" . "mpv")
                                ("mvk" . "mpv"))))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode))
  ;; :config
  ;; (evil-collection-define-key 'normal 'dired-mode-map
    ;; "H" 'dired-hide-dotfiles-mode))

(use-package term
  :config
  (setq explicit-shell-file-name "zsh")
  (setq explicit-zsh-args '())

  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package vterm
  :commands vterm
  :config
  (setq vterm-shell "zsh")
  (setq vterm-max-scrollback 10000))

(defun uver/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  ;; Bind some useful keys for evil-mode
  ;; (evil-define-key '(normal insert visual) eshell-mode-map (kbd "C-r") 'counsel-esh-history)
  ;; (evil-define-key '(normal insert visual) eshell-mode-map (kbd "<home>") 'eshell-bol)
  ;; (evil-normalize-keymaps)

  (setq eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package eshell-git-prompt)

(use-package eshell
  :hook (eshell-first-time-mode . uver/configure-eshell)
  :config

  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim"))))

  ;; (eshell-git-prompt-use-theme 'powerline)

(setq flyspell-issue-message-flag nil)

(dolist (hook '(text-mode-hook))
    (add-hook hook (lambda () (flyspell-mode 1))))

(dolist (hook '(change-log-mode log-edit-mode-hook))
    (add-hook hook (lambda () (flyspell-mode -1))))

(use-package hide-mode-line)

(defun uver/presentation-setup ()
    ;; Hide the modeline
    (hide-mode-line-mode 1)

    ;; Display images inline
    (org-display-inline-images)

    ;; Enlarge text
    (setq text-scale-mode-amount 3)
    (text-scale-mode 1))

(defun uver/presentation-end ()
    ;; Reshow the modeline
    (hide-mode-line-mode 0)

    (text-scale-mode 0))

(use-package org-tree-slide
    :hook ((org-tree-slide-play . uver/presentation-setup)
           (org-tree-slide-stop . uver/presentation-end))
    :custom
    (org-image-actual-width nil)
    (org-tree-slide-slide-in-effect t)
    (org-tree-slide-activate-message "Presentation started!")
    (org-tree-slide-deactivate-message "Presentation finished!")
    (org-tree-slide-header t)
    (org-tree-slide-breadcrumbs " ❯ "))
