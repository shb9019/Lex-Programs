
%{ 
   #include <stdio.h> 
   #include <stdlib.h>
   int yylex();
   int yyerror();
%} 

%token MACRO VAR COMMA LPAR RPAR CHAR

%% 

S : E {
    printf("Input Accepted! \n");
    exit(0);
}

E : MACRO VAR E2
  ;

E2 : LPAR E3
   | MACROBODY
   ;

E3 : RPAR MACROBODY
   | ARGS RPAR MACROBODY
   ;

ARGS : VAR COMMA ARGS
     | VAR
     ;

MACROBODY : CHAR
          | VAR
          | VAR MACROBODY
          | LPAR MACROBODY
          | RPAR
          | RPAR MACROBODY
          | CHAR MACROBODY
          ;

%% 

int main() {
    yyparse();
}

int yyerror() {
    printf("Invalid!\n");
}