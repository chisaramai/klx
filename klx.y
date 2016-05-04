%{

#include <stdio.h>
extern int yylex(void);
int yyerror(const char *msg);
extern int yylineno;

%}

%token CERCHIO RETTANGOLO TRIANGOLO SETTORE PACMAN PENTAGONO POLIGONO QUADRATO
%token SEMICOLON COMMA DUEPUNTI QUADDROPUNTI SEIPUNTI
%token SQOPEN SQCLOSE
%token KLAMMERAFFE
%token OPEN CLOSE
%token SWOPEN SWCLOSE
%token NUMERO CHARS
%token PLUS MUL POW MINUS MODULO
%token COLORA SCALA GIRA LUOGO
%token ROSSO VERDE AZZURO GIALLO
%token DOLLAR SNAKE HASH PERCENTAGE 


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

numero:	NUMERO
	|NUMERO PLUS 	numero	{$$ = $1 + $3;}
	|NUMERO MUL 	numero	{$$ = $1 * $3;}	
	|NUMERO POW 	numero	{$$ = $1 ^ $3;}
	|NUMERO MINUS	numero	{$$ = $1 - $3;}
	|NUMERO	MODULO 	numero	{$$ = $1 % $3;}
	;


// .* KLECKS    
klecks: setup modlist figura teardown;

figura: DUEPUNTI numero	SEIPUNTI PACMAN 
{	
	int rad = $2;
	printf("0 0 %d 30 330 arc\n0 0 rlineto\n",rad);
}
;

figura: DUEPUNTI numero SEIPUNTI CERCHIO
{
	int rad = $2;
	printf("0 0 %d 0 360 arc\n0 0 rlineto\n",rad);
}
;

figura: DUEPUNTI numero SEIPUNTI POLIGONO
{
	int sides = $2;
        int side_length = 30;
	printf("/polygono { 4 dict begin \n/N exch def /r exch def \n/A 360 N div def	r 0 moveto	\nN { A cos r mul A sin r mul lineto /A A 360 N div add def} repeat closepath end } def ");
	printf("0.2 setlinewidth %d %d polygono \n", side_length, sides);
}
;
figura: DUEPUNTI numero SEIPUNTI QUADRATO
{
	int a = $2;
	printf("0 %d rlineto\n%d 0 rlineto\n0 -%d rlineto\n",a);
}
;
setup:
{
	printf("gsave\n");
	printf("0 0 moveto\n");
}
;

teardown:
{
	printf("fill\n");
	printf("grestore\n");
}
;

// .* PARAMETRI
parametri:	parametro parametri
parametri:	;

parametro:	DUEPUNTI numero;

// .* MODLIST
modlist:;
modlist:	modlist mod; 

// .* MOD
mod:	scala | gira | colora | luogo; 

// .* SCALA
scala:	parametri QUADDROPUNTI SCALA
{
	int fattore = $1;
	printf("%d %d scale",fattore, fattore);
}
;
// .* GIRA
gira:	parametri QUADDROPUNTI GIRA
{
	int arc = $1;
	printf("%d %d rotate",arc);
}
;

// .* COLORA
colora:	DUEPUNTI colore QUADDROPUNTI COLORA
{
	printf(" setrgbcolor\n");
	printf("fill\n");
}
;


	// .* COLORE
	colore:		ROSSO		{printf("1 0 0");}
                	| VERDE		{printf("0 1 0");}
                	| AZZURO	{printf("0 0 1");}
                	| rgbcode
                	;
                    
		// .* RGBCODE
		rgbcode:	numero DUEPUNTI numero DUEPUNTI numero
		{	 
			printf("%f %f %f ", $1/255.0, $3/255.0, $5/255.0); 
		};
            
        
// .* LUOGO
luogo:	DUEPUNTI numero DUEPUNTI numero QUADDROPUNTI LUOGO
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
