    // definitions
%option noyywrap

%{
#include "klx.tab.h"
#include <math.h>
%}

%option yylineno

/* float exponent */
EXP ([Ee][+-]?[0-9]+)

%%
	
"+" |
"-" |
"*" |
"/" |
"|" |
"(" |
")" |
";" |	
"[" |
"]" |
"@" |
"%" |
"$" |
"#" |
"{" |
"}" |
"~" |
"," 	 		{ return yytext[0]; }
[+-]?([0-9]+\.[0-9]*{EXP}?|\.?[0-9]+{EXP}?) 	{ yylval.d = atof(yytext); return NUMERO; }
cerchio			return CERCHIO;
rettangolo		return RETTANGOLO;
triangolo		return TRIANGOLO;
settore			return SETTORE;
pacman			return PACMAN;
pentagono		return PENTAGONO;
poligono		return POLIGONO;
quadrato		return QUADRATO;
":::"			return SEIPUNTI;
"::"			return QUADDROPUNTI;
":"			return DUEPUNTI;
rosso			return ROSSO;
verde			return VERDE;
azzuro			return AZZURO;
colora			return COLORA;
scala			return SCALA;
gira			return GIRA;
luogo			return LUOGO;
"//".*			;
[ \t\n]			;    { /* ignore whitespace */ }
.			fprintf(stderr, "WARNING(%d) : '%s' is not in the lexicon\n", yylineno, yytext);
%%
 // usercode

