
all: klx tre.ps

klx: lex.yy.c klx.tab.c klx.tab.h symtab.h symtab.c
	gcc lex.yy.c klx.tab.c symtab.c -lfl -o klx

lex.yy.c: klx.l
	flex  klx.l
	
klx.tab.c: klx.y
	bison -d -v -t klx.y
	
klx.tab.h: klx.y
	bison -d- v -t klx.y
	
tre.ps: klx tre.klx
	./klx < tre.klx > tre.ps
	
clean:
	rm -f tre.ps klx.tab.* lex.yy.c klx
	rm -f *.o tre.ps lex.yy.c klx.tab.c klx.tab.h *.bak klx
