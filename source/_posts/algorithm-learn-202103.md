---
title: 刷题日志--2021年03月
comments: false
top: false
date: 2021-03-01 16:16:42
tags: [算法]
categories: 
	- [刷题日志]
headimg: https://langwenchong.gitee.io/figure-bed/20220124165531.png
---

本系列记录翀翀😐痛苦的刷题日志，坚持刷题谈起来容易做起来难，希望我可以坚持下去，这里仍然分享一段励志文案：每个人都有梦想，然而有些人把梦想变成了现实，有些人的梦想依旧是梦想，只因为他们为梦想付出的努力程度不一样，他们坚持的时间不一样，最终才有这样的结果。

<!-- more -->

### NC14538-神奇的数字

#### 题目链接

https://ac.nowcoder.com/acm/problem/14538

#### 题目描述

今天是Tabris和mengxiang000来到幼儿园的第6天，美丽的老师在黑板上写了几个数字：121,11,131，聪明的Tabris一眼就看出这些数字是那样的神奇——无论是正着写还是反着写都是一样的，mengxiang000想要得到更多的这样有趣的数，又因为这是二人到幼儿园的第6天，6+2=8。他们想知道长度为8的这样的数都有哪些。但是写着写着机智的Tabris发现这样神奇的数实在太多了，所以向你求助，你能帮帮他们吗？

#### 测试样例

无

#### 解题思路

实际上很好想，毕竟已经固定了数的长度大小，并且还要保证字符对称，所以我们只需要枚举前4位即可，再使用字符串翻转即可实现。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

int main()
{
    //一定要注意首位不可以是0但是其他位都是可以从0开始的
    for (int i = 1000; i <= 9999; i++)
    //前四位翻转即为后四位
    {
        string str = "";
        int t = i;
        while (t != 0)
        {
            //强制转换后，拼接
            str = char(t % 10 + '0') + str + char(t % 10 + '0');
            //除10取下一位
            t /= 10;
        }
        cout << str << endl;
    }
    system("pause");
    return 0;
}
```

### PTA1327634546768367617-大采购

#### 题目链接

https://pintia.cn/problem-sets/1327634511926284288/problems/1327634546768367617

#### 题目描述

众所周知，龙龙十分喜欢逛中关村南门出去几百米远的那个五星超市。这天龙龙拉着yds一起去逛五星超市，龙龙推着一个重量上限为N的购物车。他们在五星超市中逛了一圈也没看见什么想买的，购物车里还是空的，这时龙龙突然发现后门附近还有一条长长的货物架，上面有M个商品，每个商品分别有重量G，和价值S两个属性，但这个购物架是单向的，也就是说龙龙只能从现在所处的这端走到另一端将商品按顺序放入购物车中。龙龙说他可以轻松的将一些商品放入放入购物车中使得在购物车的重量承受范围内，商品的总价值最大。但yds心想，这不就是一个简单的01背包问题？~~恶毒的~~yds并不想让龙龙简单的解决这个问题，他要求龙龙在只能按顺序放入商品之外，每次放入的商品的重量还必须小于等于上一次放入的商品的重量。龙龙觉得这个问题就有点费脑筋了，他并不想去仔细思考，请你帮他算出他在这样的规则下最多能往购物车里塞价值为多少的商品。

第一行输入两个整数N，M，分别代表购物车的重量限制与商品的个，(1≤N≤100,1≤M≤100)。接下来M行，每行输入两个整数Gi,Si，分别代表第i个商品的重量与价值，(1≤Gi,Si≤100)。

#### 测试样例

输入

```c
5 5
1 5
2 2
3 3
4 4
1 2
```

输出

```c
7
```

#### 解题思路

这道题实际上是一个0/1背包dp的三维打表，可以参考《浅谈三维0/1背包dp变式以及分组背包问题》。这里我们使用三维dp打表，f[i]\[j\][k]的前两个i,j意义不变表示的是背包剩余容量为j时，从物品1\~i选择可获得的最大收益值。而k就是表示上一个所选择的最大物品质量，所以此时f函数的意义就变成了f[i]\[j\][k]的前两个i,j意义不变表示的是背包剩余容量为j时，从物品1~i选择同时保证上一个被选择的物品质量是k时可获得的最大收益值。那么每一次我们都要求当前选择的物品质量w[i]<k即可。同时还要注意memset函数的赋值，此处的255实际上赋值后全为-1。

#### 解题代码

##### 解法一：三维打表

```c
#include <bits/stdc++.h>
using namespace std;

#define close_stdin ios::sync_with_stdio(false)
const int N = 1e2;
int dp[N + 5][N + 5][N + 5], w[N + 5], v[N + 5];
int main()
{
    close_stdin;
    int ans = 0;
    int n, m;
    cin >> n >> m;
    for (int i = 1; i <= m; i++)
    {
        cin >> w[i] >> v[i];
    }
    //初始化为-1
    memset(dp, 255, sizeof(dp));
    for (int i = 0; i <= n; i++)
    {
        //将i=0的情况全部设定为0，因为无法选物品当然就是0了
        dp[0][0][i] = 0;
    }
    for (int i = 0; i < m; i++)
    {
        for (int j = 0; j <= n; j++)
        {
            for (int k = 0; k <= n; k++)
            {
                //此时要三层嵌套，枚举k
                //当为-1时，表示上一个表格未满足条件不能赋值，所以跳过以防影响后面的打表
                if (!~dp[i][j][k])
                    continue;
                //满足条件时先将这个格的下一个格赋值为当前格的值，表示不放入物品i+1的收益情况就是此时i的情况
                dp[i + 1][j][k] = max(dp[i + 1][j][k], dp[i][j][k]);
                //当满足w[i]<K时我们利用递归式求解放入和不放入的情况哪个收益更好
                if (w[i + 1] <= k && j + w[i] <= n)
                {
                    dp[i + 1][j + w[i + 1]][w[i + 1]] = max(dp[i + 1][j + w[i + 1]][w[i + 1]], dp[i][j][k] + v[i + 1]);
                }
            }
        }
    }
    for (int j = 0; j <= n; j++)
    {
        for (int k = 0; k <= n; k++)
        {
            //选取最好收益情况，此时j未必等于N且k也未必是w[n]
            ans = max(ans, dp[m][j][k]);
        }
    }
    cout << ans << endl;
    system("pause");
    return 0;
}
```

##### 解法二：降为二维dp打表

实际上此题也可以降维，我们知道在二维0/1dp降维时是使j从N到0，同时每一次进行递归的条件是满足j>=w[i]才可以，这道题我们参照这个思路，同样降维，只是在j>=w[i]的同时还需要满足k<=j。所以需要二维dp,数组的后一个参数就是k记录上一次的被选择物品质量，同样，我们降维降得是不需要i，所以仍然是多次覆盖数据，没有参数i。

```c
#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
const int maxn = 110;

int v[maxn], w[maxn], dp[maxn][maxn]; //记录上一个物品的重量

signed main()
{
    ios::sync_with_stdio(false), cin.tie(0);
    int n, m;
    while (cin >> n >> m)
    { //n容量m物品
        memset(dp, 0, sizeof dp);
        for (int i = 0; i < m; ++i)
            cin >> w[i] >> v[i];
        int ans = 0; //记录答案
        for (int i = 0; i < m; ++i)
        { //到第i件物品
            for (int j = n; j >= w[i]; --j)
            { //优化降维,逆序由上一轮到本轮,总共选了j重量
                for (int k = w[i]; k <= j; ++k)
                {                                                           //最后一个物品重量为k,保证递减
                    dp[j][w[i]] = max(dp[j][w[i]], dp[j - w[i]][k] + v[i]); //
                }
                ans = max(ans, dp[j][w[i]]);
            }
        }
        cout << ans << endl;
    }
    //system("pause");
    return 0;
}
```

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

这就是一个并查集板子题，主要是复习一下，水过去就行。不会请看[《浅谈并查集解决分组问题》](https://coolchong.cn/2021/03/03/union-find/)。

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

### NC19990-[HAOI2012]音量调节

#### 题目链接

https://ac.nowcoder.com/acm/problem/19990

#### 题目描述

一个吉他手准备参加一场演出。他不喜欢在演出时始终使用同一个音量，所以他决定每一首歌之前他都要改变一次音量。在演出开始之前，他已经做好了一个列表，里面写着在每首歌开始之前他想要改变的音量是多少。每一次改变音量，他可以选择调高也可以调低。音量用一个整数描述。输入文件中给定整数beginLevel，代表吉他刚开始的音量，以及整数maxLevel，代表吉他的最大音量。音量不能小于0也不能大于maxLevel。输入文件中还给定了n个整数c1,c2,c3…..cn，表示在第i首歌开始之前吉他手想要改变的音量是多少。吉他手想以最大的音量演奏最后一首歌，你的任务是找到这个最大音量是多少。

第一行依次为三个整数：n, beginLevel, maxlevel。第二行依次为n个整数：c1,c2,c3…..cn。输出演奏最后一首歌的最大音量。如果吉他手无法避免音量低于0或者高于maxLevel，输出-1。

#### 测试样例

输入

```c
3 5 10               
5 3 7
```

输出

```c
10
```

#### 解题思路

我们知道第i+1演出时能够达到的音量是由第i次演出后所结束的音量决定。因此我们可以定义volum[i]\[j\]数组表示第i次表演后能否到达的音量j，0表示不能，1表示可以，那么很明显就有如下递推式
$$
volum[i][j+x]=1当且仅当volum[i-1][j]=1\&\&j+x<maxVolum
$$

$$
volum[i][j-x]=1当且仅当volum[i-1][j]=1\&\&j-x>minVolum
$$

也就是说如果第i次演奏后想要达到音量j+x，那么j+x必须小于最大音量并且第i-1次演奏后可以到达音量j,第i次演奏后想要达到音量j-x，那么j-x必须大于最小音量并且第i-1次演奏后可以到达音量j。所以很明显是一个二维dp，实际上我们发现dp大部分都是可以参考0/1背包dp思路的，全部都是打表思想并且永远是后者由前者决定，只不过每一次的递推条件不同，这个具体的变式思路只能够通过多练来积累。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

//volum[i][j]表示的是在i此表演后能否到达音量j
//如果为1表示可以到达
//0表示无法到达
int volum[105][1005];

int main()
{
    int n, b, m;
    cin >> n >> b >> m;
    //未开始演出时可以到达初始音量，所以置为1
    volum[0][b] = 1;
    for (int i = 1; i <= n; i++)
    {
        //对于每一次的音量调节大小x
        int x;
        cin >> x;
        //注意枚举表演i首后能否到达音量j
        //因为还是二维0/1dp没有降维，所以j正序逆序都可以
        for (int j = 0; j <= m; j++)
        {
            //当且仅当j+x没有超出最大音量，且在表演i-1次后音量可以到达j时
            //表演第i首歌以后才可以到达j+x音量
            if (j + x <= m && volum[i - 1][j])
                volum[i][j + x] = 1;
            //当且仅当jxx没有超出最小音量，且在表演i-1次后音量可以到达j时
            //表演第i首歌以后才可以到达j-x音量
            if (j - x >= 0 && volum[i - 1][j])
                volum[i][j - x] = 1;
        }
    }
    //但是注意最终要求的是寻找表演n次后可以到达的最大音量
    //所以此时i必须为逆序的
    for (int i = m; i >= 0; i--)
    {
        //一定是volum[n][i]因为必须表演完n次
        if (volum[n][i])
        {
            //第一个出现的1值就是可以到达的最大音量
            //输出这个最大音量i即可
            cout << i << endl;
            system("pause");
            return 0;
        }
    }
    //如果整个第n行都是0，说明无法表演完n首歌，所以输出-1
    cout << "-1" << endl;
    system("pause");
    return 0;
}
```

