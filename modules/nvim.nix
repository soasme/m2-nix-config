{ pkgs }:

{
  enable = true;
  viAlias = true;
  vimAlias = true;
  withPython3 = true;
  extraPackages = with pkgs; [
    gcc
    nixfmt-classic
    black
    nodejs
    nodePackages.prettier
  ];
  plugins = with pkgs.vimPlugins; [
    lazy-nvim
  ];
  extraConfig = ''
    set relativenumber

    lua <<EOF
    -- Bootstrap lazy.nvim
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
      local lazyrepo = "https://github.com/folke/lazy.nvim.git"
      local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
      if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
          { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
          { out, "WarningMsg" },
          { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
      end
    end
    vim.opt.rtp:prepend(lazypath)
    
    vim.g.mapleader = " "
    vim.g.maplocalleader = "\\"
    
    require("lazy").setup({
      install = { colorscheme = { "habamax" } },
      checker = { enabled = true },
      spec = {
        { "tpope/vim-fugitive" },
        { "tpope/vim-commentary" },
        { "junegunn/fzf.vim" },
        { "nvim-lualine/lualine.nvim" },
        { "github/copilot.vim" },
        { "dracula/vim", name = "dracula" },
        { "LnL7/vim-nix" },
        {
          "sbdchd/neoformat",
          config = function()
            vim.g.neoformat_enabled_nix = {"nixfmt"}
            vim.g.neoformat_enabled_python = {"black"}
          end,
        },
        {
          "yetone/avante.nvim",
          event = "VeryLazy",
          lazy = false,
          version = false,
          opts = {},
          build = "make",
          dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
            "zbirenbaum/copilot.lua",
            {
              "HakonHarnes/img-clip.nvim",
              event = "VeryLazy",
              opts = {
                default = {
                  embed_image_as_base64 = false,
                  prompt_for_file_name = false,
                  drag_and_drop = {
                    insert_mode = true,
                  },
                  use_absolute_path = true,
                },
              },
            },
            {
              'MeanderingProgrammer/render-markdown.nvim',
              opts = {
                file_types = { "markdown", "Avante" },
              },
              ft = { "markdown", "Avante" },
            },
          },
        }
      },
    })
    EOF
  '';
}
