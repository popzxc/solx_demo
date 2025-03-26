# `solx` compiler demo

This repository contains a playground to test `solx` capabilities.

## Installing

Here are the URLs for the test builds:

- [Linux/AMD64](https://github.com/matter-labs/solx/releases/download/eb46690/solx-linux-amd64-gnu-test-build-06)
- [Linux/Arm64](https://github.com/matter-labs/solx/releases/download/eb46690/solx-linux-arm64-gnu-test-build-06)
- [MacOS](https://github.com/matter-labs/solx/releases/download/eb46690/solx-macosx-test-build-06)

Choose the appropriate URL, download it to current folder, and make it executable, e.g.:

```bash
wget https://github.com/matter-labs/solx/releases/download/eb46690/solx-linux-amd64-gnu-test-build-06 -O solx
chmod +x solx
```

## Using with forge

`solx` is still very early in development. Here are some guidelines:

- Run `forge build` before running tests, and run `forge clean` after running tests. Re-compilation of already built contracts may not work as expected.
- `stack too deep` and `bytecode size is too big` errors may be very frequent; the work on optimizations required to prevent that is ongoing.

## Project structure

All the projects are configured to be using `solx` and will assume that it's present in the root of the repository.

- `sample_project`: a default `forge` project.
