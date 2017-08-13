![logo](resources/logo.png)

This is a copy from [jreinert/schlauertyp](https://github.com/jreinert/schlauertyp)

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

    bin/schlauer_typ [options]

    -b HOST, --bind HOST             Host to bind (defaults to 0.0.0.0)
    -p PORT, --port PORT             Port to listen for connections (defaults to 3000)
    -s, --ssl                        Enables SSL
    --ssl-key-file FILE              SSL key file
    --ssl-cert-file FILE             SSL certificate file
    -h, --help                       Shows this help

## Benchmarks

Because why would you just have to take my word for it?

        Content-Type   Req/s  Avg Res T  Variance       Ranking
    ===========================================================
          text/plain   7.32k (136.55µs) (± 8.23%)       fastest
    application/json   7.24k (138.09µs) (± 7.32%)  1.01× slower
     application/xml    7.1k (140.94µs) (± 8.49%)  1.03× slower
           text/html   6.82k (146.55µs) (±10.31%)  1.07× slower

The benchmark was run on a Thinkpad X220 with an Intel Core i7 CPU with 4
hyperthreads and TurboBoost^tm disabled.

Still don't believe me? Run it yourself by starting `bin/schlauer_typ` and
then running `bin/benchmark`!

## Credits

- [marcusmichaely](https://github.com/marcusmichaely) for the awesome Idea.
- [dsiw](https://github.com/dsiw) for assets
