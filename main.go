package main

import (
	"github.com/hybridgroup/mechanoid/convert"
)

//go:wasmimport env printf
func _printf(ptr, size uint32) uint32

//export app_main
func app() {
	_printf(convert.StringToWasmPtr("Hello, World!\n"))
}

func main() {
}
