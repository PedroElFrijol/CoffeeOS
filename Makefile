CFILES = $(wildcard *.c kernel/*.c framebuffer/*.c) #getting all of the C files in the directories
OFILES = $(CFILES:.c=.o) #replacing .c with .o
LLVMPATH = ../../linuxbrew/.linuxbrew/Cellar/llvm/12.0.1/bin
CLANGFLAGS = -Wall -O2 -ffreestanding -nostdinc -nostdlib -mcpu=cortex-a72+nosimd

all: clean kernel.img

bootloader/bootsector.o: bootloader/bootsector.S
$(LLVMPATH)/clang --target=aarch64-elf $(CLANGFLAGS) -c $< -o $@

%.o: %.c
$(LLVMPATH)/clang --target=aarch64-elf $(CLANGFLAGS) -c $< -o $@
#$< being replaced by the .c filename and $@ being replaced by the .o filename.

kernel.img: bootloader/bootsector.o $(OFILES)
$(LLVMPATH)/ld.lld -m aarch64elf -nostdlib bootloader/bootsector.o $(OFILES) -T linker.ld -o kernel.elf
$(LLVMPATH)/llvm-objcopy -O binary kernel.elf kernel.img

clean:
/bin/rm *.o kernel/*.o framebuffer/*.o bootloader/*.o *.img *.elf > /dev/null 2> /dev/null || true
