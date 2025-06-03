# My Dot Files

dotfiles, managed with [`chezmoi`](https://github.com/twpayne/chezmoi)

## Install instructions

Use this to download the repo and setup chezmoi:

```shell
chezmoi init git@github.com:jim42xd/dotfiles.git
```

Then this to override local changes:

```shell
chezmoi apply
```

_Apply can override local files, you might wanna backup `.config` first_

It's also possible to apply selectively:

```shell
chezmoi apply ~/.config/nvim
```

## Update instructions

When making local changes that should end up in the repo:

```shell
chezmoi re-add              # To update only modified files
chezmoi add ~/.config/nvim  # To add a new folder
chezmoi cd                  # To go to the repository folder
git add .                   # At this point, it's normal git stuff
```
