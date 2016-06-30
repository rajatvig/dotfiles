(setq objc-packages
  '(
     objc-font-lock
     ))

(defun objc/init-objc-font-lock ()
  (add-to-list 'auto-mode-alist '("\\.m$" . objc-mode))
  (add-to-list 'auto-mode-alist '("\\.mm$" . objc-mode))
  (add-to-list 'magic-mode-alist
    `(,(lambda ()
         (and (string= (file-name-extension buffer-file-name) "h")
           (re-search-forward "@\\<interface\\>"
             magic-mode-regexp-match-limit t)))
       . objc-mode))
  (objc-font-lock-global-mode 1))
