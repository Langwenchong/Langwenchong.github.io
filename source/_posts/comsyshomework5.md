---
title: 计算机系统基础大作业--缓存实验cache
comments: false
top: false
date: 2020-10-23 11:35:21
tags: [机组原理,c++,linux,cache]
categories: 
	- [知识分享,项目总结]
headimg: https://langwenchong.gitee.io/figure-bed/20210704172227.png
---

🔎实验目的

理解高速缓存对于程序性能的影响。

🔧实验内容

这个实验包括两部分内容。首先，你需要使用C语言编写一个小型程序（200-300行）用来模拟高速缓存,然后，对一个矩阵转置函数进行优化，以减少函数操作中的缓存未命中次数。

文件下载:链接：https://pan.baidu.com/s/1OWjn5gFL-uLFDLPnX8OeEA 
提取码：a8w2 

<!-- more -->

### 解题思路

#### partA

要求是模拟写一个csim-ref，其中有几个命令要实现，所以逐一写出具备相应功能的函数即可。首先看到-h可以实现展示命令输入的展示清单，如下：

![](https://pic.imgdb.cn/item/5f92b2df1cd1bbb86bfb7385.jpg)

所以写一个函数如下实现：

![](https://pic.imgdb.cn/item/5f92b2f51cd1bbb86bfb7791.jpg)

编写cache的结构:

![](https://pic.imgdb.cn/item/5f92b3111cd1bbb86bfb7ca9.jpg)

然后编写读入命令行的函数：

![](https://pic.imgdb.cn/item/5f92b32c1cd1bbb86bfb82b1.jpg)

例如getOpt函数中用了getopt（）函数来检查命令行中的参数，并且又在switch中调用了atoi函数来实现将字符转换成相对应的数值。并且根据不同的参数进行相对应的操作。

然后在main中初始化cache，并且同时生命一个指针为后面文件读入操作做准备，并且同时对指令进行检查是否合法：

![](https://pic.imgdb.cn/item/5fb52c82b18d6271136aab77.jpg)

然后编写读入文件指令与地址的代码：

![](https://pic.imgdb.cn/item/5f92b35d1cd1bbb86bfb896d.jpg)

其中“r”代表文件只可以读入不可改写以防改变文件。同时对指令进行相应的操作，根据pdf文件对指令的介绍知道L无任何影响，然后M是命中，S时要调用find函数进行命令行牺牲等一系列更新操作操作，其中find函数的具体代码如下：

![](https://pic.imgdb.cn/item/5f92b3751cd1bbb86bfb8f50.jpg)

其中find函数中首先定义了两个参量分别是set address 和LRU cacheline 。然后在全局变量中定义一下参量：

![](https://pic.imgdb.cn/item/5f92b38a1cd1bbb86bfb92f4.jpg)

其中有命中，未命中，覆盖，还有s,E,b等参量为后面的操作做准备。在看一下cache的结构：

![](https://pic.imgdb.cn/item/5f92b39b1cd1bbb86bfb95c1.jpg)

其中tag是标志，usedtime表示使用的次数，初始值为0，用来判断LRU cache行，非零值越大说明使用次数越多，最大代表刚刚使用。根据原理，当缓存满的时候会将usedtime最小的命令行牺牲移除用来盛放刚刚使用的新指令。所以Usedtime就是用来判断这个牺牲航用的。所以

1. 如果usedtime!=0而且tag还匹配，那么就是一次命中
2. 如果usedtime=0,那么就是一个空block，是一次未命中，然后将新指令填入即可。
3.  如果usedtime!=0而且tag不匹配，那么就跟eviction_block.usedtime比较，如果时间更小，那么就将牺牲evictionblock的命令行而将新命令行填入这个位置，及牺牲使用次数少的命令行。

所以find函数干的就是检查是否命中，如果未命中根据不同情况或直接填入新命令行或者遍历一遍寻找Usedtime最小的命令行将其移出，并将新的命令行填入。

最后再将printSummary中参数更改为对应的参数并在其后面释放:

![](https://pic.imgdb.cn/item/5f92b3df1cd1bbb86bfba188.jpg)

至此，程序就编写完成，下面跑一遍试试看：

![](https://pic.imgdb.cn/item/5f92b3f21cd1bbb86bfba561.jpg)

可以看到我的结果与预期结果相同，所以就成功了，下面在仔细分析一下：

打开yi.trace

<img src="https://pic.imgdb.cn/item/5f92b41d1cd1bbb86bfbadf3.jpg"  />

可以看到这是一小部分读入的命令行，结果应该与第二行相对应。

分析可得：

第一个命令为对0x10进行访问，因为是第一次用所以未命中一次，然后填入，这个指令的S=0001即1

然后第2个指令对0x20进行了连续的两次访问，因为S=0010=2与1不同，所以先是一次未命中紧接着填入指令，所以第二次访问时是命中的，所以未命中一次，命中一次。

然后第3行是对0x22进行访问，S=0010=2,2操作已经将其填入至高速缓存了，所以命中一次。

第4个指令是对0x18进行访问，S=0001=1,1c操作已经将该块存入了高速缓存，所以命中一次。

第5行是访问0x110,S=0001=1,但是因为这里的标志位tag=1，所以未命中，然后牺牲命令行一次。

第6行是对0x210进行访问，S=0001=1，但是标志位tag=2，所以也是未命中一次，牺牲命令行一次

第7行对0x12进行两次的访问，S=0001=1，但是标志位不同（因为先前标志位相同的命令行已经被逐出高速缓存），所以未命中一次，并且逐出命令行一次，然后又命中一次。

所以总体来看，未命中次数5次，命中数4次，逐出次数2次，与终端结果第二行刚好对应，原理就是如此。

#### partB

PartB是要求对矩阵进行转置且要求未命中次数要低于Pdf文件中的上限，所以肯定是不能一次全部读入至高速缓存中进行转置这样未命中次数肯定会太多，所以想法是将矩阵分块化逐一进行转置。这里先对32*32矩阵进行转置算法的编写：

![](https://pic.imgdb.cn/item/5f92b46a1cd1bbb86bfbbd08.jpg)

想法如下：

因为s=5,E=1,b=5;

所以总共高速缓存有32个缓存组（2^5）且每个组可以存32个字节的信息，又因为一个int型占4个字节，所以通俗讲就是一个组可以存8个int型，所以对于32\*32想法，第一个想法就是分成8*8块的矩阵来进行转置。这样就可以有效减少未命中次数。但是如果只是这样会发现未命中次数仍然超过了300次，所以还得进一步进行优化。即发现在矩阵转置中，主对角元的位置并未发生变化，所以想的是对于这些主对角元进行特殊化转置，并不读入缓存中，这样未命中次数就地低于了300次，实验结果如下：

![](https://pic.imgdb.cn/item/5f92b4881cd1bbb86bfbc290.jpg)

未命中次数为287次，达成要求。

接下来在对64\*64的矩阵进行转置。先尝试一下8*8分块是否可行：

![](https://pic.imgdb.cn/item/5f92b4c01cd1bbb86bfbcf7b.jpg)

未命中次数为4723远远超过了上限，所以还得另想办法。考虑到8\*8分块时前4行和后4行会有反复的冲突不命中，所以容易想到进一步缩小分块，改为4\*4，此时得到的未命中次数为1699，距离1300还差一点，所以想办法进一步优化，发现在进行4*4分块时，对于B数组而言，由于访问顺序为：前4行的前4列->后4行的前4列->前4行后4列->后4行的后4列。这样会出现两次访问均有一次不命中，所以尝试这样进行优化：

![](https://pic.imgdb.cn/item/5f92b4fc1cd1bbb86bfbd8ab.jpg)

一次性将前四行全都移到左下方，此时前四行前四列就已经转置完了，后四列虽然并未转置也没移动到规定位置，但是却已经存到了一个空间里，可以减少缓存块的占用从而减少冲突不命中次数，此时在对后4行前四列逐行进行转至，同时将前4行后4列进行转置移动到相应的位置，即给后4行前四列的已转置的数让位置，同时自身也进行转置移到相应的位置。未命中次数大幅度减少。

![](https://pic.imgdb.cn/item/5f92b5101cd1bbb86bfbdd6e.jpg)

最后全部移动后

![](https://pic.imgdb.cn/item/5f92b5221cd1bbb86bfbe152.jpg)

再对后4行后4列进行转置。自此算法完成了，代码如下：（当然主对角元还是要特殊处理的）

![](https://pic.imgdb.cn/item/5f92b53b1cd1bbb86bfbe654.jpg)

![](https://pic.imgdb.cn/item/5f92b54c1cd1bbb86bfbea79.jpg)

最后在测试一下，结果如下：

![](https://pic.imgdb.cn/item/5f92b5641cd1bbb86bfbeed9.jpg)

| 分块规模N*N | Miss数 | 分块规模N*N | Miss数 |
| :---------: | :----: | :---------: | :----: |
|     2*2     |  3115  |    12*12    |  2057  |
|     3*3     |  2648  |    13*13    |  2048  |
|     4*4     |  2425  |    14*14    |  1996  |
|     5*5     |  2296  |    15*15    |  2021  |
|     6*6     |  2224  |    16*16    |  1992  |
|     7*7     |  2152  |    17*17    |  1950  |
|     8*8     |  2118  |    18*18    |  1961  |
|     9*9     |  2092  |    19*19    |  1979  |
|    10*10    |  2076  |    20*20    |  2002  |
|    11*11    |  2089  |    21*21    |  1957  |

只能逐一尝试，最后发现17\*17分块未命中次书比较低。所以就是17*17分块

代码如下：

![](https://pic.imgdb.cn/item/5f92b64e1cd1bbb86bfc1f9b.jpg)

结果如下：

![](https://pic.imgdb.cn/item/5f92b6631cd1bbb86bfc2504.jpg)

未命中次数为1992达到要求

### 实验反思

本次实验partA进一步帮助了解了高速缓存的存储原理，partB则主要是学习优化算法和分块化处理思想的学习。其中过程较难，安装valgrind,权限不够等“小坑”也是锻炼自己锻炼解决问题的能力。

### 大佬的座位

1. [第一位大佬](https://blog.csdn.net/xbb224007/article/details/81103995?utm_medium=distribute.pc_relevant_right.none-task-blog-BlogCommendFromMachineLearnPai2-3.nonecase&depth_1-utm_source=distribute.pc_relevant_right.none-task-blog-BlogCommendFromMachineLearnPai2-3.nonecase)
2. [第二位大佬](https://blog.csdn.net/zjwreal/article/details/80926046?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase)