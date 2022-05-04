---
title: 操作系统大作业--6.828shell编写
comments: false
top: false
date: 2020-10-22 09:05:47
tags: [操作系统,linux,c++]
categories: 
	- [知识分享,项目总结]
headimg: https://langwenchong.gitee.io/figure-bed/20210704174801.png
---

### 作业要求

编写一个Linux下的简单shell。要求能读写用户键盘输入的命令，解析命令，并创建子进程执行用户命令。

要求支持以下命令要求

1. 输出重定向: >
2. 输入重定向: <
3. 管道: |

实验介绍手册下载:链接：https://pan.baidu.com/s/1_o54THQNs2Y-Qk-g_H7myg 
提取码：scxa 

<!-- more -->

### 解题思路

阅读代码并分析,可以得到以下程序结构的功能与原理  

首先定义了cmd结构体,其type属性用来代表命令类型,然后execcmd,redircmd和pipecmd分别是不同类型命令的结构体定义,其属性值已给出,根据注释解释可以得知execcmd是可执行类型程序(主要是利用参数和数组记录程序名字和选项参数),redircmd是重定向程序(记录symbol标志符号指向的文件,用指针file来指向,还有打开mode,读入读出类型符号等参数),pipecmd代表的是管道类型(记录管道符号两侧的兄弟文件名称).  然后runcmd函数是6.828shell核心程序部件,负责execv(),open(),close(),dup(),pipe()等函数的调用来完成实验要求,其中作业就是要在适当位置补全代码.

首先他会先对可执行程序进行处理,检查是否有管道,若有就出发递归将所有有关联的文件之间建立管道(这里要用到parsepipe())直至全部建立完成,然后返回parsecmd()并进入runcmd()执行命令  Main()是主函数,他首先调用getcmd()获取字符串命令,并且读取字大小,并写入buf指针中,然后判断是否为cd命令,如果是就把尾部赋值为0,然后调用chdir()函数来更新路径,然后continue继续读取命令,当不是更新路径的命令时,就会触发fork1一个子进程,然后父进程挂起等待子进程执行.  此时子进程就会开始分析处理输入的字符串命令行,调用parsecmd,es执行了字符串的末端即空子符处,然后就调用了parseline函数,parseline函数封装了parsepipe函数,所以就出发了核心函数parsepipe()函数用来分析并构建管道.  

这里经常会出现while(s<es&&strchr(whitespace,*s))函数或者while(s<es&&!strchr(whitespace,*s)&&!strchr(symbols,*s))循环语句,查找发现whitespace和symbols是两个字符串数组  

<img src="https://pic.imgdb.cn/item/5f9136cf1cd1bbb86bb048fb.jpg"  /> 所以两个循环语句就是用来跳过无意义的字符如空格等,直至查找到重定向或者管道符号.    

然后,对于管道原理也进行了温习,这里建立管道实际上应用的是无名管道对近亲文件进行管道构建,原理如下:  

1. 进程A创建了一个管道，创建完成时代表管道两端的两个已打开文件都在进程A中.
2. 进程A通过frok（）创建出进程B，在fork（）的过程中进程A的打开文件表按原样复制到进程B中.
3. 进程A通过frok（）创建出进程B，在fork（）的过程中进程A的打开文件表按原样复制到进程B中.
4. 进程A又通过frok（）创建进程C，而后关闭其管道写段而与管道脱离关系，使得管道的写段在进程C中而读端在进程B中，成为两个兄弟进程之间的管道

这里面得A就是一个中间进程来搭建管道,而B.C既是两个要形成联系的子进程文件,所以在遇到管道符号时只需按照上述步骤建立管道即可.(具体实现见sh.c文件)

### 编译操作即测试说明

首先要自己手写一个文件t.sh来进行测试用,我的测试,编译全部是在自己的虚拟机上完成,截图如下:

首先输入

```c
gcc sh.c
```

编译生成a.out文件.然后输入

```c
./a.out
```

进入6.828shell且输入

```c
ls //查看当前文件夹下所有文件
```

```c
ls../ //(更新路径)
```

```c
abc //错误命令报错
```

等命令功能查看是否运行正确,然后再输入

```c
echo “6.828 is cool”>x.txt //定向输入内容
```

和

```c
cat t.txt //查看内容
```

查看是否能写入字符串至x.txt并查看输出x.txt文件,最后在输入

```c
./a.out<t.sh //脚本测试
```

查看是否能测试通过输出正确结果

### 实验正确结果截图

<img src="https://pic.imgdb.cn/item/5f91368e1cd1bbb86bb03e9e.jpg" style="zoom: 80%;" />

其中橙色线所标出的是实验所涉及的文件,其他为文件夹下瞎存放的文件不用关心,很明显实验正确达到了预设目标.

### 实验知识点总结

 本次实验开发用时较短,学习过程较长,主要是涉及一下学习方面:  查看函数功能,这里在查看了相关教程学习到了代码中一下库函数的功能:  

1.   chdir函数

   定义函数：int chdir(const char * path);

   函数说明：chdir()用来将当前的工作目录改变成以参数path 所指的目录.

   返回值执：行成功则返回0, 失败返回-1, errno 为错误代码.

2. execv()函数

   定义函数：int execv (const char * path, char * const argv[]);

   函数说明：execv()用来执行参数path 字符串所代表的文件路径, 与execl()不同的地方在于execve()只需两个参数, 第二个参数利用数组指针来传递给执行文件.

   返回值：如果执行成功则函数不会返回, 执行失败则直接返回-1, 失败原因存于errno 中

3. open()函数

     int open(const char * pathname, int flags);

     int open(const char * pathname, int flags, mode_t mode);相关的参数有以下:

   <img src="https://pic.imgdb.cn/item/5f9138cc1cd1bbb86bb098f3.jpg"  />

4. dup函数()

   定义函数：int dup (int oldfd);

   函数说明：dup()用来复制参数oldfd 所指的文件描述词, 并将它返回. 此新的文件描述词和参数oldfd 指的是同一个文件, 共享所有的锁定、读写位置和各项权限或旗标. 例如, 当利用lseek()对某个文件描述词作用时, 另一个文件描述词的读写位置也会随着改变. 不过, 文件描述词之间并不共享close-on-exec 旗标.

   返回值：当复制成功时, 则返回最小及尚未使用的文件描述词. 若有错误则返回-1, errno 会存放错误代码.

5. close()函数

   定义函数：int close(int fd);

   函数说明：当使用完文件后若已不再需要则可使用 close()关闭该文件, 二close()会让数据写回磁盘, 并释放该文件所占用的资源. 参数fd 为先前由open()或creat()所返回的文件描述词.close()函数

   定义函数：int close(int fd);

   函数说明：当使用完文件后若已不再需要则可使用 close()关闭该文件, 二close()会让数据写回磁盘, 并释放该文件所占用的资源. 参数fd 为先前由open()或creat()所返回的文件描述词.

6. 管道建立原理(上面已经讲过了)

7. .wait(&r)用来等待,且在case ‘|’下方代码下两次fork1()后要有两次wait,毕竟要等待两次子进程全部完成

8. strcat(dest,src)函数用来拼接字符串,把后面src指针所指向的字符串拼接到dest中

9. stat()和access()均可对文件操作权限进行检查,若有一项不符合则返回-1

### 答案下载

链接：https://pan.baidu.com/s/1DRWPFu-HqwNRDKH597CZkg 
提取码：y6ex 
其中sh.c就是源文件,t.sh是已经写好的测试脚本