{ pkgs, inputs, nixpkgs, config, lib, ... }:

rec {
  programs = {
    git = {
      enable = true;
      userName = "Clayton Gilmer";
      userEmail = "42688647+claytonjgilmer@users.noreply.github.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    vim = {
      enable = true;
      settings = {
        tabstop = 4;
        shiftwidth = 4;
        expandtab = true;
      };
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      oh-my-zsh = {
        enable = true;
        theme = "af-magic";
        plugins = [ "git" ];
      };
    };
  };
}
