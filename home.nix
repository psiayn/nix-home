{ config, pkgs, ... }:
{
  # generic linux support
  # targets.genericLinux.enable = true;
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "vader";
  home.homeDirectory = "/home/vader";
  # allow unfree
  nixpkgs.config.allowUnfree = true;

  # packages
  home.packages = with pkgs; [
    htop
    git
    neovim
    neofetch
    bat
    xclip
    wl-clipboard
    universal-ctags
    tmux
    ripgrep
    starship
    clang
    nodejs
    perf-tools
    openjdk
    direnv
    nyxt
  ];
  services.lorri.enable = true;
  # manage bash
  programs.bash = {
    enable = true;
    initExtra = ''
      . $HOME/.nix-profile/etc/profile.d/nix.sh
      eval "$(starship init bash)"
      export GIT_SSH=/usr/bin/ssh
      export EDITOR=nvim
      export PATH="$PATH:$HOME/.rvm/bin:$HOME/.cargo/bin:$HOME/.local/bin"
      export PATH="$PATH:$HOME/.npm-packages/bin"
      export NODE_PATH="$HOME/.npm-packages/lib/node_modules"
      . $HOME/.rvm/scripts/rvm
      eval "$(direnv hook bash)"
    '';
    shellAliases = {
      # home-manager
      hm = "home-manager";
      hms = "home-manager switch";
      hmsb = "home-manager switch -b backup";
      ehmc = "emacsclient -c ~/.config/nixpkgs/home.nix";
      # git aliases
      g = "git config";
      gst = "git status";
      gc = "git commit";
      ga = "git add";
      gp = "git push";
      gl = "git pull";
      glo = "git log";
      gsw = "git switch";
      gb = "git branch";
      gswc = "git switch -c";
      gd = "git diff";
      gwt = "git worktree";
      gwta = "git worktree add";
      # docker
      d = "docker";
      db = "docker build";
      # docker compose
      dc = "docker-compose";
      dcu = "docker-compose up";
      dcd = "docker-compose down";
      dcb = "docker-compose build";
      # normal shell utils
      cat = "bat";
      ls = "ls --color=auto";
      ec = "emacsclient";
      tmux = "tmux -u";
    };
  };
  
  # git config
  programs.git = {
    enable = true;
    userName = "Pranav Kesavarapu";
    userEmail = "pranavkesavarapu@gmail.com";
    extraConfig.diff.tool = "nvimdiff";
  };
  xdg = {
    enable = true;
    mime.enable = true;
  };
  targets.genericLinux.enable = true;
 
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
