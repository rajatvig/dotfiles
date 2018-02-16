BI=brew install
BCI=brew cask install

DDIR=$(HOME)/dotfiles
PDIR=$(DDIR)/packages
CDIR=$(DDIR)/config

VPI=vagrant plugin install

GC=git clone --recursive git@github.com
GCG=git config --global

HC=$(HOME)/.config

BIT=$(HC)/bash_it
BITP=$(BIT)/plugins

.PHONY: help
.DEFAULT_GOAL := help

bootstrap: ## Bootstrap Brew, dotfiles
	ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	cat $(PDIR)/taps.txt | xargs -I tap_name brew tap tap_name
	touch $(DDIR)/config/fish/private.fish

relink: ## Relink the Packages with what is installed
	brew list > $(PDIR)/brew.txt
	brew cask list > $(PDIR)/cask.txt
	brew tap > $(PDIR)/taps.txt
	ls $(HOME)/.atom/packages > $(PDIR)/atom.txt
	vagrant plugin list | cut -f 1 -d ' ' > $(PDIR)/vagrant.txt
	ls $(BIT)/plugins/enabled/ | cut -d "." -f 1 > $(PDIR)/bash_plugins.txt
	cp $(HOME)/Library/Preferences/com.googlecode.iterm2.plist $(CDIR)/com.googlecode.iterm2.plist
	asdf plugin-list > $(PDIR)/asdf-plugins.txt
	pip3 list --format=legacy | cut -d ' ' -f 1 > packages/pip.txt

brew_base: ## Install bare minimum brew packages
	$(BI) cask fortune cowsay toilet asdf python3 vim
	$(BI) --without-node yarn
	$(BCI) java java8 haskell-platform vagrant

brew_all: brew_base ## Install all configured brew packages
	cat $(PDIR)/brew.txt | xargs $(BI)
	cat $(PDIR)/cask.txt | xargs $(BCI)

node: ## Install required Node Packages
	$(BI) yarn --without-node
	mkdir -p $(HC)/yarn
	cat $(PDIR)/npm.txt | xargs -I package-name yarn global add package-name

python: ## Install Pip Packages
	$(BI) python3
	cat $(PDIR)/pip.txt | xargs pip3 install
	rm -rf $(HOME)/.pypirc
	ln -s $(CDIR)/pypirc $(HOME)/.pypirc

asdf: ## Install Languages
	$(BI) asdf
	asdf plugin-add glide https://github.com/rajatvig/asdf-glide.git
	asdf plugin-add glide https://github.com/rajatvig/asdf-dep.git
	cat $(PDIR)/asdf-plugins.txt | xargs -I plugin-name asdf plugin-add plugin-name || true
	cat $(CDIR)/asdf-tool-versions.txt | xargs -I tool-version asdf install tool-version || true
	rm -f $(HOME)/.tool-versions
	ln -s $(CDIR)/asdf-tool-versions.txt $(HOME)/.tool-versions
	opam init
	cabal update

vagrant: ## Install and configure Vagrant
	$(BCI) vagrant
	cat $(PDIR)/vagrant.txt | xargs $(VPI)
	mkdir -p $(HOME)/.vagrant.d
	rm -f $(HOME)/.vagrant.d/Vagrantfile
	ln -s $(CDIR)/Vagrantfile $(HOME)/.vagrant.d/Vagrantfile

atom: ## Configure Atom
	$(BCI) atom
	rm -rf $(HOME)/.atom
	mkdir $(HOME)/.atom
	ln -s $(CDIR)/atom/config.cson $(HOME)/.atom/
	ln -s $(CDIR)/atom/keymap.cson $(HOME)/.atom/
	cat $(PDIR)/atom.txt | xargs apm install

emacs: ## Configure Spacemacs
	$(BCI) emacs
	rm -rf $(HOME)/.spacemacs $(HC)/spacemacs $(HOME)/.emacs.d
	$(GC):syl20bnr/spacemacs.git $(HOME)/.emacs.d
	$(GC):rajatvig/spacemacs-config.git $(HC)/spacemacs
	ln -s $(HC)/spacemacs/spacemacs.el $(HOME)/.spacemacs

vim: ## Configure SPF-13 for VIM
	$(BI) vim neovim
	$(BCI) macvim
	curl -sLf https://spacevim.org/install.sh | bash

iterm2: ## iTerm2 Configuration
	rm -rf $(HOME)/Library/Preferences/com.googlecode.iterm2.plist
	cp $(CDIR)/com.googlecode.iterm2.plist $(HOME)/Library/Preferences/com.googlecode.iterm2.plist

git: ## Configure Git Global Settings and an Ignore file
	$(BI) git
	$(GCG) user.name "Rajat Vig"
	$(GCG) user.email "rajat.vig@gmail.com"
	$(GCG) core.editor vim
	$(GCG) core.excludesfile "$(HOME)/.gitignore_global"
	rm -f $(HOME)/.gitignore_global
	ln -s $(CDIR)/gitignore_global $(HOME)/.gitignore_global

bash: ## Configure Bash
	$(BI) bash
	rm -rf $(BIT) $(HOME)/.bashrc $(HOME)/.bash_profile
	$(GC):Bash-it/bash-it.git $(BIT)
	$(BIT)/install.sh --silent
	rm -rf $(HOME)/.bashrc $(HOME)/.bash_profile $(BITP)/enabled/*.bash
	ln -s $(CDIR)/bashrc $(HOME)/.bashrc
	ln -s $(CDIR)/bash_profile $(HOME)/.bash_profile
	mkdir $(BITP)/enabled
	cat $(PDIR)/bash_plugins.txt | xargs -I '{}' bash -c 'ln -s $(BITP)/available/{}.plugin.bash $(BITP)/enabled/{}.plugin.bash'

fish: python ## Configure Fish Shell, get TackleBox and custom plugins
	$(BI) fish mr
	rm -rf $(HC)/fish $(HC)/fish_plugins
	ln -s $(CDIR)/fish $(HC)/fish
	mkdir -p $(HC)/fish_plugins
	cp $(CDIR)/fish/mrconfig $(HC)/fish_plugins/.mrconfig
	cd $(HC)/fish_plugins; mr bootstrap .mrconfig
	sudo chsh -s /usr/local/bin/fish `whoami`

configurations: ## Configure tmux
	$(BI) direnv zsh mr
	$(GC):robbyrussell/oh-my-zsh.git $(HOME)/.oh-my-zsh
	rm -f $(HOME)/.tmux.conf $(HOME)/.aspell.en.pws $(HOME)/.aspell.en.prepl $(HOME)/.zshrc $(HOME)/.direnvrc $(HOME)/.mrconfig $(HOME)/.editorconfig
	ln -s $(CDIR)/tmux.conf $(HOME)/.tmux.conf
	ln -s $(CDIR)/aspell/aspell.en.pws $(HOME)/.aspell.en.pws
	ln -s $(CDIR)/aspell/aspell.en.prepl $(HOME)/.aspell.en.prepl
	ln -s $(CDIR)/zshrc $(HOME)/.zshrc
	ln -s $(CDIR)/direnvrc $(HOME)/.direnvrc
	ln -s $(CDIR)/mrconfig $(HOME)/.mrconfig
	ln -s $(CDIR)/editorconfig $(HOME)/.editorconfig

osx: ## Setup sane OSX Defaults
	./scripts/_osx

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
