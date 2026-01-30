{ pkgs, ... }:
{
  home.packages = [
    (pkgs.symlinkJoin {
      name = "zed-wrapped";
      paths = [ pkgs.zed-editor-fhs ]; # veya sadece zed-editor
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/zed \
          --set LD_LIBRARY_PATH "${
            pkgs.lib.makeLibraryPath [
              pkgs.zlib
              pkgs.openssl
              pkgs.glibc
              pkgs.stdenv.cc.cc.lib
            ]
          }"
      '';
    })
  ];
}
