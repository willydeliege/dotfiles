;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; test
(setq doom-font "FiraCode Nerd Font-12")
(setq shell-file-name (executable-find
                       "bash"))
(setq-default vterm-shell
              "/usr/bin/fish")
(setq-default explicit-shell-file-name
              "/usr/bin/fish")
(setq shell-file-name (executable-find
                       "bash"))
(setq doom-theme 'doom-homage-black)
;; doom-symbol-font "Nerd Font Symbol")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(+global-word-wrap-mode +1)
(after! doom-modeline
  (setq! doom-modeline-persp-name t))

(setq user-full-name "Frédéric Willem"
      user-mail-address "frederic.willem@gmail.com")

(setq calendar-location-name "Saint-Nicolas, BE"
      calendar-latitude 50.628
      calendar-longitude 5.516)
(custom-set-variables
 '(holiday-bahai-holidays nil)
 '(holiday-hebrew-holidays nil)
 '(holiday-islamic-holidays nil))

;; If you use `org' and don't want your org files in the default location below, change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-gtd-inbox-file "~/org/gtd/0-inbox.org")
(defvar org-gtd-archive-file "~/org/gtd/_gtd_archive.org")
(setq org-archive-location (concat org-gtd-archive-file "::datetree/"))
;; (setq org-log-into-drawer t)

(require 'org-agenda)
(setq org-agenda-entry-text-maxlines 3) ;; show up to 3 lines
(setq org-agenda-entry-text-leaders "    ") ;; indentation for the text
(setq org-passwords-file "~/org/password.org.gpg")
(map!
 :leader
 :desc "Org passwords" "o p" #'org-passwords)
(setq org-hide-emphasis-markers t)
(after! org
  ;; for org capture extension
  ;; (require 'org-protocol)
  ;; needed by org-contacts
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "|" "DONE(d)" "CNCLD(c@)")
          (sequence "PROJECT(p)" "|" "KILLED(k@)")))
  (add-to-list 'org-todo-keyword-faces '("NEXT" . +org-todo-active))
  (add-to-list 'org-todo-keyword-faces '("CNCLD" . +org-todo-cancel))
  (add-to-list 'org-todo-keyword-faces '("KILLED" . +org-todo-cancel))
  (setq org-tag-alist '(("@work") ("@home") ("@phone") ("@computer") ("@online") ("@errand")))

  (setq! org-capture-templates
         '(("f" "Fleeting note"
            entry
            (file+headline org-gtd-inbox-file "Notes")
            "* %?")
           ("t" "New task" entry
            (file+headline org-gtd-inbox-file "Tasks")
            "* TODO %i%?")
	   )))
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
(map! :map org-agenda-mode-map :n "g x" 'org-agenda-entry-text-mode)
;; (map! :map org-agenda-mode-map :localleader "E" 'org-agenda-entry-text-mode)
(setq org-log-done 'time)
(use-package! denote
  :defer t
  :config
  (add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)
  (setq denote-directory "~/org/roam"))

(map! :leader
      :desc "Open graph" "n r g" #'org-roam-ui-open
      :desc "Random by tag" "n r A" #'my/org-roam-random-node-by-tag)

(map! :after org
      :map org-mode-map
      :localleader
      :prefix ("m" . "org-roam")
      "g" #'org-roam-ui-open
      "x" #'denote-rename-file-using-front-matter)
(setq org-roam-capture-templates
      `(("d" "default" plain "%?"
         :target (file+head "%(my/org-roam-filename \"${title}\")"
                            "%(my/org-roam-template)")
         :immediate-finish t
         :unnarrowed t)))

(defun my/org-roam-filename (title)
  (let ((id (denote-get-identifier (current-time)))
        (tags (completing-read-multiple "New note KEYWORDS: "
                                        (org-roam-tag-completions))))
    (setq my/org-roam-capture-id id
          my/org-roam-capture-title title
          my/org-roam-capture-tags tags)
    (denote--keywords-add-to-history tags)
    (thread-first
      (denote-format-file-name "/" id tags title ".org" nil)
      (substring 1))))

(defun my/org-roam-template ()
  (let* ((filetags (if my/org-roam-capture-tags
                       (concat ":" (mapconcat #'identity my/org-roam-capture-tags ":") ":")))
         (front-matter (concat ":PROPERTIES:\n"
                               ":ID:        " my/org-roam-capture-id "\n"
                               ":END:\n"
                               "#+title:    " my/org-roam-capture-title "\n"
                               "#+filetags: " filetags "\n\n"
                               "* " my/org-roam-capture-title
                               "\n* Related")))
    (setq my/org-roam-capture-id nil
          my/org-roam-capture-title nil
          my/org-roam-capture-tags nil)
    front-matter))
(defun my/org-roam-random-node-by-tag ()
  "Prompt for a tag with completion and open a random Org-roam node that has that tag."
  (interactive)
  (require 'org-roam)

  ;; Gather all tags used in org-roam
  (let* ((all-tags (delete-dups (flatten-tree
                                 (mapcar (lambda (node)
                                           (org-roam-node-tags node))
                                         (org-roam-node-list)))))
         ;; Prompt for a tag with completion
         (chosen-tag (completing-read "Choose a tag: " all-tags nil t))
         ;; Filter nodes by tag
         (filtered-nodes (seq-filter (lambda (node)
                                       (member chosen-tag (org-roam-node-tags node)))
                                     (org-roam-node-list))))
    (if filtered-nodes
        ;; Pick a random node from filtered list and visit it
        (org-roam-node-visit (nth (random (length filtered-nodes)) filtered-nodes))
      (message "No nodes found with tag: %s" chosen-tag))))

(set-frame-parameter nil 'alpha-background 90)

(add-to-list 'default-frame-alist '(alpha-background . 90))
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)
(setq bookmark-default-file "~/.config/doom/bookmarks" )

(map!
        :map corfu-map
        :i "C-g" #'corfu-quit)
(after! orderless
  (add-to-list 'completion-styles 'flex t))

(use-package! jinx
  :general ([remap ispell-word] #'jinx-correct)
  :init
  (after! evil
    (global-set-key [remap evil-next-flyspell-error] #'jinx-next)
    (global-set-key [remap evil-prev-flyspell-error] #'jinx-previous))
  (setq jinx-languages "fr_FR en_US"))

(add-hook! (prog-mode text-mode) #'jinx-mode )

(after! evil
  (map! :map evil-org-agenda-mode-map
        "g x" #'org-agenda-entry-text-mode)
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
(after! dired
  (add-hook 'dired-mode-hook #'dired-hide-details-mode))

;; Bind your key
;; Optionally re-bind documentation to different key:
(map! :nv "gK"  #'+lookup/documentation)
(map! :leader
      :desc "Diff with file" "b d" #'diff-buffer-with-file)

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
