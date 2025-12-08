{
  description = "Khonager's Hand-Drawn Icon Theme";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        name = "my-icon-theme";
        src = ./.;
        installPhase = ''
          mkdir -p $out/share/icons/MyDreamTheme
          cp -r * $out/share/icons/MyDreamTheme/
          
          # Create the index.theme dynamically
          cat > $out/share/icons/MyDreamTheme/index.theme <<CONFIG
[Icon Theme]
Name=MyDreamTheme
Comment=Hand-drawn by Khonager
Inherits=Papirus-Dark,Adwaita,hicolor
Directories=scalable/apps,48x48/apps,scalable/places,48x48/places

[scalable/apps]
Size=128
Type=Scalable
MinSize=16
MaxSize=512
Context=Applications

[48x48/apps]
Size=48
Type=Fixed
Context=Applications

[scalable/places]
Size=128
Type=Scalable
MinSize=16
MaxSize=512
Context=Places

[48x48/places]
Size=48
Type=Fixed
Context=Places
CONFIG
        '';
      };
    };
}
