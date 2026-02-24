# Nixvim Configuration by charelev1


## 1. Single-user installation
```bash
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon
```


# 2. Enable flakes

```bash
    mkdir -p ~/.config/nix
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

# 3. Build with flakes

```bash
    mkdir -p ~/.config/nixvim && cd ~/.config/nixvim
    nix build github:charelev1/nixvim
```

# 4. Start nvim 
```bash
    ./result/bin/nvim
```

