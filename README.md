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
`define --play` reviews what is due; `define --stats` says whether any of it is
working.

**macOS only, and deliberately.** Definitions and IPA come from Dictionary.app
through CoreServices, which is where they actually live — no account, no API key,
no index to build. Pronunciation plays through `afplay` and is cached after the
first fetch. The formula therefore depends on nothing but Go at build time.

The model-backed features (`--harvest`, `--reflect`, free-form questions) need an
API key in the environment; everything else works offline.
