# Cog
![yo dawg](https://raw.githubusercontent.com/happycog/cog/master/yo_dawg.jpg)

## Installation
With [yarn](https://github.com/yarnpkg/yarn) do:

`yarn global add hc-cog`

## Scripts
All scripts run through `bin/cog`. When you run a `command`, `bin/cog` looks for `bin/cog-command` and executes it.

Whenever you create, delete, or modify a script, you must update `bin/cog-help`.

## Usage
Running `cog` on the command line will list all of the available scripts and a short description. Any new script you make will overwrite the global defaults. You can run `cog make:script dev` and create a custom bash script based on that specific project

## Plugins
You can add plugins to `cog` through the .cogconfig file. A plugin consists of a directory of `cog-<command>` commands, which can exist anywhere within your file system.

Run `cog config` to create the `.cogconfig` file in your home directory.

You can then edit the `COG_PLUGIN_DIRECTORIES=` variable with a comma-separated list of paths where your `cog-<command>` scripts are stored.

## Update
Run `cog update` to receive the latest version. 

To update this package, run `yarn version {patch, minor, major}` followed by `yarn publish`

## Builds
If you're using `Go` to write any commands, put your source `.go` file into the `src` directory and run this command to build it into a binary in the `bin` directory:

```
yarn run build
```
