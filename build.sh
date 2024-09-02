
echo "Build wasm app .."
rm -fr build && mkdir build
tinygo build -o ./build/test.wasm -target=./hello.json -no-debug main.go

# TODO: make sure we have defined WAMR_DIR to run binarydump
WAMR_DIR=~/zephyrproject/wasm-micro-runtime
echo "Build binarydump tool .."
cd build
cmake $WAMR_DIR/test-tools/binarydump-tool
make
cd ..

echo "Generate test_wasm.h .."
./build/binarydump -o ./build/test_wasm.h -n wasm_test_file ./build/test.wasm

echo "Done"
