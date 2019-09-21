/**
    Lex program to identify and print the words that start with a vowel given a sentence.

    Author: github/shb9019
**/

%{ 
%} 
  
%% 
(a|e|i|o|u|A|E|I|O|U)([a-zA-Z])* { printf("%s\n", yytext); }

([a-zA-Z])* {}

. {}

\n { return 0; }
%% 

int yywrap(){}

int main(){ 
    yylex(); 
    return 0;
}
