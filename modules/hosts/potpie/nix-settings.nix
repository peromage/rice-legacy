{ pkgs, rice, ... }:

let
  nixpkgs = rice.nixpkgs;

in {
  ## Use unfree software
  nixpkgs.config.allowUnfree = true;

  nix = {
    ## Enable experimental features
    settings.experimental-features = [ "nix-command" "flakes" ];

    ## Synonyms
    ## pkgs.nixVersions.stable -> pkgs.nix, pkgs.nixFlakes, pkgs.nixStable
    ## pkgs.nixVersions.unstable -> pkgs.nixUnstable
    ## See: https://github.com/NixOS/nixpkgs/blob/master/pkgs/top-level/aliases.nix
    package = pkgs.nixFlakes;

    ## Use the nixpkgs from the toplevel flake
    registry.nixpkgs.flake = nixpkgs;
    nixPath = [ "/etc/nix/paths" ];
  };

  environment.etc."nix/paths/nixpkgs".source = "${nixpkgs}";
}