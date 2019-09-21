/**
    Lex program to identify and count and print the words
    that contain 'p' and 't'.

    Author: github/shb9019
**/

%{ 
    int ptwords = 0; 
%} 
  
%% 
([a-zA-Z])*p([a-zA-Z])*t([a-zA-Z])* { printf("%s\n", yytext); ptwords++; }

([a-zA-Z])*t([a-zA-Z])*p([a-zA-Z])* { printf("%s\n", yytext); ptwords++; }

([a-zA-Z])* {}

. {}

\n { return 0; }
%% 

int yywrap(){}

int main(){ 
    yylex(); 
    printf("\nNumber of words containing p and t - %d\n", ptwords);
    return 0;
}
