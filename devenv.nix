{pkgs, ...}: let
  core =
    if pkgs.stdenv.isDarwin
    then [pkgs.darwin.apple_sdk.frameworks.CoreFoundation]
    else [];
in {
  env.APP = "cinc_server_exporter";
  packages = with pkgs; [git lolcat figlet] ++ core;
  scripts.banner.exec = "echo $APP | figlet -w 100 -f doom | lolcat";

  enterShell = ''
    banner
  '';

  languages = {
    nix.enable = true;
    rust = {
      enable = true;
      version = "latest";
    };
  };

  # https://devenv.sh/pre-commit-hooks/
  pre-commit.hooks = {
    shellcheck.enable = true;
    clippy.enable = true;
    rustfmt.enable = true;
  };
}
