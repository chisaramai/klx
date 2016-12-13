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
    SETTORE = 260,
    PACMAN = 261,
    POLIGONO = 262,
    DUE = 263,
    QUADDRO = 264,
    SEI = 265,
    OTTO = 266,
    EOL = 267,
    LESSSAME = 268,
    BIGGERSAME = 269,
    SAME = 270,
    ISNOT = 271,
    INTEGER = 272,
    DOUBLE = 273,
    ID = 274,
    COLORA = 275,
    SCALA = 276,
    GIRA = 277,
    POSITIONE = 278,
    ROSSO = 279,
    VERDE = 280,
    AZZURO = 281,
    GIALLO = 282,
    IF = 283,
    THEN = 284,
    WHILE = 285,
    FOREACH = 286,
    REPEAT = 287,
    VAR = 288,
    ARROW = 289
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

#line 95 "klx.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_KLX_TAB_H_INCLUDED  */
