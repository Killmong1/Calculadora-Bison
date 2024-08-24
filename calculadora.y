%{
#include <stdio.h>
#include <stdlib.h>  // Para exit()

// Declaración de yylex y yyerror
int yylex(void);
int yyerror(char *s);
%}

/* declarar tokens */
%token NUMBER
%token ADD SUB MUL DIV ABS
%token LPAREN RPAREN EOL

%%

calclist: 
    exp EOL { printf("= %d\n", $1); }
    | calclist exp EOL { printf("= %d\n", $2); }
;

exp: 
    exp ADD term { $$ = $1 + $3; }
    | exp SUB term { $$ = $1 - $3; }
    | term
;

term: 
    term MUL factor { $$ = $1 * $3; }
    | term DIV factor {
        if ($3 == 0) {
            yyerror("Error: División por cero.");
            exit(1);  // Termina el programa con un código de error
        } else {
            $$ = $1 / $3;
        }
    }
    | factor
;

factor: 
    NUMBER
    | ABS factor { $$ = $2 >= 0 ? $2 : -$2; }
    | LPAREN exp RPAREN { $$ = $2; }
;

%%

int main(int argc, char **argv)
{
    yyparse();
    return 0;
}

int yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
    return 0;
}

