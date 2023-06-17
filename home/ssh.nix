{...}: {
  programs.ssh = {
    enable = true;
    serverAliveInterval = 30;
    serverAliveCountMax = 6;
    extraConfig = ''
      Host *
        IdentityFile ~/.ssh/id_rsa
        IgnoreUnknown UseKeychain
        UseKeychain yes
        AddKeysToAgent yes

      Host git.ltd.uni-erlangen.de
        Port 22
        User git

      Match Host *.ltd.uni-erlangen.de
        Port 8822
        User di29nume
    '';
  };
}
