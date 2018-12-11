BI=brew install
BCI=brew cask install

CDIR=$(HOME)/dotfiles

VPI=vagrant plugin install

GC=git clone --recursive git@github.com
GCG=git config --global

HC=$(HOME)/.config

BIT=$(HC)/bash_it
BITP=$(BIT)/plugins

.PHONY: help bootstrap relink
.DEFAULT_GOAL := help

BINARY_STOW := /usr/local/bin/stow

$(BINARY_STOW):
	brew install stow

bootstrap: $(BINARY_STOW) ## Bootstrap Brew, dotfiles
	stow config
	mr update
	stow emacs
	stow vim
	stow alacritty
	stow vagrant
	stow fish
	cd $(HC)/fish_plugins; mr bootstrap .mrconfig

relink: ## Relink the Packages with what is installed
	brew bundle dump --force --file=$(CDIR)/Brewfile
	vagrant plugin list | cut -f 1 -d ' ' > $(CDIR)/vagrant/.vagrant.d/plugins
	ls $(BIT)/plugins/enabled/ | cut -d "." -f 1 > $(CDIR)/config/.bash_plugins
	asdf plugin-list > $(CDIR)/config/.asdf-plugins

brew: ## Install all configured brew packages
	brew bundle --file=$(CDIR)/Brewfile

asdf: ## Install Languages
	asdf plugin-remove glide || true
	asdf plugin-remove dep || true
	asdf plugin-add glide https://github.com/rajatvig/asdf-glide.git
	asdf plugin-add dep https://github.com/rajatvig/asdf-dep.git
	cat $(CDIR)/config/.asdf-plugins | xargs -I plugin-name asdf plugin-add plugin-name || true
	cat $(CDIR)/config/.tool-versions | xargs -I tool-version asdf install tool-version || true

vagrant: ## Install and configure Vagrant
	cat $(CDIR)/vagrant/.vagrant.d/plugins | xargs $(VPI)

vim: ## Configure SPF-13 for VIM
	vim +PlugInstall +qall
	nvim +PlugInstall +qall
	pip3 install --upgrade pip
	pip3 install sexpdata websocket-client neovim

bash: ## Configure Bash Shell
	$(BIT)/install.sh --silent
	mkdir $(BITP)/enabled
	cat $(PDIR)/bash_plugins.txt | xargs -I '{}' bash -c 'ln -s $(BITP)/available/{}.plugin.bash $(BITP)/enabled/{}.plugin.bash'

git: ## Configure Git Global Settings and an Ignore file
	$(GCG) user.name "Rajat Vig"
	$(GCG) user.email "rajat.vig@gmail.com"
	$(GCG) core.editor vim
	$(GCG) core.excludesfile "$(HOME)/.gitignore_global"

osx: ## Setup sane OSX Defaults
	./scripts/_osx

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
