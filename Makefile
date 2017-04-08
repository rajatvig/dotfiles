BI=brew install
BCI=brew cask install

GO_DIR=/usr/local/var/go
GG=env GOPATH=$(GO_DIR) get -u

PDIR=~/dotfiles/packages
CDIR=~/dotfiles/config

PYENV_ROOT=/usr/local/var/pyenv
PYENV=env PYENV_ROOT=$(PYENV_ROOT) /usr/local/bin/pyenv
RBENV_ROOT=/usr/local/var/rbenv
RBENV=env RBENV_ROOT=$(RBENV_ROOT) /usr/local/bin/rbenv

VPI=vagrant plugin install

GC=git clone --recursive git@github.com
GCG=git config --global

LCT=~/.config/limchat-themes

BIT=~/.config/bash_it
BITP=$(BIT)/plugins

.PHONY: help
.DEFAULT_GOAL := help

relink: ## Relink the Packages with what is installed
	brew tap > $(PDIR)/tap.txt
	brew list > $(PDIR)/brew.txt
	brew cask list > $(PDIR)/cask.txt
	ls ~/.atom/packages > $(PDIR)/atom.txt
	vagrant plugin list | cut -f 1 -d ' ' > $(PDIR)/vagrant.txt
	ls $(BIT)/plugins/enabled/ | cut -d "." -f 1 > $(PDIR)/bash_plugins.txt

install: brew brew_redo cabal golang npm opam ruby rust vagrant ## Install as much as possible

brew_init:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	cat $(PDIR)/taps.txt | xargs brew tap

brew: ## Install brew, brew cask, taps, all brew and cask packages
	$(BI) cask
	$(BCI) java
	$(BCI) vagrant
	make brew_redo

brew_redo: ## Install all configured brew and cask packages
	cat $(PDIR)/brew.txt | xargs $(BI)
	cat $(PDIR)/cask.txt | xargs $(BCI)

cabal: ## Update Cabal and add some default packages
	$(BI) cabal-install
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

npm: ## Install required NPM Packages
	$(BI) nvm node
	cat $(PDIR)/npm.txt | xargs npm uninstall -g
	cat $(PDIR)/npm.txt | xargs npm install -g

opam: ## Install and configure Opam
	$(BI) opam
	opam init

python: ## Install Python, Pip Packages, PyEnv
	mkdir -p $(PYENV_ROOT)
	$(BI) pyenv python
	cat $(PDIR)/pip.txt | xargs pip install
	$(PYENV) install 3.6.0
	$(PYENV) install 2.7.13
	ln -s $(CDIR)/pypirc ~/.pypirc

ruby: ## Install RbEnv, Ruby
	mkdir -p $(RBENV_ROOT)
	$(BI) python rbenv ruby-build
	$(RBENV) install 2.4.0
	$(RBENV) global 2.4.0

rust: ## Install RustUp
	curl https://sh.rustup.rs -sSf | sh
	rustup update

vagrant: ## Install and configure Vagrant
	$(BCI) vagrant
	cat $(PDIR)/vagrant.txt | xargs $(VPI)
	mkdir -p ~/.vagrant.d
	rm ~/.vagrant.d/Vagrantfile
	ln -s $(CDIR)/Vagrantfile ~/.vagrant.d/Vagrantfile

editors: atom editorconfig emacs vim ## Install and configure all editors

atom: ## Configure Atom
	$(BCI) atom
	rm -rf ~/.atom
	mkdir ~/.atom
	ln -s $(CDIR)/atom/config.cson ~/.atom/
	ln -s $(CDIR)/atom/keymap.cson ~/.atom/
	cat $(PDIR)/atom.txt | xargs apm install

editorconfig: ## Setup default editorconfig
	rm ~/.editorconfig
	ln -s $(CDIR)/editorconfig ~/.editorconfig

emacs: ## Configure Spacemacs
	$(BI) emacs
	$(BCI) emacs
	rm -rf ~/.spacemacs ~/spacemacs ~/.emacs.d
	$(GC):syl20bnr/spacemacs ~/.emacs.d
	$(GC):rajatvig/spacemacs-config.git ~/spacemacs
	ln -s ~/spacemacs/spacemacs.el ~/.spacemacs

