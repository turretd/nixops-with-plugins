{ pkgs }:

self: super: {
  zipp = super.zipp.overridePythonAttrs (
    old: {
      propagatedBuildInputs = old.propagatedBuildInputs ++ [
        self.toml
      ];
    }
  );

  libvirt-python = super.libvirt-python.overridePythonAttrs({ nativeBuildInputs ? [], ... }: {
    format = "pyproject";
    nativeBuildInputs = nativeBuildInputs ++ [ pkgs.pkgconfig ];
    propagatedBuildInputs = [ pkgs.libvirt ];
  });

}
