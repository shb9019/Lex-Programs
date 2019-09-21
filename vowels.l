/**
    Lex program to identify and count and print the vowels in a sentence.

    Author: github/shb9019
**/

%{ 
    int vowelCount = 0;
%} 
  
%% 
(a|e|i|o|u|A|E|I|O|U) {
    printf("%s", yytext);
    vowelCount++;
}

. {}

\n { return 0; }
%% 

int yywrap(){}

int main(){ 
    yylex(); 
    printf("\nNumber of vowels - %d\n", vowelCount);
    return 0;
}
