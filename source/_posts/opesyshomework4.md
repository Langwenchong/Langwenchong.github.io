---
title: 操作系统大作业--xv6文件系统的扩展
comments: false
top: false
date: 2021-01-04 11:10:10
tags: [操作系统,C++,大作业,linux,文件物理结构,xv6]
categories: 
	- [项目总结,操作系统大作业]
headimg: https://gitee.com/Langwenchong/figure-bed/raw/master/20210704163627.png
---

### 🔧实验要求

1. 阅读xv6源代码，理解inode结构体与dinode结构体的作用，里面重要字段的作用。
2. xv6文件系统原本有13个索引项，其中12个直接索引，一个一级间接索引，请计算出xv6系统能支持的最大文件大小，并在实验报告中描述计算过程。
3. 若索引项总个数不变，修改xv6索引项，减少一个直接索引，增加一个二级间接索引，从而增大xv6能支持的文件大小。经过这样的修改，能支持的最大文件大小是多少？请在实验报告中描述计算过程。
4. 修改内核源代码fs.c，减少一个直接索引，增加一个二级间接索引，从而增大xv6能支持的文件大小。
5. 编写用户程序big.c，验证修改后的内核正确性。

<!-- more -->

### 📢实验声明

需要运行在xv6-pulic下，你可以从以下方式选择下载：

1. 百度网盘下载直接安装配置好的虚拟盘：链接: https://pan.baidu.com/s/1INHjDRq38WFMpvJ9Z8y0ug 提取码: ukuu 
2. git：https://github.com/mit-pdos/xv6-public

这里注意，我们需要额外的一个文件Big.c用来测试，你可以从百度网盘中下载，也可以直接在下面的big.c代码中复制粘贴到文件夹下。

### big.c

```c
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int
main()
{
  char buf[512];
  int fd, i, sectors;

  fd = open("big.file", O_CREATE | O_WRONLY);
  if(fd < 0){
    printf(2, "big: cannot open big.file for writing\n");
    exit();
  }

  sectors = 0;
  while(1){
    *(int*)buf = sectors;
    int cc = write(fd, buf, sizeof(buf));
    if(cc <= 0)
      break;
    sectors++;
	if (sectors % 100 == 0)
		printf(2, ".");
  }

  printf(1, "\nwrote %d sectors\n", sectors);

  close(fd);
  fd = open("big.file", O_RDONLY);
  if(fd < 0){
    printf(2, "big: cannot re-open big.file for reading\n");
    exit();
  }
  for(i = 0; i < sectors; i++){
    int cc = read(fd, buf, sizeof(buf));
    if(cc <= 0){
      printf(2, "big: read error at sector %d\n", i);
      exit();
    }
    if(*(int*)buf != i){
      printf(2, "big: read the wrong data (%d) for sector %d\n",
             *(int*)buf, i);
      exit();
    }
  }

  printf(1, "done; ok\n"); 

  exit();
}

```

### 解题思路

首先makefile进行系统调用的文件引入和初始化参数等操作，我们根据英文的提示将CPUS：2改为CPUS:1,然后还要再加上一个选项，QEMUEXTRA:-snapshot。还要将parame.h文件中的FSSIZE更改为20000。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210104113701.png)

接下里将big.c加入到文件夹xv6-public下，并且在makefile中引入实际上和date之前的操作类似，就是在UPROGS中引入_big\

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210104113721.png)

我们从英文介绍中得知运行Big功能可以知道现在有多少个数据块，那么在修改之前我们先运行一次Big测试得出结果未修改之前的数据的最大长度，输入make qemu后输入big(如果没有$符号那么还是先将日志打印的部分代码注释掉)最后最输出结果140，也就是说明12个直接索引+1一个一级间接索引组成的大小为140个数据块。我们具体看一下怎么得到的。我们打开fs.h这其声明了索引节点有

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210104113759.png)

可以看到superblock是超级块结构体的声明，这里没关系，下面的dinode就是磁盘索引节点的结构了，我们可以看出NDIRECT的数量声明即直接索引的数量声明应该是12，我这里是修改后的。然后再看fs.c中的bmap即数据块表的函数中：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210104113825.png)

每一个直接索引都是指针后面连着一个数据块，所以有12个数据块。然后对于一级间接索引我们从fs.h中可以看出一个表的大小为512，然后一个表项的大小为uint(4)，所以一个表就有512/4=128个指针所以指向128个数据块，加起来一共是12+128=140个数据块。这就是为什么未修改时big为140，现在我们根据要求要将一个直接索引修改为二级间接索引，所以首先直接索引数量肯定是-1，所以fs.h中的#define Ndirect修改为11。接下来我们需要在bmap中添加新的代码主要是用来判断地址是否在二级间接索引表中，如下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210104113847.png)

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210104113903.png)

这里要声明几个新的参量为*indirect,*double_indirect,indirect_idx,double_indirect_idx。

首先前面的指针不用说肯定是指向表的，后面的idx表示的是索引值及对应的下一级表的索引号，如indirect_idx=bn/NINDIRECT就是求得表号，double_indirect_idx=bn%NINDIRECT就是求得表内偏移量然后找到对应的指针指向的数据块。所以就完成了二级间接索引的寻找。如果不太懂混合索引的方法，请参考我的博客[文件的物理结构](https://wenchong.space/2020/12/31/opsys-note17/)。那么接下来我们对数据块的计算表达式等细节问题进行完善，这里需要将fs.h中的addrs[NDIRECT+1]修改为addrs[NDIRECT+2]并且文件的最大长度计算MAXFILE的计算式子要修改为NDIRECT+NDIRECT+NDIRECT*NDIRECT)。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210104113939.png)

此时如果正确的话应该是11个直接索引块加上一个一级间接索引的数据块数128再加上一个二级间接索引的数据块数128*128最终的结果应该是16523我们进行测试，最终输入big后稍等一段时间就会得出结果。

### 答案截图

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210104114010.png)

### 实验分析

我们通过上面的任务完善，最终完成了预期目标将初始时的文件大小140数据块扩展到了16523个数据块，这里的扩展方法就是将一个直接索引改为二级间接索引即可。