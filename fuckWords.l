%{ 
    int fuckWords = 0;
%} 

%% 

([a-zA-Z])*(F|f)([a-zA-Z])*(U|u)([a-zA-Z])*(C|c)([a-zA-Z])*(K|k)([a-zA-Z])* {fuckWords++; printf("%s\n", yytext);}

. {}

\n {return 0;}

%% 

int yywrap() {}

int main() {
    yylex();
    printf("Number of strings with Fuck = %d \n", fuckWords);
    return 0;
}