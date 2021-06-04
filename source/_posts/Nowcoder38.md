---
title: 牛客网OJ题解--20210316
comments: false
top: false
date: 2021-03-16 14:30:58
tags: [算法,Java,C++]
categories: 算法导论
---

本系列记录翀翀😐痛苦的刷题日志，所有题目均来自于牛客网OJ题目，坚持刷题谈起来容易做起来难，希望我可以坚持下去，这里仍然分享一段励志文案：每个人都有梦想，然而有些人把梦想变成了现实，有些人的梦想依旧是梦想，只因为他们为梦想付出的努力程度不一样，他们坚持的时间不一样，最终才有这样的结果。

<!-- more -->

### NC14741-栗酱和仙剑

#### 题目链接

https://ac.nowcoder.com/acm/problem/14741

#### 题目描述

栗酱突发闲心，玩了一会儿仙剑。她玩的这个版本的仙剑非常简单，打架的时候，每次只有一个小怪，栗酱也只有一个主角，主角在每回合开始先攻击小怪，小怪有a点生命值，主角有b点生命值，小怪有c点攻击力，主角有d点攻击力，每次攻击都会造成确确实实的攻击力的伤害。生命值小于等于零时就会挂掉。栗酱发现好像战斗一开始就已经能知道结果了，请你帮她算一下，这样她就可以挂机去做更有趣的事了。数据保证攻击力和初始生命值均大于等于1。

第一行一个数据组数T。每组数据一行4个整数a，b，c，d，数据之间用一个空格隔开。对于每组数据每行给出一个"Yes"或"No"，代表栗酱能否取得胜利。

#### 测试样例

输入

```c
2
1 2 3 4
84 3 23 6
```

输出

```c
Yes
No
```

说明

```
第一回合时栗酱先发动攻击，小怪的生命值：1−4≤0，所以栗酱取得了胜利。
```

#### 解题思路

使用除加取余求得两个人的支撑回合数，当主角支撑回合数大于等于怪物时主角胜利，水题。

#### 解题代码

```java
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        for (int i = 0; i < n; i++) {
            int a = sc.nextInt();
            int b = sc.nextInt();
            int c = sc.nextInt();
            int d = sc.nextInt();
            int num1 = a / d;
            int num2 = b / c;
            if (a % d != 0)
                num1++;
            if (b % c != 0)
                num2++;
            //当主人公可以支撑的回合数大于等于小怪时，主人公胜利
            //之所以等于是主人公胜利是因为他先手
            if (num2 >= num1)
                System.out.println("Yes");
            else
                System.out.println("No");
        }
    }
}
```

### NC14572-走出迷宫

#### 题目链接

https://ac.nowcoder.com/acm/problem/14572

#### 题目描述

小明现在在玩一个游戏，游戏来到了教学关卡，迷宫是一个N*M的矩阵。 小明的起点在地图中用“S”来表示，终点用“E”来表示，障碍物用“#”来表示，空地用“.”来表示。 障碍物不能通过。小明如果现在在点（x，y）处，那么下一步只能走到相邻的四个格子中的某一个：（x+1，y），（x-1，y），（x，y+1），（x，y-1）。小明想要知道，现在他能否从起点走到终点。

本题包含多组数据。每组数据先输入两个数字N,M。接下来N行，每行M个字符，表示地图的状态。数据范围：2<=N,M<=500。保证有一个起点S，同时保证有一个终点E。每组数据输出一行，如果小明能够从起点走到终点，那么输出Yes，否则输出No。

#### 测试样例

输入

```c
3 3
S..
..E
...
3 3
S##
###
##E
```

输出

```c
Yes
No
```

#### 解题思路

很明显的dfs板子题，就是枚举四个方向，这里要注意几个细节：①输入样例是给m,n就要测试②越界问题特判③一定要进行标记剪枝，否则空间复杂度巨大会段错误④没说起点是左上角，需要自己找

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

//方向向量
int dir[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
//地图
char _map[505][505];
int vis[505][505];
bool ok = false;
int m, n;

void dfs(int i, int j)
{
    //越界就停
    if (i > m || j > n || i < 1 || j < 1)
        return;
    //不能走就停
    if (_map[i][j] == '#')
        return;
    if (vis[i][j] == 1)
        return;
    //找到终点，ok=true
    if (_map[i][j] == 'E')
    {
        ok = true;
        return;
    }
    vis[i][j] = 1;
    dfs(i + dir[0][0], j + dir[0][1]);
    dfs(i + dir[1][0], j + dir[1][1]);
    dfs(i + dir[2][0], j + dir[2][1]);
    dfs(i + dir[3][0], j + dir[3][1]);
}

int main()
{
    //m行n列
    while (cin >> m >> n)
    {
        ok = false;
        memset(_map, 0, sizeof(_map));
        memset(vis, 0, sizeof(vis));
        int x, y;
        for (int i = 1; i <= m; i++)
        {
            for (int j = 1; j <= n; j++)
            {
                cin >> _map[i][j];
                //找到起点位置
                if (_map[i][j] == 'S')
                {
                    x = i;
                    y = j;
                }
            }
        }
        //出发
        dfs(x, y);
        if (ok)
            cout << "Yes" << endl;
        else
            cout << "No" << endl;
    }
    system("pause");
    return 0;
}
```

