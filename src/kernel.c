#define VGA_ADDRESS 0xB8000
#define VGA_WIDTH 80

void print_char(char character, int col, int row, char attribute_byte) {
    // ... (same as before)
}

void clear_screen() {
    // ... (same as before)
}


// BIOS interrupt 0x16 read function
char getchar() {
    while (1) {
        if ((inb(0x64) & 0x1) == 1) {
            return inb(0x60);
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

    char input_buffer[100] = {0};
    int input_length = 0;

    while (1) {
        char key = getchar();
        
        if (key == '\n') {
            row++;
            input_buffer[input_length] = '\0';
            input_length = 0;
        } else {
            input_buffer[input_length++] = key;
            print_char(key, col + input_length - 1, row, attribute);
        }
    }
}
