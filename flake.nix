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
        installPhase = ''
                    # 1. Create the specific theme folder
                    mkdir -p $out/share/icons/Mondlicons
                    cp -r * $out/share/icons/Mondlicons/
          
                    # 2. Generate the metadata file
                    cat > $out/share/icons/Mondlicons/index.theme <<CONFIG
          [Icon Theme]
          Name=Mondlicons
          Comment=Smooth, vibrant curves.
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
