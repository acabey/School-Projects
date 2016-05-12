//Copyright Andrew Cabey 2016

#include <stdio.h>
#include <stdlib.h>
int main ()

{
 // Program will prompt user for numeric input, then will use control flow to respond
 char raw[50];
 int response = 0;

 puts("Whats the current tempurature outside?");
    gets(raw);
    response = atoi(raw);
    if (response > 65)
        puts("Guns out");
    else if (response < 40)
        puts("Brr");
    else
        puts("That's so moderate");


 puts("What’s your GPA?");
    gets(raw);
    response = atoi(raw);
    if (response > 4)
        puts("Wow ur so cool");
    else if (response < 2)
        puts("wow ur no bueno");
    else
        puts("Cool dude");


 puts("What's your age");
    gets(raw);
    response = atoi(raw);
    if (response > 65)
        puts("u can reture");
    else if (response < 35)
        puts("U cant run for president");
    else
        puts("Hope ur doin gud");

 puts("How cool are you? (number)");
    gets(raw);
    response = atoi(raw);
    if (response > 100)
        puts("thats not narcissistic");
    else if (response < 1)
        puts("get some self-confidence");
    else
        puts("cool dude");

 puts("What percentage is your battery at?");
    gets(raw);
    response = atoi(raw);
    if (response > 100)
        puts("liar");
    else if (response < 50)
        puts("go charge");
    else
        puts("get back to work");


}
