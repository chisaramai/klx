
all: klx due.ps

klx: lex.yy.c klx.tab.c klx.tab.h
	gcc lex.yy.c klx.tab.c -lfl -o klx
	
lex.yy.c: klx.l
	flex klx.l
	
klx.tab.c: klx.y
	bison -dt klx.y
	
klx.tab.h: klx.y
	bison -dt klx.y
	
due.ps: klx due.klx
	./klx < due.klx > due.ps
	
clean:
	rm -f due.ps klx.tab.* lex.yy.c klx
	rm -f *.bak *-o
		
