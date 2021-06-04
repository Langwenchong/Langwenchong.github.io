---
title: 牛客网OJ题解--20210307
comments: false
top: false
date: 2021-03-07 15:46:01
tags: [算法,C++]
categories: 算法导论
---

本系列记录翀翀😐痛苦的刷题日志，所有题目均来自于牛客网OJ题目，坚持刷题谈起来容易做起来难，希望我可以坚持下去，这里仍然分享一段励志文案：每个人都有梦想，然而有些人把梦想变成了现实，有些人的梦想依旧是梦想，只因为他们为梦想付出的努力程度不一样，他们坚持的时间不一样，最终才有这样的结果。

<!-- more -->

### NC14712-打车

#### 题目链接

https://ac.nowcoder.com/acm/problem/14712

#### 题目描述

妞妞参加完Google Girl Hackathon之后,打车回到了牛家庄。 妞妞需要支付给出租车司机车费s元。妞妞身上一共有n个硬币，第i个硬币价值为p[i]元。 妞妞想选择尽量多的硬币，使其总价值足以支付s元车费(即大于等于s)。 但是如果从妞妞支付的这些硬币中移除一个或者多个硬币，剩下的硬币总价值还是足以支付车费的话，出租车司机是不会接受的。例如: 妞妞使用价值为2，5，7的硬币去支付s=11的车费,出租车司机是不会接受的，因为价值为2这个硬币是可以移除的。妞妞希望能选取最大数量的硬币，使其总价值足以支付车费并且出租车司机能接受。 妞妞希望你能帮她计算最多可以支付多少个硬币。

输入包括两行, 第一行包括两个正整数n和s(1 <= n <= 10, 1 <= s <= 1000), 表示妞妞的硬币个数和需要支付的车费。第二行包括n个正整数p[i] (1 <= p[i] <= 100)，表示第i个硬币的价值。保证妞妞的n个硬币价值总和是大于等于s。输出一个整数, 表示妞妞最多可以支付的硬币个数。

#### 测试样例

输入

```c
5 9
4 1 3 5 4
```

输出

```c
3
```

#### 解题思路

实际上就是寻找必须用的硬币，我们从大的到小的一个个检验即可，这样就可以避免有多余的可有可无的硬币了。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;
int a[1005];
int main()
{
    int n, sum = 0, s, ans;
    cin >> n >> s;
    ans = n;
    for (int i = 1; i <= n; i++)
    {
        cin >> a[i];
        sum += a[i];
    }
    sort(a + 1, a + 1 + n);
    //其实就是寻找必须要的硬币
    for (int i = n; i >= 1; i--)
        if (sum - a[i] >= s)
            //说明第i个硬币不是必须的硬币
            ans--, sum -= a[i];
    cout << ans << endl;
    system("pause");
    return 0;
}
```

### vjudge102966G-Goombas Colliding

####  题目链接

https://vjudge.net/problem/Gym-102966G

#### 题目描述

Atsa just bought Super Mario Maker and wants to test your skills for an analysis with a level that he prepared.

That level consists of a platform with some Goombas in it. As you know, Goombas are characters with the following behavior:

- Initially, they point in one direction, (left: 0, right: 1).
- They move in the direction they are currently facing, as long as there are no obstacles.
- If two Goombas collide, they will flip their direction inmediately.
- When a Goomba reaches one end of the platform, it falls.

The platform is LL blocks long, extending from the coordinate 00, to LL. Above it, there will be GG Goombas. The i−thi−th Goomba will be located at pipi facing to the direction didi. All Goombas will advance with a speed of 11 block per second.

Atsa wants you to tell him how many seconds it will take for the platform to be empty.

For this problem purposes, consider the size of a Goomba to be a single point. No two Goombas will share the same initial xx coordinate.

The first line of the input contains two integers LL (2≤L≤1016)(2≤L≤1016) and GG (1≤G≤104)(1≤G≤104).

Each of the following GG lines contains two integers pipi (0<pi<L)(0<pi<L) and didi (di∈{0,1})(di∈{0,1}).

The time in seconds that must pass for the platform to be empty.

#### 测试样例

##### 样例1

输入

```c
3 2
1 1
2 0
```

输出

```c
2
```

##### 样例2

输入

```c
5 2
1 0
2 1
```

输出

```c
3
```

#### 解题思路

实际上这道题就迷惑人，什么换不换方向。我们假设有两个傻瓜A和B对着方向走，那么如下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210307155942.png)

实际上可以发现还是总体上距离不变的，所以对于向左走的他用的时间就是x,向右走的就是l-x。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;
typedef long long ll;

signed main()
{
    ios::sync_with_stdio(false), cin.tie(0);
    int l, n;
    while (cin >> l >> n)
    {
        int ans = 0;
        for (int i = 1; i <= n; ++i)
        {
            int x, y;
            cin >> x >> y;
            if (y == 0)
                //记录向左走的距离值
                ans = max(ans, x);
            else
                //向右走的距离值
                ans = max(ans, l - x);
        }
        //取最大值即可
        cout << ans << endl;
    }
    system("pause");
    return 0;
}
```

