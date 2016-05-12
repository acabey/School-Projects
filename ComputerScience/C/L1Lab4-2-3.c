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
    char answer[] = "Party Time";
    bool correct = false;

    printf("What time is it? ");
    while (correct == false)
    {
        gets(raw);
        if (compare(raw, answer) == true)
        {
            correct = true;
            break;
        }
        else if (compare(raw, "") == true)
        {
            break;
        }
        else
        {
            printf("Of course it's not \"%s\", try again! ", raw);
        }
    }
    puts("Final message");
}
