# -*- perl -*-
#
# arch/loongarch64/sysstub.ph
#
# Script to generate system call stubs
#

# On LOONGARCH64, most system calls follow the standard convention, with the
# system call number in r11 (a7), return an error value in r4 (a0) as
# well as the return value in r4 (a0).

sub make_sysstub($$$$$@) {
    my($outputdir, $fname, $type, $sname, $stype, @args) = @_;

    $stype = $stype || 'common';
    open(OUT, '>', "${outputdir}/${fname}.S");
    print OUT "#include <machine/asm.h>\n";
    print OUT "#include <asm/unistd.h>\n";
    print OUT "\n";
    print OUT "LEAF(${fname})\n";
    print OUT "\t  li\ta7, __NR_${sname}\n";
    print OUT "\tb\t__syscall_${stype}\n";
    print OUT "\tEND(${fname})\n";
    close(OUT);
}

1;
