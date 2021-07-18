---
title: 牛客网OJ题解--20210317
comments: false
top: false
date: 2021-03-17 21:00:31
tags: [算法,C++]
categories: 
	- [刷题日志]
---

本系列记录翀翀😐痛苦的刷题日志，所有题目均来自于牛客网OJ题目，坚持刷题谈起来容易做起来难，希望我可以坚持下去，这里仍然分享一段励志文案：每个人都有梦想，然而有些人把梦想变成了现实，有些人的梦想依旧是梦想，只因为他们为梦想付出的努力程度不一样，他们坚持的时间不一样，最终才有这样的结果。

<!-- more -->

### NC15434-wyh的迷宫

#### 题目链接

https://ac.nowcoder.com/acm/problem/15434

#### 题目描述



给你一个n*m的迷宫，这个迷宫中有以下几个标识：  

  s代表起点  ，t代表终点  ，x代表障碍物  ，.代表空地  

  现在你们涵哥想知道能不能从起点走到终点不碰到障碍物（只能上下左右进行移动，并且不能移动到已经移动过的点）。

输入第一行一个整数T(1<=T<=10)。接下来有T组测试数据，对于每一组测试数据，第一行输入2个数n和m(1<=n,m<=500)。接下来n行，每行m个字符代表这个迷宫，每个字符都是上面4个中的一种数据保证只有一个起点和一个终点。

对于每一组测试数据，如果可以的话输出YES，不可以的话输出NO。

#### 测试样例

输入

```c
1
3 5
s...x
x...x
...tx
```

输出

```c
YES
```

#### 解题思路

还是dfs板子题，主要是复习一下，水题，不写思路了。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

