%{
#include "calculadora.tab.h"
%}

%%

[0-9]+              { yylval = atoi(yytext); return NUMBER; }
"+"                 { return ADD; }
"-"                 { return SUB; }
"*"                 { return MUL; }
"/"                 { return DIV; }
"|"                 { return ABS; }
"("                 { return LPAREN; }
")"                 { return RPAREN; }
\n                  { return EOL; }
[ \t]               { /* ignorar espacios en blanco */ }

%%

int yywrap(void)
{
    return 1;
}

