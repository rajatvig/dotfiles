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
	brew bundle dump --force --file=$(PDIR)/Brewfile
	vagrant plugin list | cut -f 1 -d ' ' > $(PDIR)/vagrant.txt
	ls $(BIT)/plugins/enabled/ | cut -d "." -f 1 > $(PDIR)/bash_plugins.txt
	asdf plugin-list > $(PDIR)/asdf-plugins.txt
	cp $(HOME)/.tool-versions $(CDIR)/asdf-tool-versions.txt

brew_base: ## Install bare minimum brew packages
	$(BI) cask fortune cowsay toilet python vim
	$(BI) --without-node yarn
	$(BCI) emacs java java8 vagrant

brew_bundle: ## Install all configured brew packages
	brew bundle --file=$(PDIR)/Brewfile

node: ## Install required Node Packages
	$(BI) yarn --without-node
	mkdir -p $(HC)/yarn
	cat $(PDIR)/npm.txt | xargs -I package-name yarn global add package-name

asdf: ## Install Languages
	$(GC):asdf-vm/asdf.git $(HOME)/.asdf --branch v0.6.0
	asdf plugin-remove glide || true
	asdf plugin-remove dep || true
	asdf plugin-add glide https://github.com/rajatvig/asdf-glide.git
	asdf plugin-add dep https://github.com/rajatvig/asdf-dep.git
	cat $(PDIR)/asdf-plugins.txt | xargs -I plugin-name asdf plugin-add plugin-name || true
	cat $(CDIR)/asdf-tool-versions.txt | xargs -I tool-version asdf install tool-version || true
	rm -f $(HOME)/.tool-versions
	cp $(CDIR)/asdf-tool-versions.txt $(HOME)/.tool-versions

vagrant: ## Install and configure Vagrant
	$(BCI) vagrant
	cat $(PDIR)/vagrant.txt | xargs $(VPI)
	mkdir -p $(HOME)/.vagrant.d
	rm -f $(HOME)/.vagrant.d/Vagrantfile
	ln -s $(CDIR)/Vagrantfile $(HOME)/.vagrant.d/Vagrantfile

emacs: ## Configure Spacemacs
	$(BCI) emacs
	rm -rf $(HOME)/.spacemacs $(HC)/spacemacs $(HOME)/.emacs.d
	$(GC):syl20bnr/spacemacs.git $(HOME)/.emacs.d
	$(GC):rajatvig/spacemacs-config.git $(HC)/spacemacs
	ln -s $(HC)/spacemacs/spacemacs.el $(HOME)/.spacemacs

vim: ## Configure SPF-13 for VIM
	$(BI) vim nvim
	$(BCI) macvim
	rm -rf $(HOME)/.vimrc $(HOME)/.vim $(HOME)/.config/nvim
	mkdir -p $(HOME)/.config/nvim
	ln -s $(CDIR)/vim/.vimrc $(HOME)/.vimrc
	cp $(CDIR)/vim/init.vim $(HOME)/.config/nvim/init.vim
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim +PlugInstall +qall
	nvim +PlugInstall +qall
	pip3 install --upgrade pip
	pip3 install sexpdata websocket-client neovim

config: ## Create Links for config files
	$(BI) direnv zsh mr fish bash git
	rm -f $(HOME)/.pypirc $(HOME)/.tmux.conf $(HOME)/.aspell.en.pws $(HOME)/.aspell.en.prepl $(HOME)/.direnvrc $(HOME)/.mrconfig $(HOME)/.editorconfig
	ln -s $(CDIR)/tmux.conf $(HOME)/.tmux.conf
	ln -s $(CDIR)/aspell/aspell.en.pws $(HOME)/.aspell.en.pws
	ln -s $(CDIR)/aspell/aspell.en.prepl $(HOME)/.aspell.en.prepl
	ln -s $(CDIR)/direnvrc $(HOME)/.direnvrc
	ln -s $(CDIR)/mrconfig $(HOME)/.mrconfig
	ln -s $(CDIR)/editorconfig $(HOME)/.editorconfig
	ln -s $(CDIR)/pypirc $(HOME)/.pypirc
	cp $(CDIR)/alacritty.yml $(HOME)/alacritty/alacritty.yml

bash: ## Configure Bash Shell
	rm -rf $(BIT) $(HOME)/.bashrc $(HOME)/.bash_profile $(BITP)/enabled/*.bash
	$(GC):Bash-it/bash-it.git $(BIT)
	$(BIT)/install.sh --silent
	ln -s $(CDIR)/bashrc $(HOME)/.bashrc
	ln -s $(CDIR)/bash_profile $(HOME)/.bash_profile
	mkdir $(BITP)/enabled
	cat $(PDIR)/bash_plugins.txt | xargs -I '{}' bash -c 'ln -s $(BITP)/available/{}.plugin.bash $(BITP)/enabled/{}.plugin.bash'

fish: ## Configure Fish Shell
	rm -rf $(HC)/fish $(HC)/fish_plugins
	ln -s $(CDIR)/fish $(HC)/fish
	mkdir -p $(HC)/fish_plugins
	cp $(CDIR)/fish/mrconfig $(HC)/fish_plugins/.mrconfig
	cd $(HC)/fish_plugins; mr bootstrap .mrconfig
	sudo chsh -s /usr/local/bin/fish `whoami`

zsh: ## Configure Zsh
	rm -rf $(HOME)/.zshrc
	$(GC):robbyrussell/oh-my-zsh.git $(HOME)/.oh-my-zsh
	ln -s $(CDIR)/zshrc $(HOME)/.zshrc

git: ## Configure Git Global Settings and an Ignore file
	rm -rf $(HOME)/.gitignore_global
	ln -s $(CDIR)/gitignore_global $(HOME)/.gitignore_global
	$(GCG) user.name "Rajat Vig"
	$(GCG) user.email "rajat.vig@gmail.com"
	$(GCG) core.editor vim
	$(GCG) core.excludesfile "$(HOME)/.gitignore_global"

osx: ## Setup sane OSX Defaults
	./scripts/_osx

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