char _map[505][505];
int vis[505][505];
int dir[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
int m, n;
bool ok;

void dfs(int i, int j)
{
    if (i > m || i < 1 || j > n || j < 1)
    {
        return;
    }
    if (_map[i][j] == 'x')
    {
        return;
    }
    if (_map[i][j] == 't')
    {
        ok = true;
        return;
    }
    if (vis[i][j] == 1)
        return;
    vis[i][j] = 1;
    for (int k = 0; k < 4; k++)
    {
        dfs(i + dir[k][0], j + dir[k][1]);
    }
    return;
}
int main()
{
    int t;
    cin >> t;
    while (t--)
    {
        cin >> m >> n;
        int x, y;
        ok = false;
        memset(_map, 0, sizeof(_map));
        memset(vis, 0, sizeof(vis));
        for (int i = 1; i <= m; i++)
        {
            for (int j = 1; j <= n; j++)
            {
                cin >> _map[i][j];
                if (_map[i][j] == 's')
                {
                    x = i;
                    y = j;
                }
            }
        }
        dfs(x, y);
        if (ok)
            cout << "YES" << endl;
        else
            cout << "NO" << endl;
    }
    system("pause");
    return 0;
}
```

### NC219018-NIH Budget

#### 题目链接

https://ac.nowcoder.com/acm/problem/219018

#### 题目描述

Recently, a job for an algorithms specialist opened up at NIH. You never thought you’d be using your expertise in algorithms to save lives, but now, here is your chance! While the doctors are very good in carrying out medical research and coming up with better cures for diseases, they are not so good with numbers. This is where you come in.  You have been tasked to allocate money for all disease research at NIH. The interesting thing about disease research is that the number of lives saved doesn’t linearly increase with the amount of money spent, in most cases. Instead, there are “break-points”. For example, it might be the case that for disease A, we have the following break-points:

| Research Funding | Lives Saved |
| :--------------: | :---------: |
|    10 million    |      5      |
|    50 million    |     100     |
|   100 million    |    1000     |
|   250 million    |    1100     |

f you spend more money than one breakpoint and less than another, the number of lives saved is equal to the amount saved for the previous breakpoint. (In the above example, if you spent 150million,you’dstillonlysave1000lives,andifyouspentanyamountmorethan150 million, you’d still only save 1000 lives, and if you spent any amount more than 150million,you’dstillonlysave1000lives,andifyouspentanyamountmorethan250 million, you’d still save 1100 lives.) The doctors have figured out charts just like this one for all the diseases for which they do research.  Given these charts, your job will be to maximize the number of lives saved spending no more than a particular budget.Given several charts with information about how much has to be spent to save a certain number of lives for several diseases and a maximum amount of money you can spend, determine the maximum number of lives that can be saved.

The first input line contains a positive integer, n (n ≤ 100), indicating the number of budgets to consider. The first line of each budget contains two positive integers, d (d ≤ 10), representing the number of diseases for which there is data and B (B ≤ 100000), the total budget, in millions of dollars. The following d lines contain information about each of the d diseases. Each of these lines will contain exactly four ordered pairs of positive integers separated by spaces. Each pair will represent a dollar level (in millions) followed by the number of lives saved for that dollar 

level of funding. Each of the pairs will be separated by spaces as well. Each of these values will be less than or equal to 100,000. Assume that the dollar levels on an input line are distinct and in increasing order, and that the number of lives saved on an input line are also distinct and in increasing order.

For each test case, just output a line with the following format:
Budget #k: Maximum of x lives saved.
where k is the number of the budget, starting at 1, and x is the maximum number of lives saved in that budget.
Leave a blank line after the output for each test case. 

####  测试样例

输入

```c
3
2 2000
10 5 50 100 100 1000 250 1100
100 1 200 2 300 3 1900 1000
3 100
10 100 40 200 70 300 100 500
5 1 25 2 35 3 50 4
200 10000 300 20000 400 30000 500 40000
1 10
100 2 200 3 300 5 400 6
```

输出

```c
Budget #1: Maximum of 2000 lives saved.

Budget #2: Maximum of 500 lives saved.

Budget #3: Maximum of 0 lives saved.
```

#### 解题思路

其实读完题就有一种感觉那就是背包问题，其实仔细想一想，每一种疾病只能选择一种投资方案来解决，最终求得的是总体的最大收益，这就是分组背包问题，直接上板子即可，主要是注意一下，此时已经分好组了，所以存组号的时候需要注意一点点细节，还有就是每一中疾病都是4个方案，并且一共有d中疾病，所以将4*d个方案存到一个一维数组仍可以使用降维。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

const int N = 1e5;
//f是最高价值
//p是每一个节点的收益值
//w每一个节点的成本值
//g记录组号
int f[N], p[N], w[N], g[N];

int main()
{
    int t;
    cin >> t;
    int num = 0;
    while (t--)
    {
        num++;
        //多组测试需要初始化
        memset(w, 0, sizeof(w));
        memset(p, 0, sizeof(p));
        memset(g, 0, sizeof(g));
        memset(f, 0, sizeof(f));
        //d种疾病，总资金c
        int d, c;
        cin >> d >> c;
        for (int i = 1; i <= d; i++)
        {
            for (int j = 1; j <= 4; j++)
            {
                //存入成本，收益
                cin >> w[(i - 1) * 4 + j];
                cin >> p[(i - 1) * 4 + j];
                //用时进行分组
                g[(i - 1) * 4 + j] = i;
            }
        }
        //分组背包
        //此时每次遍历i就是打印一行
        //枚举组->枚举容量->枚举某一组中的所有节点
        //逆序容量dp降维
        for (int i = 1; i <= d; i++)
        {
            //注意，此时y还是从大到小
            for (int y = c; y >= 0; y--)
            {
                for (int k = 1; k <= 4 * d; k++)
                {
                    if (y >= w[k] && g[k] == i)
                    {
                        f[y] = max(f[y], f[y - w[k]] + p[k]);
                    }
                }
            }
        }
        printf("Budget #%d: Maximum of %d lives saved.\n\n",num,f[c]);
        // cout << "Budget #" << num << ": Maximum of " << f[c] << " lives saved." << endl;
    }
    system("pause");
    return 0;
}

```

