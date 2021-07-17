/*
 * arch/loongarch64/include/klibc/archsetjmp.h
 */

#ifndef _KLIBC_ARCHSETJMP_H
#define _KLIBC_ARCHSETJMP_H

typedef struct __jmp_buf
{
    /* Program counter.  */
    long int __pc;
    /* TLS */
    long int __tp;
    /* Stack pointer.  */
    long int __sp;
    /* Global pointer*/
    long int __x;
    /* Frame pointer. */
    long int __fp;
    /* Callee-saved registers.  */
    long int __regs[9];

    /* Callee-saved floating point registers.  */
   double __fpregs[8];
} __jmp_buf[1];

typedef struct __jmp_buf jmp_buf[1];

#endif				/* _KLIBC_ARCHSETJMP_H */
