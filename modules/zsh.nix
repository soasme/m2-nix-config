{
  enable = true;
  enableAutosuggestions = true;
  enableCompletion = true;
  enableSyntaxHighlighting = true;
  enableVteIntegration = true;
  autocd = true;
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
