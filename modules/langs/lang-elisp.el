;;; lang-elisp.el --- Configuration for Elisp code -*- lexical-binding: t -*-

;; This file is not part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Configuration for Emacs LISP, mostly adding a few hooks here and there and
;; making it so that any files are automatically byte compiled when there exists
;; a previously byte compiled version, and adding a macro expansion library.

;;; Code:

;;; `emacs-lisp':
;; Adds auto compilation for packages and libraries on load and save if there
;; exists a newer version of it, adds `outline-minor-mode' and `reveal-mode' to
;; this mode and allows us to use `C-c e' to expand any code that contains
;; macros.
(use-package emacs-lisp
  :gfhook #'auto-compile-on-load-mode #'auto-compile-on-save-mode
  :ghook 
  ('emacs-lisp-mode-hook #'outline-minor-mode)
  ('emacs-lisp-mode-hook #'reveal-mode)
  :general
  (amalthea-major-leader 'emacs-lisp-mode-map
    "C" 'emacs-lisp-byte-compile
    "e" '(:ignore t :wk "eval")
    "e b" 'eval-buffer
    "e f" 'eval-defun
    "e r" 'eval-reqion
    "e e" 'eval-last-sexp))

;;; `auto-compile':
;; Automatically compiles any `.el' files into their byte compiled version,
;; making sure everything is up to date.
(use-package auto-compile
  :commands (auto-compile-on-save-mode auto-compile-on-load-mode)
  :config
  (auto-compile-on-load-mode)
  (auto-compile-on-save-mode)
  (setq auto-compile-display-buffer nil             ;; Don't automatically show the *Compile Log* buffer
        auto-compile-mode-line-counter t            ;; Display number of warnings in modeline
        auto-compile-source-recreate-deletes-dest t ;; Delete leftover byte code when recompiling
        auto-compile-toggle-deletes-nonlib-dest t   ;; Delete non-library byte code
        auto-compile-update-autoloads t)            ;; Update autoloads after compiling
  (add-hook 'auto-compile-inhibit-compile-hook 'auto-compile-inhibit-compile-detached-git-head))

;;; `macrostep':
;; This is a hydra that we'll use together with the package itself, this makes
;; it really easy to quickly work your way through macros as you are working on
;; them or using them.
(defhydra hydra-macrostep (:color pink)
  "macrostep"
  ("q" macrostep-collapse-all "collapse all macros" :color blue)
  ("c" macrostep-collapse "collapse macro")
  ("e" macrostep-expand "expand macro")
  ("j" macrostep-next-macro "next macro")
  ("k" macrostep-prev-macro "prev macro"))

(use-package macrostep
  :general
  (amalthea-major-leader 'emacs-lisp-mode-map
    "m" 'hydra-macrostep/body))

;;; Hide some minor modes and rename the major mode
(delight '((emacs-lisp-mode "Elisp" :major)
           (eldoc-mode nil "eldoc")
           (outline-minor-mode nil "outline")
           (reveal-mode nil "reveal")))

(provide 'lang-elisp)
;;; lang-elisp.el ends here
