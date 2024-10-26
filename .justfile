alias b := build
alias s := switch
alias a := age

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

nixos task flake: submodules
    #!/usr/bin/env fish
    if [ '{{ task }}' = 'switch' ]
      sudo nixos-rebuild {{ task }} --flake .#{{ flake }}
    else
      nixos-rebuild {{ task }} --flake .#{{ flake }}
    end

age +args: identity
    cd secrets && \
    nix run github:ryantm/agenix -- \
        -i yubikey-identity.txt {{ args }}

generate-identity name="agenix" slot="1" pin="once":
    age-plugin-yubikey --generate \
      --slot {{ slot }} \
      --name {{ name }} \
      --pin-policy {{ pin }} \
      --touch-policy always

[private]
identity slot="1":
    cd secrets && \
    age-plugin-yubikey \
      --identity \
      --slot {{ slot }} > yubikey-identity.txt

[private]
submodules:
    git submodule update --init --recursive
