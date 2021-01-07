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
    int arrHello[11] = {72,69,76,76,79,32,87,79,82,76,68};
    for (int i = 0; i < 1000; i = i+2) {
        if (i >= 400 && i <= 411) 
        {
            fb_write_cell(i, (char) arrHello[i-400], WHITE, BLACK);
        }
        else
        {
            fb_write_cell(i, ' ', WHITE, BLACK);
        }
        
    }
    return 0;
}
