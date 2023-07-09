{ pkgs ? import <nixpkgs> {}}:

  environment.systemPackages = [
    pkgs.R
  ];

}

