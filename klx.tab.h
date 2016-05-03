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
    SEMICOLON = 265,
    COMMA = 266,
    DUEPUNTI = 267,
    SQOPEN = 268,
    SQCLOSE = 269,
    KLAMMERAFFE = 270,
    OPEN = 271,
    CLOSE = 272,
    SWOPEN = 273,
    SWCLOSE = 274,
    NUMERO = 275,
    CHARS = 276,
    COLORA = 277,
    SCALA = 278,
    GIRA = 279,
    LUOGO = 280,
    ROSSO = 281,
    VERDE = 282,
    AZZURO = 283,
    GIALLO = 284,
    DOLLAR = 285,
    SNAKE = 286,
    HASH = 287,
    PERCENTAGE = 288
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_KLX_TAB_H_INCLUDED  */
