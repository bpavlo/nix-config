# nix-config
DISCLAIMER: This is OMEGA broken. Main reason:
Default nix config needs to be adjusted to allow experimental features - flakes.
This is my personal nix config for my work laptop featuring nix, nix-darwin and home-manager.

## To do

- Move neovim and configs to separate repo to avoid stacking miscallenous code in Nix config repo.
  - this link will help me: https://primamateria.github.io/blog/neovim-nix/#custom-neovim-package
- Neovim related: consider switching to lazy.nvim and 'refactor' lsp, setup bindings.
  - my computer science papa released new nvim rc: https://github.com/ThePrimeagen/neovimrc
- Create flake for NixOS.
  - God I hate MacOS defaults.

## How to install

1. Install nix

```
sh <(curl -L https://nixos.org/nix/install)
```

2. Install nix-darwin

```
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer
```

3. Install home-manager as a nix-darwin module

```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```

4. Get git if you don't have it via `nix-shell -p git`. And then clone my repo or fork it and then clone.
Then use grep to find `pbunakalia` and replace it. This is my username on my work laptop and you don't want it :)
Same goes for hostname which is `darwin` in this case.

~~5. First build of nix-darwin

```
nix build ~/nix-config/.#darwinConfigurations.darwin
```
~~

5. Well, actually tested fresh install on 2024-02-24 and this is how it worked. Don't forget to delete `flake.lock` file.

```
darwin rebuild ~/nix-config/.#darwinConfigurations.darwin
```
