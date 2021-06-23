# Deno cache failure for deps shared between stable and unstable scripts.

When you have two scripts, one that needs the `--unstable` flag, one that doesn't, and a common dependency between them, Deno's cache gets in a funky state where it has to typecheck one of the scripts every time you run it.

Run [`run.sh`](./run.sh) to see a demonstration of the problem.

Known workarounds:
* Run all your scripts with `--unstable`.
* Run _nothing_ with `--unstable`. Oof.
* Manipulate the DENO_DIR environment variable when running unstable scripts, to use a different cache directory. For example, `DENO_DIR=$HOME/.cache/deno-unstable deno run --unstable a.ts`.
