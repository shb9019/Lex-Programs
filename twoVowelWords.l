/**
    Lex program to identify and count and print the words
    that contain atleast two vowels in a sentence.

    Author: github/shb9019
**/

%{ 
    int twoVowelWords = 0; 
%} 
  
%% 
([a-zA-Z])*(a|e|i|o|u|A|E|I|O|U)([a-zA-Z])*(a|e|i|o|u|A|E|I|O|U)([a-zA-Z])* {
    printf("%s\n", yytext);
    twoVowelWords++;
}

([a-zA-Z])* {}

. {}

\n { return 0; }
%% 

int yywrap(){}

int main(){ 
    yylex(); 
    printf("\nNumber of words with atleast two vowels - %d\n", twoVowelWords);
    return 0;
}
