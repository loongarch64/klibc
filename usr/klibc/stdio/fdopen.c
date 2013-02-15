/*
 * fdopen.c
 *
 * Common code between fopen(), fdopen() and the standard descriptors.
 */

#include "stdioint.h"

FILE *stdin, *stdout, *stderr;

/* Doubly-linked list of all stdio structures */
struct _IO_file_pvt __stdio_headnode =
{
	.prev = &__stdio_headnode,
	.next = &__stdio_headnode,
};

FILE *fopencookie(void *cookie, const char *mode, cookie_io_functions_t funcs)
{
	struct _IO_file_pvt *f;
	const size_t bufoffs =
		(sizeof *f + 4*sizeof(void *) - 1) &
		~(4*sizeof(void *) - 1);

	(void)mode;

	f = zalloc(bufoffs + BUFSIZ + _IO_UNGET_SLOP);
	if (!f)
		goto err;

	f->data = f->buf = (char *)f + bufoffs;
	f->funcs = funcs;
	f->cookie = cookie;
	f->bufsiz = BUFSIZ;
	f->bufmode = _IOFBF;

	/* Insert into linked list */
	f->prev = &__stdio_headnode;
	f->next = __stdio_headnode.next;
	f->next->prev = f;
	__stdio_headnode.next = f;

	return &f->pub;

err:
	if (f)
		free(f);
	errno = ENOMEM;
	return NULL;
}

FILE *fdopen(int fd, const char *mode)
{
	FILE *file;

	/*
	 * Cookie operations for ordinary files.  This is only safe because
	 * all Linux architectures pass integers <= sizeof(pointer) and
	 * pointers the same way, at least for non-structure arguments.
	 */
	const struct cookie_io_functions_t file_funcs = {
		.read  = (cookie_read_function_t *)read,
		.write = (cookie_write_function_t *)write,
		.seek  = (cookie_seek_function_t *)lseek,
		.close = (cookie_close_function_t *)close
	};

	file = fopencookie((void *)(intptr_t)fd, mode, file_funcs);
	if (file) {
		struct _IO_file_pvt *f = stdio_pvt(file);
		f->isfile = true;
		f->bufmode = isatty(fd) ? _IOLBF : _IOFBF;
	}
	return file;
}

void __init_stdio(void)
{
	stdin  = fdopen(0, NULL);
	stdout = fdopen(1, NULL);
	stderr = fdopen(2, NULL);
	stdio_pvt(stderr)->bufmode = _IONBF;
}
