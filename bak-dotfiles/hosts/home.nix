{ config, lib, ... }:

with lib;
{
  networking.hosts =
    let hostConfig = if config.time.timeZone == "America/Chicago" then {
          "192.168.1.2"  = [ "nixlab" ];
          # "192.168.1.3"  = [ "kiiro" ];
          # "192.168.1.10" = [ "kuro" ];
          # "192.168.1.11" = [ "shiro" ];
          # "192.168.1.12" = [ "midori" ];
        } else if config.time.timeZone == "Europe/Copenhagen" then {
          "192.168.1.19" = [ "shiro" ];
          # "192.168.1.20" = [ "murasaki" ];
          # "192.168.1.21" = [ "aijiro" ];
          # "192.168.1.28" = [ "ao" ];
        } else {};
        hosts = flatten (attrValues hostConfig);
        hostName = config.networking.hostName;
    in mkIf (builtins.elem hostName hosts) hostConfig;

  ## Location config -- since Toronto is my 127.0.0.1
  time.timeZone = mkDefault "America/Chicago";
  i18n.defaultLocale = mkDefault "en_US.UTF-8";
  # For redshift, mainly
  location = (if config.time.timeZone == "America/Chicago" then {
    latitude = 30.311876;
    longitude = -95.456055;
  } else if config.time.timeZone == "Europe/Copenhagen" then {
    latitude = 55.88;
    longitude = 12.5;
  } else {});

  # So the vaultwarden CLI knows where to find my server.
  # modules.shell.vaultwarden.config.server = "vault.lissner.net";


}
