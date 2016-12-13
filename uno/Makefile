
all: klx uno.ps

klx: lex.yy.c klx.tab.c klx.tab.h symtab.h symtab.c
	gcc lex.yy.c klx.tab.c symtab.c -lfl -o klx

lex.yy.c: klx.l
	flex  klx.l
	
klx.tab.c: klx.y
	bison -d -v -t klx.y
	
klx.tab.h: klx.y
	bison -d- v -t klx.y
	
uno.ps: klx uno.klx
	./klx < uno.klx > uno.ps
	
clean:
	rm -f uno.ps klx.tab.* lex.yy.c klx
	rm -f *.o uno.ps lex.yy.c klx.tab.c klx.tab.h *.bak klx
