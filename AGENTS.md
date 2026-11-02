# AGENTS.md

Personal dotfiles for macOS and Linux (apt). `setup.sh` installs them.

- Files are copied into `$HOME`, not symlinked, so edits here don't apply until they're copied over.
- Don't run `setup.sh` to test a change. It modifies `$HOME` and appends to the shell profile and `~/.ssh/config`, so reruns add duplicates.
- Shell config exists for both bash and fish. When changing one, update the other: `aliases.sh` and `config/fish/aliases.fish`, `kubernetes-helpers.sh` and `config/fish/kubernetes-helpers.fish`.
- A new file in `config/vim/plugins/` must be added to both `utils/install_vimrc.sh` and `vimrc`.
