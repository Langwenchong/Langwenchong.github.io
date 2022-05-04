---
title: 浅谈二分查找及其变式
comments: false
top: false
date: 2022-01-29 16:11:31
tags: [算法,二分查找]
categories: 
	- [知识分享,学习心得]
headimg: https://langwenchong.gitee.io/figure-bed/20220129181120.png
---

二分查找是一个非常常见的搜索算法，其时间复杂度仅仅为O(logn)比暴搜要强太多，并且变式可以寻找最小的大值和最大的小值等问题，本文记录了翀翀对于二分查找的理解。

<!-- more -->

{% note quote ,

本文参考了pengpenglang友人的[《二分与三分查找》](https://pengpenglang.cn/posts/2852476022/#%E6%A8%A1%E6%9D%BF)，非常感谢精彩的讲解😎。

%}

由于翀翀在学习Python算法题，因此以下模板均是Python所写，如果要参考c++板子请前往pengpenglang 博客获取。

### 整数二分查找

首先我们学习一个最简单的二分查找，即在一个**有序递增**的数组中寻找一个特定值的索引值。我们第一想法就是遍历整个数组中的元素然后逐一对比，没有就返还-1，找到了就返还索引值。这种方法时间复杂度为O(n)，耗时太长，因此产生了二分搜索，他的思路很简单，就是每一次都折半查找，我们需要设置记录left,right以及mid来进行折半的操作。如果你对二分查找的基础思路还不太熟悉请看下方的视频讲解：

{% link 二分查找讲解 , https://www.bilibili.com/video/BV1d54y1q7k7?from=search&seid=2027361541815860198&spm_id_from=333.337.0.0 %}

我们发现无论是多么复杂的二分查找，不同的二分板子中大体框架都如下所示：

```c
int binarySearch(int[] nums, int target) {
    int left = 0, right = ...;  //查找左边界、右边界

    while (...) {                      //判断何时查找终止
        int mid = (right + left) / 2;  //去中点
        if (nums[mid] == target) {     //相等时的操作
            ...
        } else if (nums[mid] < target) {  //小于时的操作
            left = ...
        } else if (nums[mid] > target) {  //大于时的操作
            right = ...
        }
    }
    return ...;
}
```

{% note info,

在二分查找中，我们不要出现else，最好使用elif将每种情况都写出来，这样可以清楚的展示所有细节。本文中都会使用elif罗列出每一种情况的操作即使有些情况的操作相同。其中标记的`...`部分是可能出现的细节问题的地方，需要着重注意。

%}

#### 一、基本二分查找

使用场合就是最简单的情况，一个有序递增的序列中，使用二分查找搜索一个数，找到了就返回的索引下表，不存在就输出-1。板子如下

```python
# 找到首次出现的target
def binarySearch(nums, target):
    l, r = 0, len(nums)-1 # 注意r的起始位置
    while l <= r: # 注意l和r的关系
        mid = (l+r)//2
        if nums[mid] == target: # 找到了就返回索引并退出
            return mid
        elif nums[mid] > target:
            r = mid-1
        elif nums[mid] < target:
            l = mid+1
    return -1
```

实际上上面的思路就是和视频中的讲解一样，但是我们发现有几个细节判断条件我们要注意。

##### 思考：为什么while循环的条件是l<=r而不是l<r?

我们注意观察l和r的起始取值，可以看出要查找的是一个闭区间`[left,right]`，因此每次的查找区间都是全闭区间，如果中途找到了target就直接返回索引下表即可，否则一直寻找下去直至搜索完整个元组，也就是要查找的区间为空的时候，很明显此时也是`while(left<=right)`终止的条件，那么只有当`left==right+1`时查找的全闭空间才是空的，因此循环的条件是l<=r。

{% note info,

当然如果你非要用`while(left<right)`也可以，我们只需要针对错误原因出现的地方打一个补丁即可：

```python
# ...
while l < r :
    # ...
return l if nums[left] == target else  -1;  //再额外判断区间为1的时候
```

%}

##### 思考：如上的补丁是什么意思？

while(left < right)的终止条件是 left == right，写成区间的形式就是 [right, right]，或者带个具体的数字进去 [2, 2]，**这时候搜索区间非空**，还有一个数 2，但此时 while 循环终止了。也就是说这区间 [2, 2] 被漏掉了，索引2没有被搜索，如果这时候直接返回 -1 就可能出现错误。

##### 思考：为什么下次要查找的区间边界取值是`l=mid+1,r=mid-1`，而有的写法却是`l=mid+1,r=mid`，如何理解区分？

理解的问题一种的查找区间这个概念就好及理解，因为本算法的查找区间的全闭区间，那么当我们发现索引mid不是要找的target时当然从中去除该判断过的点，所以下次查找区间取 [left,mid-1] 或者 [mid+1,right] 中的一个即可。

##### 思考：上面的算法有什么缺陷？

算法缺陷是很明显的，如果存在重复的数那么我们找到的那个值可能数值上和target相同但是位置是随机的，如果题目想要和target数值相同的最左侧的值或者和target数值相同的最右侧的值的索引又如何解决呢？这需要下面的左侧边界和右侧边界的二分查找了。

#### 二、查找左侧边界的二分查找

我们更改一下使用情景，现在要求找到最靠左侧的数值相同的元素的索引下表，如果不存在就返回-1，比如对于[2,2,3]数组，要找2元素的索引，那么此时应该返回0而不能是1。板子如下所示

```python
# 找到最左边界或者最靠近左侧的满足条件的target
def binarySearch(nums, target):
    if len(nums) == 0: # 列表长度为0直接退出搜索
        return -1
    l, r = 0, len(nums) #注意r的起始条件
    while l < r: #注意二分查找的终止条件是l==r
        mid = (l+r)//2
        # 找到某个target时不返回而是缩小右边界
        if nums[mid] == target:
            r = mid
        elif nums[mid] > target:
            r = mid
        elif nums[mid] < target:
            l = mid+1
    if l == len(nums): #target比所有的值都大
        return -1
    # 打补丁额外再检验一下l对应的值是否满足条件
    return l if nums[l] == target else -1
```

##### 思考：为什么while循环条件是l<r，而不是<=?

我们要注意此时r的起始索引值为len(nums)，但是我们知道这个索引实际上已经越界了，因此很明显此时我们需要使用`[l,r)`左闭右开的区间去查找。那么此时当l==r时要查找的区间就是[l,l)或者[r,r)了，很明显此时这个搜索区间已经是空了，因此只需要l<r进行循环即可，当l>=r时都是搜索区间为空了，退出循环即可。

##### 思考：为什么退出循环以后出现了对l的额外判断条件来返还-1?

我们发现如果不添加这个条件，我们没有了返回-1的代码操作。我们首先理解一下`最左侧边界`的含义：

![](https://langwenchong.gitee.io/figure-bed/20220129165949.png)

对于这个数组，算法会返回1。这个1的含义可以这样理解：nums中小于2的元素有1个。比如对于有序数组nums=[2,3,5,7],target=1，算法会返回0，及说明nums中小于1的元素有0个。如果target为8，那么算法返回4，即说明nums中小于8的元素有4个。

综上我们可以看出，函数的返回值（即l变量的值）取值区间是[0,len(nums)]，当`l==len(nums)`时很显然l索引下标对应的元素不存在，访问越界了，另一层含义即数组中所有的元组都小于target，那么此时这个判断式表达的意思就是没有找到target。因此此时返回-1。

##### 思考：为什么`l=mid+1,r=mid`和之前的操作不一样了？

这个很好解释，因为我们的搜索区间是`[l,r)`左闭右开，所以当nums[mid]被检测之后，下一步的搜索区间应该去掉mid分成两个区间，即[l,mid)或者[mid+1,r)，因此对应的操作就是l=mid+1和r=mid。

##### 思考：为什么这个算法可以搜索左侧边界？

关键就在于`nums[mid]==target`这种情况的处理是`r=mid`，也就是说，当我们找到target时不要立即返回，而是缩小搜索区间的上界r，在区间[l,r)中继续搜索，即不断向左收缩，达到锁定左侧边界的目的。

##### 思考：为什么返回l而不是r?

实际上此时返回l和r都是一样的，因为while终止的条件就是l==r。

#### 三、查找右侧边界的二分查找

寻找最右侧边界和寻找左侧边界的代码差不多，只有两处不同，已标注：

```python
# 找到最右边界或者最靠近右侧的满足条件的target
def binarySearch(nums, target):
    if len(nums) == 0:
        return -1
    l, r = 0, len(nums)
    while l < r:
        mid = (l+r)//2
        if nums[mid] == target:
            l = mid+1 # 注意
        elif nums[mid] > target:
            r = mid
        elif nums[mid] < target:
            l = mid+1
    if l == 0: # 注意
        return -1 
    return l-1 if nums[l-1] == target else -1 # 注意
```

##### 思考：为什么这个算法能够找到右侧边界？

类似的，找到关键点还是这里：

```python
if nums[mid] == target:
            l = mid+1 # 注意
```

当nums[mid]==target时，不要立即返回，而是增大搜索区间的下界l，使得区间不断向右收缩，达到锁定右侧边界的目的。

##### 思考：为什么最后返回的是l-1，而不是像左侧边界查找一样返回l？而且我觉得这里应该是返回r就行了？

首先while循环的终止条件是l==r,因此返回l-1或者r-1都是一样的， 但是返回r肯定是错误的。那么为什么要减一呢？这是因为右侧边界的一个特殊点：

```python
if nums[mid] == target:
            l = mid+1 # 这样想：mid=l-1
```

![](https://langwenchong.gitee.io/figure-bed/20220129173135.png)

因为我们对l的更新时l=mid+1,因此while循环结束的时候，nums[l]一定不等于target了（一定是第一个大于target的元素的索引下标值），而nums[l-1]可能是target。至于为什么l的更新时l=mid+1就不再赘述了。

##### 思考：为什么返回的-1的判断条件变成了l==0?

很显然此时l的搜索范围是[0,len(nums)]，那么当l==0时对应要返还的索引是-1很明显越界了，同时此时的另一个含义是数组中所有的元素都大于target明显此时没有找到target因此返回-1。

#### 最后总结

先来梳理一下这些细节差异的因果逻辑：

第一个，最基本的二分查找算法：

```java
因为我们初始化 right = nums.length - 1
所以决定了我们的「搜索区间」是 [left, right]
所以决定了 while (left <= right)
同时也决定了 left = mid+1 和 right = mid-1

因为我们只需找到一个 target 的索引即可
所以当 nums[mid] == target 时可以立即返回
```

第二个，寻找左侧边界的二分查找：

```java
因为我们初始化 right = nums.length
所以决定了我们的「搜索区间」是 [left, right)
所以决定了 while (left < right)
同时也决定了 left = mid+1 和 right = mid

因为我们需找到 target 的最左侧索引
所以当 nums[mid] == target 时不要立即返回
而要收紧右侧边界以锁定左侧边界
```

第三个，寻找右侧边界的二分查找：

```java
因为我们初始化 right = nums.length
所以决定了我们的「搜索区间」是 [left, right)
所以决定了 while (left < right)
同时也决定了 left = mid+1 和 right = mid

因为我们需找到 target 的最右侧索引
所以当 nums[mid] == target 时不要立即返回
而要收紧左侧边界以锁定右侧边界

又因为收紧左侧边界时必须 left = mid + 1
所以最后无论返回 left 还是 right，必须减一
```

如果以上内容你都能理解，那么恭喜你，二分查找算法的细节不过如此。

#### 思考：C++中stl库中的lowerbound和upperbound如何在python中实现？

很明显python中肯定也是有对应的库的，但是我们知道对于一般的算法比赛中，Python是不让引入第三方库的，因此我们需要自己来手动实现一下lowerbound和upperbound函数。

##### lowerbound()实现

lowerbound()方法的功能是找到第一个不小于target的值的索引值，而我们的二分查找寻找最左侧边界就是找到最左侧的target值的索引下标。因此略微修改一下就可以实现和lowerbound相似的功能：

````python
# 找到第一个不小于target的的索引下标
def lowerbound(nums, target):
    if len(nums) == 0: # 列表长度为0直接退出搜索
        return -1
    l, r = 0, len(nums) #注意r的起始条件
    while l < r: #注意二分查找的终止条件是l==r
        mid = (l+r)//2
        # 找到某个target时不返回而是缩小右边界
        if nums[mid] == target:
            r = mid
        elif nums[mid] > target:
            r = mid
        elif nums[mid] < target:
            l = mid+1
    return l #这里直接返还l就是最靠左的不小于target值的索引下标
````

##### upperbound()实现

我们知道在二分查找寻找最右侧边界找到的就是最靠右侧的和target值相同的元素的下标，当时我们是返还的l-1，原因是因为l对应的一定是第一个大于target的值，l-1索引对应的元素才有可能是和target相同的。那么现在我们只需要再返还l即可实现upperbound()方法的功能。

```python
# 找到第一个大于target的值对应的下标
def upperbound(nums, target):
    if len(nums) == 0:
        return -1
    l, r = 0, len(nums)
    while l < r:
        mid = (l+r)//2
        if nums[mid] == target:
            l = mid+1 # 注意
        elif nums[mid] > target:
            r = mid
        elif nums[mid] < target:
            l = mid+1
    return l #直接返还l索引即可
```

### 浮点数二分查找

这里我们再额外学习一下浮点数的二分查找，它相比于整数的二分查找要简单，由于在计算机中浮点数不能准确表示，而是在一个精度差范围内表示，因此我们通常在浮点数中使用二分查找并不是要找到准确数值对应的下标，而是找到第一个满足精度要求的浮点数，比如我们要在[1,10]范围内找到5的平方根的值，要求这个值和准确值精度差在1e-18内。那么此时我们就可以使用二分查找。

```python
# 浮点数的二分查找
# 遍历六十次精度为1e-18,一百次精度为1e-30
def binarySearch(l,r,target):
    for i in range(100):
        mid=(l+r)/2
        if(mid>=target):
            r=mid
        else:
            l=mid
    return (l+r)/2
```

{% note info,

通过控制循环的次数来取得要求精度，60 次循环达到 1e-18 。100 次的循环则可以达到 1e-30 的精度范围，基本上足以解决所有问题

%}

### 算法练习

学习完二分查找以后，我们再通过以下两个题来练习一下二分查找算法的应用。

#### 1）完全平方数

##### 题目链接

{% link 完全平方数 ,https://ac.nowcoder.com/acm/problem/14733  %}

##### 题目描述

多次查询[l,r]范围内的完全平方数个数 ，定义整数x为完全平方数当且仅当可以找到整数y使得y*y=x。

##### 输入描述

```
第一行一个数n表示查询次数
之后n行每行两个数l,r
```

##### 输出描述

```
对于每个查询，输出一个数表示答案
```

##### 示例

输入

```
5
1 3
1 4
2 4
4 4
1 1000000000
```

输出

```1
2
1
1
31622
```

##### 备注

```
n <= 100000
0<= l <= r <= 1000000000
```

##### 解题思路

首先我们知道实际上就是找到[l,r]中所有的平方数，即可以开平方后得到整数根的数值，那么最简单的思路就是暴搜注意检验，但是这样很明显会超时，因此我们可以使用另一个思路，即找到边界值，首先找到大于等于l的最小的平方数minn和小于等于r的最大的平方数maxx，然后maxx-minn就是答案。那么我们如何找到maxx和minn呢？有以下两种策略：

- 假设对于l就是直接使用sqrt(l)并向上取整，同时对于r使用sqrt(r)向下取整即可得到minn和maxx
- 使用二分查找中的左侧边界和右侧边界分别找到minn和maxx

很明显第一种更简单，但是这里我们为了练习二分查找使用第二个策略，代码如下

##### 解题代码

```python
def binarySearchLeft(l, r, target):
    while l < r:
        mid = (l+r)//2
        if mid**2 == target:
            r = mid
        if mid**2 > target:
            r = mid
        elif mid**2 < target:
            l = mid+1
    return l


def binarySearchRight(l, r, target):
    while l < r:
        mid = (l+r)//2
        if mid**2 == target:
            l = mid+1
        elif mid**2 > target:
            r = mid
        elif mid**2 < target:
            l = mid+1
    return l-1


n = int(input())
for i in range(n):
    # 使用map映射更快获取输入
    left, right = list(map(int, input().split()))
    # 要注意1e10的表现形式在Python中默认为浮点数，需要转换为整数
    minn = binarySearchLeft(0, int(1e10), left)
    maxx = binarySearchRight(0, int(1e10), right)
    print(maxx-minn+1)

```

#### 2）Carry爱木头

##### 题目描述

CarryNotKarry 最近迷上了砍木头，已知他需要砍 n 个木头，他有一把神奇但又有束缚的斧头，这个斧头每一次只能砍若干个**长度一样**的木头，但是**却又只能砍恰好 **m−1 次，也就是将木头分成 m 组。当然，不同组木头的长度当然可以一样的，毕竟若干个同一长度的木头可以分好几次来砍。但是，CarryNotKarry 不希望任何一组的木头个数过多，否则他会觉得分配很不均匀，也就是说，他希望木头中最多个数的组的个数尽量小。他想问问你，最多个数的那个组最小个数是多少，如果无法顺利完成，请告诉他输出 `-1`

##### 输入描述

第一行两个正整数 n,m(1≤m≤n≤1×105)，其中 n 表示一共需要砍 n 个木头，m 表示需要恰好砍 m 组。第二行有 n 个数，ai(1≤ai≤n)代表第i个木头的长度。

##### 输出描述

输出一个数，表示 *m* 个组中，个数最多的组的最小值是多少。

##### 样例1

输入

```
6 4
2 2 2 3 3 3
```

输出

```
2
```

##### 样例2

输入

```
6 3
2 2 2 3 3 3
```

输出

```
3
```

##### 样例3

输入

```
6 1
2 2 2 3 3 3
```

输出

```
-1
```

##### 样例解释

对于样例一，我们可以将 [2,2,2,3,3,3] 分成 [2],[2,2],[3],[3,3] 四组，这时候组数最多的那个数是 2，这时候 2 是最优解。

对于样例二，一种方案是将 [2,2,2,3,3,3] 分成 [2],[2,2],[3,3,3] 三组，这时候组数最多的那个数是3，同理也可以分成 [2,2,2],[3],[3,3]，这时候也是 3，注意，你不能分为 [2,3] ，因为同一组木头要长度一样。

对于样例三，你不能将他们只分成一组。

##### 解题思路

乍一看，感觉并不能使用二分。实际上对于这种寻找最大的最小值或者最小的最大值都是二分题，例如这里我们可以直接枚举答案的取值，然后检验这个答案取值能不能满足条件，那么显然此时使用暴力枚举可能的答案（范围为[0,1e5 ]）是不现实的，会超时，因此枚举可能的答案需要使用到二分法。但是此时我们并不需要使用二分来查找某一个元素，而是仅仅使用二分来进行折半的切割范围即可，因此判断条件很显然不是nums[mid]和target的关系，而是能否满足条件，此时这个条件判断就需要我们自己去实现一个check()函数了，仅仅是是否满足条件判断的后的处理操作和二分很相似而已。又因为我们要找到的是最多个数的那个组的最小个数很明显是最小的最大值，因此使用左侧边界查找。

##### 解题代码

```python
n, m = [int(x) for x in input().split()]
trees = list(map(int, input().split()))


def check(x):
    l = []
    num = 0
    idx = 0
    while idx < len(trees):
        if (len(l) == 0 or l[len(l)-1] == trees[idx]) and len(l) != x:
            l.append(trees[idx])
            idx += 1
        else:
            l.clear()
            num += 1
    return False if num > m-1 else True


def binarySearch(l, r):
    while(l < r):
        mid = (l+r)//2
        # 枚举可能的答案，然后检测check是否满足条件
        # 满足，那么可能可以进一步缩小
        if check(mid) == True:
            r = mid
        # 不满足，l右移
        elif check(mid) == False:
            l = mid+1
    if l == n:
        print(-1, end="")
        return
    print(l, end="") if check(l) else print(-1, end="")
    return

#要注意我们需要先对数目进行排序
trees.sort()
binarySearch(1, n)

```

{% note info,

也即是说二分查找仅仅是一种折半的思想，我们要熟悉这种折半的思想，同时理解左界和有界的查找原理，真正解题时可能还需要自己进行变化例如上题中重新构建判断条件。

%}

