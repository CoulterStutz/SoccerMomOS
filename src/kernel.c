#include <stdint.h>
#include <string.h>

#define VGA_ADDRESS 0xB8000
#define VGA_WIDTH 80

void print_char(char character, int col, int row, char attribute_byte) {
    unsigned char *vga = (unsigned char *)VGA_ADDRESS;
    int offset = (row * VGA_WIDTH + col) * 2;
    vga[offset] = character;
    vga[offset + 1] = attribute_byte;
}

// BIOS interrupt 0x16 read function
char getchar() {
    while (1) {
        if ((inb(0x64) & 0x1) == 1) {
            char key = inb(0x60);
            if (key == 0x0E && input_length > 0) {
                input_buffer[--input_length] = '\0';
                print_char(' ', col + input_length, row, attribute);
            } else {
                return key;
            }
        }
    }
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

    char input_buffer[100] = {0};
    int input_length = 0;

    while (1) {
        char key = getchar();

        if (key == '\n') {
            row++;
            input_buffer[input_length] = '\0';
            input_length = 0;
            
            if (strcmp(input_buffer, "?") == 0) {
                const char *response = "You asked a question!";
                int response_col = (VGA_WIDTH - strlen(response)) / 2;
                for (int i = 0; response[i] != '\0'; ++i) {
                    print_char(response[i], response_col + i, row, attribute);
                }
                row++;
            }
        } else {
            input_buffer[input_length++] = key;
            print_char(key, col + input_length - 1, row, attribute);
        }
    }
}
