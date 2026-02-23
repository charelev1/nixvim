#  Portable Nixvim Configuration

It uses **Nix-Portable** to keep your system clean while providing modern IDE
features like LSP, Treesitter, and Autocompletion.

# 1. Download the Nix-Portable engine

Run these commands in order to set up your environment:

```bash
mkdir -p ~/.config/nixvim && cd ~/.config/nixvim
curl -L [https://github.com/DavHau/nix-portable/releases/latest/download/nix-portable-$(uname](https://github.com/DavHau/nix-portable/releases/latest/download/nix-portable-$(uname) -m) > nix-portable
chmod +x nix-portable
```

# 2. Clone this setup

```bash
```

# 3. Cleanup
```bash
./nix-portable nix-store --gc
```