limechat: ## Configure LimeChat (currently broken)
	$(BCI) limechat
	mkdir -p $(LCT)
	$(GC):jschoolcraft/Limechat-Themes.git $(LCT)
	cd $(LCT); rake themes:init
	cd $(LCT); rake themes:install

vim: ## Configure SPF-13 for VIM
	$(BI) vim
	$(BCI) macvim
	curl http://j.mp/spf13-vim3 -L -o - | sh
	rm ~/.vimrc.local ~/.vimrc.bundles.local ~/.vimrc.before.local
	ln -s $(CDIR)/vim/vimrc.before.local ~/.vimrc.before.local
	ln -s $(CDIR)/vim/vimrc.bundles.local ~/.vimrc.bundles.local
	ln -s $(CDIR)/vim/vimrc.local ~/.vimrc.local

config: git aspell shells osx ## Configure Git, Aspell, Shells, OSX Defaults

git: ## Configure Git Global Settings and an Ignore file
	$(BI) git
	$(GCG) user.name "Rajat Vig"
	$(GCG) user.email "rajat.vig@gmail.com"
	$(GCG) core.editor vim
	$(GCG) core.excludesfile "~/.gitignore_global"
	rm ~/.gitignore_global
	ln -s $(CDIR)/gitignore_global ~/.gitignore_global

aspell: ## Setup personal dictionary
	rm ~/.aspell.en.pws ~/.aspell.en.prepl
	ln -s $(CDIR)aspell/aspell.en.pws ~/.aspell.en.pws
	ln -s $(CDIR)/aspell/aspell.en.prepl ~/.aspell.en.prepl

shells: bash fish zsh tmux direnv powerline ## Configure Shells

bash:
	$(BI) bash
	rm -rf $(BIT) ~/.bashrc ~/.bash_profile
	$(GC):Bash-it/bash-it.git $(BIT)
	$(BIT)/install.sh --silent
	rm -rf ~/.bashrc ~/.bash_profile $(BITP)/enabled/*.bash
	ln -s $(CDIR)/bashrc ~/.bashrc
	ln -s $(CDIR)/bash_profile ~/.bash_profile
	cat $(PDIR)/bash_plugins.txt | xargs -I '{}' bash -c 'ln -s $(BITP)/available/{}.plugin.bash $(BITP)/enabled/{}.plugin.bash'

fish: ## Configure Fish Shell, get TackleBox and custom plugins
	$(BI) fish
	rm -rf .config/fish .config/fish_plugins
	mkdir -p .config/{fish,fish_plugins}
	cat $(PDIR)/fishplugins.txt | xarg $(GC)
	ln -s $(CDIR)/fish ~/.config/fish
	sudo chsh -s /usr/local/bin/fish `echo $USER`

zsh: ## Install oh-my-zsh
	$(BI) zsh
	$(GC):robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
	rm ~/.zshrc
	ln -s $(CDIR)/zshrc ~/.zshrc

tmux: ## Configure tmux
	rm ~/.tmux.conf
	ln -s $(CDIR)/tmux.conf ~/.tmux.conf

direnv: ## Configure direnv
	rm ~/.direnvrc
	ln -s $(CDIR)/direnvrc ~/.direnvrc

powerline: ## Pretty up the prompt using PowerLine
	$(GC):milkbikis/powerline-shell.git ~/.config/powerline-shell
	cd ~/.config/powerline-shell; ./install.py
	ln -s ~/.config/powerline-shell/powerline-shell.py ~/powerline-shell.py

osx: ## Setup sane OSX Defaults
	./scripts/_osx

update_brew: ## Update brew
	brew update
	brew upgrade
	brew cleanup

update_emacs: ## Update Emacs
	cd ~/.emacs.d; git pull --rebase

update_vim: ## Update VIM
	cd ~/.spf13-vim-3; git pull --rebase
	vim +BundleInstall! +BundleClean +q

update: update_vim update_emacs update_brew ## Update software
	rustup update
	apm update -c false
	bash-it update

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
