/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_KLX_TAB_H_INCLUDED
# define YY_YY_KLX_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    CERCHIO = 258,
    RETTANGOLO = 259,
    TRIANGOLO = 260,
    SETTORE = 261,
    PACMAN = 262,
    PENTAGONO = 263,
    POLIGONO = 264,
    QUADRATO = 265,
    DUE = 266,
    QUADDRO = 267,
    SEI = 268,
    OTTO = 269,
    EOL = 270,
    LESSSAME = 271,
    BIGGERSAME = 272,
    SAME = 273,
    ISNOT = 274,
    INTEGER = 275,
    DOUBLE = 276,
    ID = 277,
    COLORA = 278,
    SCALA = 279,
    GIRA = 280,
    POSITIONE = 281,
    ROSSO = 282,
    VERDE = 283,
    AZZURO = 284,
    GIALLO = 285,
    IF = 286,
    THEN = 287,
    WHILE = 288,
    FOREACH = 289,
    REPEAT = 290,
    VAR = 291
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 12 "klx.y" /* yacc.c:1909  */

	int i;
	double d;
	node *n;

#line 97 "klx.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_KLX_TAB_H_INCLUDED  */
