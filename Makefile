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

$(BIN_DIR)/boot.img: $(BIN_DIR)/bootloader.bin $(BIN_DIR)/kernel.bin
	cat $^ > $@

$(BIN_DIR)/boot.iso: $(BIN_DIR)/boot.img
	mkisofs -o $@ -b boot.img $^

all: $(BIN_DIR)/kernel.bin $(BIN_DIR)/boot.bin $(BIN_DIR)/boot.img $(BIN_DIR)/boot.iso

clean:
	rm -f $(BIN_DIR)/*.bin $(BIN_DIR)/*.o
