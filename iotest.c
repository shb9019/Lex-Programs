#include <iostream>
using namespace std;

// Driver Code
int main() {
    int a,b,c,d;
    float* f;
    scanf("%d %d %d %f", &a, &b, &c, f);
    printf("(Inside printf): The sum of integers %d, %d and %d is %d \n", a, b, c, a + b + c);
    return 0;
}
