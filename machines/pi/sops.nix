{}:{
  sops = {
    # edit with `nix run nixpkgs#sops ./secrets/secrets.yaml`
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  };
}
