;;;*~/.doom.d/config.el -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "Hack Nerd Font" :size 11))

(setq projectile-enable-caching t)

(global-set-key (kbd "A-/") 'hippie-expand)

(global-set-key (kbd "<M-left>") 'move-beginning-of-line)
(global-set-key (kbd "<M-right>") 'move-end-of-line)

(global-set-key (kbd "<A-up>") 'backward-sentence)
(global-set-key (kbd "<A-down>") 'forward-sentence)

(global-set-key (kbd "<A-right>") 'forward-sexp)
(global-set-key (kbd "<A-left>") 'backward-sexp)
(global-set-key (kbd "<A-backspace>") 'backward-kill-sexp)

(defun save-all ()
  (interactive)
  (save-some-buffers t))

(add-hook 'focus-out-hook 'save-all)

(push 'company-lsp company-backends)

(add-hook 'go-mode-hook #'lsp-go-enable)
;; (add-hook 'lsp-mode-hook 'lsp-ui-mode)

;; (global-set-key (kbd "M-.") 'xref-find-definitions)

;; (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
;; (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)

(direnv-mode)
