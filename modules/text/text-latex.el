;;; text-latex.el --- LaTeX support -*- lexical-binding: t -*-

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

;; commentary

;;; Code:

(use-package auctex
  :load tex-site
  :mode ("\\.tex\\'" . TeX-latex-mode)
  :commands (TeX-source-correlate-mode TeX-PDF-mode)
  :functions LaTeX-math-mode
  :ghook ('LaTeX-mode-hook (list #'TeX-fold-mode #'LaTeX-math-mode #'TeX-source-correlate-mode #'TeX-PDF-mode #'flyspell-mode))
  :init
  (progn
    (setq-default TeX-master nil
                  TeX-lisp-directory (concat amalthea-emacs-dir "lib/auctex")
                  TeX-data-directory (concat amalthea-emacs-dir "lib/auctex"))
    (setq TeX-command-default "latexmk"
          TeX-command-force "latexmk"
          TeX-engine 'lualatex
          TeX-auto-save t
          TeX-parse-self t
          TeX-save-query nil
          TeX-PDF-mode t
          TeX-show-compilation nil
          TeX-syntactic-comment t
          TeX-clean-confirm t
          TeX-source-correlate-mode t
          TeX-source-correlate-method 'synctex
          TeX-source-correlate-start-server t
          LaTeX-babel-hyphen nil
          LaTeX-fill-break-at-separators nil
          TeX-view-program-selection '((output-pdf "Skim"))))

  (use-package auctex-latexmk
    :commands auctex-latexmk-setup
    :init
    (progn
      (setq auctex-latexmk-inherit-TeX-PDF-mode t)
      (auctex-latexmk-setup))))

(use-package company-auctex
  :commands company-auctex-init
  :init (company-auctex-init))

(use-package company-math
  :config
  (progn
    (add-to-list 'company-backends 'company-math-symbols-latex)
    (add-to-list 'company-backends 'company-math-symbols-unicode)
    (add-to-list 'company-backends 'company-latex-commands)))

(use-package magic-latex-buffer
  :commands magic-latex-buffer
  :ghook ('LaTeX-mode-hook #'magix-latex-buffer)
  :init
  (progn
    (setq magic-latex-enable-block-highlight t
          magic-latex-enable-suscript t
          magic-latex-enable-pretty-symbols t
          magic-latex-enable-block-align nil
          magic-latex-enable-inline-image t)))

(use-package reftex
  :commands (turn-on-reftex reftex-mode)
  :ghook ('LaTeX-mode-hook #'turn-on-reftex)
  :init
  (progn
    (setq reftex-plug-into-AUCTeX t
          reftex-use-fonts t
          reftex-default-bibliography '("~/Documents/UiB/bibliography.bib")
          reftex-toc-split-windows-fraction 0.2)))

(use-package company-reftex)

(use-package bibtex
  :config
  (progn
    (setq bibtex-dialect 'biblatex
          bibtex-align-at-equal-sign t
          bibtex-text-indentation 20
          bibtex-completion-bibliography '("~/Documents/UiB/bibliography.bib"))))

(provide 'text-latex)
;;; text-latex.el ends here