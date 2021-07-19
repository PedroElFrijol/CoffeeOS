#------------------------------------------------------
# this make file is made by Pradosh.S / pradosh-arduino
#------------------------------------------------------
.PHONY: all clean bootloader kernel run

all: bootloader kernel clean

clean:
	rm *.o
	
bootloader:
	@ echo building Bootloader for ARM...
	arm-none-eabi-gcc -mcpu=cortex-a7 -fpic -ffreestanding -c bootloader/bootsector.S -o bootsector.o
	@ echo 

kernel:
	@ echo Compiling $^
	arm-none-eabi-gcc -mcpu=arm1176jzf-s -fpic -ffreestanding -std=gnu99 -c kernel/kernel.c -o kernel.o -O2 -Wall -Wextra
	@ echo
	@ echo Linking...
	arm-none-eabi-gcc -T linker.ld -o kernel.elf -ffreestanding -O2 -nostdlib bootsector.o kernel.o -lgcc

run:
	qemu-system-arm -m 256 -M raspi2 -kernel kernel.elf
