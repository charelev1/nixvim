#  Portable Nixvim Configuration

It uses **Nix-Portable** to keep your system clean while providing modern IDE
features like LSP, Treesitter, and Autocompletion.

# Dependencies
- bwrap
- git

# 1. Download the Nix-Portable engine

Run these commands in order to set up your environment:

```bash

mkdir -p ~/tmp/nixvim && cd ~/tmp/nixvim # temporary build directory
curl -L https://github.com/DavHau/nix-portable/releases/latest/download/nix-portable-$(uname -m) > ./nix-portable
chmod +x ./nix-portable
```

# 2. Clone this setup

```bash
    git clone git@github.com:charelev1/nixvim.git
```

# 4. Set the environment variables
```bash
export NP_LOCATION=$PWD
export NP_RUNTIME=bwrap
export NP_GIT=$(which git)

```

# 4. Start nix shell
```bash
  nix-portable nix-shell -p bash
```

# 5. Build the flake 
```bash
  nix build # (In nix shell)
```

# 6. Bundle the build in an AppImage
```bash
nix bundle  --bundler github:ralismark/nix-appimage   .#default  -o nixvim.AppImage  # (In nix shell)
```
# 7. Copy the AppImage symlink to your preferred location
```bash
cp -L nixvim.AppImage ~/.config/nixvim/builds
exit # Exit the  nix shell
```

# 7. Unpack the AppImage and run
```bash
cd ~/.config/nixvim/builds
chmod +x nixvim.AppImage
nixvim.AppImage --appimage-extract
./squashfs-root/AppRun 
```
