---
title: 操作系统大作业--多线程求解pi值
comments: false
top: false
date: 2020-10-28 09:06:25
tags: [操作系统,C++,大作业,linux,多线程,pi值求解]
categories: 
	- [项目总结,操作系统大作业]
headimg: https://gitee.com/Langwenchong/figure-bed/raw/master/20210704171432.png
---

实验要求：用POSIX thead编写多线程代码，根据给定的公式求圆周率🍞。

通过下图中的近似公式，使用多线程编程实现pi的计算；通过控制变量N的数值以及线程的数量，观察程序的执行效率。

![](https://pic.downk.cc/item/5f9928501cd1bbb86b77b382.jpg)

具体实验要求见手册：链接：https://pan.baidu.com/s/1MPYRcAoR4qum1MfrTSxHPA 
提取码：wjjq 

<!-- more -->

### 实验准备

总结题意就是要输入两个参数N和t,把N分成t小份，然后建立多线程一次将不同的i带入题目所给公式然后累加求和所有线程的结果得到精确的pi值，这里面要了解一下知识点：pthreaad_create()函数，pthread_join()函数的用法以及互斥锁的原理。

### 解题思路

在说明手册所给的代码进行修改和补充，具体代码请查看源文件，这里主要讲解代码逻辑和部分重要源代码构建思路。

1. pthread_create()函数：

   原型：int pthread_create（（pthread_t \*thread, pthread_attr_t *attr, void \*（\*start_routine）（void *）, void *arg）

     头文件：用法：#include <pthread.h>

     功能：创建线程(实际上就是确定调用该线程函数的          入口点)，在线程创建以后，就开始运行相关的线程函数。

     说明：thread：线程标识符；

   ​       attr：线程属性设置；

   ​       start_routine：线程函数的起始地址；

   ​       arg：传递给start_routine的参数；

   ​       返回值：成功，返回0；出错，返回-1。

   所以这个函数是用来创建多线程并触发函数的功能函数，其中要注意返回值，可以用来检验多线程是否创建成功，因为第一个是指针，所以传进数组的值（当然这个数组需要提前声明），然后第二个设置为NULL即可无特殊要求属性，然后就会触发thread（）函数分线程计算各自的值了（手册源代码已给出提示），最后一个参数就是要传递给thread()函数的参数，如下图。![](https://pic.downk.cc/item/5f99288d1cd1bbb86b77d045.jpg)

   其中malloc就是为声明的数组申请相应大小的地址。

2. pthread_join()函数：

   pthread_join()函数原型：

   int pthread_join(pthread_t thread, void **retval);

   args:pthread_t thread: 被连接线程的线程号

   void **retval : 指向一个指向被连接线程的返回码的指针的指针

   return:线程连接的状态，0是成功，非0是失败

   同上，也是先传递值，第二个参数设置为NULL即可，并且也可以根据返回值进行判断是否正常结束线程并返回值。

   ![](https://pic.downk.cc/item/5f9928c61cd1bbb86b77f439.jpg)

3. 然后就是thread函数来进行对每一个单线程的计算了，根据提示，每次计算i是从id\*length~(id+1)\*length（注意，不包括他），所以根据公式进行相应的计算即可，最后在用互斥锁分别在每次计算完后，进行累加求和即可，这里的关键点在于如何能够得到累加求和的值，有两种思路：（1）第一种是每次返还一个值存入结果数组，然后统一在main()函数中进行求和，这种方法好处是避开了累加涉及到的对同一变量的修改（2）也可以使用全局变量sum,在每次累加求和时只需sum加上返回值即可，我采用的是第二种，变量要声明为全局变量，这样thread就可以调用这个变量了，最后再补上读入n和t的代码块就基本上完成了。![](https://pic.downk.cc/item/5f99293d1cd1bbb86b7831ad.jpg)

   变量均为全局变量，同时因为thread在最后面，要现在main()前面声明。

### 编译运行说明

编译就输入

```c
gcc test.c -o test -lpthraed
```

然后生成test文件后在在终端输入./test即可进行测试，结果当然是得pi的近似值了。

### 实验结果

这里我用我的本地虚拟机进行了机组测试结果均正确。

![](https://pic.downk.cc/item/5f9929b11cd1bbb86b787f0f.jpg)

实验结果分析：不难发现，伴随着N增大，结果值越来越精确。

![](https://pic.downk.cc/item/5f9cd3141cd1bbb86b867b20.jpg)

且不难发现，线程越多耗时越大。

### 实验反思

1. 首先是全局变量声明解决thread()累加求和的问题（上文已提到过）进一步认识到了全局变量的使用便捷性
2. 在编译过程中还发现了warn警告是在提示转换类型时size的转变，查看网上博客时学习到时32位和64位之间的转换问题，解决办法只是在转换时加入了一个参数，由于不太重要我并没有修改，因为并未影响结果计算。
3. 实验编译过程中还发现手册给的源代码参考for循环体内循环变量声明有错误。。（直接复制粘贴的小朋友要注意）
4. 由于pi是小数，所以我在声明变量时用double类型变量（小坑），需要对应c语言输入输出时为%lf或者float类型（%f）;

### 实验源代码

链接：https://pan.baidu.com/s/1F7s7Z9BNUfgDogx-DUxfqw 
提取码：rmqx 
切记不可直接抄袭！！！