//Copyright Andrew Cabey 2016

#include <stdio.h>
#include <stdlib.h>

int main ()

{
    char raw[50] = {};
    int response = 0;
    printf("How many bottles of beer on the wall?");
    gets(raw);
    response = atoi(raw);

    //Loop through variable reaches 0
    while (response > 0)
    {
        printf("%d bottles of beer on the wall,\n %d bottles of beer!\n", response, response);
        printf("Take one down, pass it around\n");
        --response;
        printf("%d bottles of beer on the wall. \n", response);
    }
    printf("Time to restock!");

    return 0;
}
