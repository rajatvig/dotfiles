(setq elpy-packages
    '(
      elpy
      ))

(defun elpy/init-elpy ()
  (elpy-enable)
  (add-hook 'python-mode-hook 'elpy-mode)
  )
