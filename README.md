# Get a recent nixops with plugins

Cloned from [nixopsenv from adisbladis](https://github.com/adisbladis/nixopsenv/).

Pinned nixpkgs version, so you can just use `default.nix` to build it or include
it somewhere else.

Pinned nixpkgs should not imply, you have to use the nixpkgs version this was
build with, anywhere else. It is just a python app being build and after
that `nixops` should pick up, which `nixpkgs` to use the usual way it always does.

Didn't get the [hetzner plugin](https://github.com/NixOS/nixops-hetzner) to work, sorry for that.

The general steps to add a plugin:

Install poetry in some way.

Add your plugin to `pyproject.toml` and in `withplug.nix`.

Run `poetry lock`. If you made any errors editing `pyproject.toml` it should
tell you.

Run `nix-build`.
