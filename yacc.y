%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int tempCount = 0, labelCount = 0, varCount = 0;
extern FILE *yyin;

char tac[1000][100];
int tacIndex = 0;

struct VarTable { char name[100]; int value; } varTable[100];

int getVarIndex(char *name) {
    for (int i = 0; i < varCount; i++)
        if (strcmp(varTable[i].name, name) == 0) return i;
    strcpy(varTable[varCount].name, name);
    varTable[varCount].value = 0;
    return varCount++;
}

char* newTemp() {
    char* temp = malloc(10);
    sprintf(temp, "t%d", tempCount++);
    return temp;
}

char* newLabel() {
    char* label = malloc(10);
    sprintf(label, "L%d", labelCount++);
    return label;
}

void yyerror(const char *s) { fprintf(stderr, "Error: %s\n", s); }
int yylex();
%}

%union {
    int ival;
    char sval[100];
    char *tacName;
}

%token <ival> NUMBER
%token <sval> ID
%token IF ELSE WHILE PRINT FOR
%token EQ NE LE GE LT GT
%token ASSIGN SEMI LPAREN RPAREN LBRACE RBRACE
%type <tacName> expression

%left ELSE
%left '+' '-'
%left '*' '/'

%%

program:
    program statement
  | /* empty */
;

statement:
    ID ASSIGN expression SEMI {
        sprintf(tac[tacIndex++], "%s = %s", $1, $3);
    }
  | PRINT ID SEMI {
        sprintf(tac[tacIndex++], "print %s", $2);
    }
  | IF LPAREN expression RPAREN LBRACE program RBRACE ELSE LBRACE program RBRACE {
        char *l1 = newLabel(), *l2 = newLabel();
        sprintf(tac[tacIndex++], "ifFalse %s goto %s", $3, l1);
        // then block already inserted
        sprintf(tac[tacIndex++], "goto %s", l2);
        sprintf(tac[tacIndex++], "%s:", l1); // else
        // else block already inserted
        sprintf(tac[tacIndex++], "%s:", l2); // end
    }
  | WHILE LPAREN expression RPAREN LBRACE program RBRACE {
        char *start = newLabel(), *end = newLabel();
        sprintf(tac[tacIndex++], "%s:", start);
        sprintf(tac[tacIndex++], "ifFalse %s goto %s", $3, end);
        // loop body already inserted
        sprintf(tac[tacIndex++], "goto %s", start);
        sprintf(tac[tacIndex++], "%s:", end);
    }
  | FOR LPAREN statement expression SEMI statement RPAREN LBRACE program RBRACE {
        char *start = newLabel(), *end = newLabel();
        sprintf(tac[tacIndex++], "%s:", start);
        sprintf(tac[tacIndex++], "ifFalse %s goto %s", $4, end);
        // loop body already inserted
        // iteration statement
        // Note: $6 is a statement that generated TAC already
        sprintf(tac[tacIndex++], "goto %s", start);
        sprintf(tac[tacIndex++], "%s:", end);
    }
  | LBRACE program RBRACE
;

expression:
    expression '+' expression { char *t = newTemp(); sprintf(tac[tacIndex++], "%s = %s + %s", t, $1, $3); $$ = t; }
  | expression '-' expression { char *t = newTemp(); sprintf(tac[tacIndex++], "%s = %s - %s", t, $1, $3); $$ = t; }
  | expression '*' expression { char *t = newTemp(); sprintf(tac[tacIndex++], "%s = %s * %s", t, $1, $3); $$ = t; }
  | expression '/' expression { char *t = newTemp(); sprintf(tac[tacIndex++], "%s = %s / %s", t, $1, $3); $$ = t; }
  | expression EQ expression { char *t = newTemp(); sprintf(tac[tacIndex++], "%s = %s == %s", t, $1, $3); $$ = t; }
  | expression NE expression { char *t = newTemp(); sprintf(tac[tacIndex++], "%s = %s != %s", t, $1, $3); $$ = t; }
  | expression LE expression { char *t = newTemp(); sprintf(tac[tacIndex++], "%s = %s <= %s", t, $1, $3); $$ = t; }
  | expression GE expression { char *t = newTemp(); sprintf(tac[tacIndex++], "%s = %s >= %s", t, $1, $3); $$ = t; }
  | expression LT expression { char *t = newTemp(); sprintf(tac[tacIndex++], "%s = %s < %s", t, $1, $3); $$ = t; }
  | expression GT expression { char *t = newTemp(); sprintf(tac[tacIndex++], "%s = %s > %s", t, $1, $3); $$ = t; }
  | NUMBER {
        char *t = malloc(10); sprintf(t, "%d", $1); $$ = t;
    }
  | ID {
        $$ = strdup($1);
    }
  | LPAREN expression RPAREN {
        $$ = $2;
    }
;

%%

int main() {
    yyin = stdin;
    yyparse();

    printf("\n--- Three Address Code ---\n");
    for (int i = 0; i < tacIndex; i++) {
        printf("%s\n", tac[i]);
    }

    return 0;
}
