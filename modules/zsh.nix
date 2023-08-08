{
  enable = true;
  enableAutosuggestions = true;
  enableCompletion = true;
  enableVteIntegration = true;
  autocd = true;
  syntaxHighlighting = {
    enable = true;
  };
  oh-my-zsh = {
    enable = true;
    theme = "random";
    plugins = [
      "git"
      "direnv"
    ];
  };
  initExtra = ''
    export EDITOR=vi;
    export PAGER=less;
  '';
}