### NC21467-货币系统

#### 题目链接

https://ac.nowcoder.com/acm/problem/21467

#### 题目描述

在网友的国度中共有n种不同面额的货币，第i种货币的面额为a[i]，你可以假设每一种货币都有无穷多张。为了方便，我们把货币种数为n、面额数组为a[1..n]的货币系统记作(n,a)。在一个完善的货币系统中，每一个非负整数的金额x 都应该可以被表示出，即对每一个非负整数x，都存在n个非负整数t[i] 满足a[i] x t[i] 的和为x。然而，在网友的国度中，货币系统可能是不完善的，即可能存在金额x不能被该货币系统表示出。例如在货币系统n=3, a=[2,5,9]中，金额1,3就无法被表示出来。两个货币系统(n,a)和(m,b)是等价的，当且仅当对于任意非负整数x，它要么均可以被两个货币系统表出，要么不能被其中任何一个表出。现在网友们打算简化一下货币系统。他们希望找到一个货币系统(m,b)，满足(m,b) 与原来的货币系统(n,a)等价，且m尽可能的小。他们希望你来协助完成这个艰巨的任务：找到最小的m。输入的第一行包含一个整数T,表示数据组数。接下来按照如下格式分别给出T组数据。每组数据的第一行包含一个正整数n。接下来一行包含n个由空格隔开的正整数a[i]。输出文件共T行, 对于每组数据, 输出一行一个正整数, 表示所有与(n, a)等价的货币系统(m, b)中, 最小的m。

#### 测试样例

输入

```c
2
4
3 19 10 6
5
11 29 13 19 17
```

输出

```c
2
5
```

说明

```c
在第一组数据中，货币系统(2, [3,10])和给出的货币系统(n, a)等价，并可以验证不存在m < 2的等价的货币系统，因此答案为2。
在第二组数据中，可以验证不存在m < n的等价的货币系统，因此答案为5。
```

#### 解题思路

首先我们很容易想到货币系统之所以可以减少货币数量，是因为给出的某些货币可以由更小的货币组成，比如样例1中的19可以由货币10+3+6组成，所以我们可以得到一个关系，价值大的货币是否可有可无主要取决于能否被小货币组合表示。因此我们定义vis数组，0表示不能被其他小货币表示，1表示可以被其他小货币表示即可有可无。那么我们将货币按价格有小到大排序，对于每一个货币k，如果他可以被表示，那么对于由k和其他货币a[i]组成的货币价格k+a[i]肯定也是可以被表示的。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

const int N = 1e5;
//存储货币
int a[105];
//vis标记数组
//0表示不可以被其他货币表示
//1表示可以被其他货币表示也就可有可无
int vis[N];

int main()
{
    int T;
    cin >> T;
    while (T--)
    {
        //初始化
        memset(a, 0, sizeof(a));
        memset(vis, 0, sizeof(vis));
        int n;
        cin >> n;
        for (int i = 1; i <= n; i++)
        {
            cin >> a[i];
        }
        //排序
        sort(a + 1, a + n + 1);
        //默认每一个货币都是必须存在的
        int ans = n;
        //首先0肯定是可有可无的
        vis[0] = 1;
        for (int i = 1; i <= n; i++)
        {
            //如果vis为1，那么这个货币可有可无
            //货币数量-1
            if (vis[a[i]])
            {
                ans--;
            }
            //否则这个货币必须存在
            //然后所有可以表示的货币值j+a[i]肯定也就是可以被表示了
            //都标记为1表示可有可无
            for (int j = 0; j <= a[n]; j++)
            {
                //枚举j从a[i]到最大货币值
                //如果j是可以被表示的
                if (vis[j])
                {
                    //那么j+a[i]肯定也可以被表示
                    vis[j + a[i]] = 1;
                }
            }
        }
        cout << ans << endl;
    }
    system("pause");
    return 0;
}
```

### NC24948-Cow Contest

#### 题目链接

https://ac.nowcoder.com/acm/problem/24948

#### 题目描述

N (1 ≤ N ≤ 100) cows, conveniently numbered 1..N, are participating in a programming contest. As we all know, some cows code better than others. Each cow has a certain constant skill rating that is unique among the competitors.
 The contest is conducted in several head-to-head rounds, each between two cows. If cow A has a greater skill level than cow B (1 ≤ A ≤ N; 1 ≤ B ≤ N; A ≠ B), then cow A will always beat cow B.Farmer John is trying to rank the cows by skill level. Given a list the results of M (1 ≤ M ≤ 4,500) two-cow rounds, determine the number of cows whose ranks can be precisely determined from the results. It is guaranteed that the results of the rounds will not be contradictory.

\* Line 1: Two space-separated integers: N and M
\* Lines 2..M+1: Each line contains two space-separated integers that describe the competitors and results (the first integer, A, is the winner) of a single round of competition: A and B

\* Line 1: A single integer representing the number of cows whose ranks can be determined

大意就是有N头牛，经过M轮比赛，并且永远是A赢B，那么老农想根据下面的2~m行的比赛来得到可以确定具体排名的牛的个数。牛的编号是1-n,并且不会出现A>B>C>A的矛盾情况出现。

#### 测试样例

输入

```c
5 5
4 3
4 2
3 2
1 2
2 5
```

输出

```c
2
```

说明

```
Cow 2 loses to cows 1, 3, and 4. Thus, cow 2 is no better than any of the cows 1, 3, and 4. Cow 5 loses to cow 2, so cow 2 is better than cow 5.  Thus, cow 2 must be fourth, and cow 5 must be fifth. The ranks of the other cows cannot be determined.

牛2输给了牛1,2,4，又赢了牛5，所以牛5一定是第五名，牛2一定是第四名，1,3,4,排名无法确定，所以答案为2
```

#### 解题思路

使用的并不是并查集而是floyd算法，其实还是并查集的思想，具体的解题过程见注释。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;
const int N = 105;
int x, y, n, m, ans;
//win[i][j]==1表示i赢了j
//lose[i][j]==1表示i输给了j
int win[N][N], lose[N][N];

int main()
{
    cin >> n >> m;
    while (m--)
    {
        //存入x，y一定是x赢y
        cin >> x >> y;
        win[x][y] = lose[y][x] = 1;
    }
    //floyd算法模拟并查集思想
    //这里不适用并查集是因为并查集记录的都是节点A和节点B是否具有共同祖先节点的关系来间接表示A和B的关系
    //但是这里只是用来记录两个相邻节点A,B的直接关系
    for (int k = 1; k <= n; k++)
        for (int i = 1; i <= n; i++)
        {
            //当i和k相同时跳过
            if (i == k)
                continue;
            for (int j = 1; j <= n; j++)
            {
                //同理i==j或者j==k也跳过总之就是必须是三头不同的牛
                if (i == j || j == k)
                    continue;
                //i赢了j当前仅当i赢了k且k赢了j，一定要注意这里是取或
                win[i][j] |= (win[i][k] && win[k][j]);
                //i输给j当且仅当i输给k且k输给j
                lose[i][j] |= (lose[i][k] && lose[k][j]);
            }
        }
    for (int i = 1; i <= n; i++)
    {
        int num = 0;
        for (int j = 1; j <= n; j++)
            //统计i赢的场数和输的场数
            num += win[i][j] + lose[i][j];
        //如果刚好和为n-1，表示排名先于i的人数和排名落后于i的人数之和为n-1，那么随之i的排名就确定了
        //可以用排队来理解，已知5个人，A前面有3个人，后面有1个人，那么就确定了A位于从前往后数第4个
        if (num == n - 1)
            ans++;
    }
    cout << ans << endl;
    system("pause");
    return 0;
}
```

### NC15121-Call your teacher

#### 题目链接

https://ac.nowcoder.com/acm/problem/15121

#### 题目描述

