{
  enable = true;
  enableCompletion = true;
  enableVteIntegration = true;
  autocd = true;
  autosuggestion = {
    enable = true;
  };
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
