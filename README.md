# `solx` Compiler Demo

[`solx`](https://solx.zksync.io/) is a new optimizing compiler for the EVM, developed by [Matter Labs](https://matter-labs.io/).

This repository contains a playground for testing `solx` capabilities.

> [!WARNING]  
> `solx` v0.1.0 is still in beta. It has already passed [all tests in these projects](https://github.com/matter-labs/solx/actions/runs/16133619145/attempts/1#summary-45527824432), but it should be used in production with care and good test coverage.

## Installing

Install [foundry](https://book.getfoundry.sh/getting-started/installation) to interact with the projects.
Foundry v1.0.0 can be used for `sample_project` and `erc20`, but Foundry v0.3.0 is required for `solmate`.

If you already have Foundry v1.0.0 installed, you can use `foundryup` to install v0.3.0:

```bash
foundryup -v 0.3.0
```

Here are the URLs for the test builds:

- [Linux/AMD64](https://github.com/matter-labs/solx/releases/download/0.1.0/solx-linux-amd64-gnu-v0.1.0)
- [Linux/Arm64](https://github.com/matter-labs/solx/releases/download/0.1.0/solx-linux-arm64-gnu-v0.1.0)
- [MacOS](https://github.com/matter-labs/solx/releases/download/0.1.0/solx-macosx-v0.1.0)
- [Windows](https://github.com/matter-labs/solx/releases/download/0.1.0/solx-windows-amd64-gnu-v0.1.0.exe)

Choose the appropriate URL, download it to current folder, and make it executable, e.g.:

```bash
wget 'https://github.com/matter-labs/solx/releases/download/0.1.0/solx-linux-amd64-gnu-v0.1.0' -O solx
chmod +x solx
```

## Using with forge

By default, all the projects will use native `solc` 0.8.28, to compile with `solx` use `FOUNDRY_PROFILE=solx`, e.g.:

```bash
FOUNDRY_PROFILE=solx forge build
FOUNDRY_PROFILE=solx forge test
```

Or you can do `export FOUNDRY_PROFILE=solx` to make it used by default within your terminal session.

Please check which version is used for compilation: `0.8.28` corresponds to native `solc`, while `0.8.30` corresponds to `solx`.
The main reason to use different versions of compiler is to force foundry to recompile contracts when switching profiles.
Feel free to compare with other versions yourself.

`solx` is still missing some features to work with Foundry as expected. Here are some guidelines:

- Run `forge build` before running tests, and run `forge clean` after running tests. Re-compilation of already built contracts may not work as expected.
- Only `forge build` and `forge test` have been checked; `forge script` and other options may not work or work incorrectly.

## Project structure

All the projects are configured to be using `solx` and will assume that it's present in the root of the repository.

- `sample_project`: a default `forge` project.
- `erc20`: sample ERC20 token using [`solady`](https://github.com/Vectorized/solady) library.
- `solmate`: copy of [`solmate`](https://github.com/transmissions11/solmate/) project, with compiler changed to `solc` 0.8.28 (for equivalence of benchmarks)
  and pragma limitations lifted. ⚠️ requires foundry v0.3.0 to work (project not compatible with v1.0.0 yet).

## Comparisons

These comparisons aren't meant to be considered proper benchmarks. Consider these comparisons to be "out-of-box", e.g. something
user will get with default settings for both compilers. Do your own research, and compare compiler performance for your
use case.

Additionally, consider that `solx` is still in a pre-alpha stage and many optimizations are not implemented yet!

In all the benchmarks, `solc` is on the left, `solx` is on the right.

### `solmate`, `solc` 1000000 optimizer runs, `solx` `-03`, legacy

⚠️ Don't forget to install `foundry` 0.3.0 to run tests.

`solmate` has a lot of tests, so we provide only a subset here. Run it yourself 😅

![04](assets/04_solmate_weth.png)

![05](assets/05_solmate_mock_erc20.png)

![06](assets/06_solmate_mock_erc721.png)

![07](assets/07_solmate_merkle_proof_lib.png)

![08](assets/08_solmate_create3_factory.png)

### Sample project, `solc` 20000 optimizer runs, `solx` `-03`, viaIR

![00](assets/00_sample_project_via_ir.png)

### Sample project, `solc` 20000 optimizer runs, `solx` `-03`, legacy

![01](assets/01_sample_project_legacy.png)

### ERC20, `solc` 20000 optimizer runs, `solx` `-03`, viaIR

![02](assets/02_erc20_via_ir.png)

### ERC20, `solc` 20000 optimizer runs, `solx` `-03`, legacy

![03](assets/03_erc20_legacy.png)