从实验室出来后，你忽然发现你居然把自己的电脑落在了实验室里，但是实验室的老师已经把大门锁上了。更糟的是，你没有那个老师的电话号码。你开始给你知道的所有人打电话，询问他们有没有老师的电话，如果没有，他们也会问自己的同学来询问电话号码。那么，你能联系到老师并且拿到电脑吗。

存在多组测试样例，每组样例的第一行分别是两个整数n(1<n<=50)，m(1<m<=2000)，n是在题目当中出现的人数，其中你的序号是1号，实验室老师的序号是n。接下来的m行，每行有两个整数x(1<=x<=n)，y(1<=y<=n)，代表x有y的电话号码。对于每组测试样例，如果你最终能联系到老师，输出“Yes”，否则输出“No”。

#### 测试样例

##### 样例1

输入

```c
5 5
1 3
2 3
3 4
2 4
4 5
```

输出

```c
Yes
```

##### 样例2

输入

```c
4 3
1 2
2 3
4 1
```

输出

```c
No
```

说明

```c
注意此时4->1->2->3,虽然老师知道你的电话号码，但是你却不知道他的，所以出事了老师并不能得知，你也不能给老师打电话，所以无法联系到老师也就拿不到电脑
```

#### 解题思路

很明显就是并查集，但是有一个小小的变式，就是merge时如果老师是第一个参数那么就不能合并，因为虽然此时老师知道你的电话，但是还是等于没有联系方式，所以也就说明无关系。是一个单向合并。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

const int N = 55;
int fa[N];

int find(int x)
{
    return (fa[x] == x ? x : find(fa[x]));
}

void merge(int x, int y)
{
    fa[find(x)] = find(y);
}

int main()
{
    int n, m;
    cin >> n >> m;
    for (int i = 1; i <= n; i++)
    {
        fa[i] = i;
    }
    while (m--)
    {
        int a, b;
        cin >> a >> b;
        //唯一变式，必须是学生拥有老师的号码
        //所以当老师知道学生号码时不能使得两人连通
        //所以当a为老师时跳过
        if (a != n)
            merge(a, b);
    }
    if (find(1) == find(n))
        cout << "Yes" << endl;
    else
        cout << "No" << endl;
    system("pause");
    return 0;
}
```

### NC14707-免费WIFI

#### 题目链接

https://ac.nowcoder.com/acm/problem/14707

#### 题目描述

TRDD开了一家免费WiFi体验店， 所有人都可以免费连接WiFi， 只有一个条件， 你要提前一天预约。今天，TRDD收到了n(1 <= n <=1000)个人的预约， 每个人有一个时间段[L, R] (1 <= L <= R <= 5000)表示这个人预约连接WiFi从L时刻到R时刻。 但是市面上只有一种路由器， 这种路由器单台最多能同时连接m(n <= 100)台设备， TRDD想要知道最少使用多少台路由器就能保证明天每个人都能连上WiFi。第一行包含两个数n(1 <= n <=1000), m (1 <= m <= 100)表示今天有n个人预约， 以及路由单台最大连接个数m。
之后有n行， 第i行有两个数字  [L, R] (1 <= L <= R <= 5000) 表示第i个人预约连接WiFi的时间是从L到R。输出一个数字表示TRDD最少需要开启的路由器的个数。

#### 测试样例

输入

```c
4 1
1 5
2 7
3 4
6 9
```

输出

```c
3
```

#### 解题思路

是一种典型的区间打表模拟，我们对于每一个是时间段都打印此时会有多少个人使用wifi，然后记录最大值，最大值就是所有时间段内人数峰值/m就好了。但是要注意当有余数时还需要再加一台机器。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

//记录每一秒会有多少个人在用wifi
int a[5005];

int main()
{
    int n, m;
    cin >> n >> m;
    int Max = -1;
    while (n--)
    {
        int l, r;
        cin >> l >> r;
        //[l,r]区间的每一秒使用wifi的人数+1
        for (int i = l; i <= r; i++)
        {
            a[i]++;
            if (a[i] > Max)
            {
                //取每一时刻最大wifi位数
                Max = a[i];
            }
        }
    }
    int ans;
    //如果能整除，就是MAX/m
    if (Max % m == 0)
    {
        ans = Max / m;
    }
    else
    {
        //否则有余数要加一
        ans = Max / m + 1;
    }
    cout << ans << endl;
    system("pause");
    return 0;
}
```

### luoguP1757-通天之分组背包

#### 题目链接

https://www.luogu.com.cn/problem/P1757

#### 题目描述

自 0101 背包问世之后，小 A 对此深感兴趣。一天，小 A 去远游，却发现他的背包不同于 0101 背包，他的物品大致可分为 k 组，每组中的物品相互冲突，现在，他想知道最大的利用价值是多少。两个数 m,n，表示一共有 n件物品，总重量为 m。

接下来 n 行，每行 33 个数 a_i,b_i,c_，表示物品的重量，利用价值，所属组数。请输出最大的价值。

#### 测试样例

输入

```c
45 3
10 10 1
10 5 1
50 400 2
```

输出

```c
10
```

#### 解题思路

就是九讲背包中的一个典型分组背包板子题，具体方法请食用本篇《浅谈三维0/1背包dp变式以及分组背包问题》。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

//分别记录最大收益，物品重量，物品价值，物品所属组号
int dp[1005], w[1005], v[1005], g[1005];
using namespace std;
int main()
{
	int n, m;
	cin >> m >> n;
	int group = -1;
	for (int i = 1; i <= n; ++i)
	{
		cin >> w[i] >> v[i] >> g[i];
		group = max(group, g[i]);
	}
	//现规定本次所要打印的是第几组的物品
	for (int i = 1; i <= group; ++i)
	{
		//注意在分组背包中必须先讨论容量，再讨论物品，这是一个特殊顺序
		//可以保证每一个组只会选择一个物品
		//具体缘由见背包九讲
		//然后j逆序打印降维
		for (int j = m; j >= 0; --j)
		{
			//物品枚举范围正序
			for (int k = 1; k <= n; ++k)
			{
				//不是所要组号或者装不下跳过
				if (g[k] != i || j < w[k])
					continue;
				//否则更新值
				dp[j] = max(dp[j], dp[j - w[k]] + v[k]);
			}
		}
	}
	cout << dp[m] << endl;
	system("pause");
	return 0;
}
```

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

![](https://langwenchong.gitee.io/figure-bed/20210307155942.png)

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

### NC15553-数学考试

#### 题目链接

https://ac.nowcoder.com/acm/problem/15553

#### 题目描述

今天qwb要参加一个数学考试，这套试卷一共有n道题，每道题qwb能获得的分数为ai，qwb并不打算把这些题全做完，他想选总共2k道题来做，并且期望他能获得的分数尽可能的大，他准备选2个不连续的长度为k的区间， 即[L,L+1,L+2,....,L+k-1]，[R,R+1,R+2,...,R+k-1]（R >= L+k）。

第一行一个整数T（T<=10）,代表有T组数据
接下来一行两个整数n,k,(1<=n<=200,000),(1<=k,2k <= n)
接下来一行n个整数a1,a2,...,an，（-100,000<=ai<=100,000）

输出一个整数，qwb能获得的最大分数。

#### 测试样例

输入

```c
2
6 3
1 1 1 1 1 1
8 2
-1 0 2 -1 -1 2 3 -1
```

输出

```C
6
7
```

#### 解题思路

这道题看似简单，但是时间卡的很死，暴力TLE，所以需要使用前缀和，然后统计长度时从第k为寻找即可。同时两个区间要没有交集，因此一个从l查找，一个从l+k查找即可避免。解题代码非常巧，多积累，这种前缀和的思想很重要。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
ll a[2000005];
int main()
{

    ios::sync_with_stdio(0);
    int t;
    cin >> t;
    while (t--)
    {
        int n, k;
        cin >> n >> k;
        for (int i = 1; i <= n; i++)
        {
            //前缀和，a[i]就是1~i的所有数之和
            cin >> a[i], a[i] += a[i - 1];
        }
        ll ma = -1e18, ans = -1e18;
        //从k开始找，意味着一定是长度大于等于k的数之和
        for (int i = k; i + k <= n; i++)
        {
            //寻找第一个最大值，a[i]-a[i-k]保证了长度一定是k
            ma = max(ma, a[i] - a[i - k]);
            //很巧，ans刚好是找a[i+1]~a[i+k]的数之和，避免了两个区间交叉的情况出现
            ans = max(ans, ma + a[i + k] - a[i]);
        }
        cout << ans << endl;
    }
    system("pause");
    return 0;
}
```

### NC15172-情人节的电灯泡

#### 题目链接

https://ac.nowcoder.com/acm/problem/15172

#### 题目描述

情人节到了，小芳和小明手牵手，打算过一个完美的情人节，但是小刚偏偏也来了，当了一个明晃晃的电灯泡，小明很尴尬，就和小刚说，我交给你个任务，你完成了我俩就带你玩，否则你就回家吧。小刚很有当单身狗的觉悟，他坚决不想让小明过好情人节，同为单身狗的你能帮帮他吗？现在有一个n×n（1 <= n <= 1000）的格子，每一个格子都有一个电灯泡，可能是亮的，也可能是灭的（1代表亮， 0代表灭），现在有两种操作，一种是给你一个坐标，对于那个坐标上的灯泡，如果他是亮的，那么熄灭他，反之如果他是灭的，那么打开它。第二种操作是给你两个坐标，第一个坐标代表一个子矩阵的左上角，另一个坐标是右下角，请你求出当前子矩阵中有多少个灯泡是亮着的。燥起来吧！！！单身狗们！！！！

