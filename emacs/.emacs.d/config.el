(add-hook 'text-mode-hook 'visual-line-mode)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq inhibit-startup-screen t)
(setq scroll-conservatively 100)
(setq make-backup-files nil)
(setq create-lockfiles nil)
(setq auto-save-default nil)
(setq ring-bell-function 'ignore)
(set-frame-font "Iosevka 10" nil t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-set-key (kbd "C-x C-<up>") 'shrink-window)
(global-set-key (kbd "C-x C-<down>") 'enlarge-window)
(global-set-key (kbd "C-x C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-x C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "<prior>") 'good-scroll-down)
(global-set-key (kbd "<next>") 'good-scroll-up)
(global-set-key (kbd "C-S-n") 'good-scroll-up)
(global-set-key (kbd "C-S-p") 'good-scroll-down)
(global-set-key (kbd "C-c n r") 'replace-regexp)
(global-set-key (kbd "C-<tab>") 'tab-recent)
(global-set-key (kbd "C-S-<tab>") 'tab-next)
(global-set-key "\C-x3" (lambda () (interactive)(split-window-horizontally) (other-window 1)))
(setq pixel-scroll-precision-large-scroll-height 40.0)
(pixel-scroll-mode 1)
(good-scroll-mode 1)
(setq mouse-wheel-progressive-speed nil)

(defun config-reload ()
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))

(defun kill-all-other-buffer ()
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(defun switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer nil))

(global-set-key (kbd "C-c b") 'switch-to-last-buffer)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(use-package rmsbolt)

(use-package good-scroll)
(global-set-key (kbd "<prior>") 'good-scroll-down)
(global-set-key (kbd "<next>") 'good-scroll-up)
(global-set-key (kbd "C-S-n") 'good-scroll-up)
(global-set-key (kbd "C-S-p") 'good-scroll-down)

(use-package ewal
  :init (setq ewal-use-built-in-always-p nil
		ewal-use-built-in-on-failure-p t))
(use-package ewal-spacemacs-themes
  :config (progn
	      (load-theme 'ewal-spacemacs-modern t)
	      (enable-theme 'ewal-spacemacs-modern)))
;; config-reload command via sway config

;;  (use-package tron-legacy-theme
;;  :config
;;  (load-theme 'tron-legacy t))

(use-package which-key
  :ensure t
  :init (which-key-mode))

(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)
(use-package ido-vertical-mode
  :ensure t
  :init
  (ido-vertical-mode 1))
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
(global-set-key (kbd "C-x b") 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(setq ibuffer-expert t)

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(use-package avy
:ensure t
:bind
("M-s" . avy-goto-char-2))

(use-package ace-window
  :ensure t
  :config
  (setq aw-background nil)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))
(global-set-key (kbd "M-o") 'ace-window)

(use-package swiper)
(global-set-key "\C-s" 'swiper)

(use-package ivy)
(ivy-mode)

(use-package org
  :config
  (setq org-log-done-with-time nil)
  (setq org-log-done nil)
  (setq org-log-repeat nil)
  (setq org-ellipsis " ▾")
  ;(setq org-directory "~/org")
  ;(setq org-agenda-files '("~/org/roam/"))
  (setq org-agenda-files (directory-files-recursively "~/org/roam" org-agenda-file-regexp))
  (setq org-refile-targets
	'(("archive.org" :maxlevel . 1)))
  (advice-add 'org-refile :after 'org-save-all-org-buffers)
  (setq org-todo-keywords
	'((sequence "TODO(t)" "GOALS(g)" "BOOK(b)" "HABIT(h)" "PROJECTS(p)" "|" "DONE(d)")))
(add-to-list 'org-structure-template-alist '("em" . "src emacs-lisp"))
:bind
(("C-c a" . org-agenda)
 ("C-c c" . calendar)))

(use-package org-journal
  :config
  (setq org-journal-dir "~/org/journal")
  :bind
  (("C-c j o" . org-journal-new-entry)))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(use-package elfeed-org)
(use-package elfeed
:config
(setq rmh-elfeed-org-files (list "~/org/elfeed.org")))
(elfeed-org)

(use-package latex-preview-pane
:load-path "~/dotfiles/emacs/latex-preview-pane"
)

(use-package org-roam
:ensure t
:custom
(org-roam-directory "~/org/roam")
:bind (("C-c n l" . org-roam-buffer-toggle)
	     ("C-c n f" . org-roam-node-find)
	     ("C-c n i" . org-roam-node-insert)
	     ("C-c n o" . org-roam-ui-mode)
	     ("C-c n z" . org-roam-ui-node-zoom)
	     ("C-c n c" . org-id-get-create))
:config
(org-roam-setup))

(use-package org-roam-ui
  :load-path "~/.emacs.d/org-roam-ui"
  :after org-roam
  :config
  (setq org-roam-ui-open-on-start nil
	org-roam-ui-follow t
	org-roam-ui-sync-theme t
	org-roam-ui-update-on-save t))

(use-package calfw)
(use-package calfw-cal)
(use-package calfw-org)

(use-package org-super-agenda)
(org-super-agenda-mode)
(setq org-super-agenda-groups
	'(
	  (:name "Search"
		 :tag "org_search")
	  (:name "Questions"
		 :tag "org_question")
	  (:name "Empty"
		 :tag "org_empty")
	  ))
(setq org-agenda-remove-tags t)
(setq org-agenda-use-time-grid nil)

(use-package org-download)

(org-roam-ui-mode)
(org-agenda-list)
(org-agenda-day-view)
(delete-other-windows)
