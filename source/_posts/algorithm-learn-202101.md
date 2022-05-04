---
title: 刷题日志--2021年01月
comments: false
top: false
date: 2021-01-24 16:04:12
tags: [算法]
categories: 
	- [刷题日志]
headimg: https://langwenchong.gitee.io/figure-bed/20220124165001.png
---

本系列记录翀翀😐痛苦的刷题日志，坚持刷题谈起来容易做起来难，希望我可以坚持下去，这里仍然分享一段励志文案：每个人都有梦想，然而有些人把梦想变成了现实，有些人的梦想依旧是梦想，只因为他们为梦想付出的努力程度不一样，他们坚持的时间不一样，最终才有这样的结果。

<!-- more -->

### NC22226-质数数量

#### 题目链接

https://ac.nowcoder.com/acm/problem/22226

#### 题目描述

给T个测试样例，每个测试样例输入一个数n，且保证1<=T<=1e8，1<=n<=1000000。答案给T个数，每个数表示为小于等于n的质数的总个数。

#### 测试样例

输入

```c
2  
10 
1000000 
```

输出

```c
4
78498
```

#### 解题思路

时间卡的很死为1s，所以暴力循环肯定是不行，这里尝试了埃氏筛法，即先默认所有的数是质数（那么其标志位vis[i]就是0），然后将所有最小质数的倍数全部标记为合数（那么其标志位vis[i]就是1了)。比如，2是质数，那么2的所有倍数例如4,6,8都不是质数了标记为合数，3是质数，那么3的所有倍数例如6,9,12就都不是质数了，所以检查从2开始。但是如果对于每一次测试样例n都重新打表仍然超时或者记录质数个数，所以需要一次性打满100000以内各个不同值所对应的小于等于他的质数总个数，即一次性打表并同时记录答案。

所以我们使用vis[1000000]和result[1000000]分别表示标志数组和答案数组，vis[i]为1那么就不是质数了，result[j]表示表示小于等于j的所有质数之和，因为这两个数组都很大，需要全局声明，否则会爆栈。同时sum用来记录质数总个数，也需要设置为全局变量较好，所有变量均只需要使用int声明即可。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;
int vis[1000001] = {0};
int result[1000001]={0};
int cnt=0;


