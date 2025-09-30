{
  lib,
  rustPlatform,
}:
rustPlatform.buildRustPackage {
  pname = "solarxr-cli";
  version = "0.1.0";

  src = ../.;
  cargoLock.lockFile = ../Cargo.lock;

  # Use cargo-make so clap can generate shell completions during the build
  buildPhase = ''
    runHook preBuild
    cargo make install build
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p "$out"
    cp -r build/. "$out"/.
    runHook postInstall
  '';

  meta = {
    description = "solarxr-cli";
    homepage = "https://github.com/notpeelz/solarxr-cli";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ different-name ];
    mainProgram = "solarxr-cli";
  };
}
