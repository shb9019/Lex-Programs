%{ 

%} 

%% 

([a-zA-Z])*red([a-zA-Z])* {printf("Found Red!\n"); return 0;}

. {}

%% 

int yywrap() {}

int main() {
    yylex();
    return 0;
}