#include <stdio.h>
#include <stdlib.h>
int main ()

{
 char msg[] = {"Hello, world!"};
 for (int i = 0; i < (sizeof(msg)/sizeof(msg[0])); ++i)
 {
    putchar(msg[i]);
 }
 return 0;
}
