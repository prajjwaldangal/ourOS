#define FB_GREEN     2
#define FB_DARK_GREY 8
#define BLACK   0
#define WHITE   15

/** fb_write_cell:
 *  Writes a character with the given foreground and background to position i
 *  in the framebuffer.
 *
 *  @param i  The location in the framebuffer
 *  @param c  The character
 *  @param fg The foreground color
 *  @param bg The background color
 */
void fb_write_cell(unsigned int i, char c, unsigned char fg, unsigned char bg)
{
    char *fb = (char *) 0x000B8000;
    fb[i] = c;
    fb[i + 1] = ((fg & 0x0F) << 4) | (bg & 0x0F);
}

void say_hello() {
    int comma = 44;
	int period = 46;
	int space = 32;
    unsigned int start = 400;
    unsigned int offset = 2;

    int arr[25] = {72,69,76,76,79,space,87,79,82,76,68,comma,space,space,79,85,82,79,83,space,72,69,82,69,period};
    for (int i = 0; i < 25; i ++) {
        fb_write_cell(start + offset * i, arr[i], WHITE, BLACK);
    }
}