---
title: 牛客网OJ题解--20210328
comments: false
top: false
date: 2021-03-28 21:24:08
tags: [算法,C++]
categories: 
	- [刷题日志]
---

本系列记录翀翀😐痛苦的刷题日志，所有题目均来自于牛客网OJ题目，坚持刷题谈起来容易做起来难，希望我可以坚持下去，这里仍然分享一段励志文案：每个人都有梦想，然而有些人把梦想变成了现实，有些人的梦想依旧是梦想，只因为他们为梦想付出的努力程度不一样，他们坚持的时间不一样，最终才有这样的结果。

<!-- more -->

### NC13882_C-涂墙

#### 题目链接

https://ac.nowcoder.com/acm/contest/13882/C

#### 题目描述

母牛哥有一桶油漆,把它用完可以给n平方米的墙涂上颜色. 母牛哥想要在墙上涂5个正方形(这些正方形的边长都是整数,单位是米),并且刚好把油漆用完. 母牛哥能做到吗?

第一行一个数字t(<=1000),表示测试样例数量

接下来t行,每行一个数字n(0<=n<=1000000),表示母牛哥的油漆可以涂多少平方米.

输出t行,对于每个输入.如果母牛哥能够做到,就输出YES.否则输出NO.

#### 测试样例

输入

```c
2
4
55
```

输出

```c
NO
YES
```

说明

```
4显然不能分解成5个正平方数,所以这桶油漆不能涂5个正方形.
55可以涂5个正方形,他们面积分别是1 4 9 16 25.
```

#### 解题思路

一开始想的就是dfs，逐一尝试但是超时。。后来借鉴大佬的代码，使用打表枚举发现规律，只有几个数不满足，其他数都是满足条件的。

#### 解题代码

##### dfs(虽然没够，但好歹练习了一下)

```c
#include <bits/stdc++.h>
using namespace std;
const long long N = 1e5;
long long n;
bool ok = false;

//这次要加的数，和，加的次数
void dfs(long long x, long long sum, long long num)
{
    if (x >= n)
        return;
    if (num == 5)
    {
        if (sum == n)
        {
            ok = true;
        }
        return;
    }
    //不选这个数x
    dfs(x + 1, sum, num);
    sum += x * x;
    if (sum > n)
    {
        return;
    }
    //选了这个数x，并且下一个还是选x
    dfs(x, sum, num + 1);
    //选了这个数x，并且下一个数选x+1
    dfs(x + 1, sum, num + 1);
}
int main()
{
    long long t;
    cin >> t;
    while (t--)
    {
        ok = false;
        cin >> n;
        //从1开始
        dfs(1, 0, 0);
        if (ok)
            cout << "YES" << endl;
        else
            cout << "NO" << endl;
    }
    system("pause");
    return 0;
}
```

##### 打表发现规律以后特判

```c
#include <bits/stdc++.h>
using namespace std;
typedef long long ll;

signed main() {
    ios::sync_with_stdio(false), cin.tie(0);
    ll t;
    cin >> t;
    while (t--) {
        ll n;
        cin >> n;
        if (n == 5 || n == 8 || n == 11 || n == 13 || n == 14 || n == 16 || n == 17 || (n != 33 && n >= 19))
            cout << "YES" << endl;
        else
            cout << "NO" << endl;
    }
    system("pause");
    return 0;
}
```

### NC13882_E-捡贝壳

#### 题目描述

小明来到一片海滩上，他很喜欢捡贝壳，但他只喜欢质量**为x的倍数**的贝壳。 贝壳被排列成一条直线，下标从1到n编号,小明打算从编号为区间[l,r]的贝壳中,捡起所有他喜欢的贝壳。你能帮他计算出他能捡多少贝壳吗。 给出一个大小为n(n≤105)的数组，下标从1到n编号，a1,a2,...ana_1,a_2,...a_na1,a2,...an。a_i表示贝壳的质量。 给出q(q≤5∗104)次询问，每次询问包含3个整数l,r,x(1≤l≤r≤n,1≤x≤105)l每次询问，输出一行整数,表示这次询问中能捡到的贝壳数。

第一行给出两个整数n和q，含义如上所示。第二行给出n个整数表示a1,a2,...ana_1,a_2,...a_na1,a2,...an。接下来q行，每行3个整数l,r,x，含义如上所示。对于每次询问输出该次询问中能捡到的贝壳数

#### 测试样例

##### 样例1

输入

```c
5 3
1 2 3 4 5
1 3 2
1 5 3
2 5 4
```

输出

```c
1
1
1
```

##### 样例2

输入

```c
10 3
5532 24380 19363 11022 23965 22383 27049 22357 30453 7451
1 6 2
3 10 10
1 10 9
```

输出

```c
3
0
1
```

#### 解题思路

直接枚举+桶排序绝对超时，需要使用vec进行分块，具体思路见注释。灵活使用lower_bound和upper_bound函数进行统计。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
const int maxn = 1e5 + 10;

vector<int> vec[maxn];
signed main()
{
    ios::sync_with_stdio(false), cin.tie(0);
    int n, q;
    cin >> n >> q;
    int big = 0;
    for (int i = 1; i <= n; ++i)
    {
        int p;
        cin >> p;
        big = max(big, p);
        //将质量为p的贝壳的键值压入p容器，所以vec[p]存放的是所有质量为p的贝壳键值
        vec[p].push_back(i);
    }
    while (q--)
    {
        int l, r, x;
        cin >> l >> r >> x;
        int ans = 0;
        //枚举x的倍数的质量的贝壳
        for (int i = x; i <= big; i += x)
        {
            //大于等于质量为i的键值
            int zuo = lower_bound(vec[i].begin(), vec[i].end(), l) - vec[i].begin();
            //大于质量为i的键值
            int you = upper_bound(vec[i].begin(), vec[i].end(), r) - vec[i].begin();
            //相见就是所有质量为i的贝壳的数量
            ans += you - zuo;
        }
        cout << ans << endl;
    }
    system("pause");
    return 0;
}
```

