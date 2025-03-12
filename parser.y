%{
#include <stdio.h>
int yylex(void);
void yyerror(const char *s);
%}

%token NUMBER
%left '+' '-'
%left '*' '/'

%%

program: /* Vazio, permite início */
       | program expr '\n' { printf("Resultado final: %d\n", $2); 
                             printf("Digite outra expressão (ou Ctrl+D para sair):\n"); }
       ;

expr: NUMBER          { $$ = $1; }
    | expr '+' expr   { $$ = $1 + $3; printf("%d + %d = %d\n", $1, $3, $$); }
    | expr '-' expr   { $$ = $1 - $3; printf("%d - %d = %d\n", $1, $3, $$); }
    | expr '*' expr   { $$ = $1 * $3; printf("%d * %d = %d\n", $1, $3, $$); }
    | expr '/' expr   { if ($3 == 0) yyerror("Divisão por zero"); 
                        else { $$ = $1 / $3; printf("%d / %d = %d\n", $1, $3, $$); } }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s\n", s);
}

int main() {
    printf("Digite uma expressão aritmética (ex: 2 + 5 - 9). Ctrl+C para sair:\n");
    yyparse(); /* Uma única chamada processa todas as expressões */
    printf("Programa encerrado.\n");
    return 0;
}