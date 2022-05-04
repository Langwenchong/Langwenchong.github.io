---
title: 浅谈前缀和&差分
comments: false
top: false
date: 2022-02-07 15:59:11
tags: [算法,前缀和,差分]
categories: 
	- [知识分享,学习心得]
headimg: https://langwenchong.gitee.io/figure-bed/20220208180137.png
---

本文简单讲述一维前缀和、二维前缀和、一维差分、二维差分等算法的原理和应用题目。当然还会记录翀翀对于以上算法的自我理解以及代码板子😗。

<!-- more -->

{% note quote ,

本文借鉴了pengpenglang大佬的[《差分》](https://pengpenglang.cn/posts/2695935933/)以及carrynotkarry的[《CUGBACM21级讲课之前缀和&差分&离散化(Carry)》]()，感谢以上大佬的精彩讲解。

%}

### 前缀和

#### 概念&用途

前缀和就是对数组中的元素进行预处理，进行前n项求和。他的作用常用于区间的求和，合理使用前缀和可以简化复杂的区间求和问题降低复杂度。假设现在我们定义一维前缀和s[i]，那么他就表示对数组中第1~i个元素的值进行求和，如下所示
$$
S[i]=a_1+a_2+a_3+...+a_i
$$

#### 一维前缀和

假设我们现在要输入一个长度为n的整数序列，接下来再输入q个查询，每一个询问都会输入一个l,r表示此次要求和查询的区间（闭区间）。那么我们该如何解决这道题呢？

首先第一想法就是暴力求和，对[l,r]内的元素逐一累加输出求和结果，但是这样当n和q稍微大一点就可能造成时间超时。原因就是时间复杂度过高了为O(n*q)，总是出现相邻查询的元素有大量重叠造成多次遍历，比如第一次要查询[3.7]内的元素之和，第二次要查询[2.5]的元素之和，那么每一次查询都要扫一次数组，就会很慢，因此我们需要用到一维前缀和进行预处理加快每一个查询的速度。

我们可以如下处理，假设传进来的元素存入num列表，那么我们再定义一个pre列表专门来存放前i个元素的和即前缀和，因此pre[i]的定义就是：
$$
pre[i]=num[1]+num[2]+...+num[i]
$$
紧接着我们很容易就可以看出pre[i]和pre[i-1]存在以下递推关系：
$$
pre[i]=pre[i-1]+num[i]
$$
很明显pre列表的长度应该与num列表长度相同，那么假设现在我们已知了输入的num列表元素，如何才能求得pre列表呢？很简单，我们只需要扫一遍num列表就可以通过如上递推公式求得pre列表了：

```python
#pre[0]和num[0]都初始化为0
for i in range(1, n+1):
        pre[i] = num[i]+pre[i-1]
```

也就是说我们只用一个时间复杂度O(n)就完成了一维前缀和数组pre的生成，加下来对于q次查询，我们如何对每一个[l,r]区间的元素进行求和呢？

也很简单，只需要用`pre[r]-pre[l-1]`就可以轻松地计算出[l,r]内所有元素之和了，原理如下：

![](https://langwenchong.gitee.io/figure-bed/20220207162446.png)

这样每一次查询就不用再扫一遍num数组了，时间复杂度降为了O(1)，那么q次查询

时间复杂度就是O(q)，因此使用一维前缀和解决这个问题的时间复杂度从O(n*q)降低为了O(n+q)。

回顾下一维前缀和的总体流程，实际上就是如下图所示：

![](https://langwenchong.gitee.io/figure-bed/20220207162650.png)

接下来给出板子：

```python
# 一位前缀和
# 对下标范围[1,n]的数组查询q次指定区间的元素之和
def solve():
    n, q = map(int, input().split())
    #一定要注意num和pre的第0个元素初始化为0
    num = [0]
    pre = [0]*int(1e5+5)
    num.extend(list(map(int, input().split())))
    for i in range(1, n+1):
        pre[i] = num[i]+pre[i-1]
    for i in range(q):
        l, r = map(int, input().split())
        print(pre[r]-pre[l-1])
```

##### 思考：为什么num和pre的第0位要初始化为0?

我们思考一下这个递推公式，为什么我们能够通过pre[i]=pre[i-1]+num[i]就可以计算出pre[1]呢？实际上当i=0时，才能出现pre[1]=pre[0]+num[1]即pre[1]=num[1]的公式从而进行接下来的递推求解。

{% note info,

要注意在算法题中，相较于0\~len(arr)-1方式的存储，我们更倾向于按照1~len(arr)的方式存储，因此在python中for循环要用`range(1,len(arr-1))`，同时初始化时数组要特别留意将第0位初始化为0方便后面的计算。

%}

#### 二维前缀和

二维前缀和实际上就在一维前缀和的基础上增加了一维，因此我们此时再看待前缀和就不要再一维的数轴，长度上进行思考，而应该从二维矩阵，面积上进行思考。

先看题意，假设现在输入了一个n行m列的整数矩阵，在输入q个查询，每一个查询包括四个整数x1,y1,x2,y2表示一个子矩阵的左上角坐标和右下角坐标。对于每一个查询输出两个坐标所表示的矩阵内的元素之和（包括边界上的）。

实际上本质上并没有变，我们还是要先预处理计算出二维前缀和，此时很明显我们需要使用num\[][]和pre\[][]来存储矩阵元素值和计算生成的前缀和了。此时num\[i][j]很容易理解就是表示二维矩阵中某个点对应元素的值，而pre\[i][j]表示应该是从左上角原点\[1][1]到第i行第j列所在点\[i][j]所形成的矩形包含的所有元素值之和。那么我们如何计算这个pre\[i][j]呢？

在一维中，我们是参考了长度来得出了pre\[i]的递推公式，那么此时我们需要参考面积来得出pre\[i][j]的递推公式了，如下所示：

![](https://langwenchong.gitee.io/figure-bed/20220207170847.png)

对于一维中我们是知道了pre[i-1]和num[i]从而通过递推公式计算得出了pre[i]，那么这里的二维我们肯定是知道了pre\[i-1][j-1]和num\[i][j]进行递推计算出pre\[i][j]。从上面的面积计算与容斥原理的应用，我们很容易就可以得到大蓝色面积pre\[i][j]的计算递推公式即等于绿色面积pre\[i-1][j]和紫色面积pre\[i][j-1]之和再加上小蓝面积num\[i][j]后再减去一个红色面积pre\[i-1][j-1]得到的，因此递推公式就是
$$
pre[i][j]=pre[i-1][j]+pre[i][j-1]+num[i][j]-pre[i-1][j-1]
$$
同样的我们再将pre的第0行和第0列初始化为0，num的第0行和第0列初始化为0就可以通过递推公式完成二维前缀和的处理了。

如下所示：

```python
num = [[0] for i in range(int(1e5+5))]
pre = [[0]*int(m+5) for j in range(int(n+5))]
for i in range(1, n+1):
    num[i].extend(list(map(int, input().split())))
    for j in range(1, m+1):
        pre[i][j] = pre[i-1][j]+pre[i][j-1]+num[i][j]-pre[i-1][j-1]
```

{% note info,

注意python的二维矩阵初始化代码写法， n行m列要先循环设置m再循环设置n，同理，如果要设置三维数组n行m列k层，那么此时代码如下所示：

```python
pre=[[[0]*(k+5) for i in range(m+5)]for j in range(n+5)]
```

之所以要多开5个内存单元是为了减少处理列表边界的麻烦问题。**同时切记不能写成如下这样是错误的！！**

```python
pre=[[[0]*(k+5)]*(m+5)]*(n+5)
```

这种写法会因为使用了浅复制造成多个一维数组之间指向了统一内存单元。必须使用for循环构造器才能深拷贝保证每一个元素指向独立的内存单元。

%}

但是此时我们只是完成了二维前缀和数组的计算，还没有进行q次查询，那么接下来我们如何进行查询的操作呢？

很明显我们也要参考面积，假设要求的是x1,y1和x2,y2组成的矩阵内的元素之和，那么他的变化就是此时这个矩阵不再是从左上角的\[1][1]开始的了，因此肯定是使用了多个矩阵pre进行相减得到的。如下所示：

![](https://langwenchong.gitee.io/figure-bed/20220207172406.png)

此时我们要查询得区间之和实际上就是对应的绿色面积，那么很明显借助面积和容斥原理有如下规律：绿色面积即为大蓝色面积pre\[x2][y2]减去黄色面积pre\[x2][y1-1]再减去紫色面积pre\[x1-1][y2]后再补加上一个红色面积pre\[x1-1][y1-1]得到的，因此查询的公式就是
$$
ans=pre[x2][y2]-pre[x2][y1-1]-pre[x1-1][y2]+pre[x1-1][y1-1]
$$
总体的流程就是：

![](https://langwenchong.gitee.io/figure-bed/20220207172813.png)

因此时间复杂度也仅仅为O(nm+q)，还是很小的。给出代码板子：

```python
# 二维前缀和
# 求下标从1开始n行m列的二维数组查询q次指定矩阵内的元素的和
# (i,j)表示第i行第j列的数值元素
def solve():
    n, m = map(int, input().split())
    num = [[0] for i in range(int(1e5+5))]
    pre = [[0]*int(m+5) for j in range(int(n+5))]
    for i in range(1, n+1):
        num[i].extend(list(map(int, input().split())))
        for j in range(1, m+1):
            pre[i][j] = pre[i-1][j]+pre[i][j-1]+num[i][j]-pre[i-1][j-1]
    q = int(input())
    for i in range(q):
        x1, y1, x2, y2 = map(int, input().split())
        print(pre[x2][y2]-pre[x1-1][y2]-pre[x2][y1-1]+pre[x1-1][y1-1])
```

#### 前缀和进阶

##### 1、思考num和pre是必须的吗？

我们发现无论是一维前缀和还是二维前缀和，我们都借助了两个同样大小的数组num和pre，然后通过递推完成了前缀和数组pre的初始化赋值。但是我们真的必须使用num吗？实际上如果我们不需要后期使用num数组来记录输入的值，那么完全可以使用一个pre就可以直接根据输入得到前缀和数组。首先我们一开始就将输入的元素值直接存储到pre中，那么很明显一开始pre\[i]或者是pre\[i][j]存储的并不是前缀和数值而是输入的元素值，然后通过递推式：

```python
# 原先的一维前缀和计算公式 
pre[i] = num[i]+pre[i-1]
# 由于前缀和pre[i]会用到数值元素num[i]和已经记录前缀和的pre[i-1]
# 而此时pre[i]就可以先存储元素值，然后通过上面递推式再更新自己为存储前缀和
# 因此一位前缀和计算公式可以更改为
pre[i] = pre[i]+pre[i-1]


# 同样的原二维前缀和递推公式
pre[i][j] = pre[i-1][j]+pre[i][j-1]+num[i][j]-pre[i-1][j-1]
# 也可以更新为
pre[i][j] = pre[i-1][j]+pre[i][j-1]+pre[i][j]-pre[i-1][j-1]
```

即只需要使用一个pre数组就可以完成，减少了内存的开支，当然一般情况下还是借用两个数据方便代码的可读性与理解。

##### 2、思考：什么是后缀和suffix?

前缀和prefix我们已经理解了，那么后缀和suffix也很容易理解了，他只不过是将pre[i]更改为了计算从末尾到第i个元素的和，因此递推公式变成了
$$
pre[i-1]=pre[i]+num[i-1]
$$

##### 3、思考：如果二维前缀和给的坐标是左下角\[x1][y1]和右上角\[x2][y2]怎么计算？

此时实际上也可以使用二维前缀和递推公式并且没有任何变化，此时只是原点变成了左下角，如下所示：

![](https://langwenchong.gitee.io/figure-bed/20220207180541.png)

因此递推公式并没有发生变化还是

```python
pre[i][j] = pre[i-1][j]+pre[i][j-1]+num[i][j]-pre[i-1][j-1]
```

很明显查询计算公式也没有发生变化还是

```python
print(pre[x2][y2]-pre[x1-1][y2]-pre[x2][y1-1]+pre[x1-1][y1-1])
```

### 差分

#### 概念&用途

差分和前缀和的关系类似于数学中的求导和积分，差分可以看成是前缀和的逆运算。假设现在我们已知q次区间操作，每一次操作都是对数值数组的某一个区间[l,r]进行整体加或者减一个数值k(每一次k都不一样）。然后问q次操作以后的某一个位置的元素数值变成了多少，那么我们该如何进行问题解决呢？我们的第一个想法肯定还是暴力操作，但是复杂度太高了，因此会使用接下来介绍的差分操作。差分是一种与前缀和相对的策略，对于一个数列num，我们之前使用**前缀和维护的前i个元素的值之和**，而现在我们使用差分以后，是**维护两个相邻元素的数值之差**。

#### 一维差分

假设给定了一个原数组num，那么此时我们该如何预处理计算得到差分数组呢？很显然diff差分数组和num数组一样长，同时对于差分数组中第i个元素diff[i]记录就是num[i]相较于num[i-1]的数值增量，即
$$
diff[i]=num[i]-num[i-1]
$$
很显然此时num就是相对于diff的前缀和数组，即num[i]=diff[1]+diff[2]+...+diff[i]。原理如下所示：

![](https://langwenchong.gitee.io/figure-bed/20220207173700.png)

很明显上图中a[2]=b[1]+b[2]。很明显此时如果我们想要得到q次修改操作以后某个元素的数值只需要通过q次修改操作后的diff数组进行累加就可以了，因此查询变成了O(1)。但是我们怎么来用diff数组表示[l,r]内的变化k呢？

无论是加k还是-k，实际上我们都可以看成是加上了一个增量c(即|k|=c)，那么如果我们现在想要在[l,r]内操作添加一个增量c(此时c可正可负)，那么该如何实现呢？我们只需要如下操作：

1. 首先我们让差分数组diff[l]加上增量c，即diff[i]+c，那么根据定义很容易我们就可以推得，此时a[i]、a[i+1]、....、a[r]、a[r+1]、...、a[n]都增加了一个增量c，即此时自l以右的元素全部增加了c
2. 但是我们只是想要 [l,r]内的元素增加一个增量c，因此我们还需要进一步操作将a[r+1]即以后的元素再减去一个增量，因此还需要进行diff[r+1]-c的操作

这样我们就完成了对[l,r]内部的一次修改，时间复杂度也仅仅为O(1)，下面是原理图：

![](https://langwenchong.gitee.io/figure-bed/20220208160225.png)

![](https://langwenchong.gitee.io/figure-bed/20220208163827.png)

q次操作以后，我们就该输出每一个变化后的num元素了，前面我们讲到了num数组实际上就可以看成是差分数组的前缀和数组，因此num[i]的计算公式就是：
$$
num[i]=num[i-1]+diff[i]
$$
通过上面的递推式我们就可以得到每一个要查询到的q次修改操作以后的第i个位置元素的值了，板子如下：

```python
# 一维差分
# 对下表范围[1,n]数组进行q次区间修改，然后查询某个位置元素的值
# diff[i]记录的是num[i]比前者num[i-1]的增量
num = [0]*int(1e5+5)
diff = [0]*int(1e5+5)


def update(l, r, x):
    diff[l] += x
    diff[r+1] -= x


def solve():
    n, m = map(int, input().split())
    for i in range(1, n+1):
        x = int(input())
        update(i, i, x)
    for i in range(m):
        l, r, x = map(int, input().split())
        update(l, r, x)
    for i in range(1, n+1):
        num[i] = num[i-1]+diff[i]
        print(num[i], end=" ")
```

##### 思考：为什么存储输入时是使用update存储到diff中而不是直接存储到num中？

很明显输入就是还没有进行q次修改操作之前的每一个num的初始值，但是我们需要将它存储到num中吗？我们思考一下之前的讲解，实际上我们是使用diff数组来进行值修改操作的表示的，然后最终通过diff来计算每一个num的，因此对于输入的初始值我们也可以看成是对0数组多次区间操作（只不过此时每一次区间操作都是整范围的）来直接存储为diff格式，方便后面进行操作。当然如果你不理解也可以先将输入存储到num中，然后再通过num和diff的关系生成差分数组。

##### 思考：我们能否根据差分数组直接生成num数组的前缀和数组pre?

首先我们来看一下差分数组，元素数组与前缀和数组的关系，很明显他们有以下转换关系：

![](https://langwenchong.gitee.io/figure-bed/20220208161637.png)

但是我们能不能直接从diff到pre呢？即如下关系能否建立？

![](https://langwenchong.gitee.io/figure-bed/20220208161811.png)

实际上也是可以得，如下是递推关系：

![](https://langwenchong.gitee.io/figure-bed/20220208161847.png)

因此我们还可以再初始化diff的同时，再维护一个序列即q序列，他与diff的关系为：
$$
q[i]=(i-1)*diff[i]
$$
这样子，我们通过以下公式就可以通过diff数组直接计算出q次修改以后的前缀和pre[i]:
$$
pre[i]=i*(diff[1]+diff[2]+...+diff[i])-(q[1]+q[2]+...+q[i])
$$

#### 二维差分

同样的，差分也可以拓展到二维，此时我们也要类比矩阵面积，坐标来思考。根据二维前缀和表示的是左上角矩型的和，由于差分只涉及前面相邻的数（由一维可以推出），并且由前面范围的数相加得到这个位置的数，那么类比二维前缀和与一维差分，我们可以简单推测出二维差分的计算公式为：
$$
diff[i][j]=num[i][j]-num[i-1][j]-num[i][j-1]+num[i-1][j-1]
$$
即为相邻2*2矩阵的主对角元之和减去次对角元之和。这样我们就可以得到二维差分数组了。接下来我们同样需要使用二维差分数组来表示q次的修改：

![](https://langwenchong.gitee.io/figure-bed/20220208163147.png)

参考上图，我们可以得到要修改[l,r]内元素，只需要如下进行增量修改：
$$
\begin{cases}
diff[x1][y1]+=c\\
diff[x1][y2+1]-=c\\
diff[x2+1][y1]-=c\\
diff[x2+1][y2+1]+=c
\end{cases}
$$
![](https://langwenchong.gitee.io/figure-bed/20220208163929.png)

这样我们也完成了q次操作以后的二维差分数组，接下来我们同样根据这个二维差分数组进行num\[i][j]的求解，其实此时num\[i][j]得求解公式很容易就得到了就是之前diff\[i][j]公式定义的逆推导：
$$
num[i][j]=num[i-1][j]+num[i][j-1]+diff[i][j]-num[i-1][j-1]
$$
最终我们就得到了二维差分的板子：

```python
# 二维差分
# 对下标从1开始n行m列的二维数组进行q此修改操作并查询所有位置的数
# 注意此时diff[i][j]递推式比较复杂并不是num[i][j]-num[i-1][j-1]
# 而是diff[i][j]=num[i][j]+num[i-1][j-1]-num[i-1][j]-num[i][j-1]
# 即主对角线相邻元素之和相较于次对角线相邻元素之和的增量
num = [[0] for i in range(int(1e5+5))]
diff = [[0]*int(1e5+5) for j in range(int(1e5+5))]


def update(x1, y1, x2, y2, x):
    diff[x1][y1] += x
    diff[x2+1][y2+1] += x
    diff[x2+1][y1] -= x
    diff[x1][y2+1] -= x


def solve():
    n, m, q = map(int, input().split())
    for i in range(1, n+1):
        tmp_list=[0]
        tmp_list.extend(list(map(int, input().split())))
        for j in range(1, m+1):
            update(i, j, i, j, tmp_list[j])
    for i in range(q):
        x1, y1, x2, y2, x = map(int, input().split())
        update(x1, y1, x2, y2, x)
    for i in range(1, n+1):
        for j in range(1, m+1):
            num[i][j] = num[i-1][j]+num[i][j-1]-num[i-1][j-1]+diff[i][j]
            print(num[i][j], end=" ")
        print()
```

### 算法练习

#### 1）一维前缀和

##### 题目描述

一天，在宿舍睡觉的你，突然梦到了游戏之神，他说：去玩《极限脱出》吧，这部作品的剧情和世界观绝对会带来很大的震撼，值得一玩。

对了，这部作品的第一代发布在nds上，所以要想在电脑上玩，你需要游戏模拟器：推荐desmume，也可以选择nogba，前者虽然优化差一些，但自带了模拟器的即使存档功能，且可以全屏。

............

但由于你没有吃安利，游戏之神很愤怒（这么好的游戏不玩，暴殄天物啊！），决定对你进行惩罚。

现在，游戏之神给了你n个非负整数，分别记为第1个数字至第n个数字，游戏之神还会向你提出q个问题，询问你第f个数到第t个数之间所有数字的和，请你正确回答游戏之神的所有提问，否则你以后打游戏必掉线。

##### 输入描述

输入的第一行包含两个整数n,q( 1<=n,q≤1e5 )，含义如题面所示；

第二行包含n个非负整数，每个数字均不超过1e9；

下面q行，每行包括两个数字f,t（1≤f≤t≤n），含义如题面所示。

##### 输出描述

对于这q行中的每一行，请你输出一个数字，回答游戏之神的提问。

##### 样例

输入

```
9 4
1 3 4 6 2 5 1000000000 1000000000 1000000000
1 6
7 9
3 5
4 4
```

输出

```
21
3000000000
12
6
```

##### 解题思路

就是一道简单的一维前缀和模板题，直接上板子就好了

##### 解题代码

```python
# 一位前缀和
# 对下标范围[1,n]的数组查询q次指定区间的元素之和
def solve():
    n, q = map(int, input().split())
    num = [0]
    pre = [0]*int(1e5+5)
    num.extend(list(map(int, input().split())))
    for i in range(1, n+1):
        pre[i] = num[i]+pre[i-1]
    for i in range(q):
        l, r = map(int, input().split())
        print(pre[r]-pre[l-1])

if __name__=="__main__":
    solve()
```

#### 2）子矩阵求和

##### 题目描述

给出一个 n行 m 列的矩阵，矩阵的每个位置有一个非负整数 a\[i][j]，有 q 次询问，每次询问求一个左上角为 (a,b)，右下角为 (c,d) 的子矩阵的所有数之和。

##### 输入描述

第一行两个整数 n,m，表示矩阵的行和列的大小。

接下来 n 行每行 m 个整数，为矩阵内容。

接下来一行为一个整数 q，表示询问次数。

接下来 q行每行 4个整数 a,b,c,d，含义见题面。

##### 输出描述

共 q行，第 i 行为第 i 个询问的答案。

##### 数据范围

n×m≤100,000，a\[i][j] <=1000，q<=100,000，1<=a<=c<=n，1<=b<=d<=m。

##### 样例

输入

```
3 5
1 2 3 4 5
3 2 1 4 7
2 4 2 1 2
3
1 1 3 5
2 2 3 3
1 1 3 3
```

输出

```
43
9
20
```

##### 解题思路

就是一道简单的二维前缀和模板题，直接上板子就好了

##### 解题代码

```python
import sys
input = sys.stdin.buffer.readline

def solve():
    n, m = map(int, input().split())
    num = [[0] for i in range(int(1e5+5))]
    pre = [[0]*int(m+5) for j in range(int(n+5))]
    for i in range(1, n+1):
        num[i].extend(list(map(int, input().split())))
        for j in range(1, m+1):
            pre[i][j] = pre[i-1][j]+pre[i][j-1]+num[i][j]-pre[i-1][j-1]
    q = int(input())
    for i in range(q):
        x1, y1, x2, y2 = map(int, input().split())
        print(pre[x2][y2]-pre[x1-1][y2]-pre[x2][y1-1]+pre[x1-1][y1-1])


if __name__ == "__main__":
    solve()
```

#### 3）Margarite and the best present

#####  题目描述

Little girl Margarita is a big fan of competitive programming. She especially loves problems about arrays and queries on them.

Recently, she was presented with an array a*a* of the size of 10^9109 elements that is filled as follows:

- a1 = -1
- a2 = 2
- a3 = -3
- a4 = 4
- a5 = -5
- And so on ...

That is, the value of the i-th element of the array a is calculated using the formula.
$$
a[i]=i*(-1)^i
$$
She immediately came up with q queries on this array. Each query is described with two numbers: land r. The answer to a query is the sum of all the elements of the array at positions from l to r inclusive.

Margarita really wants to know the answer to each of the requests. She doesn't want to count all this manually, but unfortunately, she couldn't write the program that solves the problem either. She has turned to you — the best programmer.

Help her find the answers!

##### 输入描述

The first line contains a single integer q (1<=q<=1e3) — the number of the queries.

Each of the next q lines contains two integers l and r (1<=l<=r <=1e9) — the descriptions of the queries.

##### 输出描述

Print q lines, each containing one number — the answer to the query.

##### 样例

输入

```
5
1 3
2 5
5 5
4 4
2 3
```

输出

```
-2
-2
-5
4
-1
```

##### 样例说明

In the first query, you need to find the sum of the elements of the array from position 1 to position 3. The sum is equal to a1 + a2 + a3 = -1 + 2 -3 = −2.

In the second query, you need to find the sum of the elements of the array from position 2 to position 5. The sum is equal to a2 + a3 + a4 + a5 = 2 -3 + 4 - 5 =−2.

In the third query, you need to find the sum of the elements of the array from position 5 to position 5. The sum is equal to a5 = -5.

In the fourth query, you need to find the sum of the elements of the array from position 4 to position 4. The sum is equal to a4 = 4.

In the fifth query, you need to find the sum of the elements of the array from position 2 to position 3. The sum is equal to a2+a3 = 2 - 3 =−1.

##### 解题思路

这道题乍一看感觉就是为一个非常简单的一维前缀和板子题，但是我们使用板子以后会发现由于数组长度为1e9明显超过了测试平台允许的最大空间，会导致内存超限。因此我们不能直接使用一维前缀和板子进行解题，而是需要打表找规律，我们很容易就可以看出前缀和数组中的元素应该有规律的，因此我们可以先进行局部前缀和元素（比如前50个）的打表，最终我们可以找到如下规律：

pre=[-1,1,-2,2,-3,3,-4,4,-5,5...]，很明显对于第i个前缀和元素pre[i]，当i为奇数时必定为负数，同时pre[i]的数值的绝对值有如下规律：
$$
pre[i]=(-1)^i*[(i//2)]_{向上取整}
$$

##### 解题代码

```python
if __name__ == "__main__":
    q=int(input())
    for i in range(q):
        l,r=map(int,input().split())
        a=l-1
        b=r
        if a%2!=0:
            a=0-(a//2+1)
        else:
            a//=2
        if b%2!=0:
            b=0-(b//2+1)
        else:
            b//=2
        print(b-a)
```

{% note info,

对于这种非常容易看出来有一定内在规律的题，可以尝试进行打表很容易就可以找到内在规律用递推公式表示规律，从而简化题目的解，大幅降低时间复杂度和空间复杂度

%}

#### 4）Star Sky

##### 题目描述

The Cartesian coordinate system is set in the sky. There you can see n stars, the i-th has coordinates (xi, yi), a maximum brightness *c*, equal for all stars, and an initial brightness si (0 ≤ si ≤ c).

Over time the stars twinkle. At moment 0 the i-th star has brightness si. Let at moment t some star has brightness x. Then at moment (t + 1) this star will have brightness x + 1, if x + 1 ≤ *c*, and 0, otherwise.

You want to look at the sky q times. In the i-th time you will look at the moment ti and you will see a rectangle with sides parallel to the coordinate axes, the lower left corner has coordinates (x1i, y1i) and the upper right — (x2i, y2i). For each view, you want to know the total brightness of the stars lying in the viewed rectangle.

A star lies in a rectangle if it lies on its border or lies strictly inside it.

##### 输入描述

The first line contains three integers n, q, c (1 ≤ n, q ≤ 1e5, 1 ≤ c≤ 10) — the number of the stars, the number of the views and the maximum brightness of the stars.

The next *n* lines contain the stars description. The i-th from these lines contains three integers xi, yi, si (1 ≤ xi,yi ≤ 100, 0 ≤ si ≤ c ≤ 10) — the coordinates of i-th star and its initial brightness.

The next *q* lines contain the views description. The i-th from these lines contains five integers ti, x1i, y1i, x2i, y2i (0 ≤ ti ≤ 1e9, 1 ≤ x1i < x2i ≤ 100, 1 ≤ y1i < y2i ≤ 100) — the moment of the i-th view and the coordinates of the viewed rectangle.

##### 输出描述

For each view print the total brightness of the viewed stars.

##### 样例1

输入

```
2 3 3
1 1 1
3 2 0
2 1 1 2 2
0 2 1 4 5
5 1 1 5 5
```

输出

```
3
0
3
```

##### 样例2

输入

```
3 4 5
1 1 2
2 3 0
3 3 1
0 1 1 100 100
1 2 2 4 4
2 2 1 4 7
1 50 50 51 51
```

输出

```
3
3
5
0
```

##### 样例说明

Let's consider the first example.

At the first view, you can see only the first star. At moment 2 its brightness is 3, so the answer is 3.

At the second view, you can see only the second star. At moment 0 its brightness is 0, so the answer is 0.

At the third view, you can see both stars. At moment 5 brightness of the first is 2, and brightness of the second is 1, so the answer is 3.

##### 解题思路

这道题是一个cf1600的题，是对二维前缀和的变式应用。首先我们读完题意会发现此时矩阵内的星星亮度是会变得，每一个时刻都是不同的，**同时星星数量理论上是可以大于矩阵面积的，因此说明一个坐标可能会有多个亮度不同的重叠的星星**。因此我们此时使用二维前缀和是不够的，我们需要三维来记录，即**pre\[i]\[j][k]表示的是初始时刻\[i][j]中亮度为k的星星的个数**。这样如果我们要统计t时刻某个一个范围内的所有星星亮度，只需要枚举统计该范围内不同初始亮度的星星在t时刻的亮度和个数，然后用亮度*个数再累加记得到了t时刻该范围的所有星星的亮度之和。

##### 解题代码

```python
# import io,os
# input = io.BytesIO(os.read(0, os.fstat(0).st_size)).readline
import sys
input=sys.stdin.buffer.readline
a = [[[0]*15 for i in range(105)]for j in range(105)]
pre=[[[0]*15 for i in range(105)]for j in range(105)]
if __name__ == "__main__":
    n,q,c=map(int,input().split())
    for i in range(n):
        xi,yi,si=map(int,input().split())
        a[xi][yi][si]+=1
    for k in range(c+1):
        for i in range(1,101):
            for j in range(1,101):
                pre[i][j][k]=a[i][j][k]+pre[i-1][j][k]+pre[i][j-1][k]-pre[i-1][j-1][k]
    for i in range(q):
        t,x1,y1,x2,y2=map(int,input().split())
        ans=0
        for k in range(c+1):
            ans+=(k+t)%(c+1)*(pre[x2][y2][k]-pre[x2][y1-1][k]-pre[x1-1][y2][k]+pre[x1-1][y1-1][k])
        print(ans)
```

#### 5）Matrix Subtraction

##### 题目描述

Given a matrix M of size n×m and two integers a,b，determine weither it is possible to make all entrys of M zero by repeatedly choosing a×b submatrices and reduce the values in the chosen matrices by 1. If possible, print `^_^` in one line, or print `QAQ` in one line.

##### 输入描述

The first line contains one integer T (1≤T≤100), denoting the number of test cases.

For each test case:

The first line contains four integers n,m,a,b (1≤n,m≤1000,1≤a≤n,1≤b≤m), denoting the size of given matrix and the size of chosen submatrices respectively.

The next n lines each contains m integers Mi,j (0≤Mi,j≤109), denoting the entrys of matrix M.

It's guaranteed that ∑nm≤1e6.

##### 输出描述

Print T lines each containing a string `^_^` or `QAQ`, denoting the answer to each test case.

##### 样例

输入

```
2
2 2 1 2
1 2
1 2
2 3 1 2
1 2 1
1 2 1
```

输出

```
QAQ
^_^
```

##### 样例说明

For the second case, one possible scheme is to choose (1,1)−(1,2),(1,2)−(1,3),(2,1)−(2,2),(2,2)−(2,3) respectively.

##### 解题思路

二维差分的应用，很明显我们需要使用到二维差分中的update函数对选中的子矩阵进行整体减的操作。但是每一次我们的子矩阵的左上角坐标应该选择那里呢？实际上我们会发现每一次最左上角的元素如果想要变为0，那么只能通过让这个元素位于子矩阵的左上角，假设这个元素值为tmp,那么就要用tmp次该子矩阵进行减操作处理才能变成0。然后紧接着他右侧和他下侧的元素就有可能成为下一个边角元素，因此我们的子矩阵左上角开始坐标只需要自左向右，自上到下遍历整个矩阵即可，一旦检验到当前位置的元素值小于0了，那么无论怎样处理也不可能变回0了（因为我们只能通过子矩阵进行范围-1，而不能+1),那么此时就说明不可能实现了，输出`QAQ`，否则我们就一直检验（遇到0就跳过），当一直检验到了最后一个都可以变为0 ，那么就可以将这个矩阵变成0矩阵，输出`^_^`.**我们还要特别注意很明显这个子矩阵的左上角起始坐标并不能遍历整个矩阵，他需要保证子矩阵始终在大矩阵范围内所以还需要满足`j+b-1 <= m and i+a-1 <= n`**

##### 解题代码

```python
# -*- encoding: utf-8 -*-

# @File    : ac10.py
# @Time    : 2022/02/06 18:33:43
# @Author  : langwenchong
# @Desc    : edit in python3.8.8
import sys
# sys.stdout = open('./IO/out.txt', mode='w', encoding='utf-8')
# sys.stdin = open('./IO/in.txt', mode='r', encoding='utf-8')
input = sys.stdin.buffer.readline


def update(diff, x1, y1, x2, y2, x):
    diff[x1][y1] += x
    diff[x2+1][y2+1] += x
    diff[x2+1][y1] -= x
    diff[x1][y2+1] -= x


def solve():
    t = int(input())
    for i in range(t):
        v = True
        n, m, a, b = map(int, input().split())
        diff = [[0]*(m+5) for i in range(n+5)]
        for i in range(1, n+1):
            tmp_list=[0]
            tmp_list.extend(list(map(int, input().split())))
            for j in range(1, m+1):
                update(diff,i, j, i, j, tmp_list[j])
        for i in range(1, n+1):
            for j in range(1, m+1):
                tmp = diff[i][j]
                if tmp == 0:
                    continue
                elif tmp < 0:
                    v = False
                    break
                elif j+b-1 <= m and i+a-1 <= n:
                    #注意要减tmp次1也就是减tmp
                    update(diff,i,j,i+a-1,j+b-1,-tmp)
                else:
                    v=False
                    break
        if(v):
            print("^_^")
        else:
            print("QAQ")
    return


if __name__ == "__main__":
    solve()

```

