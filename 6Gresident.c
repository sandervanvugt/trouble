#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

#define GIB_6 (6L * 1024 * 1024 * 1024) // 6 GiB

int main() {
    printf("Allocating 6 GiB of resident memory...\n");

    // Allocate 6 GiB of memory
    char *buffer = (char *)malloc(GIB_6);
    if (!buffer) {
        perror("Failed to allocate memory");
        return EXIT_FAILURE;
    }

    // Lock memory to prevent swapping
    if (mlock(buffer, GIB_6) != 0) {
        perror("Failed to lock memory (mlock)");
        free(buffer);
        return EXIT_FAILURE;
    }

    // Touch each memory page to force it into RAM
    size_t page_size = sysconf(_SC_PAGESIZE);
    for (size_t i = 0; i < GIB_6; i += page_size) {
        buffer[i] = 0; // Write to force allocation in RAM
    }

    printf("6 GiB of resident memory allocated and locked.\n");
    printf("Press Enter to release memory and exit...\n");
    getchar();

    // Cleanup
    munlock(buffer, GIB_6);
    free(buffer);
    
    return EXIT_SUCCESS;
}

