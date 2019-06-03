CDIR=$(HOME)/dotfiles

VPI=vagrant plugin install

GCG=git config --global

HC=$(HOME)/.config

.PHONY: help bootstrap relink vim vagrant base_dirs java git fish
.DEFAULT_GOAL := help

BINARY_STOW := /usr/local/bin/stow
BINARY_MR   := /usr/local/bin/mr

init: ## initialize core
	ssh-keyscan github.com >> ~/.ssh/known_hosts
	ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -C "rajat.vig@gmail.com"

$(BINARY_STOW):
	brew install stow

$(BINARY_MR):
	brew install mr

java:
	brew cask install java

base:
	mkdir -p $(HOME)/work/{github,oss,personal,papers}
	mkdir -p $(HOME)/.vagrant.d

bootstrap: $(BINARY_STOW) $(BINARY_MR) base_dirs java ## bootstrap dotfiles
	stow home
	stow mr
	stow emacs
	stow vim
	stow alacritty
	stow vagrant
	stow fish

BINARY_FISH := /usr/local/bin/fish

$(BINARY_FISH):
	brew install fish toilet cowsay kubectl

BINARY_PIP := /usr/local/bin/pip

$(BINARY_PIP):
	brew install python

bash: $(BINARY_PIP) ## configure bash
	pip install --upgrade pip
	pip install	powerline-status

fish: $(BINARY_FISH) ## configure fish
	sudo chsh -s /usr/local/bin/fish $(USER)
	cd $(HC)/fish; mr bootstrap .mrconfig

relink: ## relink the packages with what is installed
	brew bundle dump --force --file=$(CDIR)/Brewfile
	vagrant plugin list | cut -f 1 -d ' ' > $(CDIR)/vagrant/.vagrant.d/plugins
	asdf plugin-list > $(CDIR)/home/.asdf-plugins

brew: ## install all configured brew packages
	brew bundle --file=$(CDIR)/Brewfile

asdf-plugins:
	cat $(CDIR)/home/.asdf-plugins | xargs -I plugin-name asdf plugin-add plugin-name | true
	asdf plugin-remove bazel
	asdf plugin-add bazel https://github.com/rajatvig/asdf-bazel.git

asdf-tools: ## install compilers/sdks/tools using asdf
	cat $(CDIR)/home/.tool-versions | xargs -I tool-version echo asdf install tool-version > /tmp/tools
	chmod +x /tmp/tools
	/tmp/tools

vagrant: ## Install and configure Vagrant
	cat $(CDIR)/vagrant/.vagrant.d/plugins | xargs $(VPI)

BINARY_VIM  := /usr/local/bin/vim
BINARY_NVIM := /usr/local/bin/nvim

$(BINARY_VIM):
	brew install vim

$(BINARY_NVIM):
	brew install nvim

vim: $(BINARY_PIP) $(BINARY_VIM) $(BINARY_NVIM) ## configure vim/nvim
	vim +PlugInstall +qall
	nvim +PlugInstall +qall
	pip install --upgrade pip
	pip install sexpdata websocket-client neovim

git: ## configure git global settings and an ignore file
	$(GCG) user.name "Rajat Vig"
	$(GCG) user.email "rajat.vig@gmail.com"
	$(GCG) core.editor vim
	$(GCG) core.excludesfile "$(HOME)/.gitignore_global"

osx: ## setup sane OSX defaults
	./scripts/_osx

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
