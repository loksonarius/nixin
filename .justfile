alias b := build
alias s := switch

build flake: (nix "build" flake)

switch flake: (nix "switch" flake)

[private]
nix task flake:
    #!/usr/bin/env fish
    switch {{ flake }}
    	case danh@home danh@work
    		just hm '{{ task }}' '{{ flake }}'
    	case danh@keylime danh@okra
    		just darwin '{{ task }}' '{{ flake }}'
    	case mandarin
    		just nixos '{{ task }}' '{{ flake }}'
    	case '*'
    		echo 'Not a known flake'
    end

hm task flake:
    nix run home-manager -- {{ task }} --flake .#{{ flake }}

darwin task flake:
    nix run nix-darwin -- {{ task }} --flake .#{{ flake }}

nixos task flake:
    nixos-rebuild {{ task }} --flake .#{{ flake }}
