# zsh

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
