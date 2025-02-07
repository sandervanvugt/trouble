#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <fcntl.h>
#include <signal.h>
#include <sys/stat.h>
#include <sys/types.h>

#define GIB_6 (6L * 1024 * 1024 * 1024) // 6 GiB

void daemonize() {
    pid_t pid = fork();
    if (pid < 0) exit(EXIT_FAILURE); // Fork error
    if (pid > 0) exit(EXIT_SUCCESS); // Parent exits, child continues

    // Create new session
    if (setsid() < 0) exit(EXIT_FAILURE);

    // Fork again to ensure it cannot regain a terminal
    pid = fork();
    if (pid < 0) exit(EXIT_FAILURE);
    if (pid > 0) exit(EXIT_SUCCESS);

    // Redirect standard file descriptors to /dev/null
    freopen("/dev/null", "r", stdin);
    freopen("/dev/null", "w", stdout);
    freopen("/dev/null", "w", stderr);

    // Change working directory
    chdir("/");

    // Set file permissions
    umask(0);
}

int main() {
    daemonize();

    printf("Daemon process started (PID: %d). Allocating 6 GiB of resident memory...\n", getpid());

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

