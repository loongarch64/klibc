/*
 * stpcpy.c
 */

#include <string.h>

char *stpcpy(char *dst, const char *src)
{
	char ch;

	for (;;) {
		*dst = ch = *src++;
		if (!ch)
			break;
		dst++;
	}

	return dst;
}
