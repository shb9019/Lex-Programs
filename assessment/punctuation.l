%{
    #include<bits/stdc++.h>
    using namespace std;
    string currentWord = "";
%}

%% 
(["]|[?]|[.]|[,]) {
    if (currentWord != "" && currentWord != " ") {
        cout << currentWord << endl;
        currentWord = "";
    }
}

[' '] {
    currentWord = "";
}

. {
    currentWord += yytext;
}
%% 

int yywrap() {}

int main() {
    yylex();
    return 0;
}