第一行两个整数，n（1 <= n <= 1000）和m（1 <= m <= 100000），分别代表正方形格子的边长和询问次数。
接下来n行，每一行有n个bool形数字（0或1），代表灯泡的状态。
接下来m行，每一行第一个数字f（1或2）代表操作的类型，如果f是1，那么接下来输入一个坐标（x, y）(1 <= x, y <= n)，对于当前位置的灯泡状态进行改变，如果是2，那么接下来输入两个坐标（x1, y1）(1 <= x1, y1 <= n)， （x2, y2）(1 <= x2, y2 <= n)，确定子矩阵的位置，输出子矩阵中亮着的灯泡数量并换行。对于每一个2操作，输出子矩阵中亮着的灯泡数量并换行。

#### 测试样例

输入

```c
6 4
0 0 1 0 1 0
1 0 1 1 0 1
1 0 0 0 0 0
1 1 0 0 1 0
0 0 0 0 1 1
0 0 0 0 1 0
2 2 2 4 5
1 1 1
2 1 1 6 6
1 2 6
```

输出

```c
4
14
```

#### 解题思路

大水题，直接模拟即可，以后再也不摸鱼了www。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

const int N = 1005;
int _map[N][N];

void find(int a, int b, int c, int d)
{
    int sum = 0;
    for (int i = a; i <= c; i++)
    {
        for (int j = b; j <= d; j++)
        {
            if (_map[i][j])
                sum++;
        }
    }
    cout << sum << endl;
}

int main()
{
    int n, m;
    cin >> n >> m;
    for (int i = 1; i <= n; i++)
    {
        for (int j = 1; j <= n; j++)
        {
            cin >> _map[i][j];
        }
    }
    while (m--)
    {
        int index;
        cin >> index;
        if (index == 1)
        {
            int x, y;
            cin >> x >> y;
            _map[x][y] = !_map[x][y];
        }
        else
        {
            int a, b, c, d;
            cin >> a >> b >> c >> d;
            find(a, b, c, d);
        }
    }
    system("pause");
    return 0;
}
```

### NC14705-良神吃点心

#### 题目链接

https://ac.nowcoder.com/acm/problem/14705

#### 题目描述

良神爱吃甜点，如果他吃不到甜点的话就会很暴躁！现在桌子上摆着一排n个点心，每个点心具有一个甜度ai，良神一次能吃连续的一些点心，但是他一次不能吃总甜度和超过m（可以等于m），否则他就长不高啦！良神想要知道他**最少**吃几次才能把这些点心都吃完。

第1行输入两个整数n，m，代表点心数量和一次可以吃的总甜度上限。

第2行输入n个整数，第i个整数代表第i个点心的甜度ai。

数据保证：0<n≤100，0<ai≤100，m≥ai的最大值。

输出一行，一个整数，代表良神吃的最少次数。

#### 测试样例

##### 样例1

输入

```c
5 6
4 2 4 5 1
```

输出

```c
3
```

说明

```c
良神可以按照[4 2][4][5 1]的方式吃点心，最少需要3次吃完。
```

##### 样例2

输入

```c
5 6
6 6 6 6 6
```

输出

```c
5
```

说明

```c
良神可以按照[6][6][6][6][6]的方式吃点心，最少需要5次吃完。
```

#### 解题思路

简单，就是从左往右吃，吃到能容忍的最大程度就重新吃几颗，主要是注意下每一次重新吃容忍度刷新为0，并且最后一次可能吃不到最大容忍度就结束啦，那也算吃一次。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

int a[105];

int main()
{
    int n, m;
    cin >> n >> m;
    for (int i = 1; i <= n; i++)
    {
        cin >> a[i];
    }
    //甜度
    int tmp = 0;
    //次数
    int ans = 0;
    int j = 1;
    while (j <= n)
    {
        tmp += a[j];
        //甜度大于m了，说明不吃j时是本次可以吃的最大程度
        if (tmp > m)
        {
            //将第j个甜品吐出来不吃可以承受
            tmp -= a[j];
            //tmp归零为下一次吃初始化
            tmp = 0;
            //吃的次数+1
            ans++;
            //j就不加了，因为j还没吃呢
            continue;
        }
        j++;
    }
    //坑点，如果最后一次吃完还没到最大承受度
    //那么也算一次吃了
    if (tmp != 0)
        ans++;
    cout << ans << endl;
    system("pause");
    return 0;
}
```

### NC14965-大吉大利，今晚吃鸡——枪械篇

#### 题目链接

https://ac.nowcoder.com/acm/problem/14965

#### 题目描述

在绝地求生（吃鸡）游戏里，不同的枪支有不同的威力，更是可以搭配不同的配件，以提升枪支的性能。

