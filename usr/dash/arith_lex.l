%{
/*-
 * Copyright (c) 1993
 *	The Regents of the University of California.  All rights reserved.
 * Copyright (c) 1997-2005
 *	Herbert Xu <herbert@gondor.apana.org.au>.  All rights reserved.
 *
 * This code is derived from software contributed to Berkeley by
 * Kenneth Almquist.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the University nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

#include <stdlib.h>
#include <unistd.h>
#include "arith.h"
#include "error.h"
#include "expand.h"

extern int yylval;
extern const char *arith_buf, *arith_startbuf;
#undef YY_INPUT
#define YY_INPUT(buf,result,max) \
	result = (*buf = *arith_buf++) ? 1 : YY_NULL;
#define YY_NO_UNPUT
%}

%%
[ \t\n]	{ ; }
[0-9]+	{ yylval = strtoll(yytext, 0, 0); return(ARITH_NUM); }
"("	{ return(ARITH_LPAREN); }
")"	{ return(ARITH_RPAREN); }
"||"	{ return(ARITH_OR); }
"&&"	{ return(ARITH_AND); }
"|"	{ return(ARITH_BOR); }
"^"	{ return(ARITH_BXOR); }
"&"	{ return(ARITH_BAND); }
"=="	{ return(ARITH_EQ); }
"!="	{ return(ARITH_NE); }
">"	{ return(ARITH_GT); }
">="	{ return(ARITH_GE); }
"<"	{ return(ARITH_LT); }
"<="	{ return(ARITH_LE); }
"<<"	{ return(ARITH_LSHIFT); }
">>"	{ return(ARITH_RSHIFT); }
"*"	{ return(ARITH_MUL); }
"/"	{ return(ARITH_DIV); }
"%"	{ return(ARITH_REM); }
"+"	{ return(ARITH_ADD); }
"-"	{ return(ARITH_SUB); }
"~"	{ return(ARITH_BNOT); }
"!"	{ return(ARITH_NOT); }
.	{ error("arith: syntax error: \"%s\"", arith_startbuf); }
%%

void
arith_lex_reset() {
#ifdef YY_NEW_FILE
	YY_NEW_FILE;
#endif
}