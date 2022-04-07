
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

/* The C function */
int _hook()
{
	int comma = 44;
	int period = 46;
	int space = 32;
    // int arrHello[11] = {72,69,76,76,79,32,87,79,82,76,68};
    unsigned int start = 400;
    // hello
    fb_write_cell(start + 0, 72, WHITE, BLACK);
    fb_write_cell(start + 2, 69, WHITE, BLACK);
    fb_write_cell(start + 4, 76, WHITE, BLACK);
    fb_write_cell(start + 6, 76, WHITE, BLACK);
    fb_write_cell(start + 8, 79, WHITE, BLACK);
    fb_write_cell(start + 10, space, WHITE, BLACK);

    // world
    fb_write_cell(start + 12, 87, WHITE, BLACK);
    fb_write_cell(start + 14, 79, WHITE, BLACK);
    fb_write_cell(start + 16, 82, WHITE, BLACK);
    fb_write_cell(start + 18, 76, WHITE, BLACK);
    fb_write_cell(start + 20, 68, WHITE, BLACK);
    // fb_write_cell(start + 24, comma, WHITE, BLACK);
	fb_write_cell(start + 26, space, WHITE, BLACK);

	// OUROS
	fb_write_cell(start + 28, 79, WHITE, BLACK);
	fb_write_cell(start + 30, 79+6, WHITE, BLACK);
	fb_write_cell(start + 32, 82, WHITE, BLACK);
	fb_write_cell(start + 34, 79, WHITE, BLACK);
	fb_write_cell(start + 36, 83, WHITE, BLACK);
	fb_write_cell(start + 38, space, WHITE, BLACK);

	// here
	fb_write_cell(start + 40, 72, WHITE, BLACK);
	fb_write_cell(start + 42, 69, WHITE, BLACK);
	fb_write_cell(start + 44, 82, WHITE, BLACK);
	fb_write_cell(start + 46, 69, WHITE, BLACK);
	fb_write_cell(start + 48, period, WHITE, BLACK);

    
    return 0;
}