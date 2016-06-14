
%{
#include <stdio.h>
#include "symtab.h"

extern int yylineno;
int yylex(void);
void yyerror(const char *msg);
%}


%union {
	int i;
	double d;
	node *n;
}

%token CERCHIO RETTANGOLO TRIANGOLO SETTORE PACMAN PENTAGONO POLIGONO QUADRATO
%token SEMICOLON COMMA DUEPUNTI QUADDROPUNTI SEIPUNTI
%token SQOPEN SQCLOSE
%token KLAMMERAFFE EOL
%token OPEN CLOSE
%token SAME LESSSAME GREATERSAME
%token SWOPEN SWCLOSE
%token <i> INTEGER
%token <d> DOUBLE
%token <n> ID
%token COLORA SCALA GIRA LUOGO
%token ROSSO VERDE AZZURO GIALLO
%token DOLLAR SNAKE HASH
%token IF THEN WHILE
%token FOREACH FOR
%token VAR


%left '|' '&' '!'

%define parse.error verbose

%%

// :GRAMMAR

programma: header setting stmlist trailer;

header: 
	{
		printf("%%!PS-Adobe\n");
	};
	
setting:
{
	printf(".7 setgray\n300 400 translate\n");
};

// .* STMLIST
stmlist:;
stmlist:stmlist stmt;	

stmt: setup optlist klecks teardown;

stmt: 	WHILE 
{ 
	printf("{\n"); 
} 
	OPEN bool CLOSE 
{ 
	printf(" not {exit} if\n"); 
}
	stmt 
{ 
	printf("} loop\n"); 
}
;
stmt:	VAR ID ';'
{ 	
	$2 -> declared = 1; 
	printf("/klx%s 0 def \n , $2 -> symbol"); 
}
;
stmt: 	IF bool THEN 
{ 
	printf("{\n"); 
} 	
	stmt 
{ 	
	printf("} if\n"); 
}
;
stmt: 	'{' 
{ 
	scope_open(); 
	printf("4 dict begin\n"); 
} 
	stmlist 
	'}' 
{ 
	scope_close(); 
	printf("end\n"); 
}
;

stmt: 	ID '=' expr SEMICOLON 
{ 
	if(!$1 -> declared) 
		yyerror("Undeclared variable!");  
	printf("/klx%s exch def\n",$1 -> symbol);
}
;


//  BOOLEANS

bool: 	boolpraefix;
bool: 	bool '&' boolpraefix 		{printf("and ");};
bool:	bool '|' boolpraefix 		{printf("or ");};

boolpraefix: boolatomic;
boolpraefix: '!' boolatomic  		{printf("not ");}; 

boolatomic: expr '<' expr 		{printf("lt ");};
boolatomic: expr LESSSAME expr 		{printf("le ");};
boolatomic: expr '>' expr 		{printf("gt ");};
boolatomic: expr GREATERSAME expr	{printf("ge ");};
boolatomic: expr SAME expr		{printf("eq ");};
boolatomic: OPEN bool CLOSE;

// ARITHMETIC

expr: product;
expr: expr '+' product 			{printf("add ");};
expr: expr '-' product 			{printf("sub ");};

product: exponent;
product: product '*' exponent 		{printf("mul ");};
product: product '/' exponent 		{printf("div ");};

exponent: praefix; 
exponent: praefix '^' exponent 		{printf("exp \n");};

praefix: atomic;
praefix: '+' atomic;
praefix: '-' atomic 			
{	
	printf("neg \n");	
}
;

atomic: INTEGER 			
{	
	printf("%d ", $1);	
}
;
atomic: DOUBLE 				
{	
	printf("%f ", $1);	
}
;
atomic: ID 
{ 
	if(!$1) yyerror("Undeclared Variable!"); 
		printf("klx%s ", $1 -> symbol);
}
;

atomic: OPEN expr CLOSE;


// .* KLECKS    
klecks: SEIPUNTI PACMAN 
{
	printf("newpath 0 0 60 30 330 arc\n0 0 lineto\n");
}
;

klecks: SEIPUNTI CERCHIO
{
	printf("newpath 0 0 60 0 360 arc\n0 0 lineto\n");
}
;

klecks: SEIPUNTI POLIGONO
{	
	printf("newpath\n");
	printf("/polygono {");
	printf("4 dict begin \n");
	printf("/N exch def /r exch def \n");
	printf("/A 360 N div def");
	printf("r 0 moveto\n");
	printf("N { A cos r mul A sin r mul lineto /A A 360 N div add def} repeat ");
				printf("closepath"); 
				printf("end } def ");
	printf("polygono\n");
}
;

setup:
{
	printf("gsave\n");
}
;

teardown:
{
	printf("fill\n");
	printf("grestore\n");
}
;


// .* OPTLIST
optlist:;
optlist:	optlist opt; 

// .* OPT
opt:	scala | gira | colora | luogo; 

// .* SCALA
scala:	DUEPUNTI expr QUADDROPUNTI SCALA
{
	printf("scale ");
}
;

// .* GIRA
gira:	DUEPUNTI expr QUADDROPUNTI GIRA
{
	printf("rotate ");
}
;

// .* COLORA
colora:	DUEPUNTI colore QUADDROPUNTI COLORA
{
	printf(" setrgbcolor\n");
}
;


	// .* COLORE
	colore:		ROSSO		{printf("1 0 0");}
                	| VERDE		{printf("0 1 0");}
                	| AZZURO	{printf("0 0 1");}
                	| rgbcode
                	;
                    
		// .* RGBCODE
		rgbcode:	expr DUEPUNTI expr DUEPUNTI expr;
		
            
        
// .* LUOGO
luogo:	DUEPUNTI expr DUEPUNTI expr QUADDROPUNTI LUOGO
{
	printf("translate\n");  
}
;


// .* TRAILER
trailer: 
{
	printf("\nshowpage\n"); 
}
;
        
%%


void yyerror(const char *msg){
	fprintf(stderr,"Error: (%d) %s\n" ,yylineno, msg);
}

int main(){	
	yyparse();
	return 0;
}

