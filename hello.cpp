// g++ hello.cpp && ./a.out
#include <iostream>
using namespace std;

// typedef long long int bigint;
// typedef int64_t bigint;
// typedef long bigint;
typedef int64_t bigint;


int main()
{
    bigint height = 4000000;
    bigint width = 4000000;
    bigint size0 = height * width;
    bigint size = bigint(height) * bigint(width);

    cout << size0 << ", " << size << endl;
    cout << INT64_MAX << ", " << INT32_MAX <<  ", " << __LONG_MAX__ << endl;
    return 0;
}
