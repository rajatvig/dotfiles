BI=brew install
BCI=brew cask install

GO_DIR=/usr/local/var/go
GG=env GOPATH=$(GO_DIR) get -u

DDIR=$(HOME)/dotfiles
PDIR=$(DDIR)/packages
CDIR=$(DDIR)/config

PYENV_ROOT=/usr/local/var/pyenv
PYENV=env PYENV_ROOT=$(PYENV_ROOT) /usr/local/bin/pyenv
RBENV_ROOT=/usr/local/var/rbenv
RBENV=env RBENV_ROOT=$(RBENV_ROOT) /usr/local/bin/rbenv

VPI=vagrant plugin install

GC=git clone --recursive git@github.com
GCG=git config --global

HC=$(HOME)/.config

LCT=$(HC)/limchat-themes

BIT=$(HC)/bash_it
BITP=$(BIT)/plugins

.PHONY: help
.DEFAULT_GOAL := help

bootstrap: ## Bootstrap Brew, dotfiles
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	cat $(PDIR)/taps.txt | xargs brew tap
	$(GC):rajatvig/dotfiles.git $(DDIR)

relink: ## Relink the Packages with what is installed
	brew tap > $(PDIR)/taps.txt
	brew list > $(PDIR)/brew.txt
	brew cask list > $(PDIR)/cask.txt
	ls $(HOME)/.atom/packages > $(PDIR)/atom.txt
	vagrant plugin list | cut -f 1 -d ' ' > $(PDIR)/vagrant.txt
	ls $(BIT)/plugins/enabled/ | cut -d "." -f 1 > $(PDIR)/bash_plugins.txt
	cp $(HOME)/Library/Preferences/com.googlecode.iterm2.plist $(CDIR)/com.googlecode.iterm2.plist
	asdf plugin-list > $(PDIR)/asdf-plugins.txt

install: brew asdf cabal golang node opam vagrant ## Install as much as possible

brew: ## Install brew, brew cask, taps, all brew and cask packages
	$(BI) cask
	$(BCI) java
	$(BCI) vagrant
	make brew_redo

brew_redo: ## Install all configured brew and cask packages
	cat $(PDIR)/brew.txt | xargs $(BI) || true
	cat $(PDIR)/cask.txt | xargs $(BCI)

cabal: ## Update Cabal and add some default packages
	$(BCI) haskell-platform
	cabal update
	cabal install happy
	cabal install ghc-mod
	cabal install hlint

golang: ## Install and configure GoLang
	$(BI) go
	mkdir -p $(GO_DIR)
	$(GG) golang.org/x/tools/cmd/goimports
	$(GG) github.com/golang/lint/golint
	$(GG) github.com/nsf/gocode
	$(GG) golang.org/x/tools/cmd/oracle

node: ## Install required Node Packages
	$(BI) yarn --without-node
	cat $(PDIR)/npm.txt | xargs yarn global add

opam: ## Install and configure Opam
	$(BI) opam
	opam init

python: ## Install Python, Pip Packages, PyEnv
	mkdir -p $(PYENV_ROOT)
	$(BI) pyenv python
	cat $(PDIR)/pip.txt | xargs pip install
	$(PYENV) install 3.6.0
	$(PYENV) install 2.7.13
	ln -s $(CDIR)/pypirc $(HOME)/.pypirc

asdf: ## Install Languages
	$(BI) asdf
	cat $(PDIR)/asdf-plugins.txt | xargs -I plugin-name asdf plugin-add plugin-name | true
	cat $(CDIR)/asdf-tool-versions.txt | xargs -I tool-version asdf install tool-version
	rm -f $(HOME)/.tool-versions
	ln -s $(CDIR)/asdf-tool-versions.txt $(HOME)/.tool-versions

vagrant: ## Install and configure Vagrant
	$(BCI) vagrant
	cat $(PDIR)/vagrant.txt | xargs $(VPI)
	mkdir -p $(HOME)/.vagrant.d
	rm -f $(HOME)/.vagrant.d/Vagrantfile
	ln -s $(CDIR)/Vagrantfile $(HOME)/.vagrant.d/Vagrantfile

editors: atom editorconfig emacs vim ## Install and configure all editors

atom: ## Configure Atom
	$(BCI) atom
	rm -rf $(HOME)/.atom
	mkdir $(HOME)/.atom
	ln -s $(CDIR)/atom/config.cson $(HOME)/.atom/
	ln -s $(CDIR)/atom/keymap.cson $(HOME)/.atom/
	cat $(PDIR)/atom.txt | xargs apm install

editorconfig: ## Setup default editorconfig
	rm -f $(HOME)/.editorconfig
	ln -s $(CDIR)/editorconfig $(HOME)/.editorconfig

