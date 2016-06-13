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
    SEMICOLON = 266,
    COMMA = 267,
    DUEPUNTI = 268,
    QUADDROPUNTI = 269,
    SEIPUNTI = 270,
    SQOPEN = 271,
    SQCLOSE = 272,
    KLAMMERAFFE = 273,
    EOL = 274,
    OPEN = 275,
    CLOSE = 276,
    SAME = 277,
    LESSSAME = 278,
    GREATERSAME = 279,
    SWOPEN = 280,
    SWCLOSE = 281,
    INTEGER = 282,
    DOUBLE = 283,
    ID = 284,
    COLORA = 285,
    SCALA = 286,
    GIRA = 287,
    LUOGO = 288,
    ROSSO = 289,
    VERDE = 290,
    AZZURO = 291,
    GIALLO = 292,
    DOLLAR = 293,
    SNAKE = 294,
    HASH = 295,
    VAR = 296,
    IF = 297,
    THEN = 298,
    WHILE = 299,
    FOREACH = 300,
    FOR = 301
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

#line 107 "klx.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_KLX_TAB_H_INCLUDED  */
