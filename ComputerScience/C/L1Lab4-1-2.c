#include <stdio.h>
#include <stdlib.h>
int main ()

{
 char name[50];
 char hello[50];
 gets(name);
 strcpy(hello, "Hi, ");
 strcat(hello,name);
 puts(hello);
}
