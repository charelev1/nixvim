{
  description = "A fully contained Nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixvim, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      
      nixvimConfiguration = {
        # Appearance
        colorschemes.gruvbox.enable = true;

        opts = {
            cursorline = true;
            clipboard = "unnamedplus"; # Use system clipboard for all yanks/pastes
            backup = false;         # Disable backup files
            writebackup = false;    # Disable backup before overwriting
            swapfile = false;       # Disable swap files
            undofile = false;       # Disable persistent undo
            wrap = false;               # Disable text wrapping
            foldmethod = "indent";      # Fold based on indentation levels
            foldlevel = 99;             # Start with all folds open (optional but recommended)
            number = true;         # Show line numbers
            relativenumber = true; # Relative line numbers
            shiftwidth = 4;        # Tab size
            tabstop = 4;
            expandtab = true;      # Use spaces instead of tabs
            smartindent = true;
            termguicolors = true;  # Better colors in terminal
        };

        globals.mapleader = " "; # Set Space as leader key

        diagnostic.settings = {
            virtual_text = true; # This enables the inline error messages
            underline = true;
            update_in_insert = false;
            severity_sort = true;
        };


        plugins = {
            # UI and Icons
            web-devicons.enable = true;
            lualine.enable = true;

            friendly-snippets.enable = true;
            luasnip.fromVscode = [{}];
          
            # Navigation
            telescope = {
                enable = true;
                keymaps = {
                    "<leader>ff" = "find_files";
                    "<leader>fg" = "live_grep";
                    "<leader>fr" = "oldfiles";
                };
            };

            visual-multi = {
                enable = true;
            };

            # Harpoon: Quick file switching
            harpoon = {
              enable = true;
              enableTelescope = true; # Integrates with your telescope plugin
            };


            # Syntax Highlighting
            treesitter.enable = true;
            treesitter.settings.ensure_installed = ["verilog"];

            # Language Server Protocol (LSP)
            lsp = {
                enable = true;
                servers = {
                    cmake.enable = true;
                    neocmake = {
                        enable = true;
                    };
                    nil_ls.enable = true;   # Nix language support
                    pyright.enable = true;  # Python support
                    # 1. This MUST be here to fix the 'nil' root
                    verible = {
                      rootMarkers = [
                        ".git"
                        "verible.filelist"
                        ".rules.verible_lint"
                      ];
                      enable = true;
                    };
                    svls = {
                        enable = true;
                        rootMarkers = [
                        ".svlint.toml"
                        ".git"
                        ];
                        extraOptions = {
                            settings = {
                            systemverilog = {
                                linter = {
                                enabled = true;
                                # This tells svls to use the binary found in your Nix path
                                command = "svlint";
                                };
                            };
                            };
                        };
                    };

                    ruff = {
                        enable = true;
                    };

                    # TOML (Rust-based)

                    taplo.enable = true;
                    # Rust (The ultimate Rust-based LSP)
                    rust_analyzer = {
                        enable = true;
                        installCargo = true;
                        installRustc = true;
                    };

                    # Markdown (Fast and reliable)
                    marksman.enable = true;


                    clangd.enable = true;   # C/C++ <--- Add this line
                };
            };

            nui.enable = true;
            noice = {
                enable = true;
                settings = {
                    cmdline = {
                        # view = "cmdline_popup"; # This makes it a floating window
                        view = "cmdline_popup"; # This makes it a floating window
                    };
                    views = {
                    cmdline_popup = {
                        position = {
                         row = 2; # Position from the top
                        col = "50%"; # Centered horizontally
                        };
                        size = {
                        width = 60;
                        height = "auto";
                        };
                    };
                    };
                };
            };






            # Smooth, animated indentation scope
            mini = {
              enable = true;
              modules = {
                indentscope = {
                  symbol = "│";
                  options = {
                    try_as_border = true;
                  };
                };
              };
            };


            # # Add nvim-tree here
            nvim-tree = {
                enable = true;
                openOnSetup = true;
                # Add these settings:
                settings = {
                    git = {
                        enable = true;
                        ignore = false; # Set to false to SHOW gitignored files
                    };
                };
            #     autoClose = true;        # Close explorer when it's the last window
            };

            luasnip.enable = true;

            # Autocompletion
            cmp = {
                enable = true;
                settings = {
                    snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
                    autoEnableSources = true;
                    sources = [
                        { name = "nvim_lsp"; }
                        { name = "nvim_lsp_signature_help"; }
                        { name = "path"; }
                        { name = "buffer"; }
                    ];
                    mapping = {
                        # Confirm with Enter
                        "<CR>" = "cmp.mapping.confirm({ select = true })";
                    
                        # Navigate down with Ctrl+n
                        "<C-n>" = "cmp.mapping.select_next_item()";
                    
                        # Navigate up with Ctrl+p
                        "<C-p>" = "cmp.mapping.select_prev_item()";
                    
                        # Optional: Keep Tab for completion as well if you like
                        "<Tab>" = "cmp.mapping.select_next_item()";
                        "<S-Tab>" = "cmp.mapping.select_prev_item()";
                    };
                };
            };
        };

        keymaps = [
            {
                mode = "n";
                key = "<leader>n";
                action = "<cmd>NvimTreeToggle<CR>";
                options.desc = "Toggle File Explorer";
            }

            # --- Your Preferred Harpoon Keybindings ---
            {
                mode = "n";
                key = "<leader>a";
                action.__raw = "function() require('harpoon'):list():add() end";
                options.desc = "Harpoon: Add File";
            }
            {
                mode = "n";
                key = "<leader>e";
                action.__raw = "function() local harpoon = require('harpoon') harpoon.ui:toggle_quick_menu(harpoon:list()) end";
                options.desc = "Harpoon: Toggle Menu";
            }
            # Navigation using <leader> + 1-5
            {
                mode = "n";
                key = "<leader>1";
                action.__raw = "function() require('harpoon'):list():select(1) end";
                options.desc = "Harpoon: Nav to 1";
            }
            {
                mode = "n";
                key = "<leader>2";
                action.__raw = "function() require('harpoon'):list():select(2) end";
                options.desc = "Harpoon: Nav to 2";
            }
            {
                mode = "n";
                key = "<leader>3";
                action.__raw = "function() require('harpoon'):list():select(3) end";
                options.desc = "Harpoon: Nav to 3";
            }
            {
                mode = "n";
                key = "<leader>4";
                action.__raw = "function() require('harpoon'):list():select(4) end";
                options.desc = "Harpoon: Nav to 4";
            }
            {
                mode = "n";
                key = "<leader>5";
                action.__raw = "function() require('harpoon'):list():select(5) end";
                options.desc = "Harpoon: Nav to 5";
            }

            # --- Move Lines (Normal Mode) ---
            {
                mode = "n";
                key = "<C-j>";
                action = ":m .+1<CR>== ";
                options.silent = true;
            }
            {
                mode = "n";
                key = "<C-k>";
                action = ":m .-2<CR>== ";
                options.silent = true;
            }

            # --- Move Lines (Visual Mode) ---
            {
                mode = "v";
                key = "<C-j>";
                action = ":m '>+1<CR>gv=gv";
                options.silent = true;
            }
            {
                mode = "v";
                key = "<C-k>";
                action = ":m '<-2<CR>gv=gv";
                options.silent = true;
            }

            # --- Paste without losing current register ---
            {
                mode = "x";
                key = "p";
                action = "\"_dP";
                options.silent = true;
            }
            # Use Ctrl + ] to jump to definition using LSP
            {
                mode = "n";
                key = "<C-]>";
                action.__raw = "vim.lsp.buf.definition";
                options.desc = "LSP: Jump to Definition (replaces Tags)";
            }

            # Use Ctrl + t to jump back
            # Note: We use 'pop_tag_stack' or simply the jump list 'Ctrl + o'
            # But to stay true to the 'Tag' behavior, we can jump back in the list:
            {
                mode = "n";
                key = "<C-t>";
                action = "<C-o>"; 
                options.desc = "Jump Back";
            }
        ];

      };

      # Build the Neovim package
      nvim = nixvim.legacyPackages.${system}.makeNixvim nixvimConfiguration;
    in {
      packages.${system}.default = nvim;
    };
}
