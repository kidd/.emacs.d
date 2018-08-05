;; Make startup faster by reducing the frequency of garbage
;; collection.  The default is 0.8MB.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))
;; Portion of heap used for allocation.  Defaults to 0.1.
(setq gc-cons-percentage 0.6)

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)
;; Org-files encryption
(require 'epa-file)
;(epa-file-enable)

;; Enabling package index
(setq package-archives '(("melpa" . "https://melpa.org/packages/")))

;; Modular config loading
;; from https://www.emacswiki.org/emacs/DotEmacsModular#toc4
(defun load-directory (directory)
  "Load recursively all `.el' files in DIRECTORY."
  (dolist (element (directory-files-and-attributes directory nil nil nil))
    (let* ((path (car element))
           (fullpath (concat directory "/" path))
           (isdir (car (cdr element)))
           (ignore-dir (or (string= path ".") (string= path ".."))))
      (cond
       ((and (eq isdir t) (not ignore-dir))
        (load-directory fullpath))
       ((and (eq isdir nil) (string= (substring path -3) ".el"))
        (load (file-name-sans-extension fullpath)))))))
(load-directory "~/.emacs.d/configs")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-auto-complete t)
 '(company-idle-delay 0.25)
 '(company-quickhelp-delay 0.25)
 '(company-quickhelp-mode t)
 '(company-quickhelp-use-propertized-text t)
 '(company-show-numbers t)
 '(company-tooltip-idle-delay 0.25)
 '(dired-use-ls-dired nil)
 '(global-company-mode t)
 '(ido-create-new-buffer 'always)
 '(inhibit-startup-screen t)
 '(initial-frame-alist '((vertical-scroll-bars) (fullscreen . maximized)))
 '(initial-scratch-message nil)
 '(linum-highlight-in-all-buffersp t)
 '(magit-log-section-arguments '("--graph" "--color" "--decorate" "-n256"))
 '(magit-push-arguments '("--force-with-lease"))
 '(make-header-hook
   '(header-title header-blank header-author header-creation-date header-blank header-description))
 '(menu-bar-mode nil)
 '(org-refile-allow-creating-parent-nodes 'confirm)
 '(package-selected-packages
   '(pass go-direx go-eldoc go-add-tags go-stacktracer company-go dumb-jump linum-off hlinum yard-mode yari rspec-mode yafolding dockerfile-mode which-key go-playground-cli calfw-org calfw org-gcal org-journal suomalainen-kalenteri ace-window org-present password-store column-enforce-mode markdown-mode flycheck flymake-go go-autocomplete go-mode yaml-mode multi-term company-quickhelp company magit monokai-theme enh-ruby-mode robe rvm ag pallet auto-complete async))
 '(ruby-align-chained-calls nil)
 '(safe-local-variable-values
   '((encoding . utf-8)
     (epa-file-encrypt-to \“manuel@manuel\.is”)
     (header-auto-update-enabled)))
 '(scroll-bar-mode nil)
 '(send-mail-function 'sendmail-send-it)
 '(show-paren-mode t)
 '(tool-bar-mode nil))

;; Enable which-key
(which-key-mode)

;; Open files in an existing frame instead of a new frame
(setq ns-pop-up-frames nil)

;; Removes scroll bar
(toggle-scroll-bar -1)

;; Enable CUA mode (C-c, C-x, C-v, C-z)
(cua-mode 1)

;; Tramp mode
;; More info: http://www.emacswiki.org/emacs/TrampMode
(require 'tramp)
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)
(setq tramp-default-method "ssh")
(setq tramp-verbose 10)
;; Complete hostnames from ssh config
(tramp-set-completion-function "ssh"
                  '((tramp-parse-sconfig "/etc/ssh_config")
                    (tramp-parse-sconfig "~/.ssh/config")))
(put 'dired-find-alternate-file 'disabled t)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; exec-path-from-shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))
