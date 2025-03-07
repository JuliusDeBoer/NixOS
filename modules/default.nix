# Helper function to get some nice syntax when importing files. In the future
# this file might just return an array with every file inside the modules when
# I have found a way to configure the entire system with some kind of higher
# level of configuration.

{ lib }:
let
  transformFiles =
    dir:
    lib.attrsets.concatMapAttrs (name: value: {
      ${lib.strings.removeSuffix ".nix" name} =
        # FIXME(Julius): This check does not check if we are still in the root
        #                of the module directory. If another directory has a
        #                `default.nix` file it cannot be imported.
        if name == "default.nix" then
          # NOTE(Julius): Dont include this script. I guess you could. But if
          #               you are you are doing something else wrong.
          throw "Cannot use default.nix as a standalone module"

        else if value == "regular" then
          /${dir}/${name}

        else if value == "directory" then
          transformFiles ./${name}/.

        else
          throw "${name} is of type \"${value}\". While the only supported types are \"regular\" and \"directory\"";
    }) (builtins.readDir dir);

  files = transformFiles ./.;
in
files
