# homebrew-tools

A Homebrew tap for [xianxu/tools](https://github.com/xianxu/tools).

## define

A dictionary that remembers what you looked up, asks you about it later, and
answers questions a dictionary cannot.

```sh
brew trust xianxu/tools          # third-party taps are untrusted by default
brew tap xianxu/tools
brew install xianxu/tools/define
```

**Both of those lines are load-bearing.** Homebrew refuses to load formulae from
an untrusted tap and reports it as `invalid syntax in tap!`, which is not what it
sounds like. And `brew install define` gets a DIFFERENT program — `define` also
exists in homebrew-core (Rican7's dictionary client) — so the fully qualified
name is the one that installs this one.

If you have both, they collide on `PATH` and `brew` will tell you which is
winning.

Then just look a word up:

```sh
define sycophantic
```

The word joins a deck kept in whatever directory you ran it from — the directory
*is* the deck, so a project folder and a reading folder keep separate vocabularies.
Because of that, `define` **asks before making a new directory into a deck**;
declining still answers the lookup and writes nothing. With no terminal to ask —
a script, a pipe, CI — it creates nothing, so automation that wants a deck passes
`--here`.
`define --play` reviews what is due; `define --stats` says whether any of it is
working.

**macOS only, and deliberately.** Definitions and IPA come from Dictionary.app
through CoreServices, which is where they actually live — no account, no API key,
no index to build. Pronunciation plays through `afplay` and is cached after the
first fetch. The formula therefore depends on nothing but Go at build time.

The model-backed features (`--harvest`, `--reflect`, free-form questions) need an
API key in the environment; everything else works offline.

## castcut

Record, annotate and cut captioned terminal demos: record a take with asciinema,
stamp captions in a browser viewer, and cut it into a short demo that plays fast
between captions and in real time around them.

```sh
brew trust xianxu/tools
brew tap xianxu/tools
brew install xianxu/tools/castcut
```

```sh
castcut record -- ./my-app --demo          # → recordings/take-01.cast, at the window's size
castcut annotate recordings/take-01.cast   # Alt+T stamps; notes → take-01.captions.txt
castcut cut recordings/take-01.cast        # → recordings/take-01-cut.cast
```

`castcut --help` is the manual: the flow, the timing flags, the `captions`
header contract and how to embed a cut. Depends on `asciinema` (installed with
it); annotate's page loads asciinema-player from jsDelivr.
