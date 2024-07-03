{config, ...}: {
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    forwardAgent = true;
    hashKnownHosts = false;
    serverAliveInterval = 30;
    serverAliveCountMax = 6;
    matchBlocks = {
      "github.com" = {
        identityFile = "${config.home.homeDirectory}/.ssh/id_rsa";
      };
      "git.ltd.uni-erlangen.de" = {
        identityFile = "${config.home.homeDirectory}/.ssh/id_rsa";
        port = 22;
        user = "git";
      };
      "ltd.uni-erlangen.de" = {
        identityFile = "${config.home.homeDirectory}/.ssh/id_rsa";
        match = "Host *.ltd.uni-erlangen.de";
        port = 8822;
        user = "di29nume";
      };
    };
    extraConfig = ''
      IgnoreUnknown UseKeychain
      UseKeychain yes
    '';
  };
}
