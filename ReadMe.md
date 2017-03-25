[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)](/LICENSE)

# A collection of scripts, configuration to automate my install of OS X.

## How to Use

Install XCode and then run specific targets or run

```
make install editors config
```

All available targets are defined when `make` is run without a target

```bash
make
```

### Included Batteries

1. [Spacemacs](https://github.com/syl20bnr/spacemacs)
2. [fish](http://fishshell.com/) and [Oh-My-Fish](https://github.com/oh-my-fish/oh-my-fish)
3. [direnv](http://direnv.net/)
4. Configurations for Homebrew, Pyenv, node
5. Other Editors - Atom, Vim

### Why

My primary work machine died an inglorious death.
I got a loaner vanilla machine, on course to get another in a month.
I missed the software and configuration.
Didn't want to repeat installation and configuration ad nauseum.
So I started to keep a track of things, keeping it as automated as possible.

### Caveats

1. As is may not be useful to everyone.
2. Some targets are not idempotent.
2. Some targets require `sudo` permissions.
2. Scripts tested on OS X only. Ansible based [Arch Linux based developer setup with vagrant](https://github.com/rajatvig/ansible-osx)
