(setq elpy-packages
    '(
      elpy
      ))

(defun elpy/init-elpy ()
  (elpy-enable)
  (add-hook 'python-mode-hook 'elpy-mode)
  (defun projectile-pyenv-mode-set ()
    "Set pyenv version matching project name. Version must be already installed."
    (pyenv-mode-set (projectile-project-name)))
  (add-hook 'projectile-switch-project-hook 'projectile-pyenv-mode-set)
  )
