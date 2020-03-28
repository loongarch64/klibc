/*
 * stpncpy.c
 */

#include <string.h>

char *stpncpy(char *dst, const char *src, size_t n)
{
	char *end;
	char ch;

	while (n) {
		ch = *src++;
		if (!ch)
			break;
		n--;
		*dst++ = ch;
	}

	end = dst;
	memset(dst, 0, n);
	return end;
}
