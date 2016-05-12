//Copyright Andrew Cabey 2016

#include <stdio.h>
#include <stdlib.h>

typedef int bool;
#define true 1
#define false 0

//Checks if character is within range of lowercase charcodes
bool isLower(const char character)
{
    if ((character <= 122) && (character >= 96))
        return true;
    return false;
}

//Checks if character is within range of uppercase charcodes
bool isUpper(const char character)
{
    if ((character <= 90) && (character >= 65))
        return true;
    return false;
}

int main()
{
    //a = 97
    //z = 122
    //A = 65
    //Z = 90

    char input[50];
    puts("Enter type a single letter");
    gets(input);

    if (isLower(input[0]) == true)
    {
        input[0] -= 32;
    }
    else if (isUpper(input[0]) == true)
    {
        input[0] += 32;
    }
    puts(input);
}
