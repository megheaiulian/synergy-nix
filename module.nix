{ lib, pkgs, ... }: {
  systemd.user.tmpfiles.rules = [
    "d /.synergy"
  ];
  systemd.user.services.synergy = {
    description = "Synergy 3 service";

    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
    wantedBy = [ "graphical-session.target" ];

    path = with pkgs;[ coreutils synergy ];
    script = ''
      synergy-service -d
    '';
    serviceConfig = {
      Restart = "on-failure";
      RestartSec = 1;
    };
  };

  #systemd.user.services.synergy-core = {
  #  # bindsTo = [ "graphical-session.target" ];
  #  # wants = [ "graphical-session-pre.target" ];
  #  # after = [ "graphical-session-pre.target" ];

  #  wantedBy = [ "graphical-session.target" ];
  #  partOf = [ "graphical-session.target" ];
  #  wants = [ "graphical-session.target" ];
  #  after = [ "graphical-session.target" ];

  #  description = "Synergy 3 service";
  #  serviceConfig.ExecStart = ''
  #    mkdir ~/.synergy
  #    ${pkgs.synergy}/bin/synergy-service -d
  #  '';
  #  serviceConfig.Restart = "on-failure";
  #  serviceConfig.RestartSec = 1;
  #};

  environment.systemPackages = [ pkgs.synergy ];
}
