#include <machine/asm.h>
#include <asm/unistd.h>


LEAF(__syscall_common)
	syscall 0
	blt	a0, zero, 2f
	jr	ra
2:
	li	t0, -4096
	blt	a0, t0, 1f
	sub.d	a0,zero,a0  #neg	a0, a0
	la.global	t0, errno
	st.d	a0, t0,0
	li	a0, -1
1:      
	jr      ra
	END(__syscall_common)
