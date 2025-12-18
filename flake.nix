{
  description = "Mondlicons - Smooth, vibrant curves by Khonager";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        name = "mondlicons";
        src = ./.;

        # Only copy the specific folders we need to avoid copying .git/flake.nix into the system
        installPhase = ''
          mkdir -p $out/share/icons/Mondlicons
          cp -r index.theme scalable 48x48 $out/share/icons/Mondlicons/
        '';
      };
    }
}