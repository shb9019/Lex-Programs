%{
    #include <bits/stdc++.h>
    using namespace std;
    int currentNum = 0;

    void checkArmstrong() {
        int sum = 0;
        int tnum = currentNum;
        while (tnum) {
            int digit = (tnum%10);
            sum += (digit*digit*digit);
            tnum /= 10;
        }
        if (sum == currentNum) {
            cout << "Yes" << endl;
        } else {
            cout << "No" << endl;
        }
     }
%}

%% 
[0-9]+ {
    currentNum = atoi(yytext);
    checkArmstrong();
}

. {
    return 0;
}


%% 

int yywrap() {}

int main() {
    yylex();
    return 0;
}