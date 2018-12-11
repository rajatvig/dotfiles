[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)](/LICENSE)

# Bootstrap for Mac OSX Mojave

### Prerequisites
1. Xcode
2. Brew

### Getting bootstrapped

```
git clone git@github.com:rajatvig/dotfiles.git ~/dotfiles
cd dotfiles
make bootstrap
make osx
```

Other targets are defined when `make` is run without a target

```bash
make
```

#### Extra notes

0. Relies on [GNU Stow](https://www.gnu.org/software/stow/) and
   [mr](https://myrepos.branchable.com/)

1. [Doom emacs](https://github.com/hlissner/doom-emacs/)

``` bash
cd ~/.emacs.d
git checkout develop
bin/doom refresh
```

2. Languages/SDK

``` bash
make asdf
```

3. Relinking

``` bash
make relink
```
