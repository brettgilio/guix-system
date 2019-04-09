(define-module (non-gnu packages emacs-extend)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix cvs-download)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system emacs)
  #:use-module (guix build-system glib-or-gtk)
  #:use-module (guix build-system perl)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages audio)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages code)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages tex)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages tcl)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages lesstif)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages image)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages music)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages w3m)
  #:use-module (gnu packages wget)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages base)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages acl)
  #:use-module (gnu packages mail)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pdf)
  #:use-module (gnu packages scheme)
  #:use-module (gnu packages speech)
  #:use-module (gnu packages xiph)
  #:use-module (gnu packages mp3)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages fribidi)
  #:use-module (gnu packages gd)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages password-utils)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages video)
  #:use-module (gnu packages haskell)
  #:use-module (gnu packages wordnet)
  #:use-module (guix utils)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 match))

(define-public emacs-font-lock+
  (let ((commit "f2c1ddcd4c9d581bd32be88fad026b49f98b6541")
        (revision "0"))
    (package
     (name "emacs-font-lock+")
     (version (git-version "208" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/emacsmirror/font-lock-plus.git")
                    (commit commit)))
              (sha256
               (base32
                "17kqvmh3k2lvkarqra3v9nzm66l7dc72fh48crypc8f8qma9sncl"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (home-page "https://github.com/emacsmirror/font-lock-plus")
     (synopsis "")
     (description "")
     (license #f))))

;; The Guix-master build lacks proper reference to `emacs-font-lock+'
;; XXX: https://github.com/domtronn/all-the-icons.el/issues/105
(define-public emacs-all-the-icons-channel
  (let ((commit "f996fafa5b2ea072d0ad1df9cd98acc75820f530")
        (revision "1"))
    (package
     (name "emacs-all-the-icons")
     (version (git-version "3.2.0" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/domtronn/all-the-icons.el.git")
                    (commit commit)))
              (sha256
               (base32
                "0yc07xppgv78l56v7qwqp4sf3p44znkv5l0vlvwg8x1dciksxgqw"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (arguments
      `(#:include '("\\.el$" "^data/" "^fonts/")
	;; Compiling "test/" fails with "Symbol’s value as variable is void:
	;; all-the-icons--root-code".  Ignoring tests.
	#:exclude '("^test/")
	#:tests? #f))
     (propagated-inputs
      `(("f" ,emacs-f)
	("memoize" ,emacs-memoize)
	("emacs-font-lock+" ,emacs-font-lock+)))
     (home-page "https://github.com/domtronn/all-the-icons.el")
     (synopsis "Collect icon fonts and propertize them within Emacs")
     (description "All-the-icons is a utility package to collect various icon
fonts and propertize them within Emacs.  Icon fonts allow you to propertize
and format icons the same way you would normal text.  This enables things such
as better scaling of and anti aliasing of the icons.")
     ;; Package is released under Expat license.  Elisp files are licensed
     ;; under GPL3+.  Fonts come with various licenses: Expat for
     ;; "all-the-icons.ttf" and "file-icons.ttf", Apache License 2.0 for
     ;; "material-design-icons.ttf", and SIL OFL 1.1 for "fontawesome.ttf",
     ;; "ocitcons.ttf" and "weathericons.ttf".
     (license
      (list license:expat license:gpl3+ license:silofl1.1 license:asl2.0)))))

(define-public emacs-doom-modeline
  (let ((commit "a6814ac4e3c9edc95e008687e9d1e0fe49b9bf07")
        (revision "0"))
    (package
     (name "emacs-doom-modeline")
     (version (git-version "1.9.7" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/seagle0128/doom-modeline.git")
                    (commit commit)))
              (sha256
               (base32
                "16bx8g6hf2d0g3sxzrknjf0fnraj2w9a2ndl0fs69p07q0ahvx6i"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (propagated-inputs
      `(("emacs-all-the-icons" ,emacs-all-the-icons-channel)
	("emacs-shrink-path" ,emacs-shrink-path)
	("emacs-eldoc-eval" ,emacs-eldoc-eval)
	("emacs-dash" ,emacs-dash)))
     (home-page
      "https://github.com/seagle0128/doom-modeline")
     (synopsis "A minimal and modern mode-line")
     (description
      "")
     (license license:gpl3+))))
    
(define-public emacs-shrink-path
  (let ((commit "9b8cfb59a2dcee8b39b680ab9adad5ecb1f53c0b")
        (revision "0"))
    (package
     (name "emacs-shrink-path")
     (version (git-version "0.3.1" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://gitlab.com/bennya/shrink-path.el.git")
                    (commit commit)))
              (sha256
               (base32
                "0kx0c4syd7k6ff9j463bib32pz4wq0rzjlg6b0yqnymlzfr1mbki"))
              (file-name (git-file-name name version))))
       (build-system emacs-build-system)
       (propagated-inputs
	`(("emacs-s" ,emacs-s)
	  ("emacs-dash" ,emacs-dash)
	  ("emacs-f" ,emacs-f)))
       (home-page
	"https://gitlab.com/bennya/shrink-path.el")
       (synopsis "fish-style path")
       (description
	"Provides functions that offer fish shell[1] path truncation.
Directory /usr/share/emacs/site-lisp => /u/s/e/site-lisp

Also includes utility functions that make integration in eshell or the
modeline easier.

[1] https://fishshell.com/
")
       (license license:gpl3+))))

(define-public emacs-eldoc-eval
  (let ((commit "deca5e39f31282a06531002d289258cd099433c0")
        (revision "0"))
    (package
     (name "emacs-eldoc-eval")
     (version (git-version "1.1" revision commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/thierryvolpiatto/eldoc-eval.git")
                    (commit commit)))
              (sha256
               (base32
                "1fh9dx669czkwy4msylcg64azz3az27akx55ipnazb5ghmsi7ivk"))
              (file-name (git-file-name name version))))
     (build-system emacs-build-system)
     (home-page "https://github.com/thierryvolpiatto/eldoc-eval")
     (synopsis
      "Enable eldoc support when minibuffer is in use.")
     (description
      "This package enables eldoc support when minibuffer is in use.")
     (license license:gpl3+))))