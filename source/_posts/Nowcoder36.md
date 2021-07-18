---
title: 牛客网OJ题解--20210314
comments: false
top: false
date: 2021-03-14 13:29:41
tags: [算法,Java]
categories: 
	- [刷题日志]
---

本系列记录翀翀😐痛苦的刷题日志，所有题目均来自于牛客网OJ题目，坚持刷题谈起来容易做起来难，希望我可以坚持下去，这里仍然分享一段励志文案：每个人都有梦想，然而有些人把梦想变成了现实，有些人的梦想依旧是梦想，只因为他们为梦想付出的努力程度不一样，他们坚持的时间不一样，最终才有这样的结果。

<!-- more -->

### NC14715-卡牌游戏

#### 题目链接

https://ac.nowcoder.com/acm/problem/14715

#### 题目描述

中国文化的五行：金、木、水、火、土相生相克， 一天Alice和Bob玩起了卡牌游戏。卡牌包含5种类型Jin，Mu，Shui，Huo，Tu，分别代表金、木、水、火、土。 

  金克木，木克土，土克水，水克火，火克金。游戏规则如下： 

  两人玩n轮，每轮各自抽取一张卡牌，如果其中一个人的牌克制另一个人的牌那么这个人得3分，另一个人得0分。没有克制关系两人都得1分。最后得分高的获胜。

第一行包含一个整数n（1 <= n <= 1000），表示两人游戏轮数。接下来n行包含两个字符串，分别表示Alice，Bod抽到的卡牌类型（本题为单组测评）。

第一行包含一个整数n（1 <= n <= 1000），表示两人游戏轮数。接下来n行包含两个字符串，分别表示Alice，Bod抽到的卡牌类型（本题为单组测评）。

#### 测试样例

输入

```c
3 
Jin Mu
Mu Jin
Huo Huo
```

输出

```c
Draw
```

#### 解题思路

枚举即可，主要是尝试以下用Java写题。

#### 解题代码

```java
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int Alice = 0, Bob = 0;
        for (int i = 0; i < n; i++) {
            String s1 = sc.next();
            String s2 = sc.next();
            if (s1.equals("Jin") && s2.equals("Mu")) {
                Alice += 3;
            } else if (s1.equals("Mu") && s2.equals("Jin")) {
                Bob += 3;
            } else if (s1.equals("Mu") && s2.equals("Tu")) {
                Alice += 3;
            } else if (s1.equals("Tu") && s2.equals("Mu")) {
                Bob += 3;

            } else if (s1.equals("Tu") && s2.equals("Shui")) {
                Alice += 3;
            } else if (s1.equals("Shui") && s2.equals("Tu")) {
                Bob += 3;

            } else if (s1.equals("Shui") && s2.equals("Huo")) {
                Alice += 3;
            } else if (s1.equals("Huo") && s2.equals("Shui")) {
                Bob += 3;

            } else if (s1.equals("Huo") && s2.equals("Jin")) {
                Alice += 3;
            } else if (s1.equals("Jin") && s2.equals("Huo")) {
                Bob += 3;
            } else {
                Alice++;
                Bob++;
            }
        }
        if (Alice > Bob) {
            System.out.println("Alice");
        } else if (Alice < Bob) {
            System.out.println("Bob");
        } else {
            System.out.println("Draw");
        }
    }
}
```

### NC15319-跳台阶

#### 题目链接

https://ac.nowcoder.com/acm/problem/15319

#### 题目描述

小明在坐景驰科技研发的无人车到达了目的地。 景驰科技（JingChi.ai）是一家由人工智能技术驱动、以无人驾驶技术为核心的智能出行公司。它将打造面向中国市场的全无人驾驶。从无人车下来以后，小明看到了一个长长的楼梯 。有一个n级台阶的楼梯，小明一次可以向上跳1步，两步，甚至是n步，请问小明跳到n级台阶有多少种跳法？

第一行输入一个整数t，代表有t组样例:（ T<=30），接下来的t行，都用一个整数n，表示楼梯有n级台阶（ 1<=n<=30）。输出跳到第n级台阶有多少种跳法。

#### 测试样例

输入

```c
1
1
```

输出

```
1
```

#### 解题思路

找规律，n=1时1种跳法，n=2时2种跳法，n=3时4种跳法，n=4时8种跳法，n=5时16种跳法，所以f[i]=f[i-1]+2*f[i-2]。

#### 解题代码

```java
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int t = sc.nextInt();
        int f[] = new int[35];
        f[0] = 1;
        f[1] = 1;
        f[2] = 2;
        for (int i = 3; i <= 30; i++) {
            f[i] = f[i - 1] + 2 * f[i - 2];
        }
        for (int i = 1; i <= t; i++) {
            int n = sc.nextInt();
            System.out.println(f[n]);
        }
    }
}
```

