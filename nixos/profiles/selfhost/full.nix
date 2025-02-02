{ config, lib, pkgs, profiles, ... }: {

  #TODO: is this aight here?
  users.users.media = {
    # extraGroups = [ "docker" ];
    isSystemUser = true;
    group = "media";
  };
  users.groups.media = { };

  imports = with profiles.selfhost; [
    nginx
    jellyfin
    nextcloud
    postgresql
    # invidious # not using until the new helper comes out
    # homer
    ## arrs
    #sonarr
    #radarr
    bazarr
    prowlarr
    rtorrent
    transmission
    betanin
    calibre
    thelounge
    ## finance
    # firefly
    # firefly-data-importer
    ## backups
    restic
  ];
}
