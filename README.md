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

By default, all the projects will use native `solc` 0.8.29, to compile with `solx` use `FOUNDRY_PROFILE=solx`, e.g.:

```bash
FOUNDRY_PROFILE=solx forge build
FOUNDRY_PROFILE=solx forge test
```

Or you can do `export FOUNDRY_PROFILE=solx` to make it used by default within your terminal session.

Please check which version is used for compilation: `0.8.29` corresponds to native `solc`, while `0.8.30` corresponds to `solx`.
The main reason to use different versions of compiler is to force foundry to recompile contracts when switching profiles.
Feel free to compare with other versions yourself.

`solx` is still missing some features to work with Foundry as expected. Here are some guidelines:

- Run `forge build` before running tests, and run `forge clean` after running tests. Re-compilation of already built contracts may not work as expected.
- Only `forge build` and `forge test` have been checked; `forge script` and other options may not work or work incorrectly.

## Project structure

All the projects are configured to be using `solx` and will assume that it's present in the root of the repository.

- `sample_project`: a default `forge` project.
- `erc20`: sample ERC20 token using [`solady`](https://github.com/Vectorized/solady) library.
- `solmate`: copy of [`solmate`](https://github.com/transmissions11/solmate/) project, with compiler changed to `solc` 0.8.29 (for equivalence of benchmarks)
  and pragma limitations lifted. ⚠️ requires foundry v0.3.0 to work (project not compatible with v1.0.0 yet).

## Performance Comparison

> The tools below are only for the purposes of this demo.
> For a more comprehensive gas comparison, please visit our our up-to-date [gas](https://matter-labs.github.io/solx/dashboard/) and [size](https://matter-labs.github.io/solx/codesize/0.1.0/) dashboards.

At the root of each project, you can use `forge` to get gas reports for both `solc` and `solx`.

To see the `solc` report, run:

```bash
forge test --gas-report
```

Output example:

```
╭-----------------------------------+-----------------+-------+--------+-------+---------╮
| src/tokens/WETH.sol:WETH Contract |                 |       |        |       |         |
+========================================================================================+
| Deployment Cost                   | Deployment Size |       |        |       |         |
|-----------------------------------+-----------------+-------+--------+-------+---------|
| 939688                            | 4638            |       |        |       |         |
|-----------------------------------+-----------------+-------+--------+-------+---------|
|                                   |                 |       |        |       |         |
|-----------------------------------+-----------------+-------+--------+-------+---------|
| Function Name                     | Min             | Avg   | Median | Max   | # Calls |
|-----------------------------------+-----------------+-------+--------+-------+---------|
| balanceOf                         | 527             | 1326  | 527    | 2527  | 1286    |
|-----------------------------------+-----------------+-------+--------+-------+---------|
| deposit                           | 29088           | 35477 | 34688  | 68888 | 23909   |
|-----------------------------------+-----------------+-------+--------+-------+---------|
| receive                           | 28940           | 34982 | 34540  | 68740 | 23400   |
|-----------------------------------+-----------------+-------+--------+-------+---------|
| totalSupply                       | 362             | 1162  | 362    | 2362  | 1287    |
|-----------------------------------+-----------------+-------+--------+-------+---------|
| withdraw                          | 29583           | 41663 | 41907  | 42027 | 23322   |
╰-----------------------------------+-----------------+-------+--------+-------+---------╯
```

For the `solx` report, specify the `solx` profile:

```bash
FOUNDRY_PROFILE=solx forge test --gas-report
```

Output example:

```
╭-----------------------------------+-----------------+-------+--------+-------+---------╮
| src/tokens/WETH.sol:WETH Contract |                 |       |        |       |         |
+========================================================================================+
| Deployment Cost                   | Deployment Size |       |        |       |         |
|-----------------------------------+-----------------+-------+--------+-------+---------|
| 815946                            | 4084            |       |        |       |         |
|-----------------------------------+-----------------+-------+--------+-------+---------|
|                                   |                 |       |        |       |         |
|-----------------------------------+-----------------+-------+--------+-------+---------|
| Function Name                     | Min             | Avg   | Median | Max   | # Calls |
|-----------------------------------+-----------------+-------+--------+-------+---------|
| balanceOf                         | 409             | 1208  | 409    | 2409  | 1286    |
|-----------------------------------+-----------------+-------+--------+-------+---------|
| deposit                           | 29017           | 35407 | 34617  | 68817 | 24193   |
|-----------------------------------+-----------------+-------+--------+-------+---------|
| receive                           | 28836           | 34848 | 34436  | 68636 | 23880   |
|-----------------------------------+-----------------+-------+--------+-------+---------|
| totalSupply                       | 321             | 1121  | 321    | 2321  | 1287    |
|-----------------------------------+-----------------+-------+--------+-------+---------|
| withdraw                          | 29402           | 41475 | 41750  | 41846 | 23357   |
╰-----------------------------------+-----------------+-------+--------+-------+---------╯
```
