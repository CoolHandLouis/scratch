 

;;;; My .emacs init file
;;;; Started on 02/07/2022
;;;; Style Guide: https://github.com/bbatsov/emacs-lisp-style-guide
;;;; Another style guide: https://google.github.io/styleguide/lispguide.xml#Comment_semicolons
;;;; yasg: https://www.gnu.org/software/emacs/manual/html_node/elisp/Comment-Tips.html
;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; REQUIRE PACKAGE AND SET PACKAGE ARCHIVES
;; By default, Emacs 24 or later is set up with the GnuELPA package archive. If you need to add more sources to your list-packages, include Emacs code like the following to your InitFile:

;; (also see https://www.emacswiki.org/emacs/InstallingPackages) 
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MY CUSTOM PACKAGE LOAD PATH???
;;
;; I'm not sure what this is for, it was prob in some tutorial
;; or online advice.

;; These are subject to change
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/"))   ; emacs lisp files?

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; IDO MODE

;; ido allows interactive completions. consider ivy or Helm they're more advanced
;; I don't know what these lines mean, it's cut and paste
(ido-mode 1)
(setq ido-enable-flex-matching t)

;; Ido  mode to work with C-x C-f (find-files) then add this as well:
(setq ido-everywhere t)

;; emphasize these types of files in ido
(setq ido-file-extensions-order '(".org" ".txt" ".py" ".emacs" ".xml" ".el" ".ini" ".cfg" ".cnf"))

;; Now you can customize that variable as well:
;;
;;    M-x customize-variable RET completion-ignored-extensions
;;
;; Go ahead and add all the useless object files,
;; backup, autosave and other computing flotsam you don’t want Ido to show.
(setq ido-ignore-extensions t)

;; Disable ido mode's irritating "search recent buffers" behavior
(setq ido-auto-merge-work-directories-length -1)



;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)

;; Enable transient mark mode
(transient-mark-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; some stuff
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; help with parens
(show-paren-mode t)
;; (setq show-paren-style 'expression) ;; highlights entire expression between parens

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; emacs needs an unfill
;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph    
(defun unfill-paragraph (&optional region)
      "Takes a multi-line paragraph and makes it into a single line of text."
      (interactive (progn (barf-if-buffer-read-only) '(t)))
      (let ((fill-column (point-max))
            ;; This would override `fill-column' if it's an integer.
            (emacs-lisp-docstring-fill-column t))
        (fill-paragraph nil region)))
    
    ;; Handy key definition

;; I don't want this defined at this time.
;; (define-key global-map "\M-q" 'unfill-paragraph)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Some font choices
;; set up fonts for different OSes. OSX toggles to full screen.

(setq myfont "InputSerif")
;;
;;(cond ((string-equal system-name "dls-macbook-2017.local") (set-face-attribute 'default nil :
;; font myfont :
;; height 144) (toggle-frame-fullscreen))
;;
;;((string-equal system-name "doesnotexist1.local") (set-face-attribute 'default nil :
;; font myfont :
;; height 144))
;;
;;((string-equal system-name "dne2") (set-face-attribute 'default nil :
;; font myfont :
;; height 106))
;;
;;((string-equal system-name "dne3") (set-face-attribute 'default nil :
;; font myfont :
;; height 104)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; avy/ace jump mode
;;(use package avy
;;     :ensure t
;;     :bind ("M-s" . avy-goto-char))

;; (global-set-key (kbd "C-c j") 'avy-goto-word-or-subword-1)
;; (global-set-key (kbd "s-.") 'avy-goto-word-or-subword-1)
;; (global-set-key (kbd "s-w") 'ace-window)
 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; AVY BINDINGS https://github.com/abo-abo/avy  
     
;; Integrate avy with iSearch
;; First enter iSearch, then whatever pattern to search, then C-'
;; C-s PATTERN C-'
;; Note that the C-' is bound here ONLY in the context of an interactive iSearch
    (avy-setup-default)  
      
    ;; not sure what this does  
    ;; (global-set-key (kbd "C-c C-j") 'avy-resume)  
    
    ;; Suggested bindings from avy github docs  
    (global-set-key (kbd "C-:") 'avy-goto-char)  
    (global-set-key (kbd "C-'") 'avy-goto-char-2)  
    (global-set-key (kbd "M-g f") 'avy-goto-line)  
    (global-set-key (kbd "M-g w") 'avy-goto-word-1)  
    (global-set-key (kbd "M-g e") 'avy-goto-word-0)  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;; Avy Org-mode commands NOTES
	;; avy-org-goto-heading-timer: Type part of an Org heading. When you stop typing,
	;; if only one heading on the screen matches, it will be jumped to; if more than
	;; one matches, you can jump to a heading with Avy. This is like avy-goto-char-timer
	;; but for Org headings.

	;; avy-org-refile-as-child: With point in an entry you want to refile, run this command,
	;; select a heading with Avy, and the entry will be refiled as its first child heading.
	;; This makes it quick and easy to refile to headings that are visible on-screen, even
	;; to other windows or buffers.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Save and restore emacs buffers and windows
(desktop-save-mode 1)


;; This mode-line is only needed if you (1) have files with a
;; different file-ending then configured in your Emacs config (for
;; example myfile.txt). (2) Don't have the auto-mode-alist line in
;; your configuration.
;; https://orgmode.org/worg/org-tutorials/org4beginners.html -*- mode:
;; elisp -*-





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ORG MODE CONFIGURATIONS!!!


;; Enable Org mode



(require 'package)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(require 'org)

;; The following command will make lines wrap in org mode.
;; M-q is bound to fill-paragraph by default, but probably you don't
;; want to use it within org-mode.
(define-key org-mode-map "\M-q" 'toggle-truncate-lines)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The following is the default in recent emacsen so prob not needed.
;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;;(add-to-list 'auto-mode-alist '("\\.text\\'" . org-mode))
(add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))

;; Don't show me an empty line between collapsed trees
;; This sets the threshold before an empty line is shown
(setq org-cycle-separator-lines 5)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set up org mode
(setq org-startup-indented t)
(setq org-startup-folded "showall")
(setq org-directory "~/org")

;; Suggested by https://orgmode.org/guide/Introduction.html#Introduction
;; "useful in any Emacs buffer, not just Org buffers. Please choose suitable keys yourself."
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; Cycle for TODO states
;; Note that you can have multiple sequences
;; (setq org-todo-keywords
;;       '((sequence "TODO(t)" "|" "DONE(d)")
;;         (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
;;         (sequence "|" "CANCELED(c)")))
;;
;; also note you can require notes or automate time stamps
;;
;; (setq org-todo-keywords
;;      '((sequence "TODO(t)" "PROJ(p)" "WAIT(w@/!)" "SOMEDAY(s)" "ONEDAY(o)" "INBOX(i)" "|" "DONE(d!)" "CANCELED(c)")))

(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "PROJ(p)" "WAIT(w)" "SOMEDAY(s)" "ONEDAY(o)" "INBOX(i)" "HOLD(h)" "|" "DONE(d!)" "CANCELED(c)")))

;; Don't allow edits of invisible text
(setq-default org-catch-invisible-edits 'smart)

;; This allows tab to be used for folding anywhere under the heading 
(setq org-cycle-emulate-tab 'white)

(setq org-agenda-files '("~/org"))
;; (setq org-agenda-files "~/org/")
;; setq org-agenda-files (list "~/org/work.org"
;;                             "~/org/school.org" 
;;                             "~/org/home.org"))

;; (setq org-agenda-files 'load path (expand-file-name "~/org/"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Avoid slow-downs.

;; See https://notes.neeasade.net/annoying-org-typing-slowdowns.html


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ORG MODE CONFLICT NOTES
;; 
;; https://orgmode.org/manual/Conflicts.html
   ;; `cua.el' by Kim F. Storm
   ;; `ecomplete.el' by Lars Magne Ingebrigtsen
   ;; `filladapt.el' by Kyle Jones
   ;; `viper.el' by Michael Kifer
   ;; `windmove.el' by Hovav Shacham
   ;; `yasnippet.el'






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CUSTOM CHANGES BY 3RD PARTY SHOULD NOT GO IN *THIS* FILE
;; (Instead, it should go into .emacs-custom.el
;;
;; I think this should be last in the file.  It needs to be after org-mode stuff.

(setq custom-file "~/.emacs.d/.emacs-custom.el")
(load custom-file)
