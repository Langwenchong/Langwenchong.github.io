---
title: 牛客网OJ题解--20210327
comments: false
top: false
date: 2021-03-27 17:12:09
tags: [算法,C++,Java]
categories: 
	- [刷题日志]
---

本系列记录翀翀😐痛苦的刷题日志，所有题目均来自于牛客网OJ题目，坚持刷题谈起来容易做起来难，希望我可以坚持下去，这里仍然分享一段励志文案：每个人都有梦想，然而有些人把梦想变成了现实，有些人的梦想依旧是梦想，只因为他们为梦想付出的努力程度不一样，他们坚持的时间不一样，最终才有这样的结果。

<!-- more -->

### NC15173-The Biggest Water Problem

#### 题目链接

https://ac.nowcoder.com/acm/problem/15173

#### 题目描述

给你一个数，让他进行巴啦啦能量，沙鲁沙鲁，小魔仙大变身，如果进行变身的数不满足条件的话，就继续让他变身。。。直到满足条件为止。 

  巴啦啦能量，沙鲁沙鲁，小魔仙大变身：对于一个数，把他所有位上的数字进行加和，得到新的数。   如果这个数字是个位数的话，那么他就满足条件。给一个整数数字n(1<=n<=1e9)。输出由n经过操作满足条件的数

#### 测试样例

##### 样例1

输入

```c
12
```

输出

```c
3
```

说明

```c
12 -> 1 + 2 = 3
```

##### 样例2

输入

```c
38
```

输出

```c
2
```

说明

```c
38 -> 3 + 8 = 11 -> 1 + 1 = 2
```

#### 解题思路

递归就好了，模10取最后一位。

#### 解题代码

```java
import java.util.Scanner;

public class Main {
    public static int transform(int x){
        int tmp=x;
        int num=0;
        while(tmp!=0){
            num+=tmp%10;
            tmp/=10;
        }
        if(num==x%10){
            return num;
        }
        else{
            return transform(num);
        }
    }
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n=sc.nextInt();
        int ans=transform(n);
        System.out.println(ans);
    }
}
```

### NC14609-Forever97与寄信

#### 题目链接

https://ac.nowcoder.com/acm/problem/14609

#### 题目描述

Forever97与未央是一对笔友，他们经常互相写信。有一天Forever97去邮局寄信，发现邮局的收费方式变成了按字收费，收取的费用为总字数除了其自身以外的最大因子。虽然Forever97是一个有情调的人，但他不想因新收费方式而破财，所以他打算把信分成几份寄出去来减少邮费。已知Forever97写的信共有n个字，可以拆成无数封信，也可以不拆，每封信最少为2个字。求Forever97最少需要付多少邮费？

第一行一个正整数T(T<=200)，表示共有T组数据。第2至第T+1行每行一个正整数n(2<=n<=108)。对每组数据输出一行，即Forever97最少需要付的邮费。

#### 测试样例

输入

```c
3
5
6
9
```

输出

```c
1
2
2
```

说明

```c
对于第二组数据，一封6字信可以拆分成两封3字信，各付1邮资。
对于第三组数据，一封9字信可以拆分成一封2字信和一封7字信，各付1邮资。
```

#### 解题思路

思维题，直接爆搜会炸掉。其实只会有三种情况，即1块钱，2块钱和3块钱。最后一个不太好想，见下面的注释。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

int solve(int N)
{
    int n = sqrt(N);
    int flag = 1;
    for (int i = 2; i <= n; i++)
    {
        if (N % i == 0)
        {
            flag = 0;
            break;
        }
    }
    //如果字数就是质数
    if (flag)
        //一块钱就行
        return 1;
    flag = 1;
    //如果是合数且是9,49这种减去一个2后就变成了质数，那么就两块钱
    for (int i = 2; i <= n; i++)
    {
        if ((N - 2) % i == 0)
        {
            flag = 0;
            break;
        }
    }
    if (flag || N % 2 == 0)
        return 2;
    //否则像51这种合数，需要减去2个2才能变成质数，就需要三块钱，没有其他情况了
    return 3;
}

int main()
{
    int t;
    cin >> t;
    while (t--)
    {
        int n;
        cin >> n;
        cout << solve(n) << endl;
    }
    return 0;
}
```

