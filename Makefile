OBJECTS = loader.o kmain.o
CC = gcc
CFLAGS = -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector \
        -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -c
LDFLAGS = -T link.ld -melf_i386
AS = nasm
ASFLAGS = -f elf

all: kernel.elf

kernel.elf: $(OBJECTS)
	ld $(LDFLAGS) $(OBJECTS) -o kernel.elf

os.iso: kernel.elf
	cp kernel.elf iso/boot/kernel.elf
	genisoimage -R                              \
		-b boot/grub/stage2_eltorito    \
		-no-emul-boot                   \
		-boot-load-size 4               \
		-A os                           \
		-input-charset utf8             \
		-quiet                          \
		-boot-info-table                \
		-o os.iso                       \
		iso

run: os.iso
	timeout 10s bochs -f bochsrc.txt -q

runSub:
	# Compile the loader (.s file) into 32 bit ELF (.o file): 
	nasm -f elf32 loader.s
	gcc -m32 kmain.c -c -o kmain.o
	# 1.   how are you going to link oplk
	# ans: install cmake. Once that is done, cmake can handle the build
	# 2. how are you going to verify that oplk stack is up and running
	# Link the loader as: 
	ld -T link.ld -melf_i386 loader.o kmain.o -o kernel.elf
	cp kernel.elf iso/boot/kernel.elf
	genisoimage -R                              \
		-b boot/grub/stage2_eltorito    \
		-no-emul-boot                   \
		-boot-load-size 4               \
		-A os                           \
		-input-charset utf8             \
		-quiet                          \
		-boot-info-table                \
		-o os.iso                       \
		iso
	#timeout 10s bochs -f bochsrc.txt -q
	bochs -f bochsrc.txt -log bochslog.txt  -q
%.o: %.c
	$(CC) $(CFLAGS)  $< -o $@

%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -rf *.o kernel.elf os.iso
