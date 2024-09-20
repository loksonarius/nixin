# nixin

_User configs, server configs, PC configs, who knows?_

This repo's got my Nix configuration files for most of everything I can switch
over. It's a public repo because that leaves a non-0 chance that wandering eyes
with more knowledge than me can help me organize this mess better.

## Mental Model

I'm currently really early on to developing my understanding of the various
components of nix. For the sake of this repo, I have a working model I'll be
explaining here.

### Roles

In my head, a role is a logical grouping of configurations that accomplish a
goal across various system types. For example, the `users/danh` role represents
everything involved in configuring access for my user across hosts, including
both OS configs as well as my personal preferences and dotfiles. The way these
configurations are accessed is by directly importing the module matching the
type of the calling config. In other words, a nix-darwin `darwinSystem` would
import the `users/danh/darwin` module and a home-manager
`homeManagerConfiguration` would import the `users/danh/home` module.

### Outputs

Because I intend to write configurations for more than just nixos hosts, I'm not
following the common pattern of defining host configs with added user configs.
The functional differences between even nix-darwwin and nixos configs alone is
enough for me to not bother trying to have all my outputs represent "whole-host
configurations". Instead, each output is a configuration specific to just the
scope of the target tool. It is then up to the target environment to call the
appropriate tools for each output configuration to produce the intended final
host state.

So for the `danh` user on the the `keylime` host, the result would be calling
`nix-darwin switch` as well as `home-manager switch` following a general nix
installation.

## Structure

### flake.nix

Entry point for the whole thing, this is where all configurations can be built
from.

### modules/

The sub-directories here are my classification for "role" types. This is purely
semantics and has no functionality beyond organization. There's currently only
two role types:

- `hosts`: represent a physical or virtual machine
- `users`: represents a real person or archetype that'd have access to a host

Under each role, there will be module directories for each configuration type
needed to accomplish the role's intent. These will be directly imported up in
`flake.nix` according to the output being defined.

### modules/\*/\*/options.nix

For each role, I've included a place for common module options that could span
across different configuration types. These options will at least include an
enable option for the role, such that importing a role's module is not enough to
evaluate the entire config.

So for  the `danh` role, for example, the `nixin.users.danh.enable` option must
be `true` for whatever module was imported from the `danh` role.

## Usage

### if you're me

```bash
nix run nix-darwin -- switch --flake .#danh@keylime
nix run home-manager -- switch --flake .#danh@keylime
```

### if you're not

lol don't :heart:
