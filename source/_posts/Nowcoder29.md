---
title: 牛客网OJ题解--20210306
comments: false
top: false
date: 2021-03-06 17:57:26
tags: [算法,C++]
categories: 算法导论
---

本系列记录翀翀😐痛苦的刷题日志，所有题目均来自于牛客网OJ题目，坚持刷题谈起来容易做起来难，希望我可以坚持下去，这里仍然分享一段励志文案：每个人都有梦想，然而有些人把梦想变成了现实，有些人的梦想依旧是梦想，只因为他们为梦想付出的努力程度不一样，他们坚持的时间不一样，最终才有这样的结果。

<!-- more -->

### NC14556-数圈圈

#### 题目链接

https://ac.nowcoder.com/acm/problem/14556

#### 题目描述

tabris有一个习惯，无聊的时候就会数圈圈，无论数字还是字母。 现在tabris更无聊啦，晚上睡不着觉就开始数羊，从a只数到b只。 顺便还数了a到b之间有多少个圈。 但是tabris笨啊，虽然数羊不会数错，但很可能数错圈的个数。但是tabris很难接受自己笨这个事实，所以想问问你他一共应该数出多少个圈，这样tabris才好判断他到底笨不笨啊。 

输入一个T，表示数据组数，每组测试数据包含两个正整数a，b。T∈[1,50]a,b∈[1,106]

#### 测试样例

输入

```c
11
1 1
2 2
3 3
4 4
5 5
6 6
7 7
8 8
9 9
10 10
1 100
```

输出

```c
0
0
0
1
0
1
0
2
1
1
111
```

#### 解题思路

水题，主要就是一个取位的问题，可以采用字符也可以模10的方法。但是这道题我用字符会超时，不知道为什么。。。

#### 解题代码

```c
// #include <bits/stdc++.h>
// using namespace std;

// #define ll long long

// ll judge(ll x)
// {
//     ll num = 0;
//     string s = to_string(x);
//     cout << s << endl;
//     for (ll i = 0; i < s.length(); i++)
//     {
//         if (s[i] == '0' || s[i] == '4' || s[i] == '6' || s[i] == '9')
//             num++;
//         if (s[i] == '8')
//             num += 2;
//     }
//     return num;
// }

// int main()
// {
//     ll T;
//     cin >> T;
//     while (T--)
//     {
//         ll a, b;
//         cin >> a >> b;
//         ll ans = 0;
//         for (ll i = a; i <= b; i++)
//         {
//             ans += judge(i);
//         }
//         cout << ans << endl;
//     }
//     system("pause");
//     return 0;
// }

#include <iostream>
using namespace std;
int main()
{
    int t;
    cin >> t;
    for (int i = 0; i < t; i++)
    {
        int a, b;
        cin >> a >> b;
        int sum = 0;
        for (int j = a; j <= b; j++)
        {
            int temp = j;
            while (temp != 0)
            {
                int ans = temp % 10;
                if (ans == 4 || ans == 6 || ans == 9 || ans == 0)
                    sum++;
                else if (ans == 8)
                    sum = sum + 2;
                temp = temp / 10;
            }
        }
        cout << sum << endl;
    }

    system("pause");
    return 0;
}
```

### NC14619-栗酱的异或和

#### 题目链接

https://ac.nowcoder.com/acm/problem/14619

#### 题目描述

栗酱特别喜欢玩石子游戏，就是两个人玩，有n堆石子，每堆有ai个，每次一个人可以轮流选择任意一堆，取走任意多的石子（但不能不取），谁先不能取谁输。栗酱觉得这个游戏很有趣，知道有一天，小太阳告诉她，其实如果两个人足够聪明，游戏的结局一开始就已经注定。栗酱是一个冰雪聪明的女孩子，她不相信，希望你演示给她看。
多组数据，数据第一行T表示数据组数。每组数据第一行一个n，k表示一共有n堆石子，接下来你试图从第k堆开始取，从第二行开始，每隔一个空格一个第i堆石子的数量ai。
n≤105, ai≤109。输出“Yes”或“No”代表从该堆开始取是否可以必胜（如果足够聪明）。

#### 测试样例

输入

```c
2
3 2
1 2 3
2 1
2 1
```

输出

```c
No
Yes
```

说明

```c
小太阳哥哥说，如果想赢，就试图把每堆石子数量的异或和变为0，最终便可以获得胜利，不相信自己证一下。小数据较多，不要使用memset，可能导致TLE。
```

#### 解题思路

nim游戏变式题，可以食用本篇博客《浅谈nim游戏问题》。其实我们可以参考说明一样可以解题。就是如果我们先计算一下除了第k堆以外的石子数量sum，然后我们如果想让对面输，那么就需要给他留下一个石子数量异或和为0的局面，这样他先手就必定输了。但是如果我们没能够一步将这个局面制造给他，那么他就会给我们制造异或0的局面，那么我们在拿石子就必定输了。所以胜负主要关键取决于我们能否先手第一步就制造异或0的局面，所以也就要求我们要拿a个石子，使得a[k]-a^sum=0即a[k]-a和sum数相同，所以a=a[k]-sum，但是a>=0,所以还要保证a[k]>=sum，否则我们就不能一次性给对手制造必输局面。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

const int N = 2e6 + 10;
int a[N];
int main()
{
    int t;
    cin >> t;
    while (t--)
    {
        int n, k;
        cin >> n >> k;
        int sum = 0;
        for (int i = 1; i <= n; i++)
        {
            cin >> a[i];
            if (i == k)
                continue;
            sum ^= a[i];
        }
        if (sum >= a[k])
            cout << "No" << endl;
        else
            cout << "Yes" << endl;
    }
    system("pause");
    return 0;
}
```

