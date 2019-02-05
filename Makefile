CDIR=$(HOME)/dotfiles

VPI=vagrant plugin install

GCG=git config --global

HC=$(HOME)/.config

.PHONY: help bootstrap relink vim vagrant base_dirs java
.DEFAULT_GOAL := help

BINARY_STOW := /usr/local/bin/stow
BINARY_MR   := /usr/local/bin/mr

$(BINARY_STOW):
	brew install stow

$(BINARY_MR):
	brew install mr

java:
	brew cask install java

base_dirs:
	mkdir -p $(HOME)/work/{github,oss,personal,papers}
	mkdir $(HOME)/.vagrant.d

bootstrap: $(BINARY_STOW) $(BINARY_MR) base_dirs java ## Bootstrap Brew, dotfiles
	stow home
	stow mr
	stow emacs
	stow vim
	stow alacritty
	stow vagrant
	stow fish
	mr update
	cd $(HC)/fish; mr bootstrap .mrconfig

relink: ## Relink the Packages with what is installed
	brew bundle dump --force --file=$(CDIR)/Brewfile
	vagrant plugin list | cut -f 1 -d ' ' > $(CDIR)/vagrant/.vagrant.d/plugins
	asdf plugin-list > $(CDIR)/home/.asdf-plugins

brew: ## Install all configured brew packages
	brew bundle --file=$(CDIR)/Brewfile

asdf: ## Install Languages
	cat $(CDIR)/home/.asdf-plugins | xargs -I plugin-name asdf plugin-add plugin-name || true
	cat $(CDIR)/home/.tool-versions | xargs -I tool-version asdf install tool-version || xargs -I {} sh -c {} || true

vagrant: ## Install and configure Vagrant
	cat $(CDIR)/vagrant/.vagrant.d/plugins | xargs $(VPI)

vim: ## Configure VIM
	vim +PlugInstall +qall
	nvim +PlugInstall +qall
	pip3 install --upgrade pip
	pip3 install sexpdata websocket-client neovim

git: ## Configure Git Global Settings and an Ignore file
	$(GCG) user.name "Rajat Vig"
	$(GCG) user.email "rajat.vig@gmail.com"
	$(GCG) core.editor vim
	$(GCG) core.excludesfile "$(HOME)/.gitignore_global"

osx: ## Setup sane OSX Defaults
	./scripts/_osx

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
