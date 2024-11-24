#include <stdio.h>
// gcc -m32 -c print.c -o print
int main() {
    char phone[20] = "";
    fgets(phone, 19, stdin);
    fprintf(stdout, "Hello stdout\n");
    fprintf(stderr, "Hello stderr\n");
}