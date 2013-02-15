#include "stdioint.h"

int fileno(FILE *file)
{
	struct _IO_file_pvt *f = stdio_pvt(file);

	if (f->isfile)
		return (int)(intptr_t)f->cookie;

	errno = EBADF;
	return -1;
}
