---
title: 牛客网OJ题解--20210225
comments: false
top: false
date: 2021-02-25 11:51:38
tags: [算法,C++]
categories: 
	- [刷题日志]
---

本系列记录翀翀😐痛苦的刷题日志，所有题目均来自于牛客网OJ题目，坚持刷题谈起来容易做起来难，希望我可以坚持下去，这里仍然分享一段励志文案：每个人都有梦想，然而有些人把梦想变成了现实，有些人的梦想依旧是梦想，只因为他们为梦想付出的努力程度不一样，他们坚持的时间不一样，最终才有这样的结果。

<!-- more -->

### NC14386-水仙花数

#### 题目链接

https://ac.nowcoder.com/acm/problem/14386

#### 题目描述

水仙花数是指一个N位正整数（N≥3），它的每个位上的数字的N次幂之和等于它本身。例如：
$$
153=1^3+5^3+3^3
$$

$$
8208=8^4+2^4+0^4+8^4
$$

这道题请写出程序判断输入的数是否为水仙花数。首先输入正整数 n，表示需要判断的数的个数 (1<=n<=100)。随后每一行输入一个数 Ai，对于每次输入判断 Ai 是否为水仙花数。每次判断 Ai 输出判断结果：如果是，输出 yes；否则输出 no

#### 测试样例

输入

```c
3
111
153
222
```

输出

```c
no
yes
no
```

说明

```
111不是水仙花数，输出no，153是水仙花数，输出yes，222不是水仙花数，输出no
```

#### 解题思路

两个思路，一个是存为整型，然后不断地模10取最后一位即可，还有一种思路是存为字符串，这样我们可以直接调用size()函数获得幂数。但是这样最终比较时需要将整型结果转换为字符串。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

int main()
{
    int n;
    cin >> n;
    while (n--)
    {
        string num;
        cin >> num;
        int len = num.size();
        int ans = 0;
        for (int i = 0; i < len; i++)
        {
            ans = ans + pow(num[i] - '0', len);
            //自己在本地vscode上测试153居然会输出No!
            // cout << "pow:" << pow(num[i] - '0', len) << endl;
            // cout << ans << endl;
        }
        string s = to_string(ans);
        if (s == num)
            cout << "yes" << endl;
        else
            cout << "no" << endl;
    }
    system("pause");
    return 0;
}
```

### NC14399-素数判断

#### 题目链接

https://ac.nowcoder.com/acm/problem/14399

#### 题目描述

给出一个数x，判断它是否为素数，并输出所有它的素因子。第1行输入组数T，代表有T组数据。第2-T+1行输入一个数x。数据保证：2≤x≤109。每行输出两行，对应输入行的结果。第1行，如果x是素数，输出“isprime”（不含双引号），否则输出“noprime”（不含双引号）。第2行，输出x的素因子。

#### 测试样例

输入

```c
3
2
9
10
```

输出

```c
isprime
2
noprime
3
noprime
2 5
```

#### 解题思路

这里记录一下解题方法，是一个快速寻找质因子的方法。就是从2到根号x注意枚举除数，那么对于除数i满足x%i==0一定是质因子（注意必须是保证从小到大找），然后x不断除i直至不能整除，这样就可以保证下一个找到的因子一定还是质因子。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

int main()
{
    int T;
    cin >> T;
    int x;
    while (T--)
    {
        cin >> x;
        bool flag = true;
        vector<int> ans;
        //i从2到根号x枚举检验
        int n = sqrt(x);
        for (int i = 2; i <= n; ++i)
        {
            //如果当前的最小i是因子，那么就一定是质因子
            if (x % i == 0)
            {
                flag = false;
                ans.push_back(i);
                //关键步骤，循环除去i，这样保证下一个因子仍然是质因子
                while (x % i == 0)
                    x /= i;
            }
            //退出代码，不要忘记
            if (x == 1)
                break;
        }
        if (flag)
        {
            cout << "isprime" << endl;
            cout << x << endl;
        }
        else
        {
            cout << "noprime" << endl;
            for (int i = 0; i < ans.size() - 1; ++i)
            {
                cout << ans[i] << " ";
            }
            cout << ans.back();
            if (x != 1)
                //注意最后一个质因子没有存到答案数组中
                //比如10，那么i从2到根号10
                //i无法检验到5，所以10/2=5最后一个质因子5还赋值在x上，未存储到答案数组中
                cout << " " << x;
            cout << endl;
        }
    }
    system("pause");
    return 0;
}
```

