;;; markdown.el --- Markdown support -*- lexical-binding: t -*-

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

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init
  (setq-am markdown-command "pandoc --from=markdown --to=html --standalone --mathjax"
           "Use pandoc to convert documents from markdown to HTML")
  (setq-am markdown-enable-wiki-links t "Syntax highlighting for wiki links")
  (setq-am markdown-italic-underscore t "Use underscores for italic text")
  (setq-am markdown-make-gfm-checkboxes-buttons t "Make checkboxes into buttons you can interact with")
  (setq-am markdown-gfm-additional-languages '("sh") "Add `sh' as a language to convert")
  (setq-am markdown-fontify-code-blocks-natively t) "Highlight code using the languages major mode")

(use-package imenu-list
  :init
  (setq-am imenu-auto-rescan t "Always automatically update buffer")
  (setq-am imenu-list-auto-resize t "Update size after refresh"))

(provide 'markdown)

;;; markdown.el ends here