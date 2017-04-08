[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)](/LICENSE)

# Automate Developer Bootstrap for Mac OSX

## How to Use

Install XCode CLI and run

```
make bootstrap
```

This will install [homebrew](https://brew.sh/), some taps and clone itself to `~/dotfiles`.

Other targets are defined when `make` is run without a target

```bash
make
```

### Included Batteries

1. Shells - [fish](http://fishshell.com/), zsh, bash, [direnv](http://direnv.net/), tmux
2. Language Bootstraps - Go, Rust, Python, Ruby, Node
3. Editors - atom, vim, [spacemacs](https://github.com/syl20bnr/spacemacs)
4. Sane OS X Defaults
5. Brew and Brew Cask Packages
6. Update Scripts

### Why

My primary work machine died an inglorious death.
I got a loaner vanilla machine, on course to get another in a month.
I missed all the software and configuration.
Didn't want to repeat installation and configuration ad nauseum.
So I started to keep a track of things, keeping it as automated as possible.
Over time, moved it to `make` targets.

### Caveats

1. As is may not be useful to everyone.
2. Some targets are not idempotent.
2. Some targets require `sudo` permissions.
2. Ansible based [Arch Linux Developer Setup](https://github.com/rajatvig/ansible-osx)
