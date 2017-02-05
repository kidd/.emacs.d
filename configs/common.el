;; UTF-8 for ya'all
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(set-locale-environment "en_US.UTF-8")
(prefer-coding-system 'utf-8)

;; Monokai theme
(load-theme 'monokai t)

;; ZSH as shell for multi-term
(setq multi-term-program "/usr/local/bin/zsh")

;; Enable {}
(setq mac-option-modifier nil
      mac-command-modifier 'meta
      x-select-enable-clipboard t)

;; Automatically reload a file iff changed
(global-auto-revert-mode 1)

;; Reloads the current buffer without prompting
(defun reload-this-buffer ()
  (interactive)
  (revert-buffer nil t t)
  (message (concat "Reverted buffer " (buffer-name))))

;; Kill-buffer prompt for confirmation disabled
(setq kill-buffer-query-functions
  (remq 'process-kill-buffer-query-function
         kill-buffer-query-functions))

;; Removes confirmation when searching for files or buffers that don't exist.
(setq confirm-nonexistent-file-or-buffer nil)

;; Key bindings
(global-set-key (kbd "C-x r") 'reload-this-buffer)
(global-set-key (kbd "M-o") 'other-window)
(define-key yafolding-mode-map (kbd "<C-S-return>") nil)
(define-key yafolding-mode-map (kbd "<C-M-return>") nil)
(define-key yafolding-mode-map (kbd "<C-return>") nil)
(define-key yafolding-mode-map (kbd "C-i") 'yafolding-toggle-all)
(define-key yafolding-mode-map (kbd "C-f") 'yafolding-hide-parent-element)
(define-key yafolding-mode-map (kbd "C-u") 'yafolding-toggle-element)
;; Increase/Decrease text size
;; C-x C-0 restores the default font size
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)


;; Backups
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 10   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

;; Set ZSH as multi-term terminal
(setq multi-term-program "/bin/zsh")

;; Yes-or-No -> Y or N
(defalias 'yes-or-no-p 'y-or-n-p)

;; Confirm kill emacs (because sometimes I am careless)
(setq confirm-kill-emacs 'y-or-n-p)

;; Follow symlinks, or course
(setq vc-follow-symlinks t)

;; Enable clipboard integration
(setq x-select-enable-clipboard t)

;; Enable YAML when appropriate
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;; Enable yafolding (fold code based on indentation)
(add-hook 'prog-mode-hook
          (lambda () (yafolding-mode)))

;; Tramp as sudo
(defun find-alternative-file-with-sudo ()
  (interactive)
  (let ((fname (or buffer-file-name
		   dired-directory)))
    (when fname
      (if (string-match "^/sudo:root@localhost:" fname)
	  (setq fname (replace-regexp-in-string
		       "^/sudo:root@localhost:" ""
		       fname))
	(setq fname (concat "/sudo:root@localhost:" fname)))
      (find-alternate-file fname))))

