# Joshua Kreuder's Dotfiles

Cross-platform dotfiles for Bash, Zsh, Tmux, Vim/Neovim, and Git — managed via symlinks with a modular `~/.rc.d` system.

## Quick Start

```bash
git clone git@github.com:joshkreud/Dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash install.sh                # add -z for Zsh, -n for Neovim
```

Install a [Nerd Font](https://www.nerdfonts.com) for CLI icons.

## What Gets Symlinked

All config files live under [`rcfiles/`](rcfiles/). The installer symlinks them to `$HOME` and `$XDG_CONFIG_HOME`.

See: [`.bashrc`](rcfiles/.bashrc) · [`.zshrc`](rcfiles/.zshrc) · [`.bash_profile`](rcfiles/.bash_profile) · [`.inputrc`](rcfiles/.inputrc) · [`.vimrc`](rcfiles/.vimrc) · [`.gitconfig`](rcfiles/.gitconfig) · [`.tmux.conf`](rcfiles/.tmux.conf) · [`alacritty.yml`](rcfiles/alacritty.yml) · [`.config/starship.toml`](.config/starship.toml) · [NvChad config](rcfiles/nvchad/)

## Modular rc.d System

Both `.bashrc` and `.zshrc` auto-source files from `~/.rc.d/` matching these patterns:

| Shell        | Patterns                         |
| ------------ | -------------------------------- |
| Bash         | `*.rc`, `*.bashrc`               |
| Bash (login) | Bash patterns + `*.bash_profile` |
| Zsh          | `*.rc`, `*.zshrc`                |

Drop a file into `~/.rc.d/` and it's picked up automatically — no edits to the main dotfiles needed. Symlinks are fine.

Machine-specific config (paths, secrets, host-specific tools) goes into a file like `~/.rc.d/00_$(hostname).rc`.

Built-in modules: [`path.rc`](rcfiles/.rc.d/path.rc) · [`common.rc`](rcfiles/.rc.d/common.rc) · [`global_alias.git_dot.rc`](rcfiles/.rc.d/global_alias.git_dot.rc) · [`ca_certs.rc`](rcfiles/.rc.d/ca_certs.rc) · [`ssh_agent.rc`](rcfiles/.rc.d/ssh_agent.rc)

Files are loaded in alphabetical order. Machine-specific config uses a `00_` prefix so it runs before shared modules.

---

## Custom Commands

All scripts in [`commands/`](commands/) are added to `$PATH`.

| Command                | Description                                                            |
| ---------------------- | ---------------------------------------------------------------------- |
| `wslssh`               | Copy `.ssh` from Windows to WSL, fix permissions                       |
| `ensure-ssh-agent`     | Start `ssh-agent` and add keys (legacy — prefer keychain)              |
| `fzf_open_code`        | FZF-pick a git repo in `~/dev/`, open in VS Code or devcontainer       |
| `install_bw_cli`       | Download and install Bitwarden CLI                                     |
| `bw-unlock-session`    | Unlock Bitwarden, export `BW_SESSION`                                  |
| `docker-prune-all`     | Aggressively prune Docker system + build cache                         |
| `wsl_open_explorer`    | Open a directory in Windows Explorer from WSL                          |
| `mass_set_git_email`   | Bulk-set `user.email` across all git repos under a directory           |
| `load_custom_ca_certs` | Convert `.cer` → `.pem`, concat with system CA bundle, export env vars |

---

## Custom CA Certificates

To inject corporate CA certificates into every shell session:

```bash
# In a machine-specific ~/.rc.d file:
export CUSTOM_CA_CERTS="$HOME/dev/your-org/ca_certs"

# Rebuild the bundle once (or after certs change):
REBUILD_CA_BUNDLE=1
```

[`ca_certs.rc`](rcfiles/.rc.d/ca_certs.rc) calls [`load_custom_ca_certs`](commands/load_custom_ca_certs), which auto-converts `.cer` → `.pem`, concatenates them with the system CA bundle, and exports `SSL_CERT_FILE`, `REQUESTS_CA_BUNDLE`, `CURL_CA_BUNDLE`, `NODE_EXTRA_CA_CERTS`, and `NODE_OPTIONS`.

On macOS, also broadcasts these env vars to GUI apps via `launchctl setenv` so apps launched via Spotlight/Raycast inherit the custom CA bundle.

---

## SSH Key Management

[`ssh_agent.rc`](rcfiles/.rc.d/ssh_agent.rc) manages SSH agents via `keychain` (cross-platform) and broadcasts `SSH_AUTH_SOCK` to GUI apps on macOS via `launchctl setenv`.

To configure which keys to load, set `SSH_KEY_PATH` in a machine-specific `~/.rc.d` file:

```bash
export SSH_KEY_PATH="$HOME/.ssh/id_pw_ed25519 $HOME/.ssh/id_rsa"
```

Without this broadcast, macOS GUI apps launched via Spotlight/Raycast (e.g., VS Code host process) inherit the Apple-native ssh-agent socket which has no keys loaded — causing Git operations to fail even though the integrated terminal works fine.

## macOS GUI App Environment

On macOS, GUI apps don't inherit the shell environment — they get `launchd`'s environment. The shared modules handle this:

| Module                                              | Broadcasts                               |
| --------------------------------------------------- | ---------------------------------------- |
| [`ca_certs.rc`](rcfiles/.rc.d/ca_certs.rc)          | `SSL_CERT_FILE`, `NODE_EXTRA_CA_CERTS`… |
| [`ssh_agent.rc`](rcfiles/.rc.d/ssh_agent.rc)        | `SSH_AUTH_SOCK`                          |

No machine-specific configuration needed — it Just Works™ on any Mac that sources these modules.

---

## Platform Support

The installer auto-detects **apt** (Debian/Ubuntu/WSL), **pacman** (Arch), and **brew** (macOS). Core packages: `git`, `gcc`, `keychain`, `tmux`, `vim`, `socat`, `fd`.

---

## Post-Install

1. **Nerd Font** — [nerdfonts.com](https://www.nerdfonts.com) (Starship + NvChad icons)
2. **Tmux plugins** — `<prefix> + I` inside tmux
3. **Bitwarden CLI** — `install_bw_cli`
4. **VS Code CLI** — needed for `fzf_open_code` and `code`
5. **Custom CA certs** — set `$CUSTOM_CA_CERTS`, run `REBUILD_CA_BUNDLE=1`
