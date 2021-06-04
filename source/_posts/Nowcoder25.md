---
title: 牛客网OJ题解--20210302
comments: false
top: false
date: 2021-03-02 19:44:01
tags: [算法,C++]
categories: 算法导论
---

本系列记录翀翀😐痛苦的刷题日志，所有题目均来自于牛客网OJ题目，坚持刷题谈起来容易做起来难，希望我可以坚持下去，这里仍然分享一段励志文案：每个人都有梦想，然而有些人把梦想变成了现实，有些人的梦想依旧是梦想，只因为他们为梦想付出的努力程度不一样，他们坚持的时间不一样，最终才有这样的结果。

<!-- more -->

### NC15167-集合问题

#### 题目链接

https://ac.nowcoder.com/acm/problem/15167

#### 题目描述

给你a,b和n个数p[i]，问你如何分配这n个数给A,B集合，并且满足：若x在集合A中，则a-x必须也在集合A中。 若x在集合B中，则b-x必须也在集合B中。

第一行 三个数 n a b  1<=n<=1e5  1<=a,b<=1e9
第二行 n个数 p1 p2 p3...pn 1<=pi<=1e9

如果可以恰好分开就输出第一行 YES
然后第二行输出 n个数 分别代表pi 是哪个集合的  0 代表是A集合 1代表是B 集合
不行就输出NO
放在哪个集合都可以的时候优先放B

#### 测试样例

##### 样例1

输入

```c
4 5 9
2 3 4 5
```

输出

```c
YES
0 0 1 1
```

##### 样例2

输入

```c
3 3 4
1 2 4
```

输出

```c
NO
```

#### 解题思路

我们首先要读懂提，注意a-x和b-x也同样要求必须是p数组中的即使题干给出的，那么思路就很清晰了，首先由于a-x和b-x也是p[i]>=1，所以p[i]<=max(a,b)。同时对于一个p[i]，我们先检验在p数组中是否存在b-p[i]和a-p[i]，如果有一个p[i]没有a-p[i]和b-p[i]，那么就直接输出NO了。如果存在，那么对于p[i]，我们设定x是不小于b-p[i]的键值，y是不小于a-p[i]的键值，所以会使用到lower_bound函数，那么只有p[i]+p[x]=\=b时说明i和x是两个在B中集合的数的键值，如果p[i]+p[y]==a时就说明i和y时两个在A中集合的数的键值。当然也会存在i同时满足上面两种情况，那么优先放到B集合，所以对于B情况的If判断放在前面，所以上面两种情况都是x或y是lower_bound函数返还等于数值的键值，而更巧的是当lower_bound返还的是最小的大于a-p[i]和最小的大于b-p[i]的数值的键值，那么就说明p[i]不存在a-p[i]和b-p[i]。

#### 解题代码

##### 方法一：如解题思路使用lower_bound解决

```c
#include <bits/stdc++.h>
using namespace std;
int p[100005];
int vis[100005];
int main()
{
    int n, a, b, x, y, cnt = 0;
    //标记数组用来判断数p[i]属于集合A还是集合B
    memset(vis, 0, sizeof(vis));
    cin >> n >> a >> b;
    for (int i = 0; i < n; i++)
    {
        cin >> p[i];
    }
    //排序
    sort(p, p + n);
    int valid = 1;
    for (int i = 0; i < n; i++)
        if (!vis[i])
        {
            //对于每一个数p[i]同时求出不小于a-p[i]和不小于b-p[i]的值
            x = lower_bound(p, p + n, a - p[i]) - p;
            y = lower_bound(p, p + n, b - p[i]) - p;
            //这个解题方法巧就巧在当a-p[i]或者b-p[i]不存在时，那么返还的键值x,y
            //无论是p[y]+p[i]==b还是p[x]+p[i]==a都不会成立
            //那么也就检验出了a-x或者b-x这个数不存在的情况了，直接退出输出no即可了
            //如果是有一种集合情况满足，那么相应的加入对应的集合，如果是集合A，那么标记数值为1，如果是集合B，那么标记数值是2
            //如果同时满足，那么由于判断B集合的在前面，会优先加入到集合B
            if (!vis[y] && p[y] + p[i] == b)
            {
                //注意标记为2，因为标记0已经被用来当做没被使用的含义了
                vis[i] = vis[y] = 2;
                continue;
            }
            if (!vis[x] && p[x] + p[i] == a)
            {
                //注意标记为1，因为标记0已经被用来当做没被使用的含义了
                vis[i] = vis[x] = 1;
                continue;
            }
            valid = 0;
            break;
        }
    if (!valid)
        cout << "NO" << endl;
    else
    {
        cout << "YES" << endl;
        for (int i = 0; i < n - 1; i++)
            //恰巧此时-1就是相对应的标记，B集合2-1=1，A集合1-1=0
            cout << vis[i] - 1 << " ";
        cout << vis[n - 1] - 1 << endl;
    }
    system("pause");
    return 0;
}
```

##### 方法二：并查集解决

