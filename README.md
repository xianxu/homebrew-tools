# homebrew-tools

A Homebrew tap for [xianxu/tools](https://github.com/xianxu/tools).

## define

A dictionary that remembers what you looked up, asks you about it later, and
answers questions a dictionary cannot.

```sh
brew tap xianxu/tools
brew install define
```

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
