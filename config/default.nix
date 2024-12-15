{
  imports = [
    ./bufferline.nix
    ./cmp.nix
    ./utils/harpoon.nix
    # ./copilot-chat.nix
    # ./git.nix
    ./lightline.nix
    ./lsp/fidget.nix
    ./lsp/ionide.nix
    ./lsp/none-ls.nix
    ./lsp/trouble.nix
    ./nvim-tree.nix
    ./options.nix
    ./treesitter.nix
    ./utils/auto-pairs.nix
    # ./utils/autosave.nix
    # ./utils/blankline.nix
    ./utils/lazygit.nix
    ./utils/telescope.nix
    ./utils/comment-box.nix
    ./utils/markview.nix
    # ./utils/toggleterm.nix
    # ./utils/which-key.nix
    # ./utils/wilder.nix
  ];

  colorschemes.dracula.enable = true;
  plugins.web-devicons.enable = true;

  diagnostics = { virtual_lines.only_current_line = true; };

  extraConfigVim = ''
    autocmd BufRead,BufNewFile *.pl set filetype=prolog
  '';


  extraConfigLua = ''
    -- Function to copy the buffer's path to clipboard
    function copy_buffer_path_to_clipboard()
      local path = vim.api.nvim_buf_get_name(0)
      local real_path = vim.loop.fs_realpath(path) or path
      vim.fn.setreg("+", real_path)
      print("Copied buffer path to clipboard: " .. real_path)
    end
  
    -- Keymap for copying buffer path to clipboard
    vim.api.nvim_set_keymap(
      "n",
      "<leader>c",
      ":lua copy_buffer_path_to_clipboard()<CR>",
      { noremap = true, silent = true, desc = "Copy buffer path to clipboard" }
    )

    vim.cmd([[set foldmethod=indent]])
    vim.cmd([[set foldlevelstart=99]])
    vim.cmd([[set number relativenumber]])
    vim.cmd([[set nowrap]])
    vim.cmd([[set cc=80]])
    vim.cmd([[vnoremap p "_dP]])
    vim.cmd([[nnoremap _ :res +5<CR>]])
    vim.cmd([[nnoremap + :res -5<CR>]])
    vim.cmd([[nnoremap - :vertical resize +5<CR>]])
    vim.cmd([[nnoremap = :vertical resize -5<CR>]])
    vim.cmd([[vnoremap <C-f> y/<C-R>0<CR>]])

    -- Harpoon
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")
    
    vim.keymap.set("n", "<leader>a", mark.add_file)
    vim.keymap.set("n", "<leader>e", ui.toggle_quick_menu)
    vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
    vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
    vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
    vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)
    vim.keymap.set("n", "<leader>5", function() ui.nav_file(5) end)
    vim.keymap.set("n", "<leader>6", function() ui.nav_file(6) end)
    vim.keymap.set("n", "<leader>7", function() ui.nav_file(7) end)
  '';





  globals.mapleader = " ";
  keymaps = [
    # Global
    # Default mode is "" which means normal-visual-op
    # {
    #   key = "<leader>c";
    #   action = "+context";
    # }
    # {
    #   key = "<leader>co";
    #   action = "<CMD>TSContextToggle<CR>";
    #   options.desc = "Toggle Treesitter context";
    # }
    # {
    #   key = "<leader>ct";
    #   action = "<CMD>CopilotChatToggle<CR>";
    #   options.desc = "Toggle Copilot Chat Window";
    # }
    # {
    #   key = "<leader>cf";
    #   action = "<CMD>CopilotChatFix<CR>";
    #   options.desc = "Fix the selected code";
    # }
    # {
    #   key = "<leader>cs";
    #   action = "<CMD>CopilotChatStop<CR>";
    #   options.desc = "Stop current Copilot output";
    # }
    # {
    #   key = "<leader>cr";
    #   action = "<CMD>CopilotChatReview<CR>";
    #   options.desc = "Review the selected code";
    # }
    # {
    #   key = "<leader>ce";
    #   action = "<CMD>CopilotChatExplain<CR>";
    #   options.desc = "Give an explanation for the selected code";
    # }
    # {
    #   key = "<leader>cd";
    #   action = "<CMD>CopilotChatDocs<CR>";
    #   options.desc = "Add documentation for the selection";
    # }
    # {
    #   key = "<leader>cp";
    #   action = "<CMD>CopilotChatTests<CR>";
    #   options.desc = "Add tests for my code";
    # }

    # # File
    # {
    #   mode = "n";
    #   key = "<leader>f";
    #   action = "+find/file";
    # }
    {
      # Format file
      key = "<leader>fm";
      action = "<CMD>lua vim.lsp.buf.format()<CR>";
      options.desc = "Format the current buffer";
    }
    {
      mode = "n";
      key = "<leader>n";
      action = "<CMD>NvimTreeToggle<CR>";
      options.desc = "Togge nvim-tree";
    }

    # # Git    
    # {
    #   mode = "n";
    #   key = "<leader>g";
    #   action = "+git";
    # }
    # {
    #   mode = "n";
    #   key = "<leader>gt";
    #   action = "+toggles";
    # }
    # {
    #   key = "<leader>gtb";
    #   action = "<CMD>Gitsigns toggle_current_line_blame<CR>";
    #   options.desc = "Gitsigns current line blame";
    # }
    # {
    #   key = "<leader>gtd";
    #   action = "<CMD>Gitsigns toggle_deleted";
    #   options.desc = "Gitsigns deleted";
    # }
    # {
    #   key = "<leader>gd";
    #   action = "<CMD>Gitsigns diffthis<CR>";
    #   options.desc = "Gitsigns diff this buffer";
    # }
    # {
    #   mode = "n";
    #   key = "<leader>gr";
    #   action = "+resets";
    # }
    # {
    #   key = "<leader>grh";
    #   action = "<CMD>Gitsigns reset_hunk<CR>";
    #   options.desc = "Gitsigns reset hunk";
    # }
    # {
    #   key = "<leader>grb";
    #   action = "<CMD>Gitsigns reset_buffer<CR>";
    #   options.desc = "Gitsigns reset current buffer";
    # }

    # Tabs
    {
      mode = "n";
      key = "<leader>t";
      action = "+tab";
    }
    {
      mode = "n";
      key = "<leader>tn";
      action = "<CMD>tabnew<CR>";
      options.desc = "Create new tab";
    }
    {
      mode = "n";
      key = "<leader>td";
      action = "<CMD>tabclose<CR>";
      options.desc = "Close tab";
    }
    {
      mode = "n";
      key = "<leader>ts";
      action = "<CMD>tabnext<CR>";
      options.desc = "Go to the sub-sequent tab";
    }
    {
      mode = "n";
      key = "<leader>tp";
      action = "<CMD>tabprevious<CR>";
      options.desc = "Go to the previous tab";
    }

    # LazyGit
    {
      mode = "n";
      key = "<leader>lg";
      action = "<cmd>LazyGit<CR>";
      options = {
        desc = "LazyGit";
      };
    }

    # # Terminal
    # {
    #   # Escape terminal mode using ESC
    #   mode = "t";
    #   key = "<esc>";
    #   action = "<C-\\><C-n>";
    #   options.desc = "Escape terminal mode";
    # }
    #
    # # Trouble 
    # {
    #   mode = "n";
    #   key = "<leader>d";
    #   action = "+diagnostics/debug";
    # }
    # {
    #   key = "<leader>dt";
    #   action = "<CMD>Trouble diagnostics toggle<CR>";
    #   options.desc = "Toggle trouble";
    # }
  ];
}
