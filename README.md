# PedroOS

PedroOS supports the ARM architecture and can be booted on the Raspberry Pi Zero W

https://wiki.osdev.org/Raspberry_Pi_Bare_Bones

## How to build the OS

Build the Bootloader: `arm-none-eabi-gcc -mcpu=cortex-a7 -fpic -ffreestanding -c bootloader/bootsector.S -o bootsector.o`

Linking the Kernel: `arm-none-eabi-gcc -mcpu=arm1176jzf-s -fpic -ffreestanding -std=gnu99 -c kernel/kernel.c -o kernel.o -O2 -Wall -Wextra`

Converts the Object file to ELF file: `arm-none-eabi-gcc -T linker.ld -o kernel.elf -ffreestanding -O2 -nostdlib bootsector.o kernel.o -lgcc`
