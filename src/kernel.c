#define VGA_ADDRESS 0xB8000
#define VGA_WIDTH 80

void print_char(char character, int col, int row, char attribute_byte) {
    unsigned char *vga = (unsigned char *)VGA_ADDRESS;
    int offset = (row * VGA_WIDTH + col) * 2;
    vga[offset] = character;
    vga[offset + 1] = attribute_byte;
}

void clear_screen() {
    for (int row = 0; row < 25; ++row) {
        for (int col = 0; col < 80; ++col) {
            print_char(' ', col, row, 0x0F);
        }
    }
}

void kernel_main() {
    clear_screen();
    
    const char *message = "SoccerMom OS";
    int col = (VGA_WIDTH - 12) / 2;
    int row = 10;
    char attribute = 0x0F;
    
    for (int i = 0; message[i] != '\0'; ++i) {
        print_char(message[i], col + i, row, attribute);
    }
    
    while (1) {
    }
}

