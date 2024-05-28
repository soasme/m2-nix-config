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
  plugins = with pkgs; [
    vimPlugins.vim-nix
    vimPlugins.vim-fugitive
    vimPlugins.vim-commentary
    vimPlugins.fzf-vim
    vimPlugins.nvim-treesitter
    vimPlugins.lualine-nvim
    vimPlugins.copilot-vim
    vimPlugins.dracula-vim
    {
      plugin = vimPlugins.neoformat;
      config = ''
        let g:neoformat_enabled_nix = ["nixfmt"]
        let g:neoformat_enabled_python = ["black"]
      '';
    }
  ];
  extraConfig = ''
    colorscheme dracula
  '';
}
