---
title: 牛客网OJ题解--20210324
comments: false
top: false
date: 2021-03-24 23:07:26
tags: [算法,C++]
categories: 
	- [刷题日志]
---

本系列记录翀翀😐痛苦的刷题日志，所有题目均来自于牛客网OJ题目，坚持刷题谈起来容易做起来难，希望我可以坚持下去，这里仍然分享一段励志文案：每个人都有梦想，然而有些人把梦想变成了现实，有些人的梦想依旧是梦想，只因为他们为梦想付出的努力程度不一样，他们坚持的时间不一样，最终才有这样的结果。

<!-- more -->

### NC14266-Laptop

#### 题目链接

https://ac.nowcoder.com/acm/problem/14266

#### 题目描述

FST是一名可怜的小朋友，他很强，但是经常fst，所以rating一直低迷。
但是重点在于，他非常适合ACM！并在最近的区域赛中获得了不错的成绩。
拿到奖金后FST决定买一台新笔记本，但是FST发现，在价格能承受的范围内，笔记本的内存和速度是不可兼得的。
 可是，有一些笔记本是被另外一些“完虐”的，也就是内存和速度都不高于另外某一个笔记本，现在FST想统计一下有多少笔记本被“完虐”。

第一行一个正整数n，
表示笔记本的数量。接下来n行，每行两个正整数Mi，Si表示这款笔记本的内存和速度。
n≤105,Mi,Si≤109

输出一行，一个正整数，表示被完虐的笔记本数。

#### 测试样例

输入

```c
4
100 700
200 500
50 100
300 400
```

输出

```c
1
```

#### 解题思路

实际上是一个简单的排序思维题，首先我们将内存进行从大到小排序，那么第i个pad肯定是不会被第i+1个pad完爆的，因为前者的内存要比后者大，所以检验i完爆的电脑时，只需检验比他内存小的即在他后面的电脑，但是要注意并不是i就一定完爆其他的所有电脑，因为他的速度未必是最大的，所以我们单独枚举i从n到1，即内存从大到小，然后在记录最大的速度值，当被检验的电脑速度也小于i，那么他就被完爆了。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

const int N = 1e5;
struct Pad
{
    //存储ram和速度
    int a;
    int b;
} pad[N];

bool cmp(Pad x, Pad y)
{
    //将内存从大到小排序
    return x.a > y.a;
}

int main()
{
    int n;
    cin >> n;
    for (int i = 1; i <= n; i++)
    {
        cin >> pad[i].a >> pad[i].b;
    }
    //排序后最靠前的是内存最大的
    sort(pad + 1, pad + 1 + n, cmp);
    int ans = 0;
    //记录最大的速度
    int maxb = 0;
    for (int i = 1; i <= n; i++)
    {
        //更新最大速度
        if (pad[i].b > maxb)
            maxb = pad[i].b;
        else
        {
            //此时pad[i]被完爆了，因为他一定比pad[i-1]之前的ram小
            //此时速度又小了，那么就被完爆了
            ans++;
        }
    }
    cout << ans << endl;
    system("pause");
    return 0;
}
```

### NC14685-加边的无向图

#### 题目链接

https://ac.nowcoder.com/acm/problem/14685

#### 题目描述

给你一个 n 个点，m 条边的无向图，求至少要在这个的基础上加多少条无向边使得任意两个点可达~ 。

第一行两个正整数 n 和 m 。接下来的m行中，每行两个正整数 i 、 j ，表示点i与点j之间有一条无向道路。输出一个整数，表示答案。

#### 测试样例

输入

```c
4 2
1 2
3 4
```

输出

```c
1
```

#### 解题思路

就是一个很明显的并查集板子题，连接以后统计连通块数，需要练的边数就是连通块数减一。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

const int maxn = 1e5 + 5;

int fa[maxn];
//板子
int find(int x)
{
    return x == fa[x] ? x : (fa[x] = find(fa[x]));
}

void merge(int x, int y)
{
    int i = find(x);
    int j = find(y);
    fa[i] = j;
}

int main()
{
    //初始化，默认每一个孤立点都是一个连通块
    for (int i = 0; i < maxn; i++)
    {
        fa[i] = i;
    }
    int n, m;
    cin >> n >> m;
    //合并
    for (int i = 1; i <= m; i++)
    {
        int x, y;
        cin >> x >> y;
        merge(x, y);
    }
    int ans = 0;
    //统计连通块个数，属于同一个i的是一个连通块
    for (int i = 1; i <= n; i++)
    {
        if (find(i) == i)
            ans++;
    }
    //需要ans-1个边
    cout << ans - 1 << endl;
    system("pause");
    return 0;
}
```

