# My basic .dotfiles for macOS

This is pretty barebones right now. I may or may not add some more configs with time.

Some folders may or may not have their own README.md files. [Here's the one for beets](beets/README.md).

## Spaceship setup

The Zsh configuration uses Oh My Zsh with the Spaceship theme. Oh My Zsh must
already be installed at `~/.oh-my-zsh`. After cloning this repository to
`~/.dotfiles`, install the pinned Spaceship revision:

```sh
sh "$HOME/.dotfiles/zsh/install-spaceship.sh"
```

The installer keeps Spaceship's upstream checkout in
`zsh/oh-my-zsh-custom/themes/spaceship-prompt`, which is ignored by Git, and uses
a relative theme symlink. It is safe to rerun at the same revision. It stops
rather than overwriting an unrelated theme file or changing an existing
checkout with a different revision or local edits. Restart the terminal after
installation. This is only the theme setup; it does not install other shell
or application dependencies or link the rest of the dotfiles.

## Global Git ignore rules

`git/.gitignore_global` is the canonical global ignore file. Point Git at it:

```sh
git config --global core.excludesfile "$HOME/.dotfiles/git/.gitignore_global"
```

This does not require a symlink. Repository-specific exclusions belong in that
repository's `.gitignore`; global exclusions are personal defaults. Ignore rules
do not stop Git from tracking files that have already been committed.

## Private local files

Keep Beets's `library.db` and `state.pickle`, and yt-dlp's `cookies.txt`, private.
They are excluded by this repository's `.gitignore`. Do not force-add them.
They are local application data, not configuration files for this public repo.

The Beets database and state file were removed from published Git history during
a cleanup. Use a fresh clone after that cleanup; do not merge or push from older
clones or backups, since that can restore the removed history.
