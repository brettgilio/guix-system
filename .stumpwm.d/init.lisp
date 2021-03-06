;; Partially stolen, credit to https://github.com/NicolasPetton/stumpwm.d

(in-package :stumpwm)

(defvar *stumpwm-config-dir* "~/.stumpwm.d/"
  "StumpWM configuration directory.")

(defun load-user-module (name)
  (load (make-pathname :defaults *stumpwm-config-dir*
		       :name name
		       :type "lisp")))

(run-commands "exec feh --bg-scale ~/Pictures/gnulinux.png")
(run-commands "exec xterm")
(run-commands "exec nix-serve -p 8082")

(load-user-module "keybindings")
(load-user-module "theme")
