;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Frédéric Willem"
      user-mail-address "frederic.willem@gmail.com")

(setq calendar-location-name "Saint-Nicolas, BE"
      calendar-latitude 50.628
      calendar-longitude 5.516)
(custom-set-variables
 '(holiday-bahai-holidays nil)
 '(holiday-hebrew-holidays nil)
 '(holiday-islamic-holidays nil))

(setq doom-font "FiraCode Nerd Font-12")
(setq doom-theme 'modus-vivendi-tinted)
;; doom-symbol-font "Nerd Font Symbol")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(+global-word-wrap-mode +1)
;; Colemak friendly au-keys
(after! ace-window
  (setq aw-keys '(?a ?r ?s ?t ?n ?e ?i ?o)))
(after! doom-modeline
  (setq! doom-modeline-persp-name t))

(use-package! gtd
  :load-path "~/.config/doom/lisp"
  :after org
  :config
  (defvar org-gtd-archive-file "~/org/gtd/_gtd_archive_2024")
  (setq org-gtd-inbox-file "~/org/gtd/0-inbox.org")
  (setq org-archive-location (concat org-gtd-archive-file "::datetree/")))
(map! :map org-mode-map :localleader
      (:prefix ("G" . "gtd")
       :desc "Single task" "s" #'gtd-single-task
       :desc "Someday/Maybe" "m" #'gtd-sometimes-maybe
       :desc "New task in project" "t" #'gtd-new-task-in-project
       :desc "New project" "p" #'gtd-new-project))

;; If you use `org' and don't want your org files in the default location below, change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-log-into-drawer t)
(setq org-agenda-files (list "~/org/gtd"))
(setq org-passwords-file "~/org/password.org.gpg")
(map!
 :leader
 :desc "Org passwords" "o p" #'org-passwords)
(setq org-hide-emphasis-markers t)
(after! org
  ;; for org capture extension
  (require 'org-protocol)
  ;; needed by org-contacts
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "|" "DONE(d)" "CNCLD(c@)")
          (sequence "PROJECT(p)" "|" "KILLED(k@)")))
  (add-to-list 'org-todo-keyword-faces '("NEXT" . +org-todo-active))
  (add-to-list 'org-todo-keyword-faces '("CNCLD" . +org-todo-cancel))
  (add-to-list 'org-todo-keyword-faces '("KILLED" . +org-todo-cancel))
  (setq org-tag-alist '(("@work") ("@home") ("@phone") ("@computer") ("@online") ("@errand")))
  (add-to-list 'org-capture-templates
               '("i" "Inbox" entry
                 (file org-gtd-inbox-file)
                 "* %?\nCaptured On: %U\n%i\n%a"))
  (add-to-list 'org-capture-templates
               '("p" "Protocol" entry (file org-gtd-inbox-file)
                 "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?") t)
  (add-to-list 'org-capture-templates
               '("L" "Protocol Link" entry (file org-gtd-inbox-file)
                 "* %? [[%:link][%:description]] \nCaptured On: %U") t)
  (add-to-list 'org-capture-templates
               '("P" "password" entry (file "~/org/password.org.gpg")
                 "* %^{Title}\n  %^{URL}p %^{USERNAME}p %^{PASSWORD}p"))

  (delete '("p" "Templates for projects")
          org-capture-templates)
  (delete '("pn" "Project-local notes" entry
            (file+headline +org-capture-project-notes-file "Inbox")
            "* %U %?\n%i\n%a" :prepend t)
          org-capture-templates)
  (delete '("n" "Personal notes" entry
            (file+headline +org-capture-notes-file "Inbox")
            "* %u %?\n%i\n%a" :prepend t)
          org-capture-templates)
  (delete '("pt" "Project-local todo" entry
            (file+headline +org-capture-project-todo-file "Inbox")
            "* TODO %?\n%i\n%a" :prepend t)
          org-capture-templates)
  (delete '("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file "* %U %?\n %i\n %a" :heading "Changelog" :prepend t)
          org-capture-templates)
  (delete '("on" "Project notes" entry #'+org-capture-central-project-notes-file "* %U %?\n %i\n %a" :heading "Notes" :prepend t)
          org-capture-templates)
  (delete '("o" "Centralized templates for projects")
          org-capture-templates)
  (delete '("t" "Personal todo" entry
            (file+headline +org-capture-todo-file "Inbox")
            "* [ ] %?\n%i\n%a" :prepend t)
          org-capture-templates)
  (delete  '("pc" "Project-local changelog" entry
             (file+headline +org-capture-project-changelog-file "Unreleased")
             "* %U %?\n%i\n%a" :prepend t)
           org-capture-templates)
  (delete '("ot" "Project todo" entry #'+org-capture-central-project-todo-file "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
          org-capture-templates))
(setq org-agenda-custom-commands
      '(("n" "Agenda and all NEXT tasks"
         ((agenda "" nil)
          (todo "NEXT" nil))
         nil)))
(add-to-list 'org-agenda-custom-commands
             '("w" "Weekly review"
               agenda ""
               ((org-agenda-start-day "-14d")
                (org-agenda-span 14)
                (org-agenda-start-on-weekday 1)
                (org-agenda-start-with-log-mode '(closed))
                (org-agenda-skip-function))))
(setq org-log-done 'time)
(use-package! denote
  :defer t
  :config
  (setq denote-directory org-directory))
(map! :leader "n d" nil)
(map! :leader
      :prefix ("n d" . "denote"))
(map! :leader
      "n d d" #'denote
      :desc "Find in notes" "n d g" #'consult-denote-grep
      :desc "Find by name" "n d n" #'consult-denote-find)
(map! :map org-mode-map
      :localleader
      :ienmv "s e" #'denote-org-extras-extract-org-subtree)

(set-frame-parameter nil 'alpha-background 90)

(add-to-list 'default-frame-alist '(alpha-background . 90))
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)
(setq bookmark-default-file "~/.config/doom/bookmarks" )

(map!
        :map corfu-map
        :i "C-g" #'corfu-quit)
(setq projectile-project-search-path '(( "~/Repos/" . 1 )))
(after! orderless
  (add-to-list 'completion-styles 'flex t))

(require 'notmuch-mua)
(require 'notmuch-address)
(setq notmuch-address-command "~/.scripts/goobook.sh")
(global-set-key [remap compose-mail] #'+notmuch/compose)
(after! notmuch
  (set-popup-rule! "^\\*notmuch-hello" :ignore t)
  (setq notmuch-multipart/alternative-discouraged '("text/plain" "multipart/related"))
  (setq +notmuch-mail-folder "~/.mail/")
  (setq sendmail-program "gmi")
  (setq message-sendmail-extra-arguments '("send" "--quiet" "-t" "-C" "~/.mail"))
  (setq send-mail-function 'sendmail-send-it)
  (setq message-send-mail-function 'message-send-mail-with-sendmail)

  (setq notmuch-saved-searches
        '((:name "inbox" :query "tag:inbox" :key "i")
          (:name "unread" :query "tag:unread" :key "u")
          (:name "flagged" :query "tag:flagged" :key "f")
          (:name "sent" :query "tag:sent" :key "t")
          (:name "drafts" :query "tag:draft" :key "d")
          (:name "all" :query "not tag:trash and not tag:deleted and not tag:spam and not tag:sent" :key "a" :search-type tree)))
  (map!
   :map (notmuch-search-mode-map notmuch-tree-mode-map notmuch-show-mode-map)
   :n "K" #'notmuch-tag-jump
   :nv [remap evil-undo] #'notmuch-tag-undo)

  (defun +notmuch/search-trash ()
    "Flag the message."
    (interactive)
    (notmuch-search-remove-tag '("-inbox" "-flagged" "-unread"))
    (evil-collection-notmuch-toggle-tag "trash" "search" #'notmuch-tree-next-message))
  (defun +notmuch/show-trash ()
    "Flag the message."
    (interactive)
    (notmuch-show-remove-tag'("-inbox" "-flagged" "-unread"))
    (evil-collection-notmuch-toggle-tag "trash" "show" #'notmuch-show-next-thread-show))
  (defun +notmuch/tree-trash ()
    "Flag the message."
    (interactive)
    (notmuch-tree-remove-tag '("-inbox" "-flagged" "-unread"))
    (evil-collection-notmuch-toggle-tag "trash" "tree"))
  (global-set-key [remap evil-collection-notmuch-tree-toggle-delete] #'+notmuch/tree-trash)
  (global-set-key [remap evil-collection-notmuch-show-toggle-delete] #'+notmuch/show-trash)
  (global-set-key [remap evil-collection-notmuch-search-toggle-delete] #'+notmuch/search-trash)
  (defun +notmuch/search-flagged ()
    "Flag the message."
    (interactive)
    (notmuch-search-remove-tag '("-inbox" "-unread"))
    (evil-collection-notmuch-toggle-tag "flagged" "search" #'notmuch-tree-next-message))
  (defun +notmuch/show-flagged ()
    "Flag the message."
    (interactive)
    (notmuch-show-remove-tag'("-inbox" "-unread"))
    (evil-collection-notmuch-toggle-tag "flagged" "show" #'notmuch-show-next-thread-show))
  (defun +notmuch/tree-flagged ()
    "Flag the message."
    (interactive)
    (notmuch-tree-remove-tag '("-inbox" "-unread"))
    (evil-collection-notmuch-toggle-tag "flagged" "tree"))
  (global-set-key [remap evil-collection-notmuch-tree-toggle-flagged] #'+notmuch/tree-flagged)
  (global-set-key [remap evil-collection-notmuch-show-toggle-flagged] #'+notmuch/show-flagged)
  (global-set-key [remap evil-collection-notmuch-search-toggle-flagged] #'+notmuch/search-flagged)

  (defun my-notmuch-mua-empty-subject-check ()
    "Request confirmation before sending a message with empty subject"
    (when (and (null (message-field-value "Subject"))
               (not (y-or-n-p "Subject is empty, send anyway? ")))
      (error "Sending message cancelled: empty subject.")))
  (add-hook 'message-send-hook 'notmuch-mua-attachment-check)
  (add-hook 'message-send-hook 'my-notmuch-mua-empty-subject-check))
(after! org-mime
  (setq org-mime-export-options '(:with-latex dvipng
                                  :section-numbers nil
                                  :with-author nil
                                  :with-toc nil))
  (add-hook 'message-send-hook 'org-mime-confirm-when-no-multipart)
  (map! :map notmuch-message-mode-map
        :localleader
        "m" #'org-mime-htmlize
        "r" #'org-mime-revert-to-plain-text-mail
        "o" #'org-mime-edit-mail-in-org-mode))

(use-package! jinx
  :general ([remap ispell-word] #'jinx-correct)
  :init
  (after! evil
    (global-set-key [remap evil-next-flyspell-error] #'jinx-next)
    (global-set-key [remap evil-prev-flyspell-error] #'jinx-previous))
  (setq jinx-languages "fr_FR en_US"))

(add-hook! (prog-mode text-mode) #'jinx-mode )

(after! evil
  (defun +evil-paste-above ()
    "Paste the line above."
    (interactive)
    (evil-insert-newline-above)
    (evil-paste-after 1 evil-this-register))

  (defun +evil-paste-below ()
    "Paste the line below."
    (interactive)
    (evil-insert-newline-below)
    (evil-paste-after 1 evil-this-register))
  (map!
   :map evil-normal-state-map
   "[ p" #'+evil-paste-above
   "] p" #'+evil-paste-below ))

(require 'ol)
(setq org-contacts-files `(,(expand-file-name (concat org-directory "contacts.org"))
                           ,(expand-file-name (concat org-directory "contacts-maman.org"))))
(setq org-contacts-matcher
      "N<>\"\"|EMAIL<>\"\"|ALIAS<>\"\"|PHONE<>\"\"|ADDRESS<>\"\"|BIRTHDAY<>\"\"")
(add-load-path! "~/.config/doom/lisp/")
(use-package! org-contacts
  :commands org-contacts-agenda)
(map!
 :leader
 :desc "Org contacts" "o c" #'org-contacts-agenda)

(map! :map search-map
      "g" #'fd-grep-dired
      "n" #'fd-name-dired)
(map! :map dired-mode-map
      :n "K" #'dired-do-kill-lines)

;; Bind your key
;; Optionally re-bind documentation to different key:
(map! :nv "gK"  #'+lookup/documentation)
(map! :leader
      :desc "Diff with file" "b d" #'diff-buffer-with-file)
(after! avy
  (setq avy-keys '(?a ?r ?s ?t ?g ?m ?n ?e ?i)))

(after! smartparens
  (require 'hydra)
  (defhydra hydra-smartparens (:hint nil)
    "
 Moving^^^^                       Slurp & Barf^^   Wrapping^^            Sexp juggling^^^^               Destructive
------------------------------------------------------------------------------------------------------------------------
 [_a_] beginning  [_n_] down      [_h_] bw slurp   [_R_]   rewrap        [_S_] split   [_t_] transpose   [_c_] change inner  [_w_] copy
 [_e_] end        [_N_] bw down   [_H_] bw barf    [_u_]   unwrap        [_s_] splice  [_A_] absorb      [_C_] change outer
 [_f_] forward    [_p_] up        [_l_] slurp      [_U_]   bw unwrap     [_r_] raise   [_E_] emit        [_k_] kill          [_g_] quit
 [_b_] backward   [_P_] bw up     [_L_] barf       [_(__{__[_] wrap (){}[]   [_j_] join    [_o_] convolute   [_K_] bw kill       [_q_] quit"
    ;; Moving
    ("a" sp-beginning-of-sexp)
    ("e" sp-end-of-sexp)
    ("f" sp-forward-sexp)
    ("b" sp-backward-sexp)
    ("n" sp-down-sexp)
    ("N" sp-backward-down-sexp)
    ("p" sp-up-sexp)
    ("P" sp-backward-up-sexp)

    ;; Slurping & barfing
    ("h" sp-backward-slurp-sexp)
    ("H" sp-backward-barf-sexp)
    ("l" sp-forward-slurp-sexp)
    ("L" sp-forward-barf-sexp)

    ;; Wrapping
    ("R" sp-rewrap-sexp)
    ("u" sp-unwrap-sexp)
    ("U" sp-backward-unwrap-sexp)
    ("(" sp-wrap-round)
    ("{" sp-wrap-curly)
    ("[" sp-wrap-square)

    ;; Sexp juggling
    ("S" sp-split-sexp)
    ("s" sp-splice-sexp)
    ("r" sp-raise-sexp)
    ("j" sp-join-sexp)
    ("t" sp-transpose-sexp)
    ("A" sp-absorb-sexp)
    ("E" sp-emit-sexp)
    ("o" sp-convolute-sexp)

    ;; Destructive editing
    ("c" sp-change-inner :exit t)
    ("C" sp-change-enclosing :exit t)
    ("k" sp-kill-sexp)
    ("K" sp-backward-kill-sexp)
    ("w" sp-copy-sexp)

    ("q" nil)
    ("g" nil)))
(map! :map prog-mode-map
      :nv "z p" #'hydra-smartparens/body)
;; TODO:  add keybinds
(after! magit
  (setq magit-diff-refine-hunk 'all))
(setq magit-todos-rg-extra-args '("--hidden"))

(defun doom-project-commander (dir)
  "Open projectile-commander for projects in DIR.

If DIR is not a project, it will be indexed (but not cached)."
  (unless (file-directory-p dir)
    (error "Directory %S does not exist" dir))
  (unless (file-readable-p dir)
    (error "Directory %S isn't readable" dir))
  (projectile-commander))
(setq! +workspaces-switch-project-function 'doom-project-commander)
