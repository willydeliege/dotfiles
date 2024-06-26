;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Wmo ao I
(setq user-full-name "Frédéric Willem"
      user-mail-address "frederic.willem@gmail.com")

(setq doom-font "FiraCode Nerd Font-11"
      doom-symbol-font "Symbols Nerd Font")

(setq doom-theme 'ef-duo-dark)

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
(setq denote-directory org-directory)
(after! org
  (setq org-gtd-inbox-file "~/org/gtd/0-inbox.org")
  (setq org-capture-templates
        '(("i" "Inbox" entry
           (file org-gtd-inbox-file)
           "* %?\n%i\n%a"))))

(setq org-agenda-custom-commands
      '(("n" "Agenda and all NEXT tasks"
         ((agenda "" nil)
          (todo "NEXT" nil))
         nil)))

(add-hook! dired-mode #'dired-hide-details-mode)

(add-hook! dired-mode #'dired-hide-details-mode)
(defvar org-gtd-archive-file "~/org/gtd/_gtd_archive_2024")
(setq org-archive-location (concat org-gtd-archive-file "::datetree/"))
(setq org-log-done 'time)
;;
;;; Colemak almost friendly

(after! evil-collection
  (defvar evil-colemak-dh-translations
    '("n" "j"  "N" "J"
      "e" "k"  "E" "K"
      "m" "h"  "M" "H"
      "i" "l"  "I" "L"
      "k" "n"  "K" "N"
      "h" "m"  "H" "M"
      "u" "i"  "U" "I"
      "l" "u"  "L" "U"
      "j" "e"  "J" "E"

      "gn" "gj"  "gN" "gJ"
      "ge" "gk"  "gE" "gK"
      "gm" "gh"  "gM" "gH"
      "gi" "gl"  "gI" "gL"
      "gk" "gn"  "gK" "gN"
      "gh" "gm"  "gH" "gM"
      "gu" "gi"  "gU" "gI"
      "gl" "gu"  "gL" "gU"
      "gj" "ge"  "gJ" "gE")
    "Evil keys to translate for the Colemak-DH keyboard layout.")

  ;; Translate the main evil-mode bindings.
  (apply #'evil-collection-translate-key
         nil
         '(evil-normal-state-map
           evil-motion-state-map
           evil-operator-state-map
           evil-visual-state-map
           evil-window-map)
         evil-colemak-dh-translations)

  ;; Install a hook to translate bindings from evil-collection.

  (defun evil-colemak-dh-translate-keys (mode keymaps &optional states &rest _rest)
    "Translate bindings for MODE in KEYMAPS for the Colemak-DH layout in STATES."
    (apply #'evil-collection-translate-key
           (or states '(normal motion visual))
           keymaps
           evil-colemak-dh-translations))
  (add-hook 'evil-collection-setup-hook #'evil-colemak-dh-translate-keys))

;;
;;; Email config

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
  (map! :localleader
        :map (notmuch-hello-mode-map notmuch-search-mode-map notmuch-tree-mode-map notmuch-show-mode-map)
        :desc "Jump to Search" "j" #'notmuch-jump-search ))

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
