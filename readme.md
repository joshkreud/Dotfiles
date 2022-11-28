# Joshs Dotfiles

## Installation

```bash
bash install.sh
```

# Custom Commands

Some commands will be added to PATH

| Command          | Function                                                     |
| ---------------- | ------------------------------------------------------------ |
| wslssh           | copy .ssh from windows C to wsl .ssh and fix permissions     |
| ensure-ssh-agent | ensures ssh agent is started (legacy, use keyhchain instead) |

## Custom rc.d

Zshrc and bashrc are configured to source files from `$HOME/rc.d`.

| Main conf       | rc.d suffix                           |
| --------------- | ------------------------------------- |
| `.bashrc`       | `*.rc`, `*.bashrc`                    |
| `.bash_profile` | all from .bashrc and `*.bash_profile` |
| `.zshrc`        | `*.rc`, `*.zshrc`                     |

## Config SSH Keys for Agent:
Add the following eval line to a file in `~/.rc.d/`
```bash
eval `/usr/bin/keychain --eval --quiet ssh id_rsa other_key ./other/key`
```
