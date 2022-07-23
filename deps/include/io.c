#include "io.h"

void outb(unsigned short port, unsigned char data)
{
  asm volatile("outb %0, %1" :: "a"(data), "Nd"(port));
}