#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char *argv[]) {
    time_t current_time;
    time(&current_time);
    
    printf("Hello from external binary!\n");
    printf("Current time: %s", ctime(&current_time));
    printf("Server integration successful.\n");
    
    return 0;
}