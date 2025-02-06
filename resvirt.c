#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void usage(const char *prog_name) {
    printf("Usage: %s -r <resident_memory_MB> -v <virtual_memory_MB>\n", prog_name);
    exit(EXIT_FAILURE);
}

int main(int argc, char *argv[]) {
    size_t resident_mem = 0; // In MB
    size_t virtual_mem = 0;  // In MB
    int opt;

    // Parse command-line arguments
    while ((opt = getopt(argc, argv, "r:v:")) != -1) {
        switch (opt) {
            case 'r':
                resident_mem = atol(optarg);
                break;
            case 'v':
                virtual_mem = atol(optarg);
                break;
            default:
                usage(argv[0]);
        }
    }

    // Convert MB to bytes
    size_t resident_bytes = resident_mem * 1024 * 1024;
    size_t virtual_bytes = virtual_mem * 1024 * 1024;

    // Allocate virtual memory
    char *virtual_memory = NULL;
    if (virtual_bytes > 0) {
        virtual_memory = (char *)malloc(virtual_bytes);
        if (!virtual_memory) {
            perror("Failed to allocate virtual memory");
            exit(EXIT_FAILURE);
        }
        printf("Allocated %lu MB of virtual memory.\n", virtual_mem);
    }

    // Allocate and access resident memory
    char *resident_memory = NULL;
    if (resident_bytes > 0) {
        resident_memory = (char *)malloc(resident_bytes);
        if (!resident_memory) {
            perror("Failed to allocate resident memory");
            free(virtual_memory);
            exit(EXIT_FAILURE);
        }

        // Touch the memory to force it into RAM
        for (size_t i = 0; i < resident_bytes; i += sysconf(_SC_PAGESIZE)) {
            resident_memory[i] = 0; // Writing forces allocation in physical RAM
        }

        printf("Allocated %lu MB of resident memory and accessed it.\n", resident_mem);
    }

    // Keep the process alive to monitor memory usage
    printf("Memory allocation complete. PID: %d\n", getpid());
    printf("Press Enter to exit...\n");
    getchar();

    // Free memory before exiting
    free(virtual_memory);
    free(resident_memory);
    return EXIT_SUCCESS;
}

