---
title: 计算机系统基础大作业--拆弹专家有你?(bomb)
comments: false
top: false
date: 2020-10-23 10:27:10
tags: [机组原理,c++,bomb,linux]
categories: 
	- [知识分享,项目总结]
headimg: https://langwenchong.gitee.io/figure-bed/20210704174311.png
---

程序bomb是⼀个电⼦炸弹💣，当该程序运⾏时，需要按照⼀定的顺序 输⼊⼝令，才能阻 ⽌炸弹的引爆。当输⼊错误的密码时，炸弹将会引爆。当然只是输出一个信息，并不会炸毁 你的计算机，这一点请放心。认真阅读实验说明，以减少你的烦恼！ 祝你好运🙏

实验说明手册与作业文件下载:链接：https://pan.baidu.com/s/16yXk22pxxDOc_wZ9Fc-2tg 
提取码：9ri7 

<!-- more -->

### 解题思路

准备阶段：我先是用objdump -d对程序进行了反汇编过程，存入到bomb.asm文件中来进行推理，获得结果如下（由于太长了，截图不完整）利用了VScode美化插件([x86 and x86_64 Assembly](https://link.jianshu.com/?t=https://marketplace.visualstudio.com/items?itemName=13xforever.language-x86-64-assembly))j进行了颜色渲染方便查看（否则太辣眼）

![](https://pic.imgdb.cn/item/5f9296ae1cd1bbb86bf588c1.jpg)

其中得到了每个函数的反汇编代码。然后开始进行推理。

![](https://pic.imgdb.cn/item/5f92970c1cd1bbb86bf597ef.jpg)

然后，还同时用gdb对bomb的编译文件进行调试,用layout asm命令实时查看.

#### phase1

答案:"Border relations with Canade have never been better"

![](https://pic.imgdb.cn/item/5f9297701cd1bbb86bf5abe4.jpg)

可以分析得到esi被赋予了一个地址，然后就调用了一个叫strings_not_equa的函数，根据名字猜测应该是与字符串长度相等有关比较的函数。然后向后找到地址为401338可以详细看到函数内部的内容

![](https://pic.imgdb.cn/item/5f9297921cd1bbb86bf5b218.jpg)

很长。。。可以看到前几行是把两个值赋给了rbx、rbp应该是两个字符串，其中第401342行调用了string_length函数，string_length函数就在string_not_equal的上方大意是比较两个字符串的长度是否相等，第400eee行是测试eax的值，如果是0就会进入400ef7，否则会执行explode_bomb即炸弹爆炸，所以string_not_equal返回值eax需要是0，即两个字符串不相等是错误的，即两个字符串是相等的，此时两个字符串会被存储到rdi和rsi中，rdi是读入的字符串，rsi是400ee4复制0x402400得到的字符串，所以输入的字符串即密码必须与rsi相同，即和0x402400中存储的字符串相同，通过gdb来访问0x4202400存储的字符串的到答案。

![](https://pic.imgdb.cn/item/5f9297b51cd1bbb86bf5b9c1.jpg)

#### phase2

答案:1 2 4 8 16 32

![](https://pic.imgdb.cn/item/5f9297fb1cd1bbb86bf5c6fb.jpg)

上面是phase2的反汇编代码，从400f05行看出要调用read_six_numbers函数，然后去40145c看函数详细过程，应该是要读入6个数字，其中6个数字应该是要存入栈中，即先进后出，用gdb调试发现rsp寄存器中依次存入了我自己输入的123456六个数字，所以是将6个数字依次放入了一个栈中。然后分析400f0a、400f0e、400f10三行，分别是读取rsp中的数字和1比较，如果不相等就跳转出发爆炸函数，所以可以知道第一个数字一定是1，然后跳转到400f30、400f35，是将rsp+4和rsp+8并且把结果分别存到rbx和rbp，然后又跳转到400f17把rbx地址减去4的内容存放到eax中，所以rbs和rsp相等，然后祥一行又把刚刚得到的eax乘以2并且把结果和rbx比较，如果不相同就爆炸。所以就是第二个至必须是前一个值得2倍。后续步骤同上，所以得到结果为1 2 4 8 16 32

#### phase3

答案:1,311或者7,327等

![](https://pic.imgdb.cn/item/5f9298431cd1bbb86bf5d6ea.jpg)

上面是phase3的代码，看400f47和400f4c两行分别将rsp+0xc和rsp+0x8赋值给rcs和rdx，然后下一行esi被赋予了一个地址4025cf，然后又把eax重置为0,然后就调用了sscanf函数，上百度查了一下sscanf需要被赋予一个格式化的字符串才能进行，而esi可能就是，用gdb调试阿查看4025cf的值，发现就是一个格式化的字符串.

![](https://pic.imgdb.cn/item/5f92985e1cd1bbb86bf5db25.jpg)

所以读入两个int整型数值。经验证和phase2一样应该是吧rcx和rdx两个地址值传入了栈中。400f60将eax和1进行比较，eax存放的是函数返回值，sscanf是统计成功读入的数值个数，所以eax不大1，即读入的数值个数不大于1时，炸弹不爆炸。再看400f6a将11行rsp+0x8存放的值和0x7进行了比较，如果大于0x7就会爆炸。所以rsp+0x8存放的值小于0x7，然后400f71行将rsp+0x8存放的值传给了eax，然后下一行就跳转至了4002470，这是个switch语句，其中无论是哪个情况最后都要到400fbe即eax与rsp+0xc（第二个读入的数）进行判断，如果不相等就引发爆炸，而每种情况下都会得到一个数（赋值到了eax）中，所以当第一个数输入的值不同时，第二个数数值也不同，其中要满足一个给定的关系，，这里我先是将第一个数赋值成了1，此时第二个参数是0x137即311，所以一组答案是1 311，但是当第一个数赋值为7时，第二个数得到的是327，所以还有一种答案是7 327 。当然还有别的答案.

#### phase4

答案:0 0或1 0或3 0或7 0

![](https://pic.imgdb.cn/item/5f9298951cd1bbb86bf5e393.jpg)

和phase3一样，第401024行同样调用了sscanf函数，所以仍是传入格式化字符串，通过gdb调试确认传入的是两个int型整数且看400bf0行知道是放到了rcx和rdx。然后对参数个数进行比较，如果成功传入了两个数值，那么要求输入的第一个数值要小于0xe，然后把0xe赋值给了edx，0x0赋值给esi,edi被赋予rsp+0x8的值，然后第401048调用了func4函数。去400fce看func4的具体过程，看第400104d、40104fb行，知道eax如果不是0，就会出发爆炸，所以知道eax必须为0，而eax存储的是函数func4的返回值，所以知道func4返回的值必须为0。

![](https://pic.imgdb.cn/item/5f9298b51cd1bbb86bf5e8a6.jpg)

然后，这段代码没看明白。。（查看解题思路后知道了是一个递归过程），但是分析太难了，所以查看c代码（通过asm代码逆向汇编为C代码）分析。

![](https://pic.imgdb.cn/item/5f9298d41cd1bbb86bf5ee89.jpg)

这里面的a1和a2就是之前的两个值0xe和0x0，然后把递归函数在main函数中跑一遍测试一下当是何值时能够使func4返回0

![](https://pic.imgdb.cn/item/5f9298e81cd1bbb86bf5f229.jpg)

经测试当输入的值为0 1 3 7时func4会返回0。再看第401051和401056两行即phase4的代码试讲输入的代码与0比较，如果是0就引爆炸弹，所以第二个参数必须为0，所以得到的答案是0 0或1 0或3 0或7 0。

#### phase5

![](https://pic.imgdb.cn/item/5f92992b1cd1bbb86bf5fc3e.jpg)

![](https://pic.imgdb.cn/item/5f92993c1cd1bbb86bf5fec1.jpg)

没有什么思路。。于是对着博客跟着做了一遍，这里就把自己理解的思路写下来了。

第401067行把rdi赋值给了rbx，然后第40106a和401073行在栈中压进了两个哨兵变量。然后又看看了看哨兵变量的功能:

> while 循环中的变量 i 控制着最终的循环次数。这是非常流行的一个表示法，具有这个作用的变量有时也称为哨兵变量（Sentinel variable）。

然后4010d2行清空了eax，然后下一行调用了string_length函数，所以推测大概是要统计rbx所存的字符串的长度。然后40107f又把eax中的值和0x6进行了比较。如果不相等就会引爆炸弹。所以要求eax的值和0x6相等。此时就会跳转到40180b且是先把eax重置为0在跳转。看40108b是通过movzbl命令从rbx开始的rax位置的一个字节赋值给了ecx的低16位，然后把c1的值即上一步得到的结果复制到了rsp中后再复制到rdx中，第401096行使用掩码0xf取得edx的低4位（这里有查看了一下掩码：掩码是一串二进制代码对目标[字段](https://baike.so.com/doc/6911979-7133836.html)进行位与[运算](https://baike.so.com/doc/5687636-5900328.html)，屏蔽当前的输入位。）所以上面的步骤说白了就是把字符串中rax位置处的字符取出来并且在把他的低4位存放到了edx位置。然后第401099行把0x4024b0+rdx中的一个字节放入了edx的低16位中，然后下一行把这16位有复制到了rsp+0x10+rax中。然后又把rax+1，这样rax就是一个索引。第4010a8行将rax与6进行了比较，如果不等就重复第1行过程。所以一共会循环6次，分别读入了6个字符，并且记录了这个6个字符的低6位作为索引rdx，然后从0x4024b0+rdx的位置复制一个字节到rsp+0x10开始的6字节中。最后rsp+10开始存放了6个字符。然后4010ae把rsp+0x16的位置即6个字符之后放上了一个0x0也就是终止符\0。然后又把0x40245e这个地址赋给esi，把rsp+0x10这个地址赋给了rdi，接下来又调用了string_not-equal(phase1分析过)函数。所以是比较esi和rdi两个字符串的首地址是否相同，不相同就会引爆炸弹。所以首地址需要相同。看看0x40245e位置的字符串通过gdb调试可以得到。是flyers,这个就是rsp+0x10处的字符串。然后gdb调试也可得到rsp的字符来源即0x4024b0开始的字符串。是

![](https://pic.imgdb.cn/item/5f9299651cd1bbb86bf6059d.jpg)

所以flyers的索引是9 15 14 5 6 7，这个就是输入的字符串的低4诶。所以只要找到低4位分别是以上数值的字符串即可。

所以答案之一是ionefg.

#### phase6

超出能力范围,以后再填吧🙈

### 实验感悟

通过这次实验，最大的感受就是要学会读代码，并且要保持耐心，不要被一开始繁杂的代码所吓倒。当然要想解题必须牢固掌握movq等命令的功能，并且能够联系前后代码逻辑进行推理，既要有大胆的猜想还要有谨慎的思维。

### 参考的大佬博客

https://www.cnblogs.com/tmzbot/p/9901786.html

https://www.cnblogs.com/liqiuhao/p/7624880.html

