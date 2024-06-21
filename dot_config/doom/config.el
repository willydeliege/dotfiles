;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 14 :weight 'semi-light))
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'ef-dark)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-agenda-files "~/org/gtd")
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
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
(use-package! evil-colemak-basics
  :after evil
  :init
  (setq evil-colemak-basics-layout-mod `mod-dh)
  (setq evil-colemak-basics-rotate-t-f-j nil)
  :config
  (global-evil-colemak-basics-mode))
(use-package! chezmoi
  :demand t)
;; :init
;; (add-to-list 'auto-minor-mode-alist '(".*chezmoi.*" . chezmoi-mode))
;; :bind (:map ctrl-z-map
;;             ("m" . chezmoi-find)))
;;

(require 'chezmoi)
(defun chezmoi--evil-insert-state-enter ()
  "Run after evil-insert-state-entry."
  (chezmoi-template-buffer-display nil (point))
  (remove-hook 'after-change-functions #'chezmoi-template--after-change 1))

(defun chezmoi--evil-insert-state-exit ()
  "Run after evil-insert-state-exit."
  (chezmoi-template-buffer-display nil)
  (chezmoi-template-buffer-display t)
  (add-hook 'after-change-functions #'chezmoi-template--after-change nil 1))

(defun chezmoi-evil ()
  (if chezmoi-mode
      (progn
        (add-hook 'evil-insert-state-entry-hook #'chezmoi--evil-insert-state-enter nil 1)
        (add-hook 'evil-insert-state-exit-hook #'chezmoi--evil-insert-state-exit nil 1))
    (progn
      (remove-hook 'evil-insert-state-entry-hook #'chezmoi--evil-insert-state-enter 1)
      (remove-hook 'evil-insert-state-exit-hook #'chezmoi--evil-insert-state-exit 1))))
(add-hook 'chezmoi-mode-hook #'chezmoi-evil)

(map! :leader
      (:prefix ("d" . "dotfiles")
       :desc "find file" "f" #'chezmoi-find
       :desc "write file" "w" #'chezmoi-write))
;; To get information about any of these functions/macros, move the cursor over
;; the highlghted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; Emails
(setq +notmuch-mail-folder "~/.mail/")
(after! notmuch
  (set-popup-rule! "^\\*notmuch-hello" :ignore t)
  (setq notmuch-multipart/alternative-discouraged '("text/plain" "multipart/related"))
  (setq sendmail-program "gmi")
  (setq message-sendmail-extra-arguments '("send" "--quiet" "-t" "-C" "~/.mail"))
  (setq send-mail-function 'sendmail-send-it)
  (setq message-send-mail-function 'message-send-mail-with-sendmail))
(map! :localleader
      :map (notmuch-hello-mode-map notmuch-search-mode-map notmuch-tree-mode-map notmuch-show-mode-map)
      :desc "Jump to Search" "j" #'notmuch-jump-search )