int main()
{
    int T;
    cin >> T;
    // while (T--)暴力循环行不通
    // {
    //     int n;
    //     cin >> n;
    //     int sum = 0;
    //     for (int i = 2; i <= n; i++)
    //     {
    //         bool ok = true;
    //         for (int j = 2; j < i; j++)
    //         {
    //             if (i % j == 0)
    //             {
    //                 ok = false;
    //                 break;
    //             }
    //         }
    //         if (ok)
    //         {
    //             sum++;
    //         }
    //     }
    //     cout << sum << endl;
    // }
    memset(vis, 0, sizeof(vis));
    for (int i = 2; i <= 1000001; i++)
    {
        if (!vis[i])
        {
            cnt++;//打表的同时记录答案
            for (int j = 2*i; j <= 1000001; j += i)//埃氏筛核心代码
                vis[j] = 1;
        }
        result[i]=cnt;
    }
    while (T--)
    {
        int n;
        cin >> n;
        cout<<result[n]<<endl;//读表直接输出答案
    }
    system("pause");
    return 0;
}
```

### NC22231-蛇形矩阵

#### 题目链接

https://ac.nowcoder.com/acm/problem/22231

#### 题目描述

给出一个整数n，要输出一个n×n方阵，并且方阵的数值需要按照蛇形（一条龙）的形式输出。并且保证1<=N<=1000。

#### 测试样例

输入

```c
4
```

输出

```c
1 2 6 7
3 5 8 13
4 9 12 14
10 11 15 16
```

#### 解题思路

因为n很小，实际上只要暴力输出即可，我们这里主要是重点掌握输出蛇形的思路，我们这里以n=5为例进行规律寻找。我们先给出n=5的图：

![](https://langwenchong.gitee.io/figure-bed/20210130190235.png)

我们观察这个矩阵中各个数值在填写时的规律，首先我们不难看出对于在斜着的第i行就要填入i个数：

![](https://langwenchong.gitee.io/figure-bed/20210130190535.png)

并且无论是对于对角线以上的左半部分还是对角线以下的右半部分都有如下规律

4（3,1）->5（2,2）->6（1,3），即这一行填写完成后行数和列数刚好换了位置，无论是斜向上填写还是斜向下填写，再比如第四行的填写：

7（1,4）->8（2,3）->9（3,2）->10（4,1）

并且我们还发现了一个规律，假设row表示下一个数要填的行数值，col表示列数值，那么：

- 当这斜行刚开始填写时row<col，那么每次填写一个数后row++,col--直至这斜行填写完
- 当这斜行刚开始填写时row>col，那么每次填写一个数后row--,col++直至这斜行填写完

唯一有区别的是对于左上半部分，当填写一斜行该换行时，是max{row,col}++，而对于右下半部分，当填写完一斜行该换行时，是min{row,col}++。当row=col=n时就填写完这个矩阵了。所以我们可以声明两个方向向量[dir_x,dir_y]=[1,-1]表示向左下方填写的方向，用[dir_x,dir_y]=[-1,1]表示向右上方填写的方向。并且直接一次性打出1000的方阵，这样对于任何n，只需直接输出结果即可。

#### 解题代码

```c
#include <cstring>
#include <iostream>
using namespace std;
int main()
{
    int n;
    cin >> n;
    int matrix[1010][1010];
    memset(matrix, 0, sizeof matrix);
    int x = 2, y = 0;
    int dir_x = -1, dir_y = 1;
    int tmp = 0;
    for (int i = 1; i <= n; i++)
    {
        for (int j = 1; j <= i; j++)
        {
            x += dir_x;
            y += dir_y;
            matrix[x][y] = ++tmp;
        }
        if (dir_x == 1)
        {
            x += 2;
            y -= 1;
        }
        else
        {
            x -= 1;
            y += 2;
        }
        dir_x = -dir_x;
        dir_y = -dir_y;
    }
    if (n % 2 == 0)
    {
        x -= 1;
        y += 1;
    }
    else
    {
        x += 1;
        y -= 1;
    }

    for (int i = n - 1; i >= 1; i--)
    {
        for (int j = 1; j <= i; j++)
        {
            x += dir_x;
            y += dir_y;
            matrix[x][y] = ++tmp;
        }
        if (dir_x == 1)
        {
            x += 1;
        }
        else
        {
            y += 1;
        }
        dir_x = -dir_x;
        dir_y = -dir_y;
    }

    for (int i = 1; i <= n; i++)
    {
        for (int j = 1; j < n; j++)
            cout << matrix[i][j] << " ";

        cout << matrix[i][n] << endl;
    }
    system("pause");
    return 0;
}
```

### NC18951-两条斜线

#### 题目链接

https://ac.nowcoder.com/acm/problem/18951

#### 题目描述

平面上有N个点，用两个斜率分别为1和-1的斜线，尽可能的穿过更多的点，输出这个最大数量值。保证1<=N<=1000,0<=x[i],y[i]<=999。第一行是N，第二行是N个点的横坐标，第三行是N个点的纵坐标。

#### 测试样例

输入

```c
4
1 4 4 5
3 0 2 3
```

输出

```c
4
```

说明

```c
(1,3) (4,0) (4,2) (5,3)四个点都可以被经过
```

#### 解题思路

我们假设两个斜线分别是y=x+r1和y=-x+r2，我们每次都任取两个点分别求出r1,r2,然后统计在这两个斜线上的顶点的总数量，记录最大值。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

//假设y=x+r1,y=-x+r2
int main()
{
    int n;
    int sum = 0;
    cin >> n;
    int x[1000] = {};
    int y[1000] = {};
    int vis[1000] = {};
    for (int i = 0; i < n; i++)
    {
        cin >> x[i];
    }
    for (int i = 0; i < n; i++)
    {
        cin >> y[i];
    }
    int r1, r2;
    int tmp = 0;
    for (int i = 0; i < n; i++)
    {
        r1 = y[i] - x[i];
        //任取一个点计算出斜率为1的r1值
        for (int j = 0; j < n; j++)
        {
            tmp = 0;
            r2 = y[j] + x[j];
            //任取一个点计算出斜率为-1的r2值
            for (int k = 0; k < n; k++)
            {
                if (x[k] + y[k] == r2 || y[k] - x[k] == r1)
                {
                    //统计在这两条上的点
                    tmp++; 
                }
            }
            if (sum < tmp)
            {
                //记录最大值
                sum = tmp; 
            }
        }
    }
    cout << sum << endl;
    system("pause");
    return 0;
}
```

### NC21297-手机号码

#### 题目链接

https://ac.nowcoder.com/acm/problem/21297

#### 题目描述

第一行给出一个数字n和m，n表示一个电话号码的位数，m表示接下来给出的mg个号码前缀（注意，可能会出现1,12,123这样有重复的前缀)。接下来给出m行是m个号码前缀。

#### 测试样例

##### 样例1

输入

```c
7 3
0 
1
911
```

输出

```c
7990000
```

##### 样例2

输入

```c
10 3
0
1
911
```

输出

```c
7990000000
```

##### 样例3

输入

```c
8 3
1
12
123
```

输出

```c
90000000
```

##### 样例4

输入

```c
9 3
12
13
14
```

输出

```c
970000000
```

##### 样例5

输入

```c
3 1
411
```

输出

```c
999
```

#### 解题思路

我们知道实际上就是先默认有10\^n中情况（每一位都是0~9十个取值）。对于一个前缀为123长度为3，那么以123开头的情况(一共有10^(n-3)个情况)就都排除了，但是同时要完成去重1前缀和12前缀的这种情况即可。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;
int main()
{
    int n, m;
    cin >> n >> m;
    string a[55];
    int vis[55];                //1代表不是另一个前缀的一部分
    long long sum = pow(10, n); //一共有10^n个情况
    for (int i = 1; i <= m; i++)
    {
        cin >> a[i], vis[i] = 1;
    }
    for (int i = 1; i <= m; i++)
    {
        int s = a[i].size(); //前缀的长度
        for (int j = 1; j <= m; j++)
        //检验这个前缀是否是另一个前缀的一部分
        {
            //string的find函数，返还a[j]在a[i]的起始位置，没有则返还为-1
            int d = a[i].find(a[j]);
            if (d == 0 && i != j)
            {
                //是另一个前缀的一部分，比如1是12的前缀的一部分
                vis[i] = 0; //那么他就不是一个前缀了
                break;
            }
        }
        if (vis[i])
        {
            //如果是一个前缀，那么后面的所有情况都是符合前缀开头的，剪掉这种情况
            sum -= (long long)pow(10, n - s);
        }
    }
    cout << sum;
    return 0;
}
```



