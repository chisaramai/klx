%{

#include <stdio.h>
extern int yylex(void);
int yyerror(const char *msg);
extern int yylineno;}

%}

%union {
struct ast *a;
double d;
}

%token CERCHIO RETTANGOLO TRIANGOLO SETTORE PACMAN PENTAGONO POLIGONO QUADRATO
%token SEMICOLON COMMA DUEPUNTI QUADDROPUNTI SEIPUNTI
%token SQOPEN SQCLOSE
%token KLAMMERAFFE
%token OPEN CLOSE
%token SWOPEN SWCLOSE
%token <d> NUMERO
%token COLORA SCALA GIRA LUOGO
%token ROSSO VERDE AZZURO GIALLO
%token DOLLAR SNAKE HASH

%type <a> exp factor term

%left '+' '-'
%left '*' '/'
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
stmt:	klecks;

// ARITHMETIC

exp: factor
| exp '+' factor { $$ = newast('+', $1,$3); }
| exp '-' factor { $$ = newast('-', $1,$3); }
;
factor: term
| factor '*' term { $$ = newast('*', $1,$3); }
| factor '/' term {	if ($3 == 0)
                        	yyerror("divide by zero");
			else
				$$ = newast('/', $1,$3); }
;
term: NUMBER { $$ = newnum($1); }
| '|' term { $$ = newast('|', $2, NULL); }
| '(' exp ')' { $$ = $2; }
| '-' term { $$ = newast('M', $2, NULL); }
;



// .* KLECKS    
klecks: setup optlist figura teardown;

figura: DUEPUNTI exp SEIPUNTI PACMAN 
{	
	int rad = $2;
	printf("0 0 %d 30 330 arc\n0 0 lineto\n",rad);
}
;

figura: DUEPUNTI exp SEIPUNTI CERCHIO
{
	int rad = $2;
	printf("0 0 %d 0 360 arc\n0 0 lineto\n",rad);
}
;

figura: DUEPUNTI exp SEIPUNTI POLIGONO
{
	int sides = $2;
        int side_length = 30;
	printf("/polygono { 4 dict begin \n/N exch def /r exch def \n/A 360 N div def	r 0 moveto	\nN { A cos r mul A sin r mul lineto /A A 360 N div add def} repeat closepath end } def ");
	printf("0.2 setlinewidth %d %d polygono \n", side_length, sides);
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


// .* MODLIST
optlist:;
optlist:	optlist opt; 

// .* OPT
opt:	scala | gira | colora | luogo; 

// .* SCALA
scala:	DUEPUNTI exp QUADDROPUNTI SCALA
{
	int fattore = $1;
	printf("%d %d scale",fattore, fattore);
}
;
// .* GIRA
gira:	DUEPUNTI exp QUADDROPUNTI GIRA
{
	int arc = $1;
	printf("%d %d rotate",arc);
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
		rgbcode:	exp DUEPUNTI exp DUEPUNTI exp
		{	 
			printf("%f %f %f ", $1/255.0, $3/255.0, $5/255.0); 
		};
            
        
// .* LUOGO
luogo:	DUEPUNTI exp DUEPUNTI exp QUADDROPUNTI LUOGO
{
	int x = $2;
	int y = $4;
	printf("%d %d translate\n",x,y);  
}
;


// .* TRAILER
trailer: 
{
	printf("\nshowpage\n"); 
}
;	
        

%%

int yyerror(const char *msg){
	fprintf(stderr,"Error: %s\n", msg);
	return 0;
}

int main(void){
	yyparse();
	return 0;
}
