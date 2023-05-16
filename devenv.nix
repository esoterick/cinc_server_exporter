{pkgs, ...}: let
  core =
    if pkgs.stdenv.isDarwin
    then [pkgs.darwin.apple_sdk.frameworks.CoreFoundation]
    else [];
in {
  env.APP = "cinc_server_exporter";
  scripts.banner.exec = "echo $APP | figlet -w 100 -f doom | lolcat";

  enterShell = ''
    banner
  '';

  packages = with pkgs;
    [
      git
      lolcat
      figlet
    ]
    ++ core;

  services = {
    postgres = {
      enable = true;
    };
  };

  languages = {
    nix.enable = true;
    rust = {
      enable = true;
      version = "stable";
    };
  };

  # https://devenv.sh/pre-commit-hooks/
  pre-commit.hooks = {
    shellcheck.enable = true;
    clippy.enable = true;
    rustfmt.enable = true;
    alejandra.enable = true;
  };
}
