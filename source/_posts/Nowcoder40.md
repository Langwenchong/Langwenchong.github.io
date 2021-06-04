---
title: 牛客网OJ题解--20210319
comments: false
top: false
date: 2021-03-19 22:47:24
tags: [算法,C++]
categories: 算法导论
---

本系列记录翀翀😐痛苦的刷题日志，所有题目均来自于牛客网OJ题目，坚持刷题谈起来容易做起来难，希望我可以坚持下去，这里仍然分享一段励志文案：每个人都有梦想，然而有些人把梦想变成了现实，有些人的梦想依旧是梦想，只因为他们为梦想付出的努力程度不一样，他们坚持的时间不一样，最终才有这样的结果。

<!-- more -->

### NC14721-装进肚子

#### 题目链接

https://ac.nowcoder.com/acm/problem/14721

#### 题目描述

自从ZZZZone吃完糖果后，他开始改吃巧克力了，他每天想吃n个巧克力增在甜蜜值，他决定早上吃K个巧克力，晚上吃n - K个巧克力，每个巧克力在早上吃和在晚上吃的甜蜜值是不一样的，他想让自己得到的甜蜜值最大，并想知道最大是多少。  请你编程帮助他。

第一行包含两个数n，K表示每天要吃的巧克力数量和要在早上吃的数量。（n <= 100000, K <= n)
第二行包含n个整数Ai（1 <= i <= n) 表示个第i个巧克力在早上吃可得到的甜蜜值 (Ai <= 100000)
第三行包含n个整数Bi（1 <= i <= n) 表示个第i个巧克力在晚上吃可得到的甜蜜值 (Bi <= 100000)。

输出仅一行包含一个整数表示ZZZZone能获得的最大甜蜜值。

#### 测试样例

输入

```c
2 1
3 6
2 8
```

输出

```c
11
```

说明

```c
早上吃第一个巧克力得到3甜蜜值，晚上吃第2个巧克力得到8的甜蜜值，所以最大可得到11的甜蜜值。
```

#### 解题思路

实际上是一个贪心思想，先全部按照晚上的甜度吃，然后求得早上的甜度和晚上的甜度的差值（分正负），然后将差值从大到小排序，每次都加上早上的甜度比晚上甜度多出来的值。

#### 解题代码

```c
#include <bits/stdc++.h>

#define ll long long
using namespace std;
const int N = 1e5 + 5;
int m[N], e[N];
int c[N];

bool cmp(int a, int b)
{
    return a > b;
}
int main()
{
    ll n, k;
    cin >> n >> k;
    ll i;
    ll ans = 0;
    for (i = 1; i <= n; ++i)
        //存入早上的甜度
        cin >> m[i];
    for (i = 1; i <= n; ++i)
    {
        //存入晚上的甜度
        cin >> e[i];
        //默认都吃晚上的
        ans += e[i];
        c[i] = m[i] - e[i];
    }
    //将早晚甜度差值最大的从大到小排序
    sort(c + 1, c + n + 1, cmp);
    //有k个早上的可以甜度更大
    for (i = 1; i <= k; ++i)
    {
        ans += c[i];
    }
    cout << ans << endl;
    system("pause");
    return 0;
}
```

### NC219109-Pegasus Circle Shortcut

#### 题目链接

https://ac.nowcoder.com/acm/problem/219109

#### 题目描述

For the UCF High School Programming Tournament, the judges were located in the Engineering building, and most of the teams were in the Classroom building, which is on the other side of Pegasus Circle.

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210320000703.png)

Chris was walking to the Classroom building for the first time, and was joined by Jeremy, who had made the hike a couple of times already.  

  “Jeremy, is it faster to stay on the circle, or to cut through the middle using the boardwalks that go to the Student Union?” asked Chris.  

  “I don’t know.” Jeremy answered. “I think it’s about the same, but it might be slightly faster to use the walkways.”  

  “Well, if it’s about the same, let’s stick to the circle. I don’t want to be attacked by squirrels.”

