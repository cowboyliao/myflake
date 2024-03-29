#
# ssh.nix
#
# Configure ssh server
#

{ pkgs, config, ... }:

{
  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    # enable = true;
    enable = false;
    # Forbid root login through SSH.
    # Use keys only. Remove if you want to SSH using password (not recommended)
    settings={
      PasswordAuthentication=false;
      PermitRootLogin = "no";
    };
  };
}
