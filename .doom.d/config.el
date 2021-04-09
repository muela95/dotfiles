;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Pablo Muela Martínez"
      user-mail-address "muela@cajal.csic.es")

(setq mouse-autoselect-window t)
(setq focus-follows-mouse t)

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Fira Code" :size 10)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 10))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'ewal-doom-vibrant)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(setq
    org-superstar-headline-bullets-list '("⁖" "◉" "○" "✸" "✿")
)
(require 'iso-transl)
(require 'workgroups2)

(require 'telega)
(setq
 telega-use-images t
 telega-emoji-font-family 'noto-emoji
 )


;(unless (display-graphic-p)
;        (require 'evil-terminal-cursor-changer)
;        (evil-terminal-cursor-changer-activate) ; or (etcc-on)
;        )
;(setq evil-motion-state-cursor 'box)  ; █
;(setq evil-visual-state-cursor 'box)  ; █
;(setq evil-normal-state-cursor 'box)  ; █
;(setq evil-insert-state-cursor 'bar)  ; ⎸
;(setq evil-emacs-state-cursor  'hbar) ; _

(setq
 org-hide-leading-stars t
 )
(define-key global-map (kbd "C-c t") telega-prefix-map)

(setf mouse-wheel-scroll-amount '(3 ((shift) . 3))
      mouse-wheel-progressive-speed nil
      mouse-wheel-follow-mouse t
      scroll-step 1
      scroll-conservatively 100
      disabled-command-function nil)


(use-package fira-code-mode
  :custom (fira-code-mode-disabled-ligatures '("[]" "x"))  ; ligatures you don't want
  :hook prog-mode)                                         ; mode to enable fira-code-mode in
