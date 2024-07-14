NASM = nasm
GCC = x86_64-elf-gcc
LD = x86_64-elf-ld
OBJCOPY = x86_64-elf-objcopy
QEMU = qemu-system-x86_64

BUILD_DIR = build
BOOT_DIR = boot
SRC_DIR = src

BOOT_BIN = $(BUILD_DIR)/boot.bin
KERNEL_ELF = $(BUILD_DIR)/kernel.elf
KERNEL_BIN = $(BUILD_DIR)/kernel.bin
OS_IMAGE = $(BUILD_DIR)/os_image.bin

LINKER_SCRIPT = link.ld

# target
all: $(OS_IMAGE)

# compile bootloader
$(BOOT_BIN): $(BOOT_DIR)/boot.asm
	$(NASM) -f bin $< -o $@

# compile kernel
$(BUILD_DIR)/kernel.o: $(SRC_DIR)/kernel.c
	$(GCC) -m32 -ffreestanding -c $< -o $@

# link kernel
$(KERNEL_ELF): $(BUILD_DIR)/kernel.o $(LINKER_SCRIPT)
	$(LD) -m elf_i386 -T $(LINKER_SCRIPT) -o $@ $(BUILD_DIR)/kernel.o

# convert ELF to binary
$(KERNEL_BIN): $(KERNEL_ELF)
	$(OBJCOPY) -O binary $< $@

# combine bootloader + kernel into OS image
$(OS_IMAGE): $(BOOT_BIN) $(KERNEL_BIN)
	cat $(BOOT_BIN) $(KERNEL_BIN) > $@

# run the OS with QEMU
run: $(OS_IMAGE)
	$(QEMU) -drive format=raw,file=$(OS_IMAGE)

# build files
clean:
	rm -f $(BUILD_DIR)/*

.PHONY: all clean run
