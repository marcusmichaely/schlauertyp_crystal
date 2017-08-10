# schlauer_typ

This is a fork from [marcusmichaely/schlauertyp](https://github.com/marcusmichaely/schlauertyp)

Unlike the original ruby implementation this version is written in crystal and
as such compiles into a binary.  This version acts as a server backend capable
of rendering plain text, json, xml and html.

A lot of effort has been put into ensuring best possible performance which is
-- needless to say -- impeccable for a program this sophisticated.  Although
the strings used here stored in yaml files for easy editing they
are embedded in the binary during compile time for super-fast response times.

## Installation

`shards build [--release]`

## Usage

`bin/schlauer_typ [<host>:<port>]`

## Credits

All Credits to [marcusmichaely](https://github.com/marcusmichaely) for the
awesome Idea.
