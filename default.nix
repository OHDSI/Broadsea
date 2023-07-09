{ pkgs ? import <nixpkgs> {}}:

pkgs.mkShell {
  buildInputs = [
     docker
  ];

}

