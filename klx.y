%{
#include <stdlib.h>
#include <stdarg.h>
#include <stdio.h>

extern int yylex(void);
extern int yylineno;
extern void yyerror(char *s, ...);

/* nodes in the abstract syntax tree */
struct ast {
	int nodetype;
	struct ast *l;
	struct ast *r;
};
struct numval {
	int nodetype;

	 /* type K for constant */
	double number;
};

/* build an AST */
struct ast * newast(int nodetype, struct ast *l, struct ast *r);
struct ast * newnum(double d);

/* evaluate an AST */
double eval(struct ast *);

/* delete and free an AST */
void treefree(struct ast *);

%}

%union {
	struct ast *a;
	double d;
}

%token CERCHIO RETTANGOLO TRIANGOLO SETTORE PACMAN PENTAGONO POLIGONO QUADRATO
%token SEMICOLON COMMA DUEPUNTI QUADDROPUNTI SEIPUNTI
%token SQOPEN SQCLOSE
%token KLAMMERAFFE EOL
%token OPEN CLOSE
%token SWOPEN SWCLOSE
%token <d> NUMERO
%token COLORA SCALA GIRA LUOGO
%token ROSSO VERDE AZZURO GIALLO
%token DOLLAR SNAKE HASH
%type <a> exp

%left '+' '-'
%left '*' '/'
%nonassoc '|' UMINUS

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

exp: 	exp '+' exp	 	{ $$ = newast('+', $1,$3); }
	| exp '-' exp	 	{ $$ = newast('-', $1,$3); }
	| exp '*' exp 		{ $$ = newast('*', $1,$3); }
	| exp '/' exp 		{ $$ = newast('/', $1,$3); }
	| '|' exp		{ $$ = newast('|', $2, NULL); }
	| '(' exp ')' 		{ $$ = $2; }
	| '-' exp %prec UMINUS	{ $$ = newast('M', NULL, $2); }
	| NUMERO 		{ $$ = newnum($1); }
;



// .* KLECKS    
klecks: setup optlist figura teardown;

figura: DUEPUNTI exp SEIPUNTI PACMAN 
{
	
	double rad = eval($2);
	treefree($2);
	printf("0 0 %f 30 330 arc\n0 0 lineto\n",rad);
}
;

figura: DUEPUNTI exp SEIPUNTI CERCHIO
{
	double rad = eval($2);
	treefree($2);
	printf("0 0 %f 0 360 arc\n0 0 lineto\n",rad);
}
;

figura: DUEPUNTI exp SEIPUNTI POLIGONO
{
	double sides = eval($2);
	treefree($2);
        int side_length = 30;
	printf("/polygono { 4 dict begin \n/N exch def /r exch def \n/A 360 N div def	r 0 moveto	\nN { A cos r mul A sin r mul lineto /A A 360 N div add def} repeat closepath end } def ");
	printf("0.2 setlinewidth %d %d polygono \n", side_length,(int) sides);
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
	double fattore = eval($2);
	treefree($2);
	printf("%f %f scale",fattore, fattore);
}
;
// .* GIRA
gira:	DUEPUNTI exp QUADDROPUNTI GIRA
{
	double arc = eval($2);
	treefree($2);
	printf("%f %f rotate",arc);
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
			printf("%f %f %f ", eval($1)/255.0, eval($3)/255.0, eval($5)/255.0); 
			treefree($1); treefree($3); treefree($5);
		};
            
        
// .* LUOGO
luogo:	DUEPUNTI exp DUEPUNTI exp QUADDROPUNTI LUOGO
{
	double x = eval($2);
	treefree($2);
	double y = eval($4);
	treefree($4);
	printf("%f %f translate\n",x,y);  
}
;


// .* TRAILER
trailer: 
{
	printf("\nshowpage\n"); 
}
;	
        

%%

struct ast *
newast(int nodetype, struct ast *l, struct ast *r)
{
        struct ast *a = malloc(sizeof(struct ast));
        if(!a) {
        	yyerror("out of space");
        	exit(0);
        }
        a->nodetype = nodetype;
        a->l = l;
        a->r = r;
        return a;
}

struct ast *
newnum(double d)
{
        struct numval *a = malloc(sizeof(struct numval));
        if(!a) {
        yyerror("out of space");
        exit(0);
        }
        a->nodetype = 'K';
        a->number = d;
        return (struct ast *)a;
}


double eval(struct ast *a){
	double v; // calculated value of this subtree
	switch(a-> nodetype) {
	case 'K': v = ((struct numval *)a)->number; break;
	case '+': v = eval(a->l) + eval(a->r); break;
	case '-': v = eval(a->l) - eval(a->r); break;
	case '*': v = eval(a->l) * eval(a->r); break;
	case '/': v = eval(a->l) / eval(a->r); break;
	case '|': v = eval(a->l); if(v < 0) v = -v; break;
	case 'M': v = -eval(a->l); break;
	default: printf("internal error: bad node %c\n", a->nodetype);
	}
	return v;
}

void treefree(struct ast *a){

	switch(a->nodetype) {
		/* two subtrees */
		case '+':
		case '-':
		case '*':
		case '/':
			treefree(a->r);
		
		/* one subtree */
		case '|':
		case 'M':
			treefree(a->l);
	
		/* no subtree */
		case 'K':
			free(a);
		break;
		default: printf("internal error: free bad node %c\n", a->nodetype);
	}
}



void yyerror(char *s, ...){
	va_list ap;
	va_start(ap, s);
	fprintf(stderr, "%d: error: ", yylineno);
	vfprintf(stderr, s, ap);
	fprintf(stderr, "\n");
}

int main(){
	return yyparse();
}

