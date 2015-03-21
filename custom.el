;;(add-to-list 'load-path "~/.emacs.d/custom/")
;;(require 'rvm)
;;(require 'helm-config)

(add-to-list 'default-frame-alist
                       '(font . "Meslo LG L-10"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (spacegray)))
 '(custom-safe-themes (quote ("53e29ea3d0251198924328fd943d6ead860e9f47af8d22f0b764d11168455a8e" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" default)))
 '(session-use-package t nil (session)))

(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'ido)
;; Press Command-p for fuzzy find in project
;;(global-set-key (kbd "s-p") 'projectile-find-file)
;; Press Command-b for fuzzy switch buffer
;;(global-set-key (kbd "s-b") 'projectile-switch-to-buffer)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
"~/.emacs.d/.cask/24.3.50.1/elpa/auto-complete-20130724.1750/dict")
(ac-config-default)
(setq ac-ignore-case nil)
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)

(define-key projectile-mode-map [?\s-f] 'projectile-find-file)
(global-set-key (kbd "<f2>") 'ag-project-at-point)

(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))
(global-set-key (kbd "<f10>") 'comment-or-uncomment-region-or-line)

(defun duplicate-current-line (arg)
  "Duplicate current line, leaving point in lower line."
  (interactive "*p")
  ;; save the point for undo
  (setq buffer-undo-list (cons (point) buffer-undo-list))
  ;; local variables for start and end of line
  (let ((bol (save-excursion (beginning-of-line) (point)))
        eol)
    (save-excursion
      ;; don't use forward-line for this, because you would have
      ;; to check whether you are at the end of the buffer
      (end-of-line)
      (setq eol (point))
      ;; store the line and disable the recording of undo information
      (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
        ;; insert the line arg times
        (while (> count 0)
          (newline)         ;; because there is no newline in 'line'
          (insert line)
          (setq count (1- count)))
        )
      ;; create the undo information
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list)))
    ) ; end-of-let
  ;; put the point in the lowest line and return
  (next-line arg))
(global-set-key (kbd "<f11>") 'duplicate-current-line)

(setq tabbar-ruler-global-tabbar t)
(require 'tabbar-ruler)
(scroll-bar-mode 1)
(global-linum-mode 1)


(require 'sr-speedbar) 
(setq speedbar-frame-parameters
      '((minibuffer)
	(width . 0)
	(border-width . 0)
	(menu-bar-lines . 0)
	(tool-bar-lines . 0)
	(unsplittable . t)
	(left-fringe . 0)))
(setq speedbar-hide-button-brackets-flag t)
(setq speedbar-show-unknown-files t)
(setq speedbar-smart-directory-expand-flag t)
(setq speedbar-use-images nil)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-auto-refresh nil)
(setq sr-speedbar-width-x 8)
(setq sr-speedbar-width-console 8)
(setq sr-speedbar-max-width 8)
(setq sr-speedbar-skip-other-window-p t)

(add-hook 'window-setup-hook (lambda () (sr-speedbar-open) (other-window 1)))
(add-hook 'window-setup-hook (lambda () (sr-speedbar-open) (linum-mode -1)))
 
(when window-system
  (defadvice sr-speedbar-open (after sr-speedbar-open-resize-frame activate)
    (set-frame-width (selected-frame)
                     (+ (frame-width) sr-speedbar-width)))
  (ad-enable-advice 'sr-speedbar-open 'after 'sr-speedbar-open-resize-frame)
 
  (defadvice sr-speedbar-close (after sr-speedbar-close-resize-frame activate)
    (sr-speedbar-recalculate-width)
    (set-frame-width (selected-frame)
                     (- (frame-width) sr-speedbar-width)))
  (ad-enable-advice 'sr-speedbar-close 'after 'sr-speedbar-close-resize-frame))
