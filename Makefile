
all: klx due.ps

klx: lex.yy.c klx.tab.c klx.tab.h symtab.h symtab.c
	gcc lex.yy.c klx.tab.c symtab.c -lfl -o klx

lex.yy.c: klx.l
	flex  klx.l
	
klx.tab.c: klx.y
	bison -d -v -t klx.y
	
klx.tab.h: klx.y
	bison -d- v -t klx.y
	
due.ps: klx due.klx
	./klx < due.klx > due.ps
	
clean:
	rm -f due.ps klx.tab.* lex.yy.c klx
	rm -f *.o due.ps lex.yy.c klx.tab.c klx.tab.h *.bak klx
