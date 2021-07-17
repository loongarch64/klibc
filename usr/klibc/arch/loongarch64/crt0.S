#
# arch/loongarch64/crt0.S
#
# Does arch-specific initialization and invokes __libc_init
# with the appropriate arguments.
#
# See __static_init.c or __shared_init.c for the expected
# arguments.
#

#include <machine/asm.h>

ENTRY(_start)
	move	a0, sp			# Pointer to ELF entry structure
	move	a1, zero			# Kernel-provided atexit() pointer

	la.global t0,__libc_init
	jirl $r0,t0,0
	asrtgt.d	zero, zero		# Crash if we return

	END(_start)
