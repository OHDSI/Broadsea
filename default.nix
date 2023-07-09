{ pkgs ? import <nixpkgs> {}}:

pkgs.mkShell {
  buildInputs = [
     pkgs.docker
     pkgs.podman
     pkgs.podman-compose
  ];

}

