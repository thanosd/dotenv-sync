# dotenv-sync

Bidirectional `.env` file sync with [1Password](https://1password.com) — pull secrets from 1Password into your local `.env` files, push changes back, or diff to see what's out of sync.

## Install

```bash
git clone https://github.com/thanosd/dotenv-sync.git ~/.dotenv-sync
cd ~/.dotenv-sync
./install.sh   # adds dotenv-sync to your PATH
```

> You can clone it anywhere you like. The install script just adds that directory to your shell's `PATH`. If you'd rather do that yourself, add this to your `.zshrc` or `.bashrc`:
> ```bash
> export PATH="$HOME/.dotenv-sync:$PATH"
> ```

### Prerequisites

- **[1Password CLI (`op`)](https://developer.1password.com/docs/cli/get-started/)** — must be installed and authenticated
- **git** — used for installation and auto-updates

## Usage

`cd` into any project directory, then:

```bash
# Set up a new project
dotenv-sync init

# Pull secrets from 1Password → local .env files
dotenv-sync pull

# Push local .env files → 1Password
dotenv-sync push

# Show differences without making changes
dotenv-sync diff

# Force mode (no prompts)
dotenv-sync pull --force

# Update to the latest version
dotenv-sync update
```

## Config

`dotenv-sync init` creates a `.env-refresh.yaml` in your project root:

```yaml
mappings:
  - op_item: "MyApp Staging .env"
    target: ".env"
  - op_item: "MyApp Production .env"
    target: ".env.production"
```

| Field     | Description                                  |
|-----------|----------------------------------------------|
| `op_item` | The name of the 1Password Secure Note item   |
| `target`  | Path to the local `.env` file (relative to project root) |

The `.env` content is stored in the **notesPlain** field of each 1Password item.

## Auto-Update

Every time you run `dotenv-sync`, it checks GitHub for a newer version. If one is available, you'll be prompted:

```
🆕 A new version of dotenv-sync is available!
   (2 commit(s) behind)
   Update now? [y]es / [n]o:
```

Choosing `y` will `git pull` the latest version and re-run your command. You can also update manually with `dotenv-sync update`.

## License

MIT
