{
  plugins.telescope = {
    enable = true;
    keymaps = {
      "<leader>fg" = "live_grep";
      "<leader>ff" = "find_files";
      # "<C-p>" = {
      #   action = "git_files";
      #   options = {
      #     desc = "Telescope Git Files";
      #   };
      # };
    };
    extensions.fzf-native = { enable = true; };
  };
}
