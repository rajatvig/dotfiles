;;;*~/.doom.d/config.el -*- lexical-binding: t; -*-

(setq doom-theme 'base16-summerfruit-dark)

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
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'rainbow-mode)

(add-to-list 'auto-mode-alist '("\\.libsonnet$" . jsonnet-mode))

(add-to-list 'auto-mode-alist '("\\.kt$" . kotlin-mode))
(add-to-list 'auto-mode-alist '("\\.kts$" . kotlin-mode))
(add-hook 'kotlin-mode-hook 'flycheck-mode)

(add-hook 'terraform-mode-hook 'terraform-format-on-save-mode)

(add-to-list 'auto-mode-alist '("WORKSPACE$" . bazel-mode))
(add-to-list 'auto-mode-alist '("BUILD$" . bazel-mode))

(direnv-mode)