其实我们看到这道题，第一想法应该就是并查集，毕竟是集合分类问题。但是细想一下，我们会发现用并查集来实现很难，我们需要开一个\<map>mp来存储，因为是跳跃性的存储。比如样例2中的a=3,b=4。那么mp[1]=1,mp[2]=2,mp[4]=3即数4是第三个数，然后每一次检验一个p[i]，当存在mp[b-p[i]]时，就将键值i合并到键值mp[b-p[i]]，否则合并到键值0上，然后在检验当存在mp[a-p[i]]时，就将键值i合并到键值mp[a-p[i]]，否则合并到键值n+1上。所以当数p[i]同时不存在b-p[i]和a-p[i]是，那么就会出现find(mp[0])=\=find(mp[n+1])输出NO退出，否则就是能够成功。我们以样例2来看，首先i=1时，p[i]=1,mp[1]=1,那么b-p[i]=3,我们发现mp[b-p[i]]=mp[3]不存在，所以将i=1关联到了0,然后检验a-p[i]，发现a-p[i]=2,mp[2]=2,所以将i关联到2，并且我们根据find函数的实现知道此时1和0都会直接指向2即2同时是0和1的先祖节点，然后i=2，与前面类似，最终会出现2,0指向1，最后i=3的时候，p[i]=4，那么由于b-p[i]不存在，4会指向0，所以此时4,0,2指向1，然后又因为a-p[i]也不存在，那么会merge(4,n+1)，则最终4,0,2,1都会指向n+1，那么此时退出的条件就是0和n+1有共同的先祖，即find(0)==find(n+1)并且我们还知道其实就是n+1是0的先祖节点，只不过find函数当检验根节点时会直接返还根节点，而对于其他节点，会一直递归寻找最根本先祖节点。同时我们还要再一次重申merge函数回导致节点x关联到节点y，即y成为x的根本先祖的先祖。

```c
#include<bits/stdc++.h>
using namespace std;
#define ll long long
#define endl '\n'
ll pre[100005],p[100005];
void init(ll n)
{
    //初始化
    for(ll i=0;i<=n+1;i++)
        pre[i]=i;
}
ll Find(ll x)
{
    //注意当为根节点时，就直接返还自身
    return pre[x]==x?x:pre[x]=Find(pre[x]);
}
void mix(ll a,ll b)
{
    //merge函数
    //会使b节点称为a节点的根本节点的先祖节点
    ll fa=Find(a),fb=Find(b);
    if(fa!=fb){
        pre[fa]=fb;
    }
}
int main()
{
    //关流加快输入输出
    ios::sync_with_stdio(0);cin.tie(0),cout.tie(0);
    ll n,a,b,mx=0;cin>>n>>a>>b;
    init(n);
    map<ll,ll>mp;
    for(ll i=1;i<=n;i++)
    {
        cin>>p[i];
        //注意mp键值是p的数值，mp数值是p的键值
        mp[p[i]]=i;
        //读取p数组最大值
        mx=max(mx,p[i]);
    }
    if(mx>=max(a,b)){
        //特例判断
        cout<<"NO";return 0;
    }
    for(ll i=1;i<=n;i++)
    {
        //先检验p
        if(mp[b-p[i]]){
            //满足时将i挂载到b-p[i]的键值上
            mix(i,mp[b-p[i]]);
        }
        //否则暂时挂载到0
        else mix(i,0);
        if(mp[a-p[i]]){
            //满足时将i挂载到a-p[i]的键值上
            mix(i,mp[a-p[i]]);
        }
        //否则挂载到n+1
        else mix(i,n+1);
    }
    //记录0和n+1的共同祖先
    ll numa = Find(0);
    ll numb = Find(n+1);
    if(numa==numb){
        //当向同时就说明有p[i]同时不属于A和B
        cout<<"NO";
    }
    else {

        cout<<"YES"<<endl;
        for(ll i=1;i<=n;i++)
        {
            if(numa==Find(i)){
                cout<<0;
            }
            else cout<<1;
            if(i!=n)
            cout<<" ";
        }
    }

}
```

#### 反思总结

通过这道题，我们学习了lower_bound函数的功能，例如

```c
x = lower_bound(p, p + n, a - p[i]) - p;
```

是返还p数组中从p首地址到尾地址范围内即整个p数组中第一个大于等于（不小于）a-p[i]的数值的在p数组中的键值位置，由于返还的是地址，所以需要减去p数组首地址p才能得到p数组组内偏移即键值。同时一定要注意集合问题，关系网问题不一定是并查集问题。

### luoguP3367-[模板]并查集

#### 题目链接

https://www.luogu.com.cn/problem/P3367

#### 题目描述

如题，现在有一个并查集，你需要完成合并和查询操作。第一行包含两个整数 N,M ,表示共有 N 个元素和 M 个操作。

接下来 M 行，每行包含三个整数 Z_i,X_i,Y_i 。

当 Z_i=1 时，将 X_i 与 Y_i 所在的集合合并。

当 Z_i=2时，输出 X_i 与 Y_i是否在同一集合内，是的输出 Y ；否则输出 N 。对于每一个 Z_i=2的操作，都有一行输出，每行包含一个大写字母，为 Y 或者 N 。

#### 测试样例

输入

```c
4 7
2 1 2
1 1 2
2 1 2
1 3 4
2 1 4
1 2 3
2 1 4
```

输出

```c
N
Y
N
Y
```

#### 解题思路

这就是一个并查集板子题，主要是复习一下，水过去就行。不会请看[《浅谈并查集解决分组问题》](https://wenchong.space/2021/03/03/union-find/)。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

const int N = 1e4 + 5;

int fa[N];
//寻找祖先板子
int find(int x)
{
    return (fa[x] == x ? x : fa[x] = find(fa[x]));
}
//合并板子
void merge(int x, int y)
{
    fa[find(x)] = find(y);
}

int main()
{
    int n, m;
    cin >> n >> m;
    for (int i = 1; i <= n; i++)
        fa[i] = i;
    while (m--)
    {
        int a, b, z;
        cin >> z >> a >> b;
        if (z == 1)
        {
            merge(a, b);
        }
        else if (z == 2)
        {
            //核心代码
            if (find(a) == find(b))
                cout << "Y" << endl;
            else
                cout << "N" << endl;
        }
        else
        {
            //注意排除报错情况
            cout << "Error!" << endl;
            system("pause");
            return 0;
        }
    }
    system("pause");
    return 0;
}
```

