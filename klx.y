%{

#include <stdio.h>
extern int yylex(void);
int yyerror(const char *msg);
extern int yylineno;

%}

%token CERCHIO RETTANGOLO TRIANGOLO SETTORE PACMAN PENTAGONO POLIGONO
%token SEMICOLON COMMA DUEPUNTI
%token SQOPEN SQCLOSE
%token KLAMMERAFFE
%token OPEN CLOSE
%token SWOPEN SWCLOSE
%token NUMERO CHARS
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
stmlist: ;
stmlist:stmlist stmt;	
stmt:	DUEPUNTI DUEPUNTI klecks;


// .* KLECKS    
klecks: before modlist figura after;

figura: parametro PACMAN 
{	
	int rad = $1/2;
	printf("0 0 %d 30 330 arc\n0 0 rlineto\n",rad);
}
;

figura: parametro POLIGONO
{
	int sides = $1;
        int side_length = 10;
	printf("/polygono { 4 dict begin \n/N exch def /r exch def \n/A 360 N div def	r 0 moveto	\nN { A cos r mul A sin r mul lineto /A A 360 N div add def} repeat closepath end } def ");
	printf("0.2 setlinewidth %d %d polygono \n", side_length, sides);
}
;

before:
{
	printf("gsave");
	printf("0 0 moveto\n");
}
;

after:
{
	printf("fill\n");
	printf("grestore");
}
;

// .* PARAMETRI
parametri:	DUEPUNTI parametro	{$$ = $2;};
parametro:	NUMERO;
parametro:;

// .* MODLIST
modlist:;
modlist:	modlist DUEPUNTI mod; 

// .* MOD
mod:	scala | gira | colora |  luogo; 

// .* SCALA
scala:	SCALA parametri
{
	int fattore = $1;
	printf("%d %d scale",fattore, fattore);
}
;
// .* GIRA
gira:	GIRA parametri
{
	int arc = $2;
	printf("%d %d rotate",arc);
}
;

// .* RGB
colora:	COLORA colore
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
		rgbcode:        NUMERO NUMERO NUMERO 
		{	 
			printf("%f %f %f ", $1/255.0, $2/255.0, $3/255.0); 
		};
            
        
// .* LOC
luogo:	LUOGO NUMERO NUMERO
{
	x = $2;
	y = $3;
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
