---
title: 计算机系统基础大作业--脆弱性攻击实验
comments: false
top: false
date: 2020-10-23 11:01:58
tags: [计算机系统基础,C++,大作业,脆弱性实验,linux]
categories: 
	- [项目总结,计算机系统大作业]
headimg: https://gitee.com/Langwenchong/figure-bed/raw/master/20210704173312.png
---

进一步理解代码注入攻击。你需要进行3次代码注入攻击。难度依次升级，是一次很好挑战 机会。 请仔细阅读实验操作手册，需要使用一些提供的工具生成攻击用的代码。

 注意：被攻击的ctarget可执行文件，只能在虚拟机Ubuntu下进行实验。 

👉！！！WSL、MacOs、Windows下都不能运行 

重要的事情就说一遍,爱听不听,中途出现损失本人概不负责😒

实验说明手册与作业文件下载:链接：https://pan.baidu.com/s/1Ng-4QwRGs-kZsvgnnmtCbg 
提取码：3it8 

<!-- more -->

### 解题思路

#### level1

跟拆弹作业相似，仍是先进行了反汇编并存入了ctarget.asm文件中进行分析。

任务要求改变这个行为，使 `getbuf`返回的时候，执行 `touch1`而不是返回 `test,`分析touch1看出不需要注入新的代码，只用攻击字符串是其指向另一个已经存在的touch1函数即可，根据栈和寄存器的知识知道只要将缓冲区填满后是栈中存放touch1的地址即可实现相应的跳转。

先分析getbuf函数

![](https://pic.downk.cc/item/5f929e081cd1bbb86bf7268c.jpg)

根据第4017a8行得知缓冲区（rsp）大小为0x28即40字节大小。

所以要是getbuf函数结尾的ret指令跳转到touch1只需利用缓冲区将返回地址修改为touch1的起始地址。

![](https://pic.downk.cc/item/5f929e1c1cd1bbb86bf72ad1.jpg)

Touch1的起始地址为0x4017c0，所以攻击字符串就可以写出来了，这里建立一个新文件attack1.txt用来存放字符串。里面填写内容如下。

![](https://pic.downk.cc/item/5f929e2f1cd1bbb86bf72f72.jpg)

其中前5行即40个字节全部随便填写（当然啦，不能填写’\0’）这里全填写0用来充满整个缓冲区从而导致溢出。然后下一行填写touch1的地址，当然要用小端序来写。这样touch1的起始地址就会覆盖掉原先的返回地址。

然后用如下命令：

```C
./hex2raw<attack1.txt>attackraw1.txt
```

```C
./ctarget -q -I attackraw1.txt
```

即可注入字符串，结果如下：

![](https://pic.downk.cc/item/5f929e741cd1bbb86bf73d92.jpg)

第一关轻松通过!

#### level2

同上，只是要将getbuf函数返回地址改为touch2的起始地址，即跳转到touch2函数，并且看pdf文件中touch2的c代码知道还要同时给touch2接受到自己的cookie值，即0x59b997fa。

Touch2函数反汇编代码：

![](https://pic.downk.cc/item/5f929ea71cd1bbb86bf7469d.jpg)

得知touch2的起始地址为0x4017ec.

并且从touch2接收到的参数会存储在寄存器%rdi中，所以要补写一段代码，是将cookie值寄存到%rdi中，然后在跳转到touch2执行。

这里新建一个文件attack2.S文件内容如下：

![](https://pic.downk.cc/item/5f929ebe1cd1bbb86bf74aea.jpg)

如上就是实现cookie值存储的代码，然后用

gcc -o attack2.s(这里还发现一个坑，就是s文件后缀居然需要大写才行。。。。)

进行汇编后得到attack2.o文件在用

Objdump -d 进行反汇编得到attack.d文件内容如下：

![](https://pic.downk.cc/item/5f929ed61cd1bbb86bf74f07.jpg)

所以注入的代码为：48 c7 c7 fa 97 b9 59 68 ec 17 40 00 c3(千万别忘了ret的c3.。巨坑)

同时，内存中存储这段代码的地方便是getbuf开辟的缓冲区，然后利用gdb调试查看起始位置并且设置断点在查看调用完后的缓冲区位置。

![](https://pic.downk.cc/item/5f929ef21cd1bbb86bf755f7.jpg)

可见此时的缓冲区地址为0x5561dc78

所以字符串最后如下：

![](https://pic.downk.cc/item/5f929f121cd1bbb86bf75b04.jpg)

然后同上生成attackraw2.txt文件并注入得到如下结果：

![](https://pic.downk.cc/item/5f929f271cd1bbb86bf75f1c.jpg)

顺利通关!

#### level3

同样在getbuf函数返回的时候，执行touch3，并且发现从pdf的touch3的C代码中可以看出需要让touch3接受一个参数---cookie值还是0x59b99fa，但是区别是要将cookie字符串的指针存储到%rdi寄存器中。

输入main ascii获得acsii表，对应着找到了ascii码

0x59b99fa----35 39 62 39 39 37 66 61

![](https://pic.downk.cc/item/5f929f491cd1bbb86bf76629.jpg)

上图中得到touch3的起始地址为0x4018fa。

并且在touch3中调用了hexmatch以及strcmp函数，并且将数据压入栈中，覆盖getbuf使用的缓冲区的内存。所以要观察hexmatch之前和之后的缓冲区的样子，从而确定cookie字符串放置于合适的位置从而避免被改变。

这里先建立一个文件attack3.txt：

![](https://pic.downk.cc/item/5f929f661cd1bbb86bf76c18.jpg)

来查看缓冲区的字符串并进行调试。分别在hexmatch前后设置断点查看缓冲区。

![](https://pic.downk.cc/item/5f929f7c1cd1bbb86bf76f83.jpg)

![](https://pic.downk.cc/item/5f929f8e1cd1bbb86bf772c8.jpg)

不难发现在0x5561dcb8这一行内这8个字节并未发生变化即不会受缓冲区溢出从而导致覆盖的问题，所以讲cookie字符串恰好可以存放在这里。

与level2一样先补充一段指令即将cookie移动至0x5561dcb8处，这里建立了attack3.S文件：

![](https://pic.downk.cc/item/5f929fa41cd1bbb86bf7772a.jpg)

然后用

```c
gcc -o attack3.s
```

```c
objdumo -d
```

进行汇编与反汇编得到attack3.d文件：

![](https://pic.downk.cc/item/5f929fd61cd1bbb86bf77f09.jpg)

然后新建里attack4.txt文件内容如下：

![](https://pic.downk.cc/item/5f929fee1cd1bbb86bf782ad.jpg)

其中这个步骤与level2相同，主要不要忘记c3

最后在用hex2raw生成attackraw4.txt并注入记得到下面结果：

![](https://pic.downk.cc/item/5f92a00c1cd1bbb86bf78807.jpg)

任务完成!

### 实验总结

经过这次实验，巩固了缓存区溢出相关的知识并且进一步加深了gdb的学习，并且对于汇编和反汇编的过程了解更加深入，当然，同时也认识到了读代码，构建代码逻辑的能力尤其重要！这次实验中踩过的坑例如：.s文件大写.S,运行./ctarget时要输入-q，设置断点时地址要加0x，ret的反汇编代码c3不要丢失。。。都是这次实验吸收的经验，以后要更加认真仔细！

