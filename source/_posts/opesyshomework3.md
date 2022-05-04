---
title: 操作系统大作业--xv6系统系统调用的实现
comments: false
top: false
date: 2020-12-26 16:35:58
tags: [操作系统,linux,xv6,c++]
categories: 
	- [知识分享,项目总结]
headimg: https://langwenchong.gitee.io/figure-bed/20210704163805.png
---

### 🔧实验要求

1. 系统调用添加打印日志功能：阅读xv6源代码理解执行过程后修改syscall.c中的syscall()函数实现每次系统调用都在屏幕上打印系统调用的名字以及该系统调用的返回值
2. 增加date系统调用：添加date system call实现date系统调用可以在xv6 shell中打印UTC时间

<!-- more -->

### 📢实验声明

可以在虚拟机如vmbox等上面安装xv6或者自行去github上下载代码

### 🔎实验链接

百度云（使用于vmbox安装）：链接: https://pan.baidu.com/s/1Pdp-wsleONuDzd3eBcSVvQ 

提取码: uy89 

github:https://github.com/mit-pdos/xv6-public

### 任务1

我们首先打开syscall.c并阅读源代码，知道在syscall函数中的syscalls数组存储的是系统调用中断索引表，他对应着各种系统调用的名称和实现功能的函数：

![](https://langwenchong.gitee.io/figure-bed/20201226170853.png)

在下方syscall函数中当系统调用的编号合法时就可以出发相对应的系统调用函数，这个是通过修改eax指针指向系统调用函数实现的，所以我们如果想要实现追踪需要输出函数指向的函数名称和系统调用编号。

![](https://langwenchong.gitee.io/figure-bed/20201226170938.png)

首先我们需要输出系统名称，这里我们建立一个sysname数组用来存储所有的系统调用名称并且顺序一定要和syscalls数组中的一致，这样当时sysname[num]时我们就取得了相对应的系统调用函数名称，同时输出系统编号值是eax所指向的，因此在上图的注释的地方就是新添加的语句，使用cprintf函数输出，修改完后保存并退出打开终端输入指令make qemu就会发开xv6 shell并且会出现初始化系统调用的追踪信息。

### 任务2

首先我们需要知道date系统调用需要我们从无到有全部创建，所以需要参照其他系统调用的声明方式，首先输入grep -n uptime *.[chS]指令就可以查看到uptime系统调用相关的实现声明方式等，我们也照葫芦画瓢声明相应的函数即可，如下图：

![](https://langwenchong.gitee.io/figure-bed/20201226171705.png)

所以首先我们需要在syscall的106行，130行和155行添加相对应的date的定义如下：

![](https://langwenchong.gitee.io/figure-bed/20201226171043.png)

![](https://langwenchong.gitee.io/figure-bed/20201226171053.png)

![](https://langwenchong.gitee.io/figure-bed/20201226171103.png)

然后在sysproc.h文件中添加date系统调用的系统编号为

![](https://langwenchong.gitee.io/figure-bed/20201226171119.png)

并且同时还要在sysproc.c中实现具体的函数的功能，这里会用到一个新的数据结构rtcdate取对应的声明.h文件中查看知道其有year,month,day,hour等存储日期信息的属性值并且可以通过cmostim()函数对这个数据结构赋值UTC时间戳，这样我们只要在输出即可了。所以sys_date函数代码如下：

![](https://langwenchong.gitee.io/figure-bed/20201226171137.png)

其中上面的argptr函数定义在syscall中其功能注释部分已给出是将所引入的参数为指针形式，指向一个内存块，并检查指针地址。所以如果正确合法的话就可以获取UTC时间。

然后我们还要在user.h中声明这个函数使得这个函数暴露可以被调用。最后我们还要在usys.S中添加date的系统调用这样当执行到date指令时可以出发内陷中断。

我们在进行第二个任务的检验时一定要特别注意需要将任务1添加的代码注释掉因为任务1 的输出会占用vx6 shell的指令导致$莫名消失，注释掉后即可正常输入date指令最后就会返还UTCdate。

### 答案截图

任务1

![](https://langwenchong.gitee.io/figure-bed/20201226171217.png)

任务2

![](https://langwenchong.gitee.io/figure-bed/20201226171227.png)

### 总结

如果你对系统调用还不是太熟悉，请使用本篇博客：

[《系统调用》](https://coolchong.cn/2020/12/15/opsys-note2/)