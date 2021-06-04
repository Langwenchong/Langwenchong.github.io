---
title: 牛客网OJ题解--20210304
comments: false
top: false
date: 2021-03-04 23:12:49
tags: [算法,C++]
categories: 算法导论
---

本系列记录翀翀😐痛苦的刷题日志，所有题目均来自于牛客网OJ题目，坚持刷题谈起来容易做起来难，希望我可以坚持下去，这里仍然分享一段励志文案：每个人都有梦想，然而有些人把梦想变成了现实，有些人的梦想依旧是梦想，只因为他们为梦想付出的努力程度不一样，他们坚持的时间不一样，最终才有这样的结果。

<!-- more -->

### NC24948-Cow Contest

#### 题目链接

https://ac.nowcoder.com/acm/problem/24948

#### 题目描述

N (1 ≤ N ≤ 100) cows, conveniently numbered 1..N, are participating in a programming contest. As we all know, some cows code better than others. Each cow has a certain constant skill rating that is unique among the competitors.
 The contest is conducted in several head-to-head rounds, each between two cows. If cow A has a greater skill level than cow B (1 ≤ A ≤ N; 1 ≤ B ≤ N; A ≠ B), then cow A will always beat cow B.Farmer John is trying to rank the cows by skill level. Given a list the results of M (1 ≤ M ≤ 4,500) two-cow rounds, determine the number of cows whose ranks can be precisely determined from the results. It is guaranteed that the results of the rounds will not be contradictory.

\* Line 1: Two space-separated integers: N and M
\* Lines 2..M+1: Each line contains two space-separated integers that describe the competitors and results (the first integer, A, is the winner) of a single round of competition: A and B

\* Line 1: A single integer representing the number of cows whose ranks can be determined

大意就是有N头牛，经过M轮比赛，并且永远是A赢B，那么老农想根据下面的2~m行的比赛来得到可以确定具体排名的牛的个数。牛的编号是1-n,并且不会出现A>B>C>A的矛盾情况出现。

#### 测试样例

输入

```c
5 5
4 3
4 2
3 2
1 2
2 5
```

输出

```c
2
```

说明

```
Cow 2 loses to cows 1, 3, and 4. Thus, cow 2 is no better than any of the cows 1, 3, and 4. Cow 5 loses to cow 2, so cow 2 is better than cow 5.  Thus, cow 2 must be fourth, and cow 5 must be fifth. The ranks of the other cows cannot be determined.

牛2输给了牛1,2,4，又赢了牛5，所以牛5一定是第五名，牛2一定是第四名，1,3,4,排名无法确定，所以答案为2
```

#### 解题思路

使用的并不是并查集而是floyd算法，其实还是并查集的思想，具体的解题过程见注释。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;
const int N = 105;
int x, y, n, m, ans;
//win[i][j]==1表示i赢了j
//lose[i][j]==1表示i输给了j
int win[N][N], lose[N][N];

int main()
{
    cin >> n >> m;
    while (m--)
    {
        //存入x，y一定是x赢y
        cin >> x >> y;
        win[x][y] = lose[y][x] = 1;
    }
    //floyd算法模拟并查集思想
    //这里不适用并查集是因为并查集记录的都是节点A和节点B是否具有共同祖先节点的关系来间接表示A和B的关系
    //但是这里只是用来记录两个相邻节点A,B的直接关系
    for (int k = 1; k <= n; k++)
        for (int i = 1; i <= n; i++)
        {
            //当i和k相同时跳过
            if (i == k)
                continue;
            for (int j = 1; j <= n; j++)
            {
                //同理i==j或者j==k也跳过总之就是必须是三头不同的牛
                if (i == j || j == k)
                    continue;
                //i赢了j当前仅当i赢了k且k赢了j，一定要注意这里是取或
                win[i][j] |= (win[i][k] && win[k][j]);
                //i输给j当且仅当i输给k且k输给j
                lose[i][j] |= (lose[i][k] && lose[k][j]);
            }
        }
    for (int i = 1; i <= n; i++)
    {
        int num = 0;
        for (int j = 1; j <= n; j++)
            //统计i赢的场数和输的场数
            num += win[i][j] + lose[i][j];
        //如果刚好和为n-1，表示排名先于i的人数和排名落后于i的人数之和为n-1，那么随之i的排名就确定了
        //可以用排队来理解，已知5个人，A前面有3个人，后面有1个人，那么就确定了A位于从前往后数第4个
        if (num == n - 1)
            ans++;
    }
    cout << ans << endl;
    system("pause");
    return 0;
}
```

### NC15121-Call your teacher

#### 题目链接

https://ac.nowcoder.com/acm/problem/15121

#### 题目描述

从实验室出来后，你忽然发现你居然把自己的电脑落在了实验室里，但是实验室的老师已经把大门锁上了。更糟的是，你没有那个老师的电话号码。你开始给你知道的所有人打电话，询问他们有没有老师的电话，如果没有，他们也会问自己的同学来询问电话号码。那么，你能联系到老师并且拿到电脑吗。

存在多组测试样例，每组样例的第一行分别是两个整数n(1<n<=50)，m(1<m<=2000)，n是在题目当中出现的人数，其中你的序号是1号，实验室老师的序号是n。接下来的m行，每行有两个整数x(1<=x<=n)，y(1<=y<=n)，代表x有y的电话号码。对于每组测试样例，如果你最终能联系到老师，输出“Yes”，否则输出“No”。

#### 测试样例

##### 样例1

输入

```c
5 5
1 3
2 3
3 4
2 4
4 5
```

输出

```c
Yes
```

##### 样例2

输入

```c
4 3
1 2
2 3
4 1
```

输出

```c
No
```

说明

```c
注意此时4->1->2->3,虽然老师知道你的电话号码，但是你却不知道他的，所以出事了老师并不能得知，你也不能给老师打电话，所以无法联系到老师也就拿不到电脑
```

#### 解题思路

很明显就是并查集，但是有一个小小的变式，就是merge时如果老师是第一个参数那么就不能合并，因为虽然此时老师知道你的电话，但是还是等于没有联系方式，所以也就说明无关系。是一个单向合并。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

const int N = 55;
int fa[N];

int find(int x)
{
    return (fa[x] == x ? x : find(fa[x]));
}

void merge(int x, int y)
{
    fa[find(x)] = find(y);
}

int main()
{
    int n, m;
    cin >> n >> m;
    for (int i = 1; i <= n; i++)
    {
        fa[i] = i;
    }
    while (m--)
    {
        int a, b;
        cin >> a >> b;
        //唯一变式，必须是学生拥有老师的号码
        //所以当老师知道学生号码时不能使得两人连通
        //所以当a为老师时跳过
        if (a != n)
            merge(a, b);
    }
    if (find(1) == find(n))
        cout << "Yes" << endl;
    else
        cout << "No" << endl;
    system("pause");
    return 0;
}
```

