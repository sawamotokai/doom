;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Kai Sawamoto"
      user-mail-address "kaisawamoto@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;Hack Nerd Font:pixelsize=16:foundry=SRC:weight=normal:slant=normal:width=normal:scalable=true

;; (setq doom-font (font-spec :family "Hack Nerd Font" :size 18)
;;      doom-variable-pitch-font (font-spec :family "Hack Nerd Font" :size 18)
;;      doom-big-font (font-spec :family "Hack Nerd Font" :size 18))
;; 
;; (setq doom-font (font-spec :family "Iosevka" :size 24 :weight 'light)
;;       doom-variable-pitch-font(font-spec :family "SF Pro Text" :size 20))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-snazzy)
;; (setq doom-theme 'doom-tokyo-night)
;; (setq doom-theme 'doom-moonlight)
(setq doom-theme 'doom-palenight)


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(after! org
  (setq org-directory "~/Dropbox/org/")
  (setq org-agenda-files '("~/Dropbox/org/" "~/Dropbox/org/ubc/"))
  (setq org-log-done 'time)
  (setq org-agenda-start-day "-0d")
  (setq org-ros-primary-screencapture "grim -g \"$(slurp)\" -")
  (setq org-ros-secondary-screencapture "grim")
  ; (setq org-ros-secondary-screencapture "grim")
  (setq org-clock-sound "~/Audio/SE/alarm1.mp3")
  (setq org-clock-sound t)
  (require 'org-bullets)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (setq org-bullets-bullet-list
        '(;;; Large
    "◉"
    "◆"
    "✸"
    "✜"
    "▸"
    "•"
    ;; ♥ ● ◇ ✚ ✜ ☯ ◆ ♠ ♣ ♦ ☢ ❀ ◆ ◖ ▶
    ;;; Small
    ;; ► • ★ ▸
    ))
  (custom-set-faces
   '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
   '(org-level-2 ((t (:inherit outline-2 :height 1.2))))
   '(org-level-3 ((t (:inherit outline-3 :height 1.1))))
   '(org-level-4 ((t (:inherit outline-4 :height 1.05))))
   '(org-level-5 ((t (:inherit outline-5 :height 1.02))))
   '(org-level-6 ((t (:inherit outline-5 :height 1.0)))))
  (setq org-capture-templates
    `(
      ("t" "Task" entry (file+olp "~/Dropbox/org/inbox.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)
      ("i" "Idea" entry (file+olp "~/Dropbox/org/kai.org" "Dev Ideas")
           "* IDEA %?\n  %U\n  %i" :empty-lines 1)
      ("a" "Appointment" entry (file+olp "~/Dropbox/org/kai.org" "Appointments")
           "* %?\n  %U\n  %i" :empty-lines 1)
      ("s" "Shopping" entry (file+olp "~/Dropbox/org/shopping.org" "Wishlist")
           "* %?\n  %U\n  %i" :empty-lines 1)
      ("b" "Brief" entry (file+olp "~/Dropbox/org/brief.org" "Temporary Notes")
           "* %?\n  %U\n  %i" :empty-lines 1)
      ))
  (setq org-todo-keywords
        '((sequence
           "TODO(t)"  ; A task that needs doing & is ready to do
           "NEXT(n)"  ; Next action
           "PROJ(p)"  ; A project, which usually contains other tasks
           "IDEA(i)"  ; Someday
           ;; "LOOP(r)"  ; A recurring task
           ;; "STRT(s)"  ; A task that is in progress
           "|"
           "DONE(d)"  ; Task successfully completed
           )
          (sequence
           "WAIT(w@/!)"  ; Something external is holding up this task
           "HOLD(h@/!)"  ; This task is paused/on hold because of me
           "|"
           "KILL(k@/!)") ; Task was cancelled, aborted or is no longer applicable
          (sequence
           "[ ](T)"   ; A task that needs doing
           "[-](S)"   ; Task is in progress
           "[?](W)"   ; Task is being held up or paused
           "|"
           "[X](D)")  ; Task was completed
          ;; (sequence
           ;; "|"
           ;; "OKAY(o)"
           ;; "YES(y)"
           ;; "NO(n)")
           )
        org-todo-keyword-faces
        '(("[-]"  . +org-todo-active)
          ("NEXT" . +org-todo-active)
          ("[?]"  . +org-todo-onhold)
          ("WAIT" . +org-todo-onhold)
          ("HOLD" . +org-todo-onhold)
          ("PROJ" . +org-todo-project)
          ("NO"   . +org-todo-cancel)
          ("KILL" . +org-todo-cancel)))
  (setq gtd/next-action-head "Next actions:")
  (setq gtd/waiting-head  "Waiting on:")
  (setq gtd/complete-head "Completed items:")
  (setq gtd/project-head "Projects:")
  (setq gtd/someday-head "Someday/maybe:")
  (setq gtd/inbox "Inbox:")
  (defun my-skip-completed-tasks-older-than-24h ()
  "Skip tasks that were completed more than 24 hours ago."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
        (completion-time (org-entry-get nil "CLOSED")))
    (if (and completion-time
             (< (time-to-seconds (time-since (org-parse-time-string completion-time)))
                (* 24 60 60)))
        nil
      subtree-end)))
  (setq org-agenda-custom-commands
       '(
         ("g" "GTD view"
          ((agenda ""((org-agenda-span 'day)))
           (todo "NEXT" ((org-agenda-overriding-header gtd/next-action-head)))
           (todo "WAIT" ((org-agenda-overriding-header gtd/waiting-head)))
           (tags-todo "project/-DONE" ((org-agenda-overriding-header gtd/project-head)))
           (tags "maybe"  ((org-agenda-overriding-header gtd/someday-head)))
           (tags-todo "inbox|maybe|repeater/-DONE-NEXT" ((org-agenda-overriding-header gtd/inbox)))
           (todo "DONE" ((org-agenda-overriding-header gtd/complete-head)
                         (org-agenda-skip-function 'my-skip-completed-tasks-older-than-24h)))
           ))))
  (global-set-key (kbd "C-c c") #'org-capture)
  (global-set-key (kbd "C-c a") #'org-agenda))

;; Whenever you reconfigure a package, make sure to wrap your config in an `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(setq package-selected-packages
  '(dart-mode lsp-mode lsp-dart lsp-treemacs flycheck company
    ;; Optional packages
    lsp-ui company hover org-bullets))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

(add-hook 'dart-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024))

(defun my-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (setq filename
        (concat
         (make-temp-name
          (concat (file-name-directory (buffer-file-name))
                  "images/"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (setq area (concat "\""
                     (string-trim (shell-command-to-string "slurp"))
                     "\""))
  (setq arg
        (concat " -g "
                area
                " "
                filename))
  (print arg)
  (print filename)
  (print area)
  ; (call-process "grim" nil 't nil "-g" area filename)
  (setq grim-command (concat "grim -g " area " " filename))
  (print grim-command)
  (shell-command grim-command)
  (insert (concat "[[" filename "]]"))
  (org-display-inline-images))

(use-package org-roam
  :ensure t
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n a" . org-roam-alias-add)
         ("C-c n t" . org-roam-tag-add)
         ("C-c n z" . org-roam-ui-node-zoom)
         ("C-c n d" . org-roam-dailies-capture-date)
         ("C-c n u" . org-roam-ui-open)
         ("C-c n n" . org-roam-capture))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-completion-everywhere t)
  (setq org-roam-capture-templates
   '(
     ("b" "bibliography" plain
      "%?"
      :if-new (file+head "biblio/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n#+filetags: biblio\n\n")
      :unnarrowed t)
     ("r" "reference" plain
      "%?"
      :if-new (file+head "reference/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n#+filetags: reference\n\n")
      :unnarrowed t)
     ("f" "fleeting" plain
      "%?"
      :if-new (file+head "fleeting/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n#+filetags: fleeting\n\n")
      :unnarrowed t)
     ("p" "permanent" plain
      "%?"
      :if-new (file+head "permanent/${slug}.org" "#+title: ${title}\n#+date: %U\n#+filetags: permanent\n\n")
      :unnarrowed t)
     ("s" "structure" plain
      "%?"
      :if-new (file+head "structure/${slug}.org" "#+title: ${title}\n#+date: %U\n#+filetags: structure\n\n")
      :unnarrowed t)
     ("l" "life" plain
      "%?"
      :if-new (file+head "life/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n#+filetags: life\n\n")
      :unnarrowed t)))
  (setq org-roam-directory "~/Dropbox/org/roam/")
  (setq org-roam-dailies-directory "~/Dropbox/org/roam/life/journal")
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}"))))

(after! which-key
  :config
  (setq which-key-idle-delay 0.2))


(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

;; {{ make IME compatible with evil-mode
(defun evil-toggle-input-method ()
  "when toggle on input method, goto evil-insert-state. "
  (interactive)

  ;; load IME when needed, less memory footprint
  ;; (unless (featurep 'chinese-pyim)
  ;;   (require 'chinese-pyim))

  (cond
   ((and (boundp 'evil-mode) evil-mode)
    ;; evil-mode
    (cond
     ((eq evil-state 'insert)
      (toggle-input-method))
     (t
      (evil-insert-state)
      (unless current-input-method
        (toggle-input-method))
      ))
    (if current-input-method (message "IME on!")))
   (t
    ;; NOT evil-mode, some guy don't use evil-mode at all
    (toggle-input-method))))

(defadvice evil-insert-state (around evil-insert-state-hack activate)
  ad-do-it
  (if current-input-method (message "IME on!")))

(global-set-key (kbd "C-\\") 'evil-toggle-input-method)
;; }}
