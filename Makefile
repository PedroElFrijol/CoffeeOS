CFILES = $(wildcard *.c) #getting all of the C files in the directory
OFILES = $(CFILES:.c=.o) #replacing .c with .o
LLVMPATH = ../../linuxbrew/.linuxbrew/Cellar/llvm/12.0.1/bin
CLANGFLAGS = -Wall -O2 -ffreestanding -nostdinc -nostdlib -mcpu=cortex-a72+nosimd

all: clean kernel.img

bootsector.o: bootsector.S
	$(LLVMPATH)/clang --target=aarch64-elf $(CLANGFLAGS) -c boot.S -o boot.o

%.o: %.c
	$(LLVMPATH)/clang --target=aarch64-elf $(CLANGFLAGS) -c $< -o $@ 
#$< being replaced by the .c filename and $@ being replaced by the .o filename.

kernel.img: bootsector.o $(OFILES)
	$(LLVMPATH)/ld.lld -m aarch64elf -nostdlib boot.o $(OFILES) -T linker.ld -o kernel.elf
	$(LLVMPATH)/llvm-objcopy -O binary kernel.elf kernel.img

clean:
	rm *o