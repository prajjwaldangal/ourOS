OBJECTS = loader.o kmain.o
CC = gcc
CFLAGS = -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector \
        -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -c \
		-I/home/dev1/ourOS/deps/include -L/home/dev1/ourOS/deps/lib
LDFLAGS = -T link.ld -melf_i386 -L/home/dev1/ourOS/deps/lib
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

ourOS:
	# Compile the loader (.s file) into 32 bit ELF (.o file): 
	nasm -f elf32 loader.s
	gcc $(CFLAGS) -m32 kmain.c -c -o kmain.o
	# Link the loader as: 
	ld $(LDFLAGS) loader.o kmain.o -o kernel.elf
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
	# timeout 60s bochs -f bochsrc.txt -q
	bochs -f bochsrc.txt -log bochslog.txt  -q
%.o: %.c
	$(CC) $(CFLAGS)  $< -o $@

%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -rf *.o kernel.elf os.iso
