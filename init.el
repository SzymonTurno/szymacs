;; Stops startup message.
(setq inhibit-splash-screen t)

;; Set default font.
(set-face-attribute 'default nil :font "Consolas-11")

;; Maximize screen on startup.
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Disable menu on startup.
(menu-bar-mode -1)

;; Disable tools on startup.
(tool-bar-mode -1)

;; Disable scroll bar on startup.
(scroll-bar-mode -1)

;; Electric pair mode.
(electric-pair-mode 1)

;; Show cursor position.
(setq column-number-mode t)

;; Remove macro backslashes auto alignment.
(setq c-auto-align-backslashes nil)

;; Make the backspace properly erase the tab instead of
;; removing 1 space at a time.
(setq backward-delete-char-untabify-method 'hungry)

;; Add line numbering.
(add-hook 'prog-mode-hook 'global-display-line-numbers-mode)

;; Enable line highlight.
(global-hl-line-mode 1)

;; Remove sounds.
(setq visible-bell 1)

;; Set backup directory.
(setq backup-directory-alist '(("." . "~/.emacs.d/backup")))

;; Do not create lock (recovery) files.
(setq create-lockfiles nil)

;; Scroll one line.
(setq scroll-conservatively most-positive-fixnum)

;; Save session.
(desktop-save-mode 1)

;; Shortcut for single-line scrolling - down.
(defun scroll_single_line_down()
  (interactive)
  (execute-kbd-macro (read-kbd-macro "C-u 1 M-v"))
  )
(global-set-key (kbd "C-,") 'scroll_single_line_down)

;; Shortcut for single-line scrolling - up.
(defun scroll_single_line_up()
  (interactive)
  (execute-kbd-macro (read-kbd-macro "C-u 1 C-v"))
  )
(global-set-key (kbd "C-.") 'scroll_single_line_up)

;; Disable arrow keys.
(global-unset-key (kbd "<C-left>"))
(global-unset-key (kbd "<C-right>"))
(global-unset-key (kbd "<C-up>"))
(global-unset-key (kbd "<C-down>"))
(global-unset-key (kbd "<M-left>"))
(global-unset-key (kbd "<M-right>"))
(global-unset-key (kbd "<M-up>"))
(global-unset-key (kbd "<M-down>"))
(global-unset-key (kbd "<prior>"))
(global-unset-key (kbd "<next>"))
(global-unset-key (kbd "<home>"))
(global-unset-key (kbd "<end>"))

;;;; PROJECT SPECIFIC [--
;; 8 characters wide tab.
(setq c-basic-offset 8)

;; Ruler.
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(add-hook 'tex-mode-hook #'display-fill-column-indicator-mode)
(setq-default display-fill-column-indicator-column 80)
;;;; --] PROJECT SPECIFIC

;;;; EXTERNAL DEPENDENCIES [--
;; Add custom load path for themes and load path for misc.
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/misc")

;; Disable mouse.
(require 'disable-mouse)
(global-disable-mouse-mode)

;; Extend shell autocompletion with TAB.
(require 'bash-completion)
(bash-completion-setup)

;; Highlight parens when inside.
(require 'highlight-parentheses)
(add-hook 'prog-mode-hook #'highlight-parentheses-mode)

;; Rainbow delimiters.
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; Load theme and confirm that it is safe.
(load-theme 'clues t)

;; Tree sitter.
(add-to-list 'load-path "~/elisp-tree-sitter/core")
(add-to-list 'load-path "~/elisp-tree-sitter/lisp")
(add-to-list 'load-path "~/elisp-tree-sitter/langs")
(require 'tree-sitter)
(require 'tree-sitter-hl)
(require 'tree-sitter-langs)
(require 'tree-sitter-debug)
(require 'tree-sitter-query)
(add-hook 'c-mode-hook #'tree-sitter-hl-mode)
(add-hook 'cpp-mode-hook #'tree-sitter-hl-mode)

;; Indentation's vertical line.
(require 'highlight-indent-guides)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'character)
(setq highlight-indent-guides-responsive 'top)
(setq highlight-indent-guides-delay 0)
(setq highlight-indent-guides-auto-enabled 'nil)
(set-face-foreground 'highlight-indent-guides-character-face "#444")
(set-face-foreground 'highlight-indent-guides-top-character-face "#888")

;; Toggle whitespace.
(defun toggle_whitespace()
  (interactive)
  (whitespace-mode (if highlight-indent-guides-mode 1 0))
  (highlight-indent-guides-mode (if highlight-indent-guides-mode 0 1))
  )
(add-hook 'prog-mode-hook
	  (lambda ()
	     (local-set-key (kbd "C-'") 'toggle_whitespace)))

;; Remove smart indentation.
(require 'cc-mode)
(add-to-list 'c-mode-common-hook (lambda () (setq c-syntactic-indentation nil)))
;;;; --] EXTERNAL DEPENDENCIES
