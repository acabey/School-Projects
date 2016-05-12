//Copyright Andrew Cabey 2016
#include <stdio.h>
#include <stdlib.h>

typedef int bool;
#define true 1
#define false 0

//Counts the amount of characters in a string
int length(const char *string)
{
    int i = 0;
    while (!(string[i]==0x00))
    {
        ++i;
    }
    return i;
}

int main() {
	while(true) 
	{
		char data[100] = {};
		printf("Enter a character string: ");
		fgets(data, 100, stdin);
		if (!(length(data)-1))
			break;
		
		// Sort the data
		int firstUnsorted = 0;
		while (firstUnsorted < (length(data) - 1))
		{
			//Data[firstUnsorted] = smallest remaining unsorted item
			int compare = firstUnsorted + 1;
			while (compare < length(data))
			{
				if (data[firstUnsorted] > data[compare])
				{
					char temp = data[firstUnsorted];
					data[firstUnsorted] = data[compare];
					data[compare] = temp;
				}
				++compare;
			}
			++firstUnsorted;
		}
		printf("%s \n", data);
	}
}