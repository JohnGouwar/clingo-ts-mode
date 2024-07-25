;;; clingo-ts-mode.el --- Clingo major mode powered by treesitter

;; Copyright (C) 2024 John Gouwar

;; Author: John Gouwar <jgouwar@gmail.com>
;; Version: 0.0.0
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:
(require 'treesit)
;; Source: https://github.com/llaisdy/clingo-mode
(defvar clingo-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?' "w" table)
    (modify-syntax-entry ?% "<" table)
    (modify-syntax-entry ?\n ">" table)
    (modify-syntax-entry ?, "_ p" table)
    table)
  "Syntax table for `clingo-mode`.")


(defun clingo-ts-setup ()
  (interactive)
  (setq-local treesit-font-lock-settings
    (treesit-font-lock-rules
     :language 'clingo
     :feature 'err
     '((ERROR) @font-lock-warning-face)
     
     :language 'clingo
     :feature 'comment
     '((single_comment) @font-lock-comment-face)

     :language 'clingo
     :feature 'builtin
     '((IF) @font-lock-builtin-face)

     :language 'clingo
     :feature 'builtin
     '((COLON) @font-lock-builtin-face)

     :language 'clingo
     :feature 'builtin
     '((NOT) @font-lock-builtin-face)

     :language 'clingo
     :feature 'constant
     '((NUMBER) @font-lock-number-face)

     :language 'clingo
     :feature 'constant
     '((STRING) @font-lock-string-face)

     :language 'clingo
     :feature 'variable
     '((VARIABLE) @font-lock-variable-name-face)

     :language 'clingo
     :feature 'atom
     '((identifier) @font-lock-constant-face)

     :language 'clingo
     :feature 'keyword
     '([
	(TRUE)
	(FALSE)
	(SUPREMUM)
	(INFIMUM)
	(MAXIMIZE)
	(MINIMIZE)
	(CONST)
	(DEFINED)
	(SUM)
	(SHOW)
	(EDGE)]
       @font-lock-keyword-face)))
  (setq-local font-lock-defaults nil)
  (setq-local treesit--indent-verbose t)
  (setq-local treesit-font-lock-feature-list
	      '((comment)
		(constant atom variable builtin keyword)
		(err)))
  (setq-local treesit-font-lock-level 5)
  (setq-local treesit-simple-indent-rules
	      `((clingo
		 ((node-is "statement") column-0 0)
                 ((node-is "RPAREN") parent 0)
		 ((parent-is "bodycomma") prev-sibling 0)
		 ((parent-is "bodydot") prev-sibling 0)
		 ((parent-is "litvec") first-sibling 0)
		 ((parent-is "termvec") first-sibling 0)
		 (catch-all prev-line 2))))
  
  (treesit-major-mode-setup))

;;;###autoload 
(define-derived-mode clingo-ts-mode prog-mode "Clingo[TS]"
  "Major mode for editing AnsProlog with treesitter (as provided by Clingo)."
  :syntax-table clingo-mode-syntax-table
  (when (treesit-ready-p 'clingo)
    (treesit-parser-create 'clingo)
    (setq-local comment-start "%")
    (setq-local comment-start-skip "%+[\t ]*")
    (clingo-ts-setup)))

(provide 'clingo-ts-mode)
;;; clingo-ts-mode.el ends here
