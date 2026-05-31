FASM-IO Example
=========

A minimal ELF64 example that prompts for input and echoes it back.

Prerequisites
- Linux x86_64 (or WSL on Windows)
- flat assembler (`fasm`) installed

Build
```sh
fasm entry.asm
```
This produces an ELF64 executable named `entry`.

Run
```sh
chmod +x entry
./entry
```

Notes
- The program reads up to 200 bytes from stdin and writes them back to stdout.
- This is an ELF64 Linux binary; to run on Windows use WSL or rebuild for a different target.
