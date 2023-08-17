@echo off

set CC=gcc
set AS=nasm
set LD=ld

set CFLAGS=-m32 -nostdlib -nostartfiles -nodefaultlibs -fno-builtin -fno-stack-protector -c
set ASFLAGS=-f elf32
set LDFLAGS=-m elf_i386 -T linker.ld

set SRC_DIR=src
set BIN_DIR=bin

mkdir %BIN_DIR% 2>nul

echo Building bootloader...
%AS% %ASFLAGS% -o %BIN_DIR%\bootloader.bin %SRC_DIR%\bootloader.asm

echo Building kernel...
%CC% %CFLAGS% -o %BIN_DIR%\kernel.o %SRC_DIR%\kernel.c
%LD% %LDFLAGS% -o %BIN_DIR%\kernel.bin %BIN_DIR%\bootloader.bin %BIN_DIR%\kernel.o

echo Creating boot.img...
copy /b %BIN_DIR%\bootloader.bin + %BIN_DIR%\kernel.bin %BIN_DIR%\boot.img

echo Creating boot.iso...
mkisofs -o %BIN_DIR%\boot.iso -b boot.img %BIN_DIR%\boot.img

echo Build completed.
