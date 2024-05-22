;;; good-scroll-autoloads.el --- automatically extracted autoloads (do not edit)   -*- lexical-binding: t -*-
;; Generated by the `loaddefs-generate' function.

;; This file is part of GNU Emacs.

;;; Code:

(add-to-list 'load-path (or (and load-file-name (directory-file-name (file-name-directory load-file-name))) (car load-path)))



;;; Generated autoloads from good-scroll.el

(defvar good-scroll-mode nil "\
Non-nil if Good-Scroll mode is enabled.
See the `good-scroll-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `good-scroll-mode'.")
(custom-autoload 'good-scroll-mode "good-scroll" nil)
(autoload 'good-scroll-mode "good-scroll" "\
Good pixel line scrolling

This is a global minor mode.  If called interactively, toggle the
`Good-Scroll mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='good-scroll-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

(fn &optional ARG)" t)
(register-definition-prefixes "good-scroll" '("good-scroll-"))


;;; Generated autoloads from good-scroll-bezier.el

(register-definition-prefixes "good-scroll-bezier" '("good-scroll-bezier"))


;;; Generated autoloads from good-scroll-linear.el

(register-definition-prefixes "good-scroll-linear" '("good-scroll-linear"))

;;; End of scraped data

(provide 'good-scroll-autoloads)

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; no-native-compile: t
;; coding: utf-8-emacs-unix
;; End:

;;; good-scroll-autoloads.el ends here
