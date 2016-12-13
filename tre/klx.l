
%option noyywrap
 
%{

#include <stdio.h> 
#include "symtab.h"
#include "klx.tab.h"

%}

option yylineno

/* float exponent */
EXP ([Ee][+-]?[0-9]+)

%%
	
"+" |
"-" |
"*" |
"/" |
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
"<" |
">" |
"=" |
"^" |
"," |
"&" |
"!" |
"|"   	 		{ return yytext[0]; }
0|[1-9][0-9]*		{ yylval.i = atoi(yytext); return INTEGER;}
[0-9]+\.[0-9]*{EXP}?|\.[0-9]+{EXP}? 	{ yylval.d = atof(yytext); return DOUBLE; }
var			return VAR;
if			return IF;
then			return THEN;
while			return WHILE;
repeat			return REPEAT;
cerchio			return CERCHIO;
rettangolo		return RETTANGOLO;
triangolo		return TRIANGOLO;
settore			return SETTORE;
pacman			return PACMAN;
pentagono		return PENTAGONO;
poligono		return POLIGONO;
quadrato		return QUADRATO;
rosso			return ROSSO;
verde			return VERDE;
azzuro			return AZZURO;
colora			return COLORA;
scala			return SCALA;
gira			return GIRA;
positione		return POSITIONE;
":"			return DUE;
"::"			return QUADDRO;
":::"			return SEI;
"::::"			return OTTO;
"<="			return LESSSAME;
">="			return BIGGERSAME;
"=="			return SAME;
"!="			return ISNOT;
[a-zA-Z]+		{ yylval.n = lookup(yytext);
				if(yylval.n == NULL) yylval.n = insert(yytext); 
				return ID;}
"//".*			;
[ \t\n]+		;    { /* ignore whitespace */ }
.			fprintf(stderr, "WARNING (%d): character %c ignored\n", yylineno, yytext[0]);

%%

