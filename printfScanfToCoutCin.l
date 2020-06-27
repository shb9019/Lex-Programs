/**
    Lex program to convert all printf/scanf in input.c to cout/cin respectively
    and write to output.c

    Cases not handled:
    a) Replicating scanf format input to cout (Needs complex data structures in C++)
    b) Ignoring printf and scanf in comments
    c) Ignoring %% which is to print % inside a scanf or printf pattern. Breaks code.

    Author: github/shb9019
**/

%{ 
    #include <bits/stdc++.h>
    using namespace std;

    // Traversing in a printf statement
    bool isInPrintf = false;
    // Traversing in a scanf statement
    bool isInScanf = false;
    // Traversing in a string
    bool isInString = false; 
    // List of arguments of current print/scanf other than the first one
    vector<string> args;

    // First argument of printf/scanf, defines format of output/input
    string formatString;
    // Current argument being traversed other than format
    string currentArg;

    // Given start index, find where an argument of form "%[^' ']*" ends in format string
    int getArgumentEndIndex(int index) {
        index++;
        while(index != formatString.length() && formatString[index] != ' ' && formatString[index] != '%') {
            index++;
        }
        return index;
    }

    // Get end of string which does not include arguments in format string
    pair<string, int> getNonFormatStringEndIndex(int index) {
        string currentString;
        while(index != formatString.length() && formatString[index] != '%') {
            currentString += formatString[index];
            index++;
        }
        return make_pair(currentString, index);
    }

    // For debugging
    void printArgs() {
        cout << formatString << endl;
        for (auto it : args) {
            cout << it << endl;
        }
    }

    // Remove leading white spaces in arguments
    void cleanArgs() {
        vector<string> targs;
        for (auto it : args) {
            int index = 0;
            while (it[index] == ' ' && index != it.length()) {
                index++;
            }
            if (index != it.length()) {
                targs.push_back(it.substr(index, it.length() - index));
            }
        }
        args = targs;
    }

    // Print cout statement after traversing printf
    void printCout() {
        cleanArgs();
        int argCount = args.size();
        int currentArg = 0;
        int currIndex = 0;
        if (argCount != 0 || formatString.length() != 0) cout << "cout ";
        while(currIndex < formatString.length()) {
            if (formatString[currIndex] == '%') {
                cout << " << " << args[currentArg];
                currIndex = getArgumentEndIndex(currIndex);
                currentArg++;
            } else {
                auto psi = getNonFormatStringEndIndex(currIndex);
                cout << " << \"" << psi.first << "\"";
                currIndex = psi.second;
            }
        }
    }

    // Print cout statement after traversing scanf statement
    void printCin() {
        cleanArgs();
        int argCount = args.size();
        int currentArg = 0;
        int currIndex = 0;
        if (argCount != 0 || formatString.length() != 0) cout << "cin";
        while(currIndex < formatString.length()) {
            if (args[currentArg][0] == '&') {
                args[currentArg] = args[currentArg].substr(1,args[currentArg].length() - 1);
            } else {
                args[currentArg] = '*' + args[currentArg];
            }
            cout << " >> " << args[currentArg];
            currIndex++;
            while (formatString[currIndex] != '%' && currIndex != formatString.length()) {
                currIndex++;
            }
            currentArg++;
        }
    }
%} 
  
%% 
printf[(\"] { 
    if (!isInString) {
        isInPrintf = true;
    } else {
        formatString += yytext;
    }
}

scanf[(\"] {
    if (!isInString) {
        isInScanf = true;
    } else {
        formatString += yytext;
    }
}

\\\" {
    if ((isInPrintf || isInScanf) && isInString) formatString += "\\\"";
    else cout << yytext;
}

\" {
    if (isInPrintf || isInScanf) isInString = !isInString;
}

[)] {
    if (isInPrintf || isInScanf) {
        if (isInString) {
            formatString += ")";
        } else {
            if (currentArg != "") {
                args.push_back(currentArg);
                currentArg = "";
            }
            if (isInPrintf) printCout();
            else if (isInScanf) printCin();
            args.clear();
            formatString = "";
            if (isInPrintf) isInPrintf = false;
            if (isInScanf) isInScanf = false;
        }
    } else {
        cout << yytext;
    }
 }

, {
    if (isInPrintf || isInScanf) {
        if (isInString) formatString += yytext;
        else if (currentArg != "") {
            args.push_back(currentArg);
            currentArg = "";
        }
    } else {
        cout << yytext;
    }
}

\n {
    cout << endl;
}

. { 
    if (isInString) {
        formatString += yytext;
    } else if (isInPrintf || isInScanf) {
        currentArg += yytext;
    } else {
        cout << yytext;
    }
 }

%% 

int yywrap(){}

int main(){ 
    extern FILE *yyin;
    yyin = fopen("input.c", "r"); 
    freopen("output.c", "w", stdout);
    yylex();
    return 0;
}
