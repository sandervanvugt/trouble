#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    const int megabyte = 1024 * 1024;
    
    while (1) {
        // Allocate 1 MB of memory
        char *buffer = malloc(megabyte);
        if (buffer == NULL) {
            fprintf(stderr, "Memory allocation failed!\n");
            return 1;
        }

        // Optionally, use the memory
        // memset(buffer, 0, megabyte);

        printf("Allocated 1 MB of memory\n");

        // Wait for 1 second
        sleep(1);
    }

    return 0;
}

