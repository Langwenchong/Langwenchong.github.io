---
title: 牛客网OJ题解--20210219
comments: false
top: false
date: 2021-02-19 17:24:36
tags: [算法,C++]
categories: 
	- [刷题日志]
---

本系列记录翀翀😐痛苦的刷题日志，所有题目均来自于牛客网OJ题目，坚持刷题谈起来容易做起来难，希望我可以坚持下去，这里仍然分享一段励志文案：每个人都有梦想，然而有些人把梦想变成了现实，有些人的梦想依旧是梦想，只因为他们为梦想付出的努力程度不一样，他们坚持的时间不一样，最终才有这样的结果。

<!-- more -->

### NC16661-火星人

#### 题目链接

https://ac.nowcoder.com/acm/problem/16661

#### 题目描述

人类终于登上了火星的土地并且见到了神秘的火星人。人类和火星人都无法理解对方的语言，但是我们的科学家发明了一种用数字交流的方法。这种交流方法是这样的，首先，火星人把一个非常大的数字告诉人类科学家，科学家破解这个数字的含义后，再把一个很小的数字加到这个大数上面，把结果告诉火星人，作为人类的回答。 火星人用一种非常简单的方式来表示数字——掰手指。火星人只有一只手，但这只手上有成千上万的手指，这些手指排成一列，分别编号为1，2，3……。火星人的任意两根手指都能随意交换位置，他们就是通过这方法计数的。 一个火星人用一个人类的手演示了如何用手指计数。如果把五根手指——拇指、食指、中指、无名指和小指分别编号为1，2，3，4和5，当它们按正常顺序排列时，形成了5位数12345，当你交换无名指和小指的位置时，会形成5位数12354，当你把五个手指的顺序完全颠倒时，会形成54321，在所有能够形成的120个5位数中，12345最小，它表示1；12354第二小，它表示2；54321最大，它表示120。下表展示了只有3根手指时能够形成的6个3位数和它们代表的数字： 

  三进制数  

   123  

   132  

   213  

   231  

   312  

   321  

  代表的数字  

   1  

   2  

   3  

   4  

   5  

   6  

 现在你有幸成为了第一个和火星人交流的地球人。一个火星人会让你看他的手指，科学家会告诉你要加上去的很小的数。你的任务是，把火星人用手指表示的数与科学家告诉你的数相加，并根据相加的结果改变火星人手指的排列顺序。输入数据保证这个结果不会超出火星人手指能表示的范围。

第一行有一个正整数N，表示火星人手指的数目（1 <= N <= 10000）。
第二行是一个正整数M，表示要加上去的小整数（1 <= M <= 100）。
下一行是1到N这N个整数的一个排列，用空格隔开，表示火星人手指的排列顺序。

我们要输出外星人的手指编号顺序。

#### 测试样例

输入

```c
5
3
1 2 3 4 5
```

输出

```c
1 2 4 5 3
```

#### 解题思路

实际上我们就是要在已经给出的外星人表示的数编号基础上，进行m次全排列，输出字典序中更靠后的m位的数的编号，我们可以调用next_permutation()函数进行字典序全排列。这个函数时每次调用将字符数组进行一次顺序重新排列为下一个字典组合。我们只需要调用m次即可。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

int main()
{
    int n, m;
    cin >> n >> m;
    int a[n];
    //获取火星人的手指排列顺序
    for (int i = 0; i < n; i++)
    {
        cin >> a[i];
    }
    //m次全排列后就是要输出的结果（就是字典序排列）
    for (int i = 0; i < m; i++)
    {
        next_permutation(a, a + n);
    }
    //输出结果
    for (int i = 0; i < n; i++)
    {
        cout << a[i] << " ";
    }
    cout << endl;
    system("pause");
    return 0;
}
```

### NC16642-Hanoi双塔问题

#### 题目链接

https://ac.nowcoder.com/acm/problem/16642

#### 题目描述

给定A、B、C三根足够长的细柱，在A柱上放有2n个中间有孔的圆盘，共有n个不同的尺寸，每个尺寸都有两个相同的圆盘，注意这两个圆盘是不加区分的（下图为n=3的情形）。现要将这些圆盘移到C柱上，在移动过程中可放在B柱上暂存。要求：
（1）每次只能移动一个圆盘；
（2）A、B、C三根细柱上的圆盘都要保持上小下大的顺序；

  任务：设An为2n个圆盘完成上述任务所需的最少移动次数，对于输入的n，输出An。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210219173216.png)

输入一个正整数n，表示在A柱上放有2n个圆盘。输出最少的移动次数。

#### 测试样例

##### 样例1

输入

```c
1
```

输出

```c
2
```

##### 样例2

输入

```c
2
```

输出

```c
6
```

#### 解题思路

实际上这就是移到汉诺塔的变式题+大数运算模拟。我们先来讲解一下汉诺塔问题。

##### 汉诺塔问题

假设现在有n个盘子从高到低从小到大排列在A，我们要移动到C，且还有一个辅助柱子B，那么很明显我们只需要先将前n-1个盘子移动到B，再将第n个盘子移动到C，然后再将前n-1个盘子从B移动到C，依次递归，直到只剩下一个盘子时，那么直接将它从A移动到B即可。伪代码如下：

```c
Function Hanoi(n,a,b,c)
    if n==1 then
        //如果就一个盘子就直接移动到C即可
        print(a+'->'+c)
    else
        //否则前n-1个先借助C移动到B
        Hanoi(n-1,a,c,b)
        //第n个盘子移动到C
        print(a+'->'+c)
        //前n-1个盘子从B移动到C，此时B看成原先的A，A看成原先的辅助柱子
        Hanoi(n-1,b,a,c)
    end if
