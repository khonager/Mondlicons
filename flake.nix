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
        pname = "mondlicons";
        version = "0.0.1";

        src = ./.;

        nativeBuildInputs = [ ];

        # Disable the automatic icon cache generation hook
        dontGtkUpdateIconCache = true;
        # Prevent the hook from dropping the cache if it were generated
        dontDropIconThemeCache = true;

        installPhase = ''
          mkdir -p $out/share/icons/Mondlicons
          
          # Copy folders
          cp -r scalable 48x48 $out/share/icons/Mondlicons/

          # Fix filenames with spaces (using bash substitution)
          find $out/share/icons/Mondlicons -name "* *" -print0 | while IFS= read -r -d $'\0' file; do
            mv "$file" "''${file// /_}"
          done

          # Write index.theme
          cat > $out/share/icons/Mondlicons/index.theme <<THEME
[Icon Theme]
Name=Mondlicons
Comment=Smooth, vibrant curves.
Inherits=Papirus-Dark,Adwaita,hicolor
Directories=scalable/apps,48x48/apps

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
THEME
        '';
      };
    };
}