![](https://langwenchong.gitee.io/figure-bed/20210309223758.png)

每一把枪都有其威力及其可装备配件种类。每一个配件有其所属种类，可以为枪支提供威力的百分比加成。每一把枪只能装备一个同类配件。给你n把枪支和m个配件，枪的威力为p，可装备的配件数量为k，为k个不同类型的配件，同种类配件只可以装备一个。配件种类用数字q表示，配件威力加成用一个小数b表示。请你挑选一把枪并为其搭配配件使其威力最大。  假设一把枪的威力是p，装配的k个配件的威力加成是bi，那么枪最后的威力w=p*（1+b1+b2+…+bk）。

数据有多组，处理到文件结束。
第一行两个整数n和m，代表枪支数量和配件数量。
接下来n行，描述n把枪的属性：第一个整数为p，代表枪支的威力；第二个整数为k，代表该枪支可装备的配件数量；后面k个整数，代表可装备配件的种类。
接下来m行，描述m个配件的属性：第一个整数为q，代表配件的种类，第二个浮点数为b，代表配件可以为枪支提供的威力加成。

每组数据输出为一行，输出一个浮点数，代表合理装备配件后的枪支最大威力。精确到小数点后4位。

对于100%的数据，1 <= n,m,k,q <= 1000;0 <= p <= 1000;

#### 测试样例

输入

```c
3 6
120 3 1 2 3
100 4 1 2 3 4
110 3 2 3 4
1 0.12
2 0.23
2 0.26
4 0.57
3 0.35
5 0.41
```

输出

```c
239.8000
```

说明

```c
对于上面的样例，正确答案应该是，使用第三把枪，配上第三、四、五个配件。
枪的最终威力就是110*（1+0.26+0.57+0.35）=239.8
```

#### 解题思路

这道题实际上就是一个暴力枚举，但是比较锻炼读题能力，思路就是输入数据时将每一个最大类型的强奸属性记录下来，然后注意求得每一把枪满配的战斗力，然后取最大战斗力。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

struct Gun
{
    //枪的初始战斗力
    double num;
    //枪支持的配件数
    int len;
    //枪支持的配件号
    int a[1005];
} gun[1005];
//配件加强数值数组
double plugin[1005];

//计算每把枪的最理想战斗力
double Count(int x)
{
    double sum = 1;
    for (int i = 1; i <= gun[x].len; i++)
    {
        //这里要注意，较难想
        sum += plugin[gun[x].a[i]];
    }
    return gun[x].num * sum;
}

int main()
{
    int n, m;
    cin >> n >> m;
    //存储枪的初始数据
    for (int i = 1; i <= n; i++)
    {
        cin >> gun[i].num;
        cin >> gun[i].len;
        for (int j = 1; j <= gun[i].len; j++)
        {
            cin >> gun[i].a[j];
        }
    }
    //记录每一个型号的枪件最强属性
    for (int i = 1; i <= m; i++)
    {
        int index;
        double tmp;
        cin >> index >> tmp;
        plugin[index] = max(plugin[index], tmp);
    }
    double ans = 0.0;
    for (int i = 1; i <= n; i++)
    {
        if (ans < Count(i))
            ans = Count(i);
    }
    cout << fixed << setprecision(4) << ans << endl;
    system("pause");
    return 0;
}
```

### NC14670-脸盆大哥的木桶

#### 题目链接

https://ac.nowcoder.com/acm/problem/14670

#### 题目描述

彩虹岛网红脸盆大哥最骄傲就是自己制作的木桶。一天𝑙𝑤𝑞拿了𝑛块木板，其中第𝑖块木板的高度为ℎ𝑖，他希望脸盆大哥能够用这些木板制作出精美的木桶。脸盆大哥告诉𝑙𝑤𝑞制作一个木桶需要𝑘块木板，并且所有桶的底面积为𝑠，底面的木板由𝑠𝑙𝑝提供。𝑙𝑤𝑞想知道用这些木块所制作出来的木桶最多能够盛多少体积的水。
 注意，木板不能叠在另一个木板上，且不需要考虑木桶具体是怎么由木板组成的，即是说1块或2块木板也可以组成木桶，底面积仍为𝑠。

输入第一行为一个整数𝑇(2 ≤ 𝑇 ≤ 20)，表示一共有𝑇组测试数据。
对于每组测试数据：
第一行有三个整数𝑛(2 ≤ 𝑛 ≤ 103), 𝑘, 𝑠(1 ≤ 𝑛, 𝑘, 𝑠 ≤ 103)，分别表示木板的数量、制作一个木桶所需要的木板数以及木桶的底面积。
第二行有𝑛个整数，其中第𝑖个整数ℎ𝑖(1 ≤ ℎ𝑖 ≤ 103)代表第𝑖个木板的高度。

对于每组测试数据输出一个整数𝑥，代表用这些木板制作的桶最多能装体积为𝑥的水。

#### 测试样例

输入

```c
2
4 2 5
1 2 3 4
5 2 5
1 4 5 2 3
```

输出

```c
20
30
```

说明

```c
对于第一组样例，第一个桶由第一块木板和第二块木板组成，能够盛水的体积为5，第二个桶由第三块木板和第四块木板组成，能够盛水的体积为15，所以最终体积为20。
对于第二组样例，最后会剩下一块木板无法参与木桶的制作。
```

#### 解题思路

实际上就是将模板长度从高到低排序，然后每次选k个就组成一个桶，并且用最短的模板来计算体积。看注释很容易就能看懂。

#### 解题代码

```c
#include<bits/stdc++.h>
using namespace std;

const int N=1e5;
int a[N];

int main(){
    int t;
    cin>>t;
    while(t--){
        int n,k,s;
        cin>>n>>k>>s;
        for(int i=1;i<=n;i++){
            cin>>a[i];
        }
        //排序
        sort(a+1,a+1+n);
        int i=n;
        int ans=0;
        //每一个桶的最小高度分别是下面的i
        for(int i=n-k+1;i>=1;i-=k){
            ans+=a[i]*s;
        }
        cout<<ans<<endl;
    }
    system("pause");
    return 0;
}
```

### NC15360-银行存款

#### 题目链接

https://ac.nowcoder.com/acm/problem/15360

#### 题目描述

银行的定期存款一般有1年期、2年期、3年期、5年期四种。
 现在我们有1块钱，我们想知道，通过合理安排存款方式，n年以后这1块钱最多会变成几块钱。假设在这n年里利率不变，且n年以后这笔钱不能处于2年期、3年期、5年期存款年限的中间（否则会变成活期）。第一行五个数n, r1, r2, r3, r5分别表示年数，1年期年利率，2年期年利率，3年期年利率和5年期年利率。假设我们有1块钱，i年期存款到期后这1块钱会变成（1 + ri)i块钱。1 <= n <= 20 且 n为整数，0.04 <= r1 <= r2 <= r3 <= r5 <= 0.05。一行一个数表示答案。保留5位小数(绝对误差或相对误差在1e-5之内的结果均判断为通过)。

#### 测试样例

输入

```c
8 0.0430 0.0449 0.0458 0.0473
```

输出

```c
1.44112
```

#### 解题思路

就是一个简单的dp，对于这种前面状态决定后面状态的题，基本上就是打表dp，但是难点还是在于找到递推式，很遗憾，这次没找到，作为积累吧。

#### 解题代码

```c
#include <bits/stdc++.h>

#define ll long long
using namespace std;

double max(double a, double b)
{
    if (a > b)
        return a;
    else
        return b;
}
double dp[40];
int main()
{
    int n;
    double r1, r2, r3, r5;
    cin >> n >> r1 >> r2 >> r3 >> r5;
    r1 = pow(1 + r1, 1);
    r2 = pow(1 + r2, 2);
    r3 = pow(1 + r3, 3);
    r5 = pow(1 + r5, 5);
    dp[0] = 1;
    //dp打表yyds
    for (int i = 1; i <= 20; ++i)
    {
        if (i >= 1)
            dp[i] = max(dp[i - 1] * r1, dp[i]);
        if (i >= 2)
            dp[i] = max(dp[i - 2] * r2, dp[i]);
        if (i >= 3)
            dp[i] = max(dp[i - 3] * r3, dp[i]);
        if (i >= 5)
            dp[i] = max(dp[i - 5] * r5, dp[i]);
    }
    cout << dp[n] << endl;
    system("pause");
    return 0;
}
```

### NC14597-可编程拖拉机比赛

#### 题目链接

https://ac.nowcoder.com/acm/problem/14597

#### 题目描述

“这个比赛，归根结底就是控制一个虚拟的小拖拉机跑完整个赛道。一般一场比赛会有 9 个到 13 个赛道，最后看能跑完多少个赛道。”通常在一场可编程拖拉机比赛中，分别会有实际参赛队伍数 10%、20%、30% 向下取整的队伍获得金、银、铜牌，其余队伍获得荣誉提名，俗称“铁牌”。但是主办方往往会多准备一些奖牌，那么在发奖牌的时候会按照比例向上取整发出的奖牌以减少浪费，就会有一些原本获得银牌的队伍获得了金牌。现在给出一个赛区的规模，也就是这个赛区的实际参赛队伍数，小 Q 同学想知道有多少队伍的奖牌会由银变金、由铜变银、由铁变铜。输入只有一行，包含一个整数 n (10 <= n <= 1000)，表示实际参赛队伍数。输出一行，包含三个由空格分隔的整数，分别表示奖牌会由银变金、由铜变银、由铁变铜的队伍数。

#### 测试样例

输入

```c
115
```

输出

```c
1 1 2
```

#### 解题思路

我们首先要知道，当一个金牌人数增加时，那么根据堆积的效应，银牌和铜牌的人数也会加1，当银牌人数增加时，金牌人数不受影响，只是铜牌受影响，而铜牌人数改变不影响任何人数。当前10%不是刚好整数，即n%10不是0时，说明规矩改变后，金牌人数会加1，且最多只会有增多一个人，银牌就是前20%有问题，所以应该是模5不是0时，说明规矩改变后，银牌人数会加1且最多只会增加一个人，同理铜牌是n%（10/3）的时候，会增加一人。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

int main()
{
    int a = 0, b = 0, c = 0;
    int n;
    cin >> n;
    //当乘10%即模10的时候不是整数，那么所有牌的人数都++
    if (n % 10 != 0)
    {
        a++;
        b++;
        c++;
    }
    //当乘20%即模10/2=5的时候不是整数，那么银、铜人数都++
    if (2 * n % 10 != 0)
    {
        b++;
        c++;
    }
    //当乘30%即模10/3的时候不是整数，那么铜牌人数++
    if (3 * n % 10 != 0)
    {
        c++;
    }
    cout << a << " " << b << " " << c << endl;
    system("pause");
    return 0;
}
```

### NC14599-子序列

#### 题目链接

https://ac.nowcoder.com/acm/problem/14599

#### 题目描述

定一个小写字母字符串T ，求有多少长度为m的小写字母字符串S满足，T是S的一个**子序列**(不需要连续)。第一行一个字符串T，第二行一个正整数m，输出答案对109+7取模的值。

#### 测试样例

输入

```C
a
2
```

输出

```c
51
```

说明

```c
长度为2的里面有a的串有51种
```

#### 解题思路

逆元+组合数题，自己的没过，但是思路正确，直接看注释吧

#### 解题代码

```c
#include <bits/stdc++.h>
const int maxx = 1e5 + 15;
#define ll long long
//取模提前声明，好习惯
const ll mod = 1e9 + 7;
using namespace std;
string s;

//快速幂取模板子，注意第一个放C底下的数，第二个放C上面的数
ll qmi(int a, int k)
{
    a %= mod;
    //ans是结果值
    int ans = 1;
    //采用的是二进制的计算方法
    while (k)
    {
        //这里k在机器中是二进制表示，与1相与，只有k的最后一位是1才能使得if条件成立
        if (k & 1)
            //此时ans就乘以一个基数a
            ans = ans * a % mod;
        //每一次a都要扩大一倍表示下一位的位权
        a = a * a % mod;
        //k右移一位取最低位
        k >>= 1;
    }
    return ans;
}

//逆元取模的组合数板子
ll C(ll k, ll n)
{
    int num = 1;
    for (int i = 1, j = k; i <= n; i++, j--)
    //一共分子和分母只需要计算n次
    {
        //这里用来计算Ckn
        num = num * j % mod;
        //这里是求n!的逆元，以便能够取模
        num = num * qmi(i, mod - 2) % mod;
    }
    return num;
}

int main()
{
    ll i, m, n;
    cin >> s;
    cin >> m;
    n = s.length();
    //多余出来的位数
    ll ans = 0;
    //i至少有n个，同时还忽悠m-n个多于的位，这里就是在模拟这些位放在哪里
    //如果是插在子序列的左边或中间，那么就只能有25个选择
    //否则子序列右边就是26个选择
    //枚举子序列左边的位数（包括子序列自身）
    //那么i-n是插到子序列左边的多于位数的个数（有25个选择的位数个数）
    //m-i是放到子序列右边即后面的位数个数（有26个选择的位数的个数）
    //实际上模拟取模的二项式定理
    for (i = n; i <= m; i++)
    {
        //注意当长度为4，那么实际上C的底数是3即为n-1,上面就是
        ans += C(n - 1, i - 1) * qmi(25, i - n) % mod * qmi(26, m - i) % mod;
        ans %= mod;
    }
    cout << ans << endl;
    system("pause");
    return 0;
}
```

### NC14673-栗酱数数

#### 题目链接

https://ac.nowcoder.com/acm/problem/14673

#### 题目描述

栗酱在酒桌上玩一个小游戏，第一个人从1开始数数，如果遇到数字中含4或者数字是4的倍数则跳过报下一个，谁数错了就要罚酒一杯。所以栗酱想让你写个程序把所有数生成出来，这样她就可以作弊直接读了。你一定能解决的吧？只有一组数据，一个数n代表从1开始数到n。(n≤100000)，按顺序输出所有1到n之间任何一位都不是4的数，每两个数之间用一个回车隔开。

#### 测试样例

输入

```c
9
```

输出

```c
1
2
3
5
6
7
9
```

#### 解题思路

实际上就是一个枚举法，这里主要是练习一下用while不断模10取最后一位

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

int main()
{
    int n;
    cin >> n;
    for (int i = 1; i <= n; i++)
    {
        if (i % 4 == 0)
            continue;
        bool v = true;
        int k = i;
        while (k != 0)
        {
            if (k % 10 == 4)
            {
                v = false;
                break;
            }
            k /= 10;
        }
        if (v)
        {
            cout << i << endl;
        }
    }
    system("pause");
    return 0;
}
```

### NC14676-裁缝大师

#### 题目链接

https://ac.nowcoder.com/acm/problem/14676、

#### 题目描述

坤酱想把一块圆形的布裁成正多边形，于是请你告诉坤酱正多边形的几个顶点应在哪里？  为了方便表示，圆给出在坐标系中，正多边形的第一个顶点固定在该圆在平行于x轴正方向最远的位置上，请按顺时针顺序输出所有的顶点。输入第一行给出单独一个整数T，表示数据组数接下来T行，每行顺序给出四个整数x,y,R,N：表示圆心为(x,y)，半径为R，裁出一个正N边形。−104≤x,y≤104，0<R≤103，3≤N≤50。

对于每组数据，输出N行，从第一个顶点开始，按顺时针顺序输出所有N个顶点的坐标。
（由于坤酱工具有限，你只需保留2位小数）

#### 测试样例

输入

```c
2
0 0 10 4
100 0 1 3
```

输出

```c
10.00 0.00
0.00 -10.00
-10.00 0.00
0.00 10.00
101.00 0.00
99.50 -0.87
99.50 0.87
```

#### 解题思路

首先求出一个内角k=2pi/n的大小，然后从0度开始，每次减去一个内角，然后算Rsink和Rcosk也就是坐标变化量，然后用初始坐标相加即可。难点在于-0.0要标准化为0.0同时对于很小的10^-6以下的值也要标准化为0.0，这样类似于0.000001的值也会标准化为0.0从而实现和题目要求的小数位。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

//pi的定义，学习了
const double pi(acos(-1));

int main()
{
    int t;
    cin >> t;
    while (t--)
    {
        double cx, cy, r, n;
        cin >> cx >> cy >> r >> n;
        //一个内角的大小
        double k = 2 * pi / n;
        //其实就是每次旋转一个内角，然后坐标加上cos和sin的值即可
        for (int i = n; i; i--)
        {
            //sin函数和cos函数都是接受的参数为弧度
            double a = cx + cos(k * i) * r;
            double b = cy + sin(k * i) * r;
            //核心：当小于1e-6应该是0.0
            if (fabs(a) < 1e-6)
                a = 0.0;
            if (fabs(b) < 1e-6)
                b = 0.0;
            cout << fixed << setprecision(2) << a << " " << b << endl;
        }
    }
    system("pause");
    return 0;
}
```

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

### NC15431-比较月亮大小

#### 题目链接

https://ac.nowcoder.com/acm/problem/15431

#### 题目描述

点点是一名出色的狼人。众所周知，狼人只有在满月之夜才会变成狼。 同时，月亮的大小随着时间变化，它的大小变化30天为一循环。它的变化情况(从第一天开始)为0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 然后又再一次循环。 今年夏天点点很无聊，于是开始看月亮。由于点点很忙，所以他只选择一段连续的时间看月亮，并把月亮的大小记录了下来。现在，他告诉你他记录下东西，让你告诉他下一天(即点点记录下的最后一天的第二天)的月亮是比前一天(即点点记录下的最后一天)大还是小。

给你一个正整数n表示点点记录下的时间个数。下一行n个自然数表示点点记录下的月亮大小。一个字符串。如果下一天的比前一天的大则输出"UP"如果下一天的比前一天的小则输出"DOWN"。如果无法判断则输出"-1"

#### 测试样例

##### 样例1

输入

```c
5
3 4 5 6 7
```

输出

```c
UP
```

##### 样例2

输入

```c
8
12 13 14 15 14 13 12 11
```

输出

```c
DOWN
```

##### 样例3

输入

```c
1
8
```

输出

```c
-1
```

#### 解题思路

实际上我们发现只要观察前两个天数就可以判断出天数的走向从而锁定起始天数的位置，然后加上n天就是我们要比较的那个天X，那X和起始天进行比较即可。但是要注意对于只有1天的情况要进行特判，如果是1天，那么只有0和15可以判断，其他情况都是无法判断。

#### 解题代码

```java
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int date[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2,
                1 };
        int n = sc.nextInt();
        if (n == 1) {
            // 一个情况的特判
            int a = sc.nextInt();
            // 如果刚好是0，那么下一天一定是1，直接输出UP
            if (a == 0)
                System.out.println("UP");
            // 如果是15，那么下一天一定是14，直接输出DOWN
            else if (a == 15)
                System.out.println("DOWN");
            else
                // 否则无法判断，返还-1
                System.out.println("-1");
        } else {
            int a[] = new int[n + 1];
            for (int i = 1; i <= n; i++) {
                a[i] = sc.nextInt();
            }
            int index = 0;
            // 寻找匹配的段，实际上两个天就可以找到起始天了
            case1: for (int i = 0; i < 30; i++) {
                for (int j = 1; j <= 2; j++) {
                    if (a[j] == date[i] && a[j + 1] == date[i + 1]) {
                        index = i;
                        break case1;
                    }
                }
            }
            // 然后加上n天取模30（因为可能会到下一个30天了）
            // 就得到了需要的下一天
            // 根据大小判断即可，此时不可能再有无法判断的情况了
            if (date[index + n % 30] > a[n])
                System.out.println("UP");
            else
                System.out.println("DOWN");
        }
    }
}
```

### NC16120-博弈论

#### 题目链接

https://ac.nowcoder.com/acm/problem/16120

#### 题目描述

铁子和顺溜在学习了博弈论的sg函数之后，解决了很多很多博弈题，现在他们遇到了一道难题。给出一个长度为 n 的数列，数列里的每个元素都是个位数，这个数列的每一个连续子数列都能生成。一个十进制数，对于子数列a[l~r]，这个十进制数的个位为a[r],十位为a[r - 1]，...，最高位为a[l]。现在铁子需要知道最小的不能被该数列的子数列生成的十进制非负整数是多少？第一行一个数字n。(1 ≤ n ≤ 1000)。第二行n个数字di。(0 ≤ di ≤ 9)。输出一个数字表示答案。

#### 测试样例

##### 样例1

输入

```c
4
3 0 1 2
```

输出

```c
4
```

##### 样例2

输入

```c
10
9 8 7 6 5 4 3 2 1 0
```

输出

```c
11
```

#### 解题思路

大水题，一开始读错题了以为是子序列，谁知道居然是子数列，那么就简单许多了，直接暴力打表即可。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

bool v[1000009];
int a[100005];

int main()
{
    int n;
    cin >> n;
    for (int i = 1; i <= n; i++)
    {
        //存入数列
        cin >> a[i];
    }
    //枚举打表
    //初始位置从i开始
    for (int i = 1; i <= n; i++)
    {
        //子数列长度最大也就到6了，再长表示不出来了
        for (int l = 1; l <= 6; l++)
        {
            int ans = 0;
            //j最长只能到n和i+l-1的最小值，即可能j到不了n，如果超出n了那么就停止
            for (int j = i; j <= min(n, i + l - 1); j++)
            {
                ans = ans * 10 + a[j];
            }
            v[ans] = 1;
        }
    }
    for (int i = 0; i <= 1e6; i++)
    {
        //找道第一个表示不出来的数
        if (!v[i])
        {
            cout << i << endl;
            return 0;
        }
    }
}
```

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

### NC15434-wyh的迷宫

#### 题目链接

https://ac.nowcoder.com/acm/problem/15434

#### 题目描述



给你一个n*m的迷宫，这个迷宫中有以下几个标识：  

  s代表起点  ，t代表终点  ，x代表障碍物  ，.代表空地  

  现在你们涵哥想知道能不能从起点走到终点不碰到障碍物（只能上下左右进行移动，并且不能移动到已经移动过的点）。

输入第一行一个整数T(1<=T<=10)。接下来有T组测试数据，对于每一组测试数据，第一行输入2个数n和m(1<=n,m<=500)。接下来n行，每行m个字符代表这个迷宫，每个字符都是上面4个中的一种数据保证只有一个起点和一个终点。

对于每一组测试数据，如果可以的话输出YES，不可以的话输出NO。

#### 测试样例

输入

```c
1
3 5
s...x
x...x
...tx
```

输出

```c
YES
```

#### 解题思路

还是dfs板子题，主要是复习一下，水题，不写思路了。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

char _map[505][505];
int vis[505][505];
int dir[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
int m, n;
bool ok;

void dfs(int i, int j)
{
    if (i > m || i < 1 || j > n || j < 1)
    {
        return;
    }
    if (_map[i][j] == 'x')
    {
        return;
    }
    if (_map[i][j] == 't')
    {
        ok = true;
        return;
    }
    if (vis[i][j] == 1)
        return;
    vis[i][j] = 1;
    for (int k = 0; k < 4; k++)
    {
        dfs(i + dir[k][0], j + dir[k][1]);
    }
    return;
}
int main()
{
    int t;
    cin >> t;
    while (t--)
    {
        cin >> m >> n;
        int x, y;
        ok = false;
        memset(_map, 0, sizeof(_map));
        memset(vis, 0, sizeof(vis));
        for (int i = 1; i <= m; i++)
        {
            for (int j = 1; j <= n; j++)
            {
                cin >> _map[i][j];
                if (_map[i][j] == 's')
                {
                    x = i;
                    y = j;
                }
            }
        }
        dfs(x, y);
        if (ok)
            cout << "YES" << endl;
        else
            cout << "NO" << endl;
    }
    system("pause");
    return 0;
}
```

### NC219018-NIH Budget

#### 题目链接

https://ac.nowcoder.com/acm/problem/219018

#### 题目描述

Recently, a job for an algorithms specialist opened up at NIH. You never thought you’d be using your expertise in algorithms to save lives, but now, here is your chance! While the doctors are very good in carrying out medical research and coming up with better cures for diseases, they are not so good with numbers. This is where you come in.  You have been tasked to allocate money for all disease research at NIH. The interesting thing about disease research is that the number of lives saved doesn’t linearly increase with the amount of money spent, in most cases. Instead, there are “break-points”. For example, it might be the case that for disease A, we have the following break-points:

| Research Funding | Lives Saved |
| :--------------: | :---------: |
|    10 million    |      5      |
|    50 million    |     100     |
|   100 million    |    1000     |
|   250 million    |    1100     |

f you spend more money than one breakpoint and less than another, the number of lives saved is equal to the amount saved for the previous breakpoint. (In the above example, if you spent 150million,you’dstillonlysave1000lives,andifyouspentanyamountmorethan150 million, you’d still only save 1000 lives, and if you spent any amount more than 150million,you’dstillonlysave1000lives,andifyouspentanyamountmorethan250 million, you’d still save 1100 lives.) The doctors have figured out charts just like this one for all the diseases for which they do research.  Given these charts, your job will be to maximize the number of lives saved spending no more than a particular budget.Given several charts with information about how much has to be spent to save a certain number of lives for several diseases and a maximum amount of money you can spend, determine the maximum number of lives that can be saved.

The first input line contains a positive integer, n (n ≤ 100), indicating the number of budgets to consider. The first line of each budget contains two positive integers, d (d ≤ 10), representing the number of diseases for which there is data and B (B ≤ 100000), the total budget, in millions of dollars. The following d lines contain information about each of the d diseases. Each of these lines will contain exactly four ordered pairs of positive integers separated by spaces. Each pair will represent a dollar level (in millions) followed by the number of lives saved for that dollar 

level of funding. Each of the pairs will be separated by spaces as well. Each of these values will be less than or equal to 100,000. Assume that the dollar levels on an input line are distinct and in increasing order, and that the number of lives saved on an input line are also distinct and in increasing order.

For each test case, just output a line with the following format:
Budget #k: Maximum of x lives saved.
where k is the number of the budget, starting at 1, and x is the maximum number of lives saved in that budget.
Leave a blank line after the output for each test case. 

####  测试样例

输入

```c
3
2 2000
10 5 50 100 100 1000 250 1100
100 1 200 2 300 3 1900 1000
3 100
10 100 40 200 70 300 100 500
5 1 25 2 35 3 50 4
200 10000 300 20000 400 30000 500 40000
1 10
100 2 200 3 300 5 400 6
```

输出

```c
Budget #1: Maximum of 2000 lives saved.

Budget #2: Maximum of 500 lives saved.

Budget #3: Maximum of 0 lives saved.
```

#### 解题思路

其实读完题就有一种感觉那就是背包问题，其实仔细想一想，每一种疾病只能选择一种投资方案来解决，最终求得的是总体的最大收益，这就是分组背包问题，直接上板子即可，主要是注意一下，此时已经分好组了，所以存组号的时候需要注意一点点细节，还有就是每一中疾病都是4个方案，并且一共有d中疾病，所以将4*d个方案存到一个一维数组仍可以使用降维。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

const int N = 1e5;
//f是最高价值
//p是每一个节点的收益值
//w每一个节点的成本值
//g记录组号
int f[N], p[N], w[N], g[N];

int main()
{
    int t;
    cin >> t;
    int num = 0;
    while (t--)
    {
        num++;
        //多组测试需要初始化
        memset(w, 0, sizeof(w));
        memset(p, 0, sizeof(p));
        memset(g, 0, sizeof(g));
        memset(f, 0, sizeof(f));
        //d种疾病，总资金c
        int d, c;
        cin >> d >> c;
        for (int i = 1; i <= d; i++)
        {
            for (int j = 1; j <= 4; j++)
            {
                //存入成本，收益
                cin >> w[(i - 1) * 4 + j];
                cin >> p[(i - 1) * 4 + j];
                //用时进行分组
                g[(i - 1) * 4 + j] = i;
            }
        }
        //分组背包
        //此时每次遍历i就是打印一行
        //枚举组->枚举容量->枚举某一组中的所有节点
        //逆序容量dp降维
        for (int i = 1; i <= d; i++)
        {
            //注意，此时y还是从大到小
            for (int y = c; y >= 0; y--)
            {
                for (int k = 1; k <= 4 * d; k++)
                {
                    if (y >= w[k] && g[k] == i)
                    {
                        f[y] = max(f[y], f[y - w[k]] + p[k]);
                    }
                }
            }
        }
        printf("Budget #%d: Maximum of %d lives saved.\n\n",num,f[c]);
        // cout << "Budget #" << num << ": Maximum of " << f[c] << " lives saved." << endl;
    }
    system("pause");
    return 0;
}

```

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

![](https://langwenchong.gitee.io/figure-bed/20210320000703.png)

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

### NC14266-Laptop

#### 题目链接

https://ac.nowcoder.com/acm/problem/14266

#### 题目描述

FST是一名可怜的小朋友，他很强，但是经常fst，所以rating一直低迷。
但是重点在于，他非常适合ACM！并在最近的区域赛中获得了不错的成绩。
拿到奖金后FST决定买一台新笔记本，但是FST发现，在价格能承受的范围内，笔记本的内存和速度是不可兼得的。
 可是，有一些笔记本是被另外一些“完虐”的，也就是内存和速度都不高于另外某一个笔记本，现在FST想统计一下有多少笔记本被“完虐”。

第一行一个正整数n，
表示笔记本的数量。接下来n行，每行两个正整数Mi，Si表示这款笔记本的内存和速度。
n≤105,Mi,Si≤109

输出一行，一个正整数，表示被完虐的笔记本数。

#### 测试样例

输入

```c
4
100 700
200 500
50 100
300 400
```

输出

```c
1
```

#### 解题思路

实际上是一个简单的排序思维题，首先我们将内存进行从大到小排序，那么第i个pad肯定是不会被第i+1个pad完爆的，因为前者的内存要比后者大，所以检验i完爆的电脑时，只需检验比他内存小的即在他后面的电脑，但是要注意并不是i就一定完爆其他的所有电脑，因为他的速度未必是最大的，所以我们单独枚举i从n到1，即内存从大到小，然后在记录最大的速度值，当被检验的电脑速度也小于i，那么他就被完爆了。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

const int N = 1e5;
struct Pad
{
    //存储ram和速度
    int a;
    int b;
} pad[N];

bool cmp(Pad x, Pad y)
{
    //将内存从大到小排序
    return x.a > y.a;
}

int main()
{
    int n;
    cin >> n;
    for (int i = 1; i <= n; i++)
    {
        cin >> pad[i].a >> pad[i].b;
    }
    //排序后最靠前的是内存最大的
    sort(pad + 1, pad + 1 + n, cmp);
    int ans = 0;
    //记录最大的速度
    int maxb = 0;
    for (int i = 1; i <= n; i++)
    {
        //更新最大速度
        if (pad[i].b > maxb)
            maxb = pad[i].b;
        else
        {
            //此时pad[i]被完爆了，因为他一定比pad[i-1]之前的ram小
            //此时速度又小了，那么就被完爆了
            ans++;
        }
    }
    cout << ans << endl;
    system("pause");
    return 0;
}
```

### NC14685-加边的无向图

#### 题目链接

https://ac.nowcoder.com/acm/problem/14685

#### 题目描述

给你一个 n 个点，m 条边的无向图，求至少要在这个的基础上加多少条无向边使得任意两个点可达~ 。

第一行两个正整数 n 和 m 。接下来的m行中，每行两个正整数 i 、 j ，表示点i与点j之间有一条无向道路。输出一个整数，表示答案。

#### 测试样例

输入

```c
4 2
1 2
3 4
```

输出

```c
1
```

#### 解题思路

就是一个很明显的并查集板子题，连接以后统计连通块数，需要练的边数就是连通块数减一。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

const int maxn = 1e5 + 5;

int fa[maxn];
//板子
int find(int x)
{
    return x == fa[x] ? x : (fa[x] = find(fa[x]));
}

void merge(int x, int y)
{
    int i = find(x);
    int j = find(y);
    fa[i] = j;
}

int main()
{
    //初始化，默认每一个孤立点都是一个连通块
    for (int i = 0; i < maxn; i++)
    {
        fa[i] = i;
    }
    int n, m;
    cin >> n >> m;
    //合并
    for (int i = 1; i <= m; i++)
    {
        int x, y;
        cin >> x >> y;
        merge(x, y);
    }
    int ans = 0;
    //统计连通块个数，属于同一个i的是一个连通块
    for (int i = 1; i <= n; i++)
    {
        if (find(i) == i)
            ans++;
    }
    //需要ans-1个边
    cout << ans - 1 << endl;
    system("pause");
    return 0;
}
```

### NC15891-iko和她的糖

#### 题目链接

https://ac.nowcoder.com/acm/problem/15891

#### 题目描述

iko超级超级喜欢吃糖，有一天iko想出去玩，她计划从1点走到N点（按1,2,3，...，n的顺序走），每个点都有一个补给站，第i点的补给站有a[i]颗糖，从i点走到i+1点会消耗掉b[i]颗糖，iko在出游的途中可以选择三个补给站，iko想知道她走完全程到达N点时口袋里最多还能剩下几颗糖（初始时iko的口袋里一颗糖都没有）。

第一行输入N（3<=N<=1000）
第二行输入N个数代表a[1].......a[N]  (0<=a[i]<=1000 )
第三行输入N-1个数代表b[1]......b[N-1]  ( 0<=b[i]<=1000 )

输出一个数字表示iko到达n点时口袋里最多剩下的糖，若不能到达N点输出-1。

#### 测试样例

##### 样例1

输入

```c
3
1 3 4
3 4
```

输出

```c
-1
```

##### 样例2

输入

```c
5
3 4 5 2 4
3 2 2 2
```

输出

```c
3
```

#### 解题思路

dfs剪枝就可以，根据题意我们知道每一个站点都会经过一次所以每一次都要花费一定的糖，到达站点以后iko可以选择那这个站点的糖或者不拿（dfs两个不同方向的搜索）。同时剪枝的条件是当到达某个站点后剩余糖数是负数，说明他不能到达这个站点，也就走不到这里所以就停止，或者拿糖次数一定多于3次了，那么也停止。当他可以到达13号站点时说明他可以到达终点，那么用max统计不同到达终点策略最后剩下的最多糖数即可。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

const int N = 1e5;
int ans = -1;
//存储获取糖的数量，以及达到这个站点消耗的糖的数量
int a[N], b[N];
int n;

//当下剩余的糖的数量，所处站点编号，已经拿过糖的次数
void dfs(int extra, int x, int c)
{
    //如果拿糖次数>3
    //或者剩余糖的数量<0,说明到达不了这个站点
    if (c > 3 || extra < 0)
    {
        //退出
        return;
    }
    //如果到达了n+1，那么就走完了，统计糖的个数
    if (x == n + 1)
    {
        ans = max(ans, extra);
        return;
    }
    //去往下一个站点，并且此次站点不拿糖
    dfs(extra - b[x], x + 1, c);
    //去往下一个站点，并且此次站点拿糖
    extra += a[x];
    dfs(extra - b[x], x + 1, c + 1);
}
int main()
{
    cin >> n;
    for (int i = 1; i <= n; i++)
    {
        cin >> a[i];
    }
    for (int i = 1; i < n; i++)
    {
        cin >> b[i];
    }
    dfs(0, 1, 0);
    cout << ans << endl;
    system("pause");
    return 0;
}
```

### NC15613-K序列

#### 题目链接

https://ac.nowcoder.com/acm/problem/15613

#### 题目描述

给一个数组 a，长度为 n，若某个子序列中的和为 K 的倍数，那么这个序列被称为“K 序列”。现在要你 对数组 a 求出最长的子序列的长度，满足这个序列是 K 序列。链接：

第一行为两个整数 n, K, 以空格分隔，第二行为 n 个整数，表示 a[1] ∼ a[n]，1 ≤ n ≤ 105 , 1 ≤ a[i] ≤ 109 , 1 ≤ n，K ≤ 107 。输出一个整数表示最长子序列的长度 m。

#### 测试样例

输入

```c
7 5
10 3 4 2 2 9 8
```

输出

```c
6
```

#### 解题思路

dp,一如既往地大脑空白，就当总结题型了，其实这道题和[《被3整除的子序列》](https://coolchong.cn/2021/02/05/Nowcoder7/)这道题有相同的思路，可以作为参考。我们每次取一个数，假设为num[i]，并且声明两个数组，dp[j]表示的是加上num[i]以后模k余数为j的最长子序列的长度，temp[h]表示的是在未加num[i]之前余数为h的最长子序列的长度。那么我们很容易得到一个递推式：
$$
dp[(num[i]+j)\%k]=temp[j]+1
$$
即cnt=(num[i]+j)%k,那么dp[cnt]即余数为cnt的最长子序列长度就等于temp[j]+1即等于余数为j的最长子序列的长度+1。但是我们要注意几个细节：

- 如果temp[j]==0，那么也就是说明在num[i]之前的所有数无论怎么组合也凑不来余数为j的子序列，那么很显然余数为(num[i]+j)%k的子序列也凑不来，所以跳过上面的递归式
- 但是如果temp[j]\==0时又满足j==0，那么此时（num[i]+j)%k的子序列至少可以增加一个长度，即只取num[i]自己组成一个单位长度的子序列就满足num[i]%k\==0，所以可以进入上面的递归式
- 每一次检验完一个数以后，dp[j]的长度可能大于或等于temp[j]，所以我们需要更新temp数组

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;

const int maxn = 1e5 + 5;
const int maxk = 1e7 + 5;
//假设我们取的下一个数是num[i]
//temp[j]表示在num[i]之前的所有数中所能凑出的余数为j的最长子序列的长度
int temp[maxk];
//dp[j]表示在加上num[i]以后余数为j的子序列的最大长度
int dp[maxk];
//存储数值
int num[maxn];
int main()
{
    int n, k;
    cin >> n >> k;
    for (int i = 0; i < n; i++)
        cin >> num[i];
    for (int i = 0; i < n; i++)
    {
        //j==0时可以进入，因为至少存在一个只取num[i]自己组成一个单位长度的子序列使得余数为(0+num[i])%k的子序列长度+1
        //temp[j]==0时不可以进入，因为此时就不存在能凑出来所需要的余数为j的子序列
        //那么相应的余数为(j+num[i])%k的子序列肯定也不存在，所以就不用加一了
        for (int j = 0; j < k; j++)
        {
            if (j == 0 || temp[j] != 0)
                dp[(j + num[i]) % k] = temp[j] + 1;
        }
        //每次检查完num[i]以后
        //dp>=temp,所以我们需要更新temp
        for (int j = 0; j < k; j++)
            temp[j] = max(temp[j], dp[j]);
    }
    cout << temp[0] << endl;
}
```

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

### NC13882_C-涂墙

#### 题目链接

https://ac.nowcoder.com/acm/contest/13882/C

#### 题目描述

母牛哥有一桶油漆,把它用完可以给n平方米的墙涂上颜色. 母牛哥想要在墙上涂5个正方形(这些正方形的边长都是整数,单位是米),并且刚好把油漆用完. 母牛哥能做到吗?

第一行一个数字t(<=1000),表示测试样例数量

接下来t行,每行一个数字n(0<=n<=1000000),表示母牛哥的油漆可以涂多少平方米.

输出t行,对于每个输入.如果母牛哥能够做到,就输出YES.否则输出NO.

#### 测试样例

输入

```c
2
4
55
```

输出

```c
NO
YES
```

说明

```
4显然不能分解成5个正平方数,所以这桶油漆不能涂5个正方形.
55可以涂5个正方形,他们面积分别是1 4 9 16 25.
```

#### 解题思路

一开始想的就是dfs，逐一尝试但是超时。。后来借鉴大佬的代码，使用打表枚举发现规律，只有几个数不满足，其他数都是满足条件的。

#### 解题代码

##### dfs(虽然没够，但好歹练习了一下)

```c
#include <bits/stdc++.h>
using namespace std;
const long long N = 1e5;
long long n;
bool ok = false;

//这次要加的数，和，加的次数
void dfs(long long x, long long sum, long long num)
{
    if (x >= n)
        return;
    if (num == 5)
    {
        if (sum == n)
        {
            ok = true;
        }
        return;
    }
    //不选这个数x
    dfs(x + 1, sum, num);
    sum += x * x;
    if (sum > n)
    {
        return;
    }
    //选了这个数x，并且下一个还是选x
    dfs(x, sum, num + 1);
    //选了这个数x，并且下一个数选x+1
    dfs(x + 1, sum, num + 1);
}
int main()
{
    long long t;
    cin >> t;
    while (t--)
    {
        ok = false;
        cin >> n;
        //从1开始
        dfs(1, 0, 0);
        if (ok)
            cout << "YES" << endl;
        else
            cout << "NO" << endl;
    }
    system("pause");
    return 0;
}
```

##### 打表发现规律以后特判

```c
#include <bits/stdc++.h>
using namespace std;
typedef long long ll;

signed main() {
    ios::sync_with_stdio(false), cin.tie(0);
    ll t;
    cin >> t;
    while (t--) {
        ll n;
        cin >> n;
        if (n == 5 || n == 8 || n == 11 || n == 13 || n == 14 || n == 16 || n == 17 || (n != 33 && n >= 19))
            cout << "YES" << endl;
        else
            cout << "NO" << endl;
    }
    system("pause");
    return 0;
}
```

### NC13882_E-捡贝壳

#### 题目描述

小明来到一片海滩上，他很喜欢捡贝壳，但他只喜欢质量**为x的倍数**的贝壳。 贝壳被排列成一条直线，下标从1到n编号,小明打算从编号为区间[l,r]的贝壳中,捡起所有他喜欢的贝壳。你能帮他计算出他能捡多少贝壳吗。 给出一个大小为n(n≤105)的数组，下标从1到n编号，a1,a2,...ana_1,a_2,...a_na1,a2,...an。a_i表示贝壳的质量。 给出q(q≤5∗104)次询问，每次询问包含3个整数l,r,x(1≤l≤r≤n,1≤x≤105)l每次询问，输出一行整数,表示这次询问中能捡到的贝壳数。

第一行给出两个整数n和q，含义如上所示。第二行给出n个整数表示a1,a2,...ana_1,a_2,...a_na1,a2,...an。接下来q行，每行3个整数l,r,x，含义如上所示。对于每次询问输出该次询问中能捡到的贝壳数

#### 测试样例

##### 样例1

输入

```c
5 3
1 2 3 4 5
1 3 2
1 5 3
2 5 4
```

输出

```c
1
1
1
```

##### 样例2

输入

```c
10 3
5532 24380 19363 11022 23965 22383 27049 22357 30453 7451
1 6 2
3 10 10
1 10 9
```

输出

```c
3
0
1
```

#### 解题思路

直接枚举+桶排序绝对超时，需要使用vec进行分块，具体思路见注释。灵活使用lower_bound和upper_bound函数进行统计。

#### 解题代码

```c
#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
const int maxn = 1e5 + 10;

vector<int> vec[maxn];
signed main()
{
    ios::sync_with_stdio(false), cin.tie(0);
    int n, q;
    cin >> n >> q;
    int big = 0;
    for (int i = 1; i <= n; ++i)
    {
        int p;
        cin >> p;
        big = max(big, p);
        //将质量为p的贝壳的键值压入p容器，所以vec[p]存放的是所有质量为p的贝壳键值
        vec[p].push_back(i);
    }
    while (q--)
    {
        int l, r, x;
        cin >> l >> r >> x;
        int ans = 0;
        //枚举x的倍数的质量的贝壳
        for (int i = x; i <= big; i += x)
        {
            //大于等于质量为i的键值
            int zuo = lower_bound(vec[i].begin(), vec[i].end(), l) - vec[i].begin();
            //大于质量为i的键值
            int you = upper_bound(vec[i].begin(), vec[i].end(), r) - vec[i].begin();
            //相见就是所有质量为i的贝壳的数量
            ans += you - zuo;
        }
        cout << ans << endl;
    }
    system("pause");
    return 0;
}
```

