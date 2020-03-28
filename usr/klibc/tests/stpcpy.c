#include <stdio.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>

int main(void)
{
	char temp[10];
#define clear_temp() strcpy(temp, "XXXXXXXXX")
	char *end;

	printf("stpcpy:\n");

	clear_temp();
	end = stpcpy(temp, "123");
	printf("'%s'len:%zu strlen:%zu\n", temp, end - temp, strlen(temp));
	if (end != temp + 3 || memcmp(temp, "123\0XXXXX", 10))
		goto error;

	clear_temp();
	end = stpcpy(temp, "");
	printf("'%s'len:%zu strlen:%zu\n", temp, end - temp, strlen(temp));
	if (end != temp || memcmp(temp, "\0XXXXXXXX", 10))
		goto error;

	clear_temp();
	end = stpcpy(temp, "1234567");
	printf("'%s'len:%zu strlen:%zu\n", temp, end - temp, strlen(temp));
	if (end != temp + 7 || memcmp(temp, "1234567\0X", 10))
		goto error;

	printf("\n");
	printf("stpncpy:\n");

	clear_temp();
	end = stpncpy(temp, "123", 8);
	printf("'%s'len:%zu strnlen:%zu\n", temp, end - temp, strnlen(temp, 8));
	if (end != temp + 3 || memcmp(temp, "123\0\0\0\0\0X", 10))
		goto error;

	clear_temp();
	end = stpncpy(temp, "", 8);
	printf("'%s'len:%zu strnlen:%zu\n", temp, end - temp, strnlen(temp, 8));
	if (end != temp || memcmp(temp, "\0\0\0\0\0\0\0\0X", 10))
		goto error;

	clear_temp();
	end = stpncpy(temp, "1234567890", 8);
	printf("'%s'len:%zu strnlen:%zu\n", temp, end - temp, strnlen(temp, 8));
	if (end != temp + 8 || memcmp(temp, "12345678X", 10))
		goto error;

	clear_temp();
	end = stpncpy(temp, "123", 5);
	printf("'%s'len:%zu strnlen:%zu\n", temp, end - temp, strnlen(temp, 5));
	if (end != temp + 3 || memcmp(temp, "123\0\0XXXX", 10))
		goto error;

	clear_temp();
	end = stpncpy(temp, "123", 1);
	printf("'%s'len:%zu strnlen:%zu\n", temp, end - temp, strnlen(temp, 1));
	if (end != temp + 1 || memcmp(temp, "1XXXXXXXX", 10))
		goto error;

	clear_temp();
	end = stpncpy(temp, "123", 0);
	printf("'%s'len:%zu strnlen:%zu\n", temp, end - temp, strnlen(temp, 0));
	if (end != temp || memcmp(temp, "XXXXXXXXX", 10))
		goto error;

	exit(0);
error:
	printf("unexpected result\n");
	exit(1);
}
