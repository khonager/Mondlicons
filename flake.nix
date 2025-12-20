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

        # Attempt to disable the hook
        dontGtkUpdateIconCache = true;
        dontDropIconThemeCache = true;

        installPhase = ''
          mkdir -p $out/share/icons/Mondlicons
          
          # ✅ Copy the new 240x240 folder, scalable, and your index.theme file
          cp -r scalable 240x240 48x48 index.theme $out/share/icons/Mondlicons/

          # Fix filenames with spaces
          find $out/share/icons/Mondlicons -name "* *" -print0 |
          while IFS= read -r -d $'\0' file; do
            mv "$file" "''${file// /_}"
          done
        '';
      };
    };
}
