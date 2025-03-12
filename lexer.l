%{
#include "parser.tab.h"
#include <stdio.h>
%}

DIGIT   [0-9]
NUMBER  {DIGIT}+

%%

{NUMBER}    { yylval = atoi(yytext); return NUMBER; }
"+"         { return '+'; }
"-"         { return '-'; }
"*"         { return '*'; }
"/"         { return '/'; }
[ \t]       ; /* Ignora espaços e tabs */
\n          { return '\n'; } /* Retorna nova linha como token */
.           { printf("Caractere inválido: %s\n", yytext); }

%%

int yywrap() {
    return 1; /* Indica fim da entrada */
}