;;; gtd.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2024 Frédéric Willem
;;
;; Author: Frédéric Willem <frederic.willem@gmail.com>
;; Maintainer: Frédéric Willem <frederic.willem@gmail.com>
;; Created: June 29, 2024
;; Modified: June 29, 2024
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/willefi/gtd
;; Package-Requires: ((emacs "27.2"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(require 'org-refile)

(defvar gtd-area-of-focus '("Family" "Work" "Health" "Personal"))
(defun gtd-single-task ()
  "Refile subtree to tasks list."
  (interactive)
  (let ((org-refile-targets '(("tasks.org" :level . 0))))
    (save-excursion
      (message (org-entry-get nil "ITEM"))
      (org-todo "NEXT")
      (org-set-property "CATEGORY" (completing-read "Select area" gtd-area-of-focus))
      (org-set-tags (completing-read "Select context" org-tag-alist)))
    (org-refile)))

(defun gtd-new-project ()
  "Refile subtree as a new project."
  (interactive)
  (let ((org-refile-targets '(("projects.org" :level . 0))))
    (org-todo "PROJECT")
    (org-set-property "CATEGORY" (org-entry-get nil "ITEM"))
    (org-refile)))

(defun gtd-new-task-in-project ()
  "Refile subtree as a new task in a project."
  (interactive)
  (let ((org-refile-targets '(("projects.org" :level . 1))))
    (save-excursion
      (org-todo "TODO")
      (org-set-tags (completing-read "Select context" org-tag-alist)))
    (org-refile)))

(defun gtd-sometimes-maybe ()
  "Refile subtree as a new task in a project."
  (interactive)
  (let ((org-refile-targets '(("someday.org" :level . 1))))
    (org-refile)))

(provide 'gtd)
;;; gtd.el ends here
