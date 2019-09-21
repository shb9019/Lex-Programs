/**
    Lex program to identify and print the words that start with a 'k' given a sentence.

    Author: github/shb9019
**/

%{ 
%} 
  
%% 
k([a-zA-Z])* { printf("%s\n", yytext); }

([a-zA-Z])* {}

. {}

\n { return 0; }
%% 

int yywrap(){}

int main(){ 
    yylex(); 
    return 0;
}
