# /etc/nixos/my-pkgs/nofetch/nofetch.nix
# These are the inputs to our function (yes, this is a function).
#
# `callPackage` will automatically fill in these arguments with
# anything that is available in `pkgs`, so that includes all packages,
# as well as some build utilities and library functions.
with import <nixpkgs> {};
# This function (stdenvNoCC.mkDerivation) is the "build a package for
# me please" function from nixpkgs.
#
# It's an enhanced version of a nix builtin function for building
# derivations (read: packages), and provides some basic utilities that
# you usually need (e.g. `cp` and `mkdir`).
#
# I'm using the NoCC variant of stdenv, which doesn't include a C
# compiler, and therefore takes less time to download.
  stdenvNoCC.mkDerivation {
    # Just the package name, this is used for the file name in
    # `/nix/store` and primarily useful for debugging or displaying
    # info. It's also mandatory.
    pname = "modprobed-db";
    # The version of the package; In this case, the project isn't
    # versioned, so the recommended practice is to use unstable-<date>.
    version = "1.0";

    src = ./.;

    # This is the actual process for "installing" the files into the
    # package. It's basically just a bash script.
    installPhase = ''
      mkdir -p $out/bin
      chmod +x modprobed-db
      cp 'modprobed-db' $out/bin/modprobed-db
    '';
  }
