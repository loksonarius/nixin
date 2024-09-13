# nixin

_User configs, server configs, PC configs, who knows?_

This repo's got my Nix configuration files for most of everything I can switch
over. It's a public repo because that leaves a non-0 chance that wandering eyes
with more knowledge than me can help me organize this mess better.

## Structure

### flake.nix

Entry point for the whole thing, this is where all configurations can be built
from.

### home/

Currently just the home-manager configuration for my specific self, kitchen-sink
style. As I add more systems into here with differrent users or different slices
of my personal user's roles, this directory will likely change. For now: it's a
home-manager dump for everything I can possibly configure for myself through
here.

To accomodate the different operating environments I'll be using nixpkgs with,
I'll be structuring the home-manager configs here such that the "happy path" is
what's common to all variations of a single user config, with a top-level
modification file that includes _all_ changes necessary to accomodate a
different OS. I don't like the structure as of right now, but I'll probably come
back to it when I can worry more about how to better structure nix modules.

### darwin/

I'm dumping nix-darwin configs here. I appreciate the pattern of isolating
system configurations from user configurations, but practically speaking, that
seems to make way more sense for NixOS-only repos than trying to semantically
overload the idea of "system configuration" with whatever one can call what
nix-darwin does isn't making it any easier for me to keep it all in my head.

The Darwin configurations in here will be one-per-role-per-system. Since
nix-darwin includes methods for modifying user preferences and Brew casks, I'm
not going to pretend that this is a system-wide configuration tool like how
nixOS configurations work.

## Usage

### if you're me

```bash
nix run nix-darwin -- switch --flake .#danh@keylime
```

### if you're not

lol don't :heart:
