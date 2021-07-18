---
title: 牛客网OJ题解--20210224
comments: false
top: false
date: 2021-02-24 14:13:34
tags: [算法,C++]
categories: 
	- [刷题日志]
---

本系列记录翀翀😐痛苦的刷题日志，所有题目均来自于牛客网OJ题目，坚持刷题谈起来容易做起来难，希望我可以坚持下去，这里仍然分享一段励志文案：每个人都有梦想，然而有些人把梦想变成了现实，有些人的梦想依旧是梦想，只因为他们为梦想付出的努力程度不一样，他们坚持的时间不一样，最终才有这样的结果。

<!-- more -->

### NC14370-入学考试

#### 题目链接

https://ac.nowcoder.com/acm/problem/14370

#### 题目描述

马云是个聪明的孩子，他想成为世界上最伟大的医师。所以他想拜附近最有威望的张丹成为师。医师为了判断他的资质，给他出了一个难题。医师把他带到一个到处都是草药的山洞里对他说：“孩子，这个山洞里有一些不同的草药，采每一株都需要一些时间，每一株也有它自身的价值。我会给你一段时间，在这段时间里，你可以采到一些草药。如果你是一个聪明的孩子，你应该可以让采到的草药的总价值最大。”如果你是马云，你能完成这个任务吗？（注：马云啥的是编的 。。）第一行有两个整数T（1 <= T <= 1000）和M（1 <= M <= 100），用一个空格隔开，T代表总共能够用来采药的时间，M代表山洞里的草药的数目。接下来的M行每行包括两个在1到100之间（包括1和100）的整数，分别表示采摘某株草药的时间和这株草药的价值。

第一行有两个整数T（1 <= T <= 1000）和M（1 <= M <= 100），用一个空格隔开，T代表总共能够用来采药的时间，M代表山洞里的草药的数目。接下来的M行每行包括两个在1到100之间（包括1和100）的整数，分别表示采摘某株草药的时间和这株草药的价值。

#### 测试样例

输入

```c
70 3
71 100
69 1
1 2
```

输出

```c
3
```

#### 解题思路

贪心和k-优化算法不好实现，典型的0/1背包动态规划板子题，如果使用二维数组请参考本篇文章[《动态规划》](https://wenchong.space/2020/11/22/dynamic-programming/)，但是这里又学习到了二维到一维数组优化的算法，请参考本篇文章《浅谈用一维数组dp解决0/1背包问题》。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

int f[1005], t[1005], v[105];

int T, n, i, j;
int main()
{
    cin >> T >> n;
    for (i = 1; i <= n; i++)
        cin >> t[i] >> v[i];
    //f[i]物品1~i范围选取
    for (i = 1; i <= n; i++)
        //注意，逆序是逆序的即背包容量从大到小，fot已经特判能否装入
        for (j = T; j >= t[i]; j--)
            //右边的都是第i-1次循环的结果
            f[j] = max(f[j], f[j - t[i]] + v[i]);
    cout << f[T] << endl;
    system("pause");
    return 0;
}
```

### NC14381-蝴蝶

#### 题目链接

https://ac.nowcoder.com/acm/contest/profile/126727419/practice-coding

#### 题目描述

给定一个 n*m 的矩阵，矩阵元素由X和O构成，请求出其中最大的蝴蝶形状。
 蝴蝶形状的定义如下：
存在一个中心点（必须为X），并且其往左上（必须为X）、左下（必须为X）、右上（必须为O）、右下（必须为O）四个方向扩展相同的长度，且左上顶点与左下顶点之间全由X填充，右上顶点与右下顶点之间全由O填充。我们不在意在蝴蝶形状内部是X还是O。例如：

<img src="https://gitee.com/Langwenchong/figure-bed/raw/master/20210224142311.png" style="zoom:200%;" />

是一个蝴蝶形状（其中A表示X或O）。并且X是大小为1的蝴蝶。而、

<img src="https://gitee.com/Langwenchong/figure-bed/raw/master/20210224142438.png" style="zoom:200%;" />

不是（不存在中心点）。

第一行两个整数n, m表示矩阵的大小 (1 <= n, m <= 500)，接下来 n 行，每行一个长度为 m 的字符串表示矩阵，矩阵元素保证由X和O构成。一行一个整数表示最大的蝴蝶形状的对角线的长度。

#### 测试样例

输入

```c
5 5
XOOOO
XXOOO
XOXOO
XXOOO
XOOOO
```

输出

```c
5
```

#### 解题思路

该死，这题一开始读错题意了。一定要注意他要求的是顶点之间的字符必须相同，即如样例1的蝴蝶左上角顶点和左下角顶点之间也要都为X，右上角顶点和右下角顶点也要为O才可以。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210224142833.png)

即红色线部分要满足左半部分全是X，右半部分全是O，同时蓝线的左半部分要全部是X，右半部分全是O。我们只需要先逐一枚举中心点，如果满足中心点为X，那么沿四个方向延伸检验是否红色线满足题意，如果满足再检验蓝色线部分是否满足。最会取得最大值的情况就可以了。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;
typedef long long ll;

char Map[505][505];
int n, m;

bool flag(int x, int y)
{
    //检验是否越界的函数
    if (x >= 0 && x < n && y >= 0 && y < m)
        return 1;
    else
        return 0;
}

int main()
{

    cin >> n >> m;
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < m; j++)
            cin >> Map[i][j];
    }
    int ans = 0;
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < m; j++)
        {
            //因为是四个方向检查，所以需要四个方向临时点
            int x1, y1, x2, y2, x3, y3, x4, y4;
            //寻找中心点
            if (Map[i][j] != 'X')
                continue;
            ans = max(ans, 1);
            for (int len = 1; len <= min(n, m) / 2; len++)
            {
                int valid = 1;
                //算出四个方向的从中心点移动后的顶点位置
                x1 = i - len;
                y1 = j - len;
                x2 = i + len;
                y2 = j - len;
                x3 = i - len;
                y3 = j + len;
                x4 = i + len;
                y4 = j + len;
                //检验是否越界
                if (flag(x1, y1) && flag(x2, y2) && flag(x3, y3) && flag(x4, y4))
                {
                    //如果都不越界，那么检验顶点值是否满足题意
                    if (Map[x1][y1] == 'X' && Map[x2][y2] == 'X' && Map[x3][y3] == 'O' && Map[x4][y4] == 'O')
                    {
                        //满足以后分别检验顶点中间的值是否满足题意
                        for (int l = x1; l <= x2; l++)
                        {
                            if (Map[l][y1] != 'X')
                            {
                                valid = 0;
                                break;
                            }
                        }
                        for (int l = x3; l <= x4; l++)
                        {
                            if (Map[l][y3] != 'O')
                            {
                                valid = 0;
                                break;
                            }
                        }
                        //满足题意就为斜边长的2倍再+1（因为有一个中心点)
                        if (valid)
                            ans = max(ans, len * 2 + 1);
                    }
                    else
                        break;
                }
                else
                    break;
            }
        }
    }
    cout << ans << endl;
    system("pause");
    return 0;
}
```

