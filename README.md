# emacs.d

n-th re-write of emacs configs. This time as literate code.

The configurations available in the `config.org` itself.

## Notes

- `init.el` should only contain the following, enabling config.org to be loaded into `config.el`

```lisp
(let ((gc-cons-threshold most-positive-fixnum))

  ;; Set repositories
  (require 'package)
  (setq-default
   load-prefer-newer t
   package-enable-at-startup nil)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
  (setq package-enable-at-startup nil)
  (package-initialize)

  ;; Install dependencies
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package t))
  (setq-default
   use-package-always-defer t
   use-package-always-ensure t)

  ;; Use latest Org
  (use-package org :ensure org-plus-contrib)

  ;; Tangle configuration
  (org-babel-load-file (expand-file-name "config.org" user-emacs-directory))
(garbage-collect))
```

Thus, `init.el` should be ignored from the repo:

`git update-index --assume-unchanged init.el`

Adding new packages would mean:

  - Editing the block in `config.org` where packages are requried.
  - Remove config.el generated.
  - Stop and start emacs server, letting Org-babel load the new packages/functions.
