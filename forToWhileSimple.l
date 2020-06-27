%{ 
    #include <bits/stdc++.h>
    using namespace std;

    string st1, st2, st3;
    int currentSegment = 1;
    bool inFor = false;
    int parStack = 0;

    void replaceForHeader() {
        cout << st1 << ";\n";
        cout << "while(" << st2 << ") ";
    }

    void printIncrement() {
        cout << st3 << ";\n";
    }
%} 

%% 

for[(] {
    currentSegment = 1;
    st1 = "";
    st2 = "";
    st3 = "";
    inFor = true;
    parStack = 0;
}

[{] {
    parStack++;
    printf("%s", yytext);
}

[}] {
    parStack--;
    if (parStack == 0) {
        printIncrement();
    }
    printf("%s", yytext);
}

[;] {
    if (inFor) currentSegment++;
    else {
        printf("%s", yytext);
    }
}

[)] {
    if (inFor) {
        inFor = false;
        replaceForHeader();
    } else {
        printf("%s", yytext);
    }
}

. {
    if (inFor) {
        switch(currentSegment) {
            case 1: {
                st1 += yytext;
                break;
            }
            case 2: {
                st2 += yytext;
                break;
            }
            default: {
                st3 += yytext;
            }
        }
    } else {
        printf("%s", yytext);
    }
}


%% 

int yywrap() {}

int main() {
    extern FILE *yyin;
    yyin = fopen("input.c", "r");
    freopen("output.c", "w", stdout);
    yylex();
    return 0;
}