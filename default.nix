{ pkgs ? import <nixpkgs> {}, pythonPackages ? pkgs.python3Packages }:

pkgs.mkShell {
  buildInputs = [
     pythonPackages.numpy
     pythonPackages.scipy
     pythonPackages.jupyterlab
     pkgs.R
  ];

}

