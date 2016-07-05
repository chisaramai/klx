
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
%token DUE QUADDRO SEI OTTO
%token EOL
%token LESSSAME BIGGERSAME SAME
%token <i> INTEGER
%token <d> DOUBLE
%token <n> ID
%token COLORA SCALA GIRA POSITIONE
%token ROSSO VERDE AZZURO GIALLO
%token IF THEN WHILE
%token FOREACH REPEAT
%token VAR


%left '|' '&' '!'

%define parse.error verbose

%%

// :GRAMMAR

programma: header setting functions stmlist trailer;

header: 
	{
		printf("%%!PS-Adobe\n");
	};
	
setting:
{
	printf(".7 setgray\n300 400 translate\n");
	printf("0.0 setsmoothness\n");
};

functions: 
{
    	printf("/polygono {\n");
	printf("4 dict begin \n");
	printf("/N exch def /r exch def \n");
	printf("/A 360 N div def\n");
	printf("r 0 moveto\n");
	printf("N { A cos r mul A sin r mul lineto /A A 360 N div add def} repeat ");
				printf("closepath\n"); 
				printf("end } def\n");
}

// .* STMLIST
stmlist:;
stmlist:stmlist stmt;	

stmt: setup optlist klecks teardown;

stmt: 	WHILE 
{ 
	printf("{\n"); 
} 
	'(' bool ')'
{ 
	printf(" not {exit} if\n"); 
}
	stmt 
{ 
	printf("} loop\n"); 
}
;
stmt:	VAR '@' ID
{ 	
	$3 -> declared = 1; 
	printf("/klx%s 0 def \n" , $3 -> symbol); 
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

stmt: 	expr '@' ID
{ 
	if(!$3 -> declared){ 
		yyerror("Undeclared variable!");
	}  
	printf("/klx%s exch store\n",$3 -> symbol);
}
;
stmt:  '#' expr 
{	
	printf(" { ");
}
	stmt
{
	printf(" } repeat\n");
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
boolatomic: expr BIGGERSAME expr	{printf("ge ");};
boolatomic: expr SAME expr		{printf("eq ");};
boolatomic: '(' bool ')';

// ARITHMETIC

expr: product;
expr: expr '+' product 			{printf("add ");};
expr: expr '-' product 			{printf("sub ");};
expr: expr '%' product			{printf("%");}

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

atomic: '(' expr ')';


// .* KLECKS    
klecks: SEI PACMAN 
{
	printf("newpath 0 0 60 30 330 arc\n0 0 lineto\n");
}
;

klecks: SEI CERCHIO
{
	printf("newpath 0 0 60 0 360 arc\n0 0 lineto\nclosepath\n");
}
;

klecks: DUE expr DUE expr SEI POLIGONO
{	

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
	printf("4 setlinewidth\n");
	printf(".75 setgray\n");
	printf("stroke\n");
}
;


// .* OPTLIST
optlist:;
optlist:	optlist opt; 

// .* OPT
opt:	scala | gira | colora | positione; 

// .* SCALA
scala:	DUE expr DUE expr QUADDRO SCALA
{
	printf("scale ");
}
;

// .* GIRA
gira:	DUE expr QUADDRO GIRA
{
	printf("rotate ");
}
;

// .* COLORA
colora:	DUE colore QUADDRO COLORA
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
		rgbcode:	expr DUE expr DUE expr;
		
            
        
// .* POSITIONE
positione:	DUE expr DUE expr QUADDRO POSITIONE
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

