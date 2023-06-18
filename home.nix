{ pkgs }:

let
  username = "soasme";
in
{
  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "23.05";

  home.packages = [
    pkgs.gnumake
    pkgs.ripgrep
    pkgs.direnv
    pkgs.autojump
    pkgs.jq
    pkgs.rsync
    pkgs.keepassxc
  ];

  programs.git = import ./modules/git.nix;
  programs.neovim = import ./modules/nvim.nix { inherit pkgs; };
  programs.zsh = import ./modules/zsh.nix;
}
