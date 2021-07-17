#
# arch/loongarch64/setjmp.S
#
# setjmp/longjmp for the LOONGARCH64 architecture
#
# The jmp_buf is assumed to contain the following, in order:
#	ra
#	sp
#   fp
#	s0..s7
#	s8

#include <machine/asm.h>

ENTRY (_setjmp)
  li a1,0
  b __sigsetjmp
END (_setjmp)
ENTRY (setjmp)
  li a1,1
END (setjmp)
ENTRY (__sigsetjmp)
  REG_S ra, a0, 0*SZREG
  REG_S tp, a0, 1*SZREG
  REG_S sp, a0, 2*SZREG
  REG_S  x, a0, 3*SZREG
  REG_S fp, a0, 4*SZREG
  REG_S s0, a0, 5*SZREG
  REG_S s1, a0, 6*SZREG
  REG_S s2, a0, 7*SZREG
  REG_S s3, a0, 8*SZREG
  REG_S s4, a0, 9*SZREG
  REG_S s5, a0, 10*SZREG
  REG_S s6, a0, 11*SZREG
  REG_S s7, a0, 12*SZREG
  REG_S s8, a0, 13*SZREG

  FREG_S $f24, a0, 14*SZREG + 0*SZFREG
  FREG_S $f25, a0, 14*SZREG + 1*SZFREG
  FREG_S $f26, a0, 14*SZREG + 2*SZFREG
  FREG_S $f27, a0, 14*SZREG + 3*SZFREG
  FREG_S $f28, a0, 14*SZREG + 4*SZFREG
  FREG_S $f29, a0, 14*SZREG + 5*SZFREG
  FREG_S $f30, a0, 14*SZREG + 6*SZFREG
  FREG_S $f31, a0, 14*SZREG + 7*SZFREG

  li v0, 0
  jirl zero,ra,0
END (__sigsetjmp)


ENTRY (longjmp)
  REG_L ra, a0, 0*SZREG
  REG_L tp, a0, 1*SZREG
  REG_L sp, a0, 2*SZREG
  REG_L  x, a0, 3*SZREG
  REG_L fp, a0, 4*SZREG
  REG_L s0, a0, 5*SZREG
  REG_L s1, a0, 6*SZREG
  REG_L s2, a0, 7*SZREG
  REG_L s3, a0, 8*SZREG
  REG_L s4, a0, 9*SZREG
  REG_L s5, a0, 10*SZREG
  REG_L s6, a0, 11*SZREG
  REG_L s7, a0, 12*SZREG
  REG_L s8, a0, 13*SZREG

  FREG_L $f24, a0, 14*SZREG + 0*SZFREG
  FREG_L $f25, a0, 14*SZREG + 1*SZFREG
  FREG_L $f26, a0, 14*SZREG + 2*SZFREG
  FREG_L $f27, a0, 14*SZREG + 3*SZFREG
  FREG_L $f28, a0, 14*SZREG + 4*SZFREG
  FREG_L $f29, a0, 14*SZREG + 5*SZFREG
  FREG_L $f30, a0, 14*SZREG + 6*SZFREG
  FREG_L $f31, a0, 14*SZREG + 7*SZFREG

  sltui a0,a1,1
  add.d  a0, a0, a1   # a0 = (a1 == 0) ? 1 : a1
  jirl zero,ra,0

END (longjmp)
