CDIR=$(HOME)/dotfiles

VPI=vagrant plugin install

GCG=git config --global

HC=$(HOME)/.config

BIT=$(HC)/bash_it
BITP=$(BIT)/plugins

.PHONY: help bootstrap relink
.DEFAULT_GOAL := help

BINARY_STOW := /usr/local/bin/stow
BINARY_MR   := /usr/local/bin/mr

$(BINARY_STOW):
	brew install stow

$(BINARY_MR):
	brew install mr

bootstrap: $(BINARY_STOW) $(BINARY_MR) ## Bootstrap Brew, dotfiles
	stow home
	stow emacs
	stow vim
	stow alacritty
	stow vagrant
	stow fish
	mr update
	cd $(HC)/fish_plugins; mr bootstrap .mrconfig

relink: ## Relink the Packages with what is installed
	brew bundle dump --force --file=$(CDIR)/Brewfile
	vagrant plugin list | cut -f 1 -d ' ' > $(CDIR)/vagrant/.vagrant.d/plugins
	ls $(BIT)/plugins/enabled/ | cut -d "." -f 1 > $(CDIR)/home/.bash_plugins
	asdf plugin-list > $(CDIR)/home/.asdf-plugins

brew: ## Install all configured brew packages
	brew bundle --file=$(CDIR)/Brewfile

asdf: ## Install Languages
	cat $(CDIR)/home/.asdf-plugins | xargs -I plugin-name asdf plugin-add plugin-name || true
	cat $(CDIR)/home/.tool-versions | xargs -I tool-version asdf install tool-version || true

vagrant: ## Install and configure Vagrant
	cat $(CDIR)/vagrant/.vagrant.d/plugins | xargs $(VPI)

vim: ## Configure SPF-13 for VIM
	vim +PlugInstall +qall
	nvim +PlugInstall +qall
	pip3 install --upgrade pip
	pip3 install sexpdata websocket-client neovim

bash: ## Configure Bash Shell
	$(BIT)/install.sh --silent
	mkdir -p $(BITP)/enabled
	cat $(CDIR)/home/.bash_plugins | xargs -I '{}' bash -c 'ln -s $(BITP)/available/{}.plugin.bash $(BITP)/enabled/{}.plugin.bash'

git: ## Configure Git Global Settings and an Ignore file
	$(GCG) user.name "Rajat Vig"
	$(GCG) user.email "rajat.vig@gmail.com"
	$(GCG) core.editor vim
	$(GCG) core.excludesfile "$(HOME)/.gitignore_global"

osx: ## Setup sane OSX Defaults
	./scripts/_osx

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
