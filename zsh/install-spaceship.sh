#!/bin/sh
set -eu

# Match the existing installation; update this revision deliberately.
spaceship_revision=e46f334c548734c8320a534afa8b84ae10db3e1f
spaceship_upstream=https://github.com/spaceship-prompt/spaceship-prompt.git
script_dir=$(CDPATH='' cd "$(dirname "$0")" && pwd -P)
themes_dir="$script_dir/oh-my-zsh-custom/themes"
checkout="$themes_dir/spaceship-prompt"
theme_link="$themes_dir/spaceship.zsh-theme"
relative_target=spaceship-prompt/spaceship.zsh-theme

command -v git >/dev/null 2>&1 || {
  printf '%s\n' 'Git is required to install Spaceship.' >&2
  exit 1
}

# Refuse to overwrite a regular file or an unrelated shortcut.
if [ -L "$theme_link" ]; then
  if [ "$(readlink "$theme_link")" != "$relative_target" ]; then
    printf '%s\n' 'Unexpected theme shortcut; review it before installing.' >&2
    exit 1
  fi
elif [ -e "$theme_link" ]; then
  printf '%s\n' 'An existing theme file would be overwritten; stopping.' >&2
  exit 1
fi

mkdir -p "$themes_dir"
if [ -e "$checkout" ] || [ -L "$checkout" ]; then
  if [ -L "$checkout" ] || [ ! -d "$checkout/.git" ]; then
    printf '%s\n' 'The Spaceship destination is not a standalone Git checkout.' >&2
    exit 1
  fi
  if [ "$(git -C "$checkout" rev-parse HEAD)" != "$spaceship_revision" ]; then
    printf '%s\n' 'Spaceship is at a different revision; review it before updating.' >&2
    exit 1
  fi
  if [ -n "$(git -C "$checkout" status --porcelain)" ]; then
    printf '%s\n' 'Spaceship has local changes; leaving them untouched.' >&2
    exit 1
  fi
else
  git clone --no-checkout "$spaceship_upstream" "$checkout"
  git -C "$checkout" checkout --detach "$spaceship_revision"
fi

if [ ! -f "$checkout/spaceship.zsh-theme" ]; then
  printf '%s\n' 'The installed checkout is missing its theme.' >&2
  exit 1
fi
if [ ! -L "$theme_link" ]; then
  ln -s "$relative_target" "$theme_link"
fi
printf '%s\n' 'Spaceship is ready. Its checkout remains ignored by the dotfiles repository.'