emacs: ## Configure Spacemacs
	$(BI) emacs
	$(BCI) emacs
	rm -rf $(HOME)/.spacemacs $(HC)/spacemacs $(HOME)/.emacs.d
	$(GC):syl20bnr/spacemacs.git $(HOME)/.emacs.d
	$(GC):rajatvig/spacemacs-config.git $(HC)/spacemacs
	ln -s $(HC)/spacemacs/spacemacs.el $(HOME)/.spacemacs

limechat: ## Configure LimeChat (currently broken)
	$(BCI) limechat
	mkdir -p $(LCT)
	$(GC):jschoolcraft/Limechat-Themes.git $(LCT)
	cd $(LCT); rake themes:init
	cd $(LCT); rake themes:install

vim: ## Configure SPF-13 for VIM
	$(BI) vim
	$(BCI) macvim
	curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh && rm spf13-vim.sh
	rm -rf $(HOME)/.vimrc.local $(HOME)/.vimrc.bundles.local $(HOME)/.vimrc.before.local
	ln -s $(CDIR)/vim/vimrc.before.local $(HOME)/.vimrc.before.local
	ln -s $(CDIR)/vim/vimrc.bundles.local $(HOME)/.vimrc.bundles.local
	ln -s $(CDIR)/vim/vimrc.local $(HOME)/.vimrc.local

iterm2: ## iTerm2 Configuration
	rm -rf $(HOME)/Library/Preferences/com.googlecode.iterm2.plist
	cp $(CDIR)/com.googlecode.iterm2.plist $(HOME)/Library/Preferences/com.googlecode.iterm2.plist

config: git aspell shells osx ## Configure Git, Aspell, Shells, OSX Defaults

git: ## Configure Git Global Settings and an Ignore file
	$(BI) git
	$(GCG) user.name "Rajat Vig"
	$(GCG) user.email "rajat.vig@gmail.com"
	$(GCG) core.editor vim
	$(GCG) core.excludesfile "$(HOME)/.gitignore_global"
	rm -f $(HOME)/.gitignore_global
	ln -s $(CDIR)/gitignore_global $(HOME)/.gitignore_global

mr: ## Configire mr config
	$(BI) mr
	ln -s $(CDIR)/mrconfig $(HOME)/.mrconfig

aspell: ## Setup personal dictionary
	rm -f $(HOME)/.aspell.en.pws $(HOME)/.aspell.en.prepl
	ln -s $(CDIR)aspell/aspell.en.pws $(HOME)/.aspell.en.pws
	ln -s $(CDIR)/aspell/aspell.en.prepl $(HOME)/.aspell.en.prepl

shells: bash fish zsh tmux direnv powerline ## Configure Shells

bash:
	$(BI) bash
	rm -rf $(BIT) $(HOME)/.bashrc $(HOME)/.bash_profile
	$(GC):Bash-it/bash-it.git $(BIT)
	$(BIT)/install.sh --silent
	rm -rf $(HOME)/.bashrc $(HOME)/.bash_profile $(BITP)/enabled/*.bash
	ln -s $(CDIR)/bashrc $(HOME)/.bashrc
	ln -s $(CDIR)/bash_profile $(HOME)/.bash_profile
	cat $(PDIR)/bash_plugins.txt | xargs -I '{}' bash -c 'ln -s $(BITP)/available/{}.plugin.bash $(BITP)/enabled/{}.plugin.bash'

fish: ## Configure Fish Shell, get TackleBox and custom plugins
	$(BI) fish mr
	rm -rf .config/fish .config/fish_plugins
	mkdir -p .config/fish
	mr boostrap $(CDIR)/mrconfig .config/fish_plugins
	ln -s $(CDIR)/fish $(HC)/fish
	sudo chsh -s /usr/local/bin/fish `echo $USER`

zsh: ## Install oh-my-zsh
	$(BI) zsh
	$(GC):robbyrussell/oh-my-zsh.git $(HOME)/.oh-my-zsh
	rm -f $(HOME)/.zshrc
	ln -s $(CDIR)/zshrc $(HOME)/.zshrc

tmux: ## Configure tmux
	rm -f $(HOME)/.tmux.conf
	ln -s $(CDIR)/tmux.conf $(HOME)/.tmux.conf

direnv: ## Configure direnv
	$(BI) direnv
	rm -rf $(HOME)/.direnvrc
	ln -s $(CDIR)/direnvrc $(HOME)/.direnvrc

powerline: ## Pretty up the prompt using PowerLine
	$(GC):milkbikis/powerline-shell.git $(HC)/powerline-shell
	cd $(HC)/powerline-shell; ./install.py
	ln -s $(HC)/powerline-shell/powerline-shell.py $(HOME)/powerline-shell.py

osx: ## Setup sane OSX Defaults
	./scripts/_osx

update_brew: ## Update brew
	brew update
	brew upgrade
	brew cleanup

update_vim: ## Update VIM
	vim +BundleInstall! +BundleClean +q

update: ## Update Software
	mr update
	make update_brew
	rustup update
	apm update -c false
	make update_vim

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
