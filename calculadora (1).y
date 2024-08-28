%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>  // Para pow() y sqrt()

// Declaración de yylex y yyerror
int yylex(void);
int yyerror(char *s);

// Variable global para manejar errores
int error_flag = 0;

// Declaración de yyin para utilizarlo en Bison
extern FILE *yyin;
%}

/* Definir precedencia y asociatividad */
%left ADD SUB
%left MUL DIV MOD
%left POW
%right ABS
%nonassoc UMINUS

/* declarar tokens */
%token NUMBER
%token ADD SUB MUL DIV ABS
%token LPAREN RPAREN EOL
%token POW SQRT MOD

%%

calclist: 
    exp EOL { 
        if (!error_flag) {
            printf("= %d\n", $1); 
        }
        error_flag = 0;  // Resetear el flag de error
    }
    | calclist exp EOL {
        if (!error_flag) {
            printf("= %d\n", $2); 
        }
        error_flag = 0;  // Resetear el flag de error
    }
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
            $$ = 0;  // Valor por defecto para indicar error
            error_flag = 1;  // Activar el flag de error
        } else {
            $$ = $1 / $3;
        }
    }
    | term MOD factor { $$ = $1 % $3; }
    | factor
;

factor: 
    NUMBER
    | ABS factor { $$ = $2 >= 0 ? $2 : -$2; }
    | LPAREN exp RPAREN { $$ = $2; }
    | factor POW factor { $$ = pow($1, $3); }
    | SQRT LPAREN exp RPAREN { $$ = sqrt($3); }
    | SQRT NUMBER { $$ = sqrt($2); }
;

%%

int main(int argc, char **argv)
{
    FILE *input = stdin;  // Leer desde stdin por defecto
    char option;

    // Presentar el menú de opciones al usuario
    printf("Seleccione una opción:\n");
    printf("1. Ingresar operaciones por consola\n");
    printf("2. Leer operaciones desde un archivo\n");
    printf("Ingrese su opción (1/2): ");
    scanf(" %c", &option);
    getchar();  // Consumir el carácter de nueva línea después de la opción

    if (option == '2') {
        char filename[256];
        printf("Ingrese el nombre del archivo: ");
        scanf("%s", filename);
        
        // Abrir archivo si se proporciona como argumento
        input = fopen(filename, "r");
        if (!input) {
            perror("No se puede abrir el archivo");
            return 1;
        }
    } else if (option != '1') {
        printf("Opción inválida. Saliendo del programa.\n");
        return 1;
    }

    yyin = input;  // Establecer el archivo de entrada para el lexer
    yyparse();

    if (input != stdin) {
        fclose(input);  // Cerrar el archivo si se abrió
    }

    return 0;
}

int yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
    return 0;
}