end Function 
```

所以我们就得到了如下的递推式：
$$
\begin{cases}a_1=1\\a_n=a_{n-1}+1+a_{n-1}=2a_{n-1}+1\end{cases}
$$
这就是一个等比数列的递推式我们可以将它转换一下：
$$
a_n+1=2a_{n-1}+2=2(a_{n-1}+1)
$$

$$
设c_n=a_n+1
$$

$$
c_n=2c_{n-1}
$$

$$
c_n=c_1*2^{n-1}=2*2^{n-1}=2^n
$$

$$
所以a_n=2^n-1
$$

所以我们就得到了对于n个盘子时汉诺塔的最少移动次数的规律。[点这里看讲解视频](https://www.bilibili.com/video/BV1Hk4y1k7KL?from=search&seid=12741831933281164469)

##### 本题推导

那么此题只不过是变成了每一种大小的盘子有两个，所以每次都是移动一对。我们也不难推导出如下规律：
$$
\begin{cases}a_1=2\\a_n=a_{n-1}+2+a_{n-1}=2a_{n-1}+2\end{cases}
$$
所以可以推出an的等比通项公式是
$$
所以a_n=2^{n+1}-2
$$
那么接下来我们就是带入n即可，但是发现n最大是200，而long long int只能表示2^64-1，超范围了，所以我们使用大数模拟，这里套用了大佬的板子，使用的是重载运算符，使用模10来模拟大数高精度运算（也有的板子使用的是字符串）。这样我们就可以输出结果了。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

//大数运算模拟，摘自https://ac.nowcoder.com/acm/contest/profile/827921411大佬
void trunc_zero(vector<int> &num)
{
    while (num.empty() == false && num.back() == 0)
    {
        num.pop_back();
    }
}

class Big_uint
{
    friend ostream &operator<<(ostream &os, Big_uint const &a);
    vector<int> digits;

public:
    Big_uint(string const &str)
    {
        digits.resize(str.size());
        auto i = digits.begin();
        auto ed = digits.end();
        auto j = str.rbegin();
        while (i != ed)
        {
            *i++ = *j++ - '0';
        }
    }
    Big_uint(vector<int> &&n) : digits(n) {}

    Big_uint operator*(int const a) const
    {
        vector<int> num(digits.size() + 10, 0);
        size_t i = 0;
        for (; i < digits.size(); ++i)
        {
            num[i] += digits[i] * a;
            if (num[i] >= 10)
            {
                num[i + 1] += num[i] / 10;
                num[i] %= 10;
            }
        }
        while (num[i] >= 10)
        {
            num[i + 1] += num[i] / 10;
            num[i] %= 10;
            ++i;
        }
        trunc_zero(num);
        return {std::move(num)};
    }
    Big_uint &operator-=(int const a)
    {
        digits[0] -= a;
        size_t i = 0;
        while (digits[i] < 0)
        {
            digits[i] += 10;
            --digits[++i];
        }
        trunc_zero(digits);
        return *this;
    }
};

ostream &operator<<(ostream &os, Big_uint const &a)
{
    if (a.digits.empty())
    {
        os << '0';
    }
    else
    {
        auto i = a.digits.rbegin(), j = a.digits.rend();
        while (i != j)
        {
            os << *i++;
        }
    }
    return os;
}

int main()
{
    int n;
    cin>>n;
    Big_uint ans("2");
    //使用前面的递推式an=2^n+1-2,大数模拟运算就是解决n>=64时超过了long long int后计算结果输出的问题
    for(int i=0;i<n;i++){
        ans=ans*2;
    }
    ans-=2;
    cout<<ans<<endl;
    system("pause");
    return 0;
}
```

