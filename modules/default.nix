{ pkgs, lib }:
let
  transformFiles =
    dir:
    lib.attrsets.concatMapAttrs (name: value: {
      ${lib.strings.removeSuffix ".nix" name} =
        if name == "default.nix" then
          # NOTE(Julius): Dont include this script. I guess you could. But if
          #               you are you are doing something else wrong.
          throw "Cannot use default.nix as a standalone module"

        else if value == "regular" then
          import /${dir}/${name} { inherit pkgs lib; }

        else if value == "directory" then
          transformFiles ./${name}/.

        else
          throw "${name} is of type \"${value}\". While the only supported types are \"regular\" and \"directory\"";
    }) (builtins.readDir dir);

  files = transformFiles ./.;
in
files
