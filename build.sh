
echo "Build wasm app .."
rm -fr build && mkdir build

DEFAULTTARGET=wasi
TARGET="${1:-$DEFAULTTARGET}"

if [[ $TARGET == "wasmunknown" ]]
then
  TARGET="./wamr.json"
fi

tinygo build -o ./build/test.wasm -target=$TARGET -no-debug main.go

# TODO: allow user to override locations for WAMR_DIR to run binarydump
WAMR_DIR=~/zephyrproject/wasm-micro-runtime
echo "Build binarydump tool .."
cd build
cmake $WAMR_DIR/test-tools/binarydump-tool
make
cd ..

echo "Generate test_wasm.h .."
./build/binarydump -o ./build/test_wasm.h -n wasm_test_file ./build/test.wasm

echo "Done"
