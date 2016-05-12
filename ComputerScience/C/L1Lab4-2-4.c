//Copyright Andrew Cabey 2016

#include <stdio.h>
#include <stdlib.h>

typedef int bool;
#define true 1
#define false 0

//Compares two strings
bool compare(const char *str1, const char *str2) //Since I'm not allowed to use stuff outside the manual
{
    int i = 0; //GCC isn't happy with initial declaration in loop
    for (i = 0; i < sizeof(str1)/sizeof(str1[0]); ++i)
    {
        if (!(str1[i] == str2[i]))
            return false;
    }
    return true;
}

//Checks if a character is in a given string
bool contains(const char *str1, const char str2)
{
    int i = 0;
    for (i = 0; i < sizeof(str1)/sizeof(str1[0]); ++i)
    {
        if (str1[i] == str2)
            return true;
    }
    return false;
}

int main ()
{
    char raw[50];
    char response[50];
    int intin = 0;
    float floatin = 0;

    printf("Absolute value finder\nJust enter a positive or negative number, or 0 to quit\n");
    gets(raw);

    floatin = atof(raw);
    intin = atoi(raw);

    // Invert numbers if negative
    if (intin < 0)
    {
        intin *= -1;
        floatin *= -1.0;
    }

    if (contains(raw, '.') == 1)
    {
        printf("The absolute value of \"%s\" is %f\n", raw, floatin);
    }
    else
    {
        printf("The absolute value of \"%s\" is %i\n", raw, intin);
    }
}