Given two points on a circle, and two paths to get from one to the other—one following the perimeter of the circle, and the other by a sequence of connected straight line segments through the interior of the circle—determine the shorter of the two paths.

The input will contain multiple test cases, each consisting of two lines. The first line of each testcase contains six floating-point numbers:xc,yc,xs,ys,xf, andyf, where (xc,yc) is the center point of the circle, (xs,ys) is the start point for both paths (e.g., the Engineering building), and (xf,yf) is the finish point for both paths (e.g., the Classroom building).The circle will always have a radius greater than 1, and the start and finish points are both guaranteed to be at distinct pointson its perimeter, with an accuracy of at least 3 placesafter the decimal.The path along the perimeter is always in the directioncounter-clockwise around the circle.



The second line of each test case will start with an integer,n(1≤n≤ 10), followed by n pairs of floating-point numbers,x1,y1,x2,y2, …xn, and yn, where each pair (xi,yi) is a point inside the circle. The interior path traveled will be from point (xs,ys) to point (x1,y1), then from (x1,y1) to (x2,y2), then from (x2,y2) to (x3,y3), …, then from (xn,yn) to (xf,yf).

The last test case will be followed by a line containing six zeros. All numbers on an input line will beseparated from each other by one space, with no extra spaces at the beginning or end of lines. Assumethat all the input floating point numbers will be less than 1000.0 and greater than

-1000.0, with at most 6 places after the decimal.

For each test case in the input, output a line in either the format

Case #n:Stick to the Circle.

if the perimeter path is shorter,or

Case #n:Watch out for squirrels!

if the interior pathis shorter, where n is the num berof the input test case, starting at 1.

Assume that the two paths will not be equal, i.e., it is guaranteed that the two distances will not be equal. In particular, assume that the two paths will differ in length by 0.001 or more.Leave a blank line after the output for each test case.

#### 测试样例

输入

```c
5.0 5.0 10.0 5.0 5.0 10.0
6 8.5 4.7 6.9 5.0 3.6 6.5 4.2 7.1 4.2 8.3 4.7 8.8
2.0 8.0 0.5 16.87412 7.5 0.8761
2 3.25 9.25 7.0 7.0
0 0 0 0 0 0
```

输出

```c
Case #1: Stick to the Circle.

Case #2: Watch out for squirrels!
```

#### 解题思路

实际上就是求折线和逆时针旋转得到的圆弧长度那个更小，半径已经给出，只要在求得弧度角就可以求弧长了，很明显使用向量点积公式求弧度角。然后折线长度就是不断的取两个点坐标求斜边长度即可。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

int main()
{
    int t = 0;
    double x0, x1, x2, y0, y1, y2;
    while (cin >> x0)
    {
        cin >> y0 >> x1 >> y1 >> x2 >> y2;
        if (x0 == 0 && !x1 && !x2 && !y1 && !y0 && !y2)
            break;
        t++;
        double r = sqrt((x0 - x1) * (x0 - x1) + (y0 - y1) * (y0 - y1));
        double ans1 = r * acos(((x1 - x0) * (x2 - x0) + (y1 - y0) * (y2 - y0)) / (r * r)); //求弧长公式
        double a = x1, b = y1, c, d, ans2 = 0;
        int n;
        cin >> n;
        for (int i = 1; i <= n; i++)
        {
            cin >> c >> d;
            ans2 += sqrt((a - c) * (a - c) + (b - d) * (b - d));
            a = c, b = d;
        }
        ans2 += sqrt((a - x2) * (a - x2) + (b - y2) * (b - y2));
        cout << "Case #" << t << ": ";
        if (ans1 < ans2)
            cout << "Stick to the Circle."
                 << "\n\n";
        else
            cout << "Watch out for squirrels!"
                 << "\n\n";
    }
    system("pause");
    return 0;
}
```

