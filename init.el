;; Stops startup message.
(setq inhibit-splash-screen t)

;; Set default font.
(set-face-attribute 'default nil :height 120)

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

;; Add line numbering.
(global-display-line-numbers-mode 1)

;; Enable line highlight.
(global-hl-line-mode 1)

;; Remove sounds.
(setq visible-bell 1)

;; Set backup directory.
(setq backup-directory-alist '(("." . "~/.emacs.d/backup/")))

;; Do not create lock (recovery) files.
(setq create-lockfiles nil)

;; Scroll one line.
(setq scroll-conservatively most-positive-fixnum)

;; Save session.
(desktop-save-mode 1)

;; Wrap lines with a visual mode.
;; (global-visual-line-mode 1)

;; Truncate lines.
(set-default 'truncate-lines t)

;; Region narrowing for selection replace.
(put 'narrow-to-region 'disabled nil)

;; Keybindings for scrolling.
(global-set-key (kbd "M-n") (lambda () (interactive) (scroll-down 1)))
(global-set-key (kbd "M-p") (lambda () (interactive) (scroll-up 1)))

;; Move window to the left.
(defun move_window_left()
  (interactive) (execute-kbd-macro(kbd "C-x 0 C-x 3 C-x b RET")))
(global-set-key (kbd "C-c <left>") 'move_window_left)

;; Move window to the right.
(defun move_window_right()
  (interactive) (execute-kbd-macro(kbd "C-x 0 C-x 3 C-x o C-x b RET")))
(global-set-key (kbd "C-c <right>") 'move_window_right)

;; Move window up.
(defun move_window_up()
  (interactive) (execute-kbd-macro(kbd "C-x 0 C-x 2 C-x b RET")))
(global-set-key (kbd "C-c <up>") 'move_window_up)

;; Move window down.
(defun move_window_down()
  (interactive) (execute-kbd-macro(kbd "C-x 0 C-x 2 C-x o C-x b RET")))
(global-set-key (kbd "C-c <down>") 'move_window_down)

;; Switch panels with <Shift-arrow>.
(windmove-default-keybindings)

;; Align braces with if statements.
(c-set-offset 'substatement-open 0)

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
;; Make the backspace properly erase the tab instead of removing 1 space at a time.
(setq backward-delete-char-untabify-method 'hungry)

;; 8 characters wide tab.
(setq c-basic-offset 8)
(setq-default tab-width 8)

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

;; Git - highlight changes.
(require 'diff-hl)
(require 'diff-hl-flydiff)
(global-diff-hl-mode)
(diff-hl-flydiff-mode 1)

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
(setq highlight-indent-guides-method 'bitmap)
(setq highlight-indent-guides-bitmap-function
      'highlight-indent-guides--bitmap-line)
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
            (local-set-key (kbd "C-c w") 'toggle_whitespace)))

;; Enable multiple terminals.
(require 'multi-term)
(defalias 'szyterm 'multi-term)
(setq multi-term-program "/usr/bin/bash")

;; Remove "C-y" binding from 'term-unbind-key-list' and 'term-bind-key-list'
;; to be able to use "C-u" "C-y" combo for cut and paste in terminal.
(setq term-unbind-key-list (delete "C-y" term-unbind-key-list))
(setq term-bind-key-alist
   '(("C-c C-c" . term-interrupt-subjob)
     ("C-c C-e" . term-send-esc)
     ("C-p" . previous-line)
     ("C-n" . next-line)
     ("C-s" . isearch-forward)
     ("C-r" . isearch-backward)
     ("C-m" . term-send-return)
     ("M-f" . term-send-forward-word)
     ("M-b" . term-send-backward-word)
     ("M-o" . term-send-backspace)
     ("M-p" . term-send-up)
     ("M-n" . term-send-down)
     ("M-M" . term-send-forward-kill-word)
     ("M-N" . term-send-backward-kill-word)
     ("<C-backspace>" . term-send-backward-kill-word)
     ("M-r" . term-send-reverse-search-history)
     ("M-d" . term-send-delete-word)
     ("M-," . term-send-raw)
     ("M-." . comint-dynamic-complete)))

;; Use default keybinding for line mode in multi-term.
(global-set-key (kbd "C-c C-j") 'term-line-mode)

;; MARKDOWN
;; (autoload 'markdown-mode "markdown-mode"
;;    "Major mode for editing Markdown files" t)
;; (add-to-list 'auto-mode-alist
;;              '("\\.\\(?:md\\|markdown\\|mkd\\|mdown\\|mkdn\\|mdwn\\)\\'" . markdown-mode))

;; (autoload 'gfm-mode "markdown-mode"
;;    "Major mode for editing GitHub Flavored Markdown files" t)
;; (add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;; (with-eval-after-load 'markdown-mode
;;   (define-key markdown-mode-map (kbd "C-c C-e") #'markdown-do))

;; MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

;; Load theme and confirm that it is safe.
(use-package doom-themes :ensure t)
(load-theme 'doom-sourcerer t)
;;;; --] EXTERNAL DEPENDENCIES
