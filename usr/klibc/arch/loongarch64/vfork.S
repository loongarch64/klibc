#include <machine/asm.h>
#include <asm/unistd.h>

#define CLONE_VM	0x00000100
#define CLONE_VFORK	0x00004000
#define SIGCHLD		17


LEAF(vfork)
	li	a0, CLONE_VFORK | CLONE_VM | SIGCHLD
	add.d a1, zero, sp
	li	a7, __NR_clone
	b	__syscall_common
	END(vfork)
