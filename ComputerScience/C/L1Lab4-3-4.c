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

//Counts the amount of characters in a string
int count(const char *string)
{
    int i = 0;
    while (!(string[i]==0x00))
    {
        ++i;
    }
    return i;
}

int main()
{
    //a = 97
    //z = 122
    //A = 65
    //Z = 90

    while(true)
    {
        char input[50];
        puts("Enter a phrase: ");
        gets(input);

        if (!input[0])
            break;

        int i = 0;
        while (i < count(input))
        {
            if (isLower(input[i]))
            {
                input[i] -= 32;
            }
            else if (isUpper(input[i]))
            {
                input[i] += 32;
            }
            ++i;
        }
        puts(input);
    }
}
