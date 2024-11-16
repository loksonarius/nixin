# Build a flake by name
build flake: (nix "build" flake)

alias b := build

# Activate a configuration flake by name
switch flake: (nix "switch" flake)

alias s := switch

[private]
nix task flake:
    #!/usr/bin/env fish
    switch {{ flake }}
    	case danh@home danh@work
    		just hm '{{ task }}' '{{ flake }}'
    	case danh@keylime danh@okra
    		just darwin '{{ task }}' '{{ flake }}'
    	case durian mandarin
    		just nixos '{{ task }}' '{{ flake }}'
    	case '*'
    		echo 'Not a known flake'
    end

[private]
hm task flake:
    nix run home-manager -- {{ task }} --flake .#{{ flake }}

[private]
darwin task flake:
    nix run nix-darwin -- {{ task }} --flake .#{{ flake }}

[private]
nixos task flake:
    #!/usr/bin/env fish
    if [ '{{ task }}' = 'switch' ]
      sudo nixos-rebuild {{ task }} --flake .#{{ flake }}
    else
      nixos-rebuild {{ task }} --flake .#{{ flake }}
    end
