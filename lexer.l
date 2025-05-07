%{
#include "y.tab.h"
%}

%%

"if"                { return IF; }
"else"              { return ELSE; }
"while"             { return WHILE; }
"for"               { return FOR; }
"print"             { return PRINT; }

"=="                { return EQ; }
"!="                { return NE; }
"<="                { return LE; }
">="                { return GE; }
"<"                 { return LT; }
">"                 { return GT; }

"="                 { return ASSIGN; }
";"                 { return SEMI; }
"("                 { return LPAREN; }
")"                 { return RPAREN; }
"{"                 { return LBRACE; }
"}"                 { return RBRACE; }

"+"                 { return '+'; }
"-"                 { return '-'; }
"*"                 { return '*'; }
"/"                 { return '/'; }

[0-9]+              { yylval.ival = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { strcpy(yylval.sval, yytext); return ID; }

[ \t\r\n]+          ;  // skip whitespace

.                   { printf("Unexpected char: %s\n", yytext); }

%%

int yywrap() { return 1; }
