;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Who ao I
(setq user-full-name "Frédéric Willem"
      user-mail-address "frederic.willem@gmail.com")

(setq doom-font "FiraCode Nerd Font-11")
;; doom-symbol-font "Nerd Font Symbol")

(setq doom-theme 'ef-dark)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(+global-word-wrap-mode +1)
(setq projectile-project-search-path '(( "~/Repos/" . 1 )))
(after! orderless
  (add-to-list 'completion-styles 'flex t))
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-agenda-files (list "~/org/gtd"))
(setq bookmark-default-file "~/.config/doom/bookmarks" )
(setq denote-directory org-directory)
(setq org-hide-emphasis-markers t)
(after! org
  ;; for org capture chrome extension
  (require 'org-protocol)
  ;; needed by org-contacts
  (require 'ol)
  (setq org-todo-keywords
        '(
          (sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "|" "DONE(d)" "CNCLD(c@)")
          (sequence "PROJECT(p)" "|" "KILLED(k@)")))
  (setq org-tag-alist '(("@work") ("@home") ("@phone") ("@computer") ("@online") ("@errand")))
  (setq org-gtd-inbox-file "~/org/gtd/0-inbox.org")
  (add-to-list 'org-capture-templates
               '("i" "Inbox" entry
                 (file org-gtd-inbox-file)
                 "* %?\n%i\n%a"))
  (add-to-list 'org-capture-templates
               '("p" "Protocol" entry (file org-gtd-inbox-file)
                 "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?") t)
  (add-to-list 'org-capture-templates
               '("L" "Protocol Link" entry (file org-gtd-inbox-file)
                 "* %? [[%:link][%:description]] \nCaptured On: %U") t)

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
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)
(defvar org-gtd-archive-file "~/org/gtd/_gtd_archive_2024")
(setq org-archive-location (concat org-gtd-archive-file "::datetree/"))
(setq org-log-done 'time)
(after! corfu
  (setq corfu-preselect 'directory))

;;
;;; Colemak almost friendly

;; (after! evil-collection
;;   (defvar evil-colemak-dh-translations
;;     '("n" "j"  "N" "J"
;;       "e" "k"  "E" "K"
;;       "m" "h"  "M" "H"
;;       "i" "l"  "I" "L"
;;       "k" "n"  "K" "N"
;;       "h" "m"  "H" "M"
;;       "u" "i"  "U" "I"
;;       "l" "u"  "L" "U"
;;       "j" "e"  "J" "E"

;;       "gn" "gj"  "gN" "gJ"
;;       "ge" "gk"  "gE" "gK"
;;       "gm" "gh"  "gM" "gH"
;;       "gi" "gl"  "gI" "gL"
;;       "gk" "gn"  "gK" "gN"
;;       "gh" "gm"  "gH" "gM"
;;       "gu" "gi"  "gU" "gI"
;;       "gl" "gu"  "gL" "gU"
;;       "gj" "ge"  "gJ" "gE")
;;     "Evil keys to translate for the Colemak-DH keyboard layout.")

;;   ;; Translate the main evil-mode bindings.
;;   (apply #'evil-collection-translate-key
;;          nil
;;          '(evil-normal-state-map
;;            evil-motion-state-map
;;            evil-operator-state-map
;;            evil-visual-state-map
;;            evil-window-map)
;;          evil-colemak-dh-translations)

;;   ;; Install a hook to translate bindings from evil-collection.

;;   (defun evil-colemak-dh-translate-keys (mode keymaps &optional states &rest _rest)
;;     "Translate bindings for MODE in KEYMAPS for the Colemak-DH layout in STATES."
;;     (apply #'evil-collection-translate-key
;;            (or states '(normal motion visual))
;;            keymaps
;;            evil-colemak-dh-translations))
;;   (add-hook 'evil-collection-setup-hook #'evil-colemak-dh-translate-keys))

;;
;;; Email config


(require 'notmuch-mua)
(global-set-key [remap compose-mail] #'+notmuch/compose)
(after! notmuch
  (set-popup-rule! "^\\*notmuch-hello" :ignore t)
  (setq notmuch-multipart/alternative-discouraged '("text/plain" "multipart/related"))
  (setq +notmuch-mail-folder "~/.mail/")
  (setq sendmail-program "gmi")
  (setq message-sendmail-extra-arguments '("send" "--quiet" "-t" "-C" "~/.mail"))
  (setq send-mail-function 'sendmail-send-it)
  (setq message-send-mail-function 'message-send-mail-with-sendmail)
  (require 'notmuch-address)
  (setq notmuch-address-command "~/.scripts/gook")
  (map!
   :map (notmuch-search-mode-map notmuch-tree-mode-map notmuch-show-mode-map)
   :nv [remap evil-undo] #'notmuch-tag-undo
   :nv [remap evil-ex-search-next] #'notmuch-tag-jump)

  (defun +notmuch/search-trash ()
    "Flag the message."
    (interactive)
    (notmuch-search-remove-tag '("-inbox" "-unread"))
    (evil-collection-notmuch-toggle-tag "trash" "search" #'notmuch-tree-next-message)
    )
  (defun +notmuch/show-trash ()
    "Flag the message."
    (interactive)
    (notmuch-show-remove-tag'("-inbox" "-unread"))
    (evil-collection-notmuch-toggle-tag "trash" "show" #'notmuch-show-next-thread-show)
    )
  (defun +notmuch/tree-trash ()
    "Flag the message."
    (interactive)
    (notmuch-tree-remove-tag '("-inbox" "-unread"))
    (evil-collection-notmuch-toggle-tag "trash" "tree")
    )
  (global-set-key [remap evil-collection-notmuch-tree-toggle-delete] #'+notmuch/tree-trash)
  (global-set-key [remap evil-collection-notmuch-show-toggle-delete] #'+notmuch/show-trash)
  (global-set-key [remap evil-collection-notmuch-search-toggle-delete] #'+notmuch/search-trash)
  (defun +notmuch/search-flagged ()
    "Flag the message."
    (interactive)
    (notmuch-search-remove-tag '("-inbox" "-unread"))
    (evil-collection-notmuch-toggle-tag "flagged" "search" #'notmuch-tree-next-message)
    )
  (defun +notmuch/show-flagged ()
    "Flag the message."
    (interactive)
    (notmuch-show-remove-tag'("-inbox" "-unread"))
    (evil-collection-notmuch-toggle-tag "flagged" "show" #'notmuch-show-next-thread-show)
    )
  (defun +notmuch/tree-flagged ()
    "Flag the message."
    (interactive)
    (notmuch-tree-remove-tag '("-inbox" "-unread"))
    (evil-collection-notmuch-toggle-tag "flagged" "tree")
    )
  (global-set-key [remap evil-collection-notmuch-tree-toggle-flagged] #'+notmuch/tree-flagged)
  (global-set-key [remap evil-collection-notmuch-show-toggle-flagged] #'+notmuch/show-flagged)
  (global-set-key [remap evil-collection-notmuch-search-toggle-flagged] #'+notmuch/search-flagged))

;;
;;; Spelling: avoid tis

;; https://github.com/minad/jinx/
;; Faster and support multiple dictionaries out-of-the-box
(use-package! jinx
  :general ([remap ispell-word] #'jinx-correct)
  :init
  (after! evil
    (global-set-key [remap evil-next-flyspell-error] #'jinx-next)
    (global-set-key [remap evil-prev-flyspell-error] #'jinx-previous))
  (setq jinx-languages "fr_FR en_US en_GB"))

(add-hook! (prog-mode text-mode) #'jinx-mode )

;;
;;; Chezmoi

;; dotfiles management
(use-package! chezmoi
  :commands chezmoi-find
  :init
  (map! :leader
        :desc "Dotfiles" "f m" #'chezmoi-find)
  (add-to-list 'auto-minor-mode-alist '(".*chezmoi.*" . chezmoi-mode)))

;;
;;; Calendar

;; (setq      org-gcal-fetch-file-alist '(("frederic.willem@gmail.com" .  "~/org/gtd/calendar.org")))

;;
;;; Evil

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

;; (require 'ol)
(setq org-contacts-files `(,(expand-file-name (concat org-directory "contacts.org"))
                           ,(expand-file-name (concat org-directory "contacts-maman.org"))))
(setq org-contacts-matcher
      "N<>\"\"|EMAIL<>\"\"|ALIAS<>\"\"|PHONE<>\"\"|ADDRESS<>\"\"|BIRTHDAY<>\"\"")
(add-load-path! "~/.config/doom/lisp/")
(require 'gtd)
(use-package! org-contacts
  :commands org-contacts-agenda)
(map!
 :mode ( text-mode prog-mode )
 :gi "TAB"   #'yasnippet-capf
 :gi "<tab>" #'yasnippet-capf)
(map!
 :map (doom-leader-open-map)
 :desc "Org contacts" "c" #'org-contacts-agenda)
