{ pkgs ? import <nixpkgs> { config = { android_sdk.accept_license = true; allowUnfree = true; }; } }:

let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    buildToolsVersions = [ "34.0.0" ];
    platformVersions = [ "34" ];
    includeEmulator = false;
    includeSources = false;
    includeSystemImages = false;
  };
in
pkgs.mkShell {
  buildInputs = [
    pkgs.jdk17
    pkgs.gradle
    androidComposition.androidsdk
    pkgs.android-tools
  ];
  shellHook = ''
    export ANDROID_HOME=${androidComposition.androidsdk}/libexec/android-sdk
    export JAVA_HOME=${pkgs.jdk17}
    echo "Android SDK and Build Tools are ready."
  '';
}
