# tinygo-wamr-module

WebAssembly Micro Runtime (WAMR) compatible WASM module written using TinyGo.

https://github.com/bytecodealliance/wasm-micro-runtime


## How to build

You can either compile your TinyGo WASM Module targeting WASI Preview 1, or the even smaller WASM Unknown.

### WASI Preview 1

To build for WASI Preview 1, run this command:

```shell
./build.sh wasi
```

The compiled WASM module will be in the `build` directory:

```shell
$ ls -l build/test.wasm 
-rwxrwxr-x 1 ron ron 13697 sep  2 20:45 build/test.wasm
```

You can use either the `build/test.wasm` file, or the `./build/test_wasm.h` file, by copying it into the directory in which you want to use it from your WAMR application.

### WASM Unknown

To build for WASM Unknown, run this command:

```shell
./build.sh wasmunknown
```

The compiled WASM module will be in the `build` directory:

```shell
$ ls -l build/test.wasm 
-rwxrwxr-x 1 ron ron 329 sep  2 20:45 build/test.wasm
```

You can use either the `build/test.wasm` file, or the `./build/test_wasm.h` file, by copying it into the directory in which you want to use it from your WAMR application.

## Running your compiled module using WAMR

### Running with `iwasm`

Here is the TinyGo module running on Linux using the `iwasm` command line tool:

```shell
iwasm -f app_main ./build/test.wasm 
Hello, TinyGo!
```

See https://github.com/bytecodealliance/wasm-micro-runtime/tree/main/product-mini#build-iwasm

### Running with Zephyr

Compiling WAMR on Zephyr for the STM32 Nucleo-144 board

```shell
west build -b nucleo_f767zi \
    . -p always -- \
    -DWAMR_BUILD_TARGET=THUMBV7 \
    -DWAMR_BUILD_GLOBAL_HEAP_SIZE=262144
west flash
```

Here is the TinyGo module running on Zephyr on an STM32 Nucleo-144 board in the `product-mini/platforms/zephyr/simple` example with verbose logging.

```shell
Connected to /dev/ttyACM0. Press Ctrl-C to exit.
*** Booting Zephyr OS build v3.7.0-1575-g45705a84ab8e ***
[00:00:00:021 - 20020E40]: Load type section success.

[00:00:00:026 - 20020E40]: Load import section success.

[00:00:00:031 - 20020E40]: Load function section success.

[00:00:00:037 - 20020E40]: Load memory section success.

[00:00:00:042 - 20020E40]: Load export section success.

[00:00:00:047 - 20020E40]: Load datacount section success.

[00:00:00:052 - 20020E40]: Load code segment section success.

[00:00:00:058 - 20020E40]: Load data segment section success.

[00:00:00:063 - 20020E40]: Ignore custom section [name].
[00:00:00:068 - 20020E40]: Ignore custom section [producers].
[00:00:00:074 - 20020E40]: Ignore custom section [target_features].
[00:00:00:080 - 20020E40]: Load module success.

[00:00:00:085 - 20020E40]: Memory instantiate:
[00:00:00:089 - 20020E40]:   page bytes: 73728, init pages: 1, max pages: 1
[00:00:00:095 - 20020E40]:   heap offset: 65536, heap size: 8192

[00:00:00:111 - 20020E40]: Memory instantiate success.
[00:00:00:117 - 20020E40]: Calling app_main function

Hello, TinyGo!
result: 0x0
elapsed: 135
```

See https://github.com/bytecodealliance/wasm-micro-runtime/blob/main/product-mini/platforms/zephyr/simple/README.md
