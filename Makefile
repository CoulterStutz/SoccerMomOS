# Makefile

CC = gcc
AS = nasm
LD = ld

CFLAGS = -m32 -nostdlib -nostartfiles -nodefaultlibs -fno-builtin -fno-stack-protector -c
ASFLAGS = -f elf32
LDFLAGS = -m elf_i386 -T linker.ld

SRC_DIR = src
BIN_DIR = bin

all: $(BIN_DIR)/kernel.bin

$(BIN_DIR)/kernel.bin: $(BIN_DIR)/bootloader.bin $(BIN_DIR)/kernel.o
	$(LD) $(LDFLAGS) -o $@ $(BIN_DIR)/bootloader.bin $(BIN_DIR)/kernel.o

$(BIN_DIR)/bootloader.bin: $(SRC_DIR)/bootloader.asm
	$(AS) $(ASFLAGS) -o $@ $<

$(BIN_DIR)/kernel.o: $(SRC_DIR)/kernel.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -f $(BIN_DIR)/*.bin $(BIN_DIR)/*.o
