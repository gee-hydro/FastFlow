// g++ hello.cpp && ./a.out
#include <iostream>
using namespace std;

typedef long long int bigint;

int main()
{
    int height = 4000000;
    int width = 4000000;
    int size0 = height * width;
    bigint size = bigint(height) * bigint(width);

    cout << size0 << ":" << size << endl;
    return 0;
}
