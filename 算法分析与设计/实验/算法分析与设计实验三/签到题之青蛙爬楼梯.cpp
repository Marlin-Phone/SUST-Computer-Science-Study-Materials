#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<math.h>

long long step[50];

long long climbStairs(int n)
{
    if (n == 1)
    {
        step[n] = 1;
    }
    else
    {
        step[n] = 2 * climbStairs(n - 1);
    }
    return step[n];
}

int main()
{
    int n = 0;
    scanf("%d", &n);
    printf("%lld\n", climbStairs(n));
    return 0;
}
