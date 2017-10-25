# Cog
![yo dawg](https://raw.githubusercontent.com/happycog/cog/master/yo_dawg.jpg)

## Installation
With [yarn](https://github.com/yarnpkg/yarn) do:

`yarn global add hc-cog`
## Scripts
Whether you are creating/deleting/modifying a script, you must update `package.json` inside of `bin: {…}` and `bin/cog-help`.

## Usage
Running `cog` on the command line will list all of the avalible scripts and a short description. Any new script you make will overwrite the global defaults. You can run `cog make:script dev` and create a custom bash script based on that specific project

## Update
Run `cog update` to recieve the latest version. To update this package, run `npm version {patch, minor, major}` followed by `npm publish`