{ config, lib, pkgs, sshKeys, user, profiles, ... }:
{
  imports = with profiles; [
    types.desktop # type of machine
    sway # window manager
    polkit
    work
    dev
    entertainment
    ./hardware-configuration.nix
  ];

  home-manager.users.crea = {
    imports = with profiles.home; [ core neovim gammastep ];
    home.stateVersion = "23.11";
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  zramSwap.enable = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  networking.hostId = "0bf65e23"; # For example: head -c 8 /etc/machine-id
  services.zfs.autoScrub.enable = true;

  i18n = {
    # defaultLocale = "ja_JP.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pt_PT.utf8";
      LC_IDENTIFICATION = "pt_PT.utf8";
      LC_MEASUREMENT = "pt_PT.utf8";
      LC_MONETARY = "pt_PT.utf8";
      LC_NAME = "pt_PT.utf8";
      LC_NUMERIC = "pt_PT.utf8";
      LC_PAPER = "ja_JP.utf-8";
      LC_TELEPHONE = "pt_PT.utf8";
      LC_TIME = "ja_JP.utf-8";
    };
  };

  users.users.${user} = {
    extraGroups = [ "qemu-libvirtd" "input" ];
    openssh.authorizedKeys.keys = with sshKeys. lib.mkForce [ user_ryuujin user_xiaomi ];
  };

  services.printing.enable = true;
  # services.fprintd = {
  #   enable = true;
  # };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true; # seems like a sddm issue

  environment.systemPackages = with pkgs; [
    qbittorrent
    yt-dlp
    python3
    xsettingsd
    home-manager
    unstable.vesktop
  ];

  system.stateVersion = "23.11"; # Did you read the comment?
}
