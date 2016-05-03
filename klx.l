    // definitions -->
%option noyywrap

%{
#include "klx.tab.h"
%}

%option yylineno

%%
    // rules -->

^("\*").*         ; // * comments
\( 			 return OPEN;
\)                   return CLOSE;
cerchio             return CERCHIO;
rettangolo      return RETTANGOLO;
triangolo       return TRIANGOLO;
settore             return SETTORE;
pacman       return PACMAN;
pentagono return PENTAGONO;
poligono    return POLIGONO;
";"		        return SEMICOLON;
\[		        return SQOPEN;
\]		        return SQCLOSE;
@                 return KLAMMERAFFE;
("\<X")            return PUT;
(origin@)   return ORIGINAT;
\%                   return PERCENTAGE;
#                   return HASH;
"$"                   return DOLLAR;
\{                  return SWOPEN;
\}                  return SWCLOSE;
"~"                   return SNAKE;
,                   return COMMA;
rosso           return ROSSO;
("verde")           return VERDE;
("azzuro")           return AZZURO;
("rgb")             return RGB;
[a-zA-Z]+               return CHARS;
\/\/.*		; // comments like this one
0|-?[1-9][0-9]*	      yylval = atoi(yytext);       return NUMBER;
[[:space:]] 	;
.		fprintf(stderr, "WARNING(%d) : '%s' ignored\n",yylineno ,yytext);

%%
    //user code -->
