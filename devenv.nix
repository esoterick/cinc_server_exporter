{ pkgs, ... }:

{
  env.GREET = "cinc_server_exporter";
  packages = [ pkgs.git ];
  scripts.hello.exec = "echo hello from $GREET";

  enterShell = ''
    hello
    git --version
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
