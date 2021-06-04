---
title: 数字逻辑与数字系统笔记-第十二讲
comments: false
top: false
date: 2021-04-25 18:55:03
tags: [机组原理]
categories: 计算机系统
---

记录翀翀🥺学习数字逻辑与数字系统的核心笔记与思考，由于这门课程和计算机系统基础的知识点联系性较强，可以作为408机组原理的补充学习。这里分享一段话：要么出众，要么出局，乾坤未定，你我皆是黑马，同是寒窗苦读，怎愿甘拜下风。

<!-- more -->

#### 根据电路图导出状态机

有时候我们并不是事先了解到需求功能后设计电路图，而是在给定电路原理图的情况下推断电路的逻辑功能，也就是电路设计的逆过程。此时我们需要按照如下步骤进行：

1. 检查电路，标明输入输出和状态位
2. 写出次态方程和输出方程
3. 列出状态表和输出表
4. 删除不可达状态以简化状态表
5. 给每个有效状态编码指定状态名称
6. 用状态名称重写状态表和输出表
7. 画出状态转换图
8. 使用文字描述有限状态机的功能

下面我们用一个案例来学习根据电路原理图导出状态机：如下图是一个键盘锁电路，包含两个输入和一个输出，当输出为1时表示开锁成功，试分析，如何进行输入才能使电路产生开锁信号

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210425191332.png)

首先我们要检查电路图，标明输入，输出和状态位：

- 输入A0,A1
- 输出unlock
- 状态位S0,S1
- 电路的输出只取决于状态位Unlock=S1
- 很明显这个电路使用个Moore型状态机

接下来我们写出次态和输出的计方程：

观察上面的电路图，我们可以直接对照着写出次态的计算方程
$$
\begin{cases}
S_1'=S0\overline{A_1}A_0\\
S_0'=\overline{S_1S_0}A_1A_0
\end{cases}
$$
同样输出的计算方程我们也可以轻松推得：
$$
Unlock=S_1
$$
接下来我们要根据上面的方程枚举所有的情况列出状态表和输出表：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210425191851.png)

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210425191819.png)

然后我们将状态表填写完整，进行不可达状态的删除：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210425191935.png)

我们发现状态S1:0=11从未在表中作为次态出现过，即无论输入A1,A0取何值都不可能计算得到次态的11，因此将状态表和输出表对应不可达状态S1:0=11的一栏删除。同时对于现态S1:0=10，总是得到次态S1:0=00，因此此时与输入无关，可以使用无关项X来进一步化简。最终我们得到化简后的状态表和输出表如下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210425192148.png)

接下来我们为状态表和输出表中的每一个有效状态编码指定状态名称，从而使得更容易知道输入情况同时也方便后面进行状态转换图的绘制：

我们规定有效状态编码对应的名称如下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210425192316.png)

因此将上面的化简后的两个表使用新的名称来表示：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210425192401.png)

此时我们根据已经用状态名称标注的状态表和输出表进行状态转换图的绘制，要注意因为是Moore型状态转换机，因此输出应该是写在状态圆圈的内部的。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210425193206.png)

最后我们再观察状态转换图，进行以下逻辑整理，便可以描述出这个电路图要实现的功能了，如上图，在复位状态下，只有先后输入了3和1才能到达解锁状态S2，这也就说明这个键盘输入锁的密码就是31。

#### 基于SystemVerilog HDL的时序逻辑设计

前面我们学习了使用建模语言设计组合逻辑电路，那么接下来我们来学习使用SystemVerilog HDL来设计时序逻辑电路。首先我们需要注意SystemVerilog使用一些特殊的编码风格（IDIOMS)描述锁存器、触发器和状态机。其他的编码风格虽然可以正确的进行仿真，但是综合后会产生错误的电路。

这里我们学习一下如何使用always过程块进行时序逻辑电路的建模:

always过程块分为三类：

- always_comb(描述组合逻辑)
- always_latch
- always_ff

其中后面两个都是描述时序逻辑电路的声明语句。always过程块结构：

```Verilog
always @(sensitivity list)
 		statements;
```

sensitivity list是敏感事件列表，当列表中的事件产生时，过程块的语句就开始工作。下面我们就来用几个实例来具体学习一下使用always过程块进行时序逻辑器件的建模。

#### 寄存器建模

寄存器是一个典型的时序逻辑器件，他在同一时刻更新存储多位信息。其结构如下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210425194707.png)

那么我们的建模代码如下

```Verilog
module flop(input logic clk,
			input logic[3:0] d,
			output logic[3:0] q);
		always_ff @(posedge clk)
			q<=d;
endmodule
```

我们使用正边沿D触发器来实现这个寄存器的功能，always_ff用来表示触发器，@后面括号中的posedge clk就是敏感事件，其实就是时刻监视clk，即clk就是时序逻辑电路的条件，当满足时就执行内部的代码，posedge clk表示信号上升沿有效，因此当clk处于有效上升沿时，q的更新赋予d的值。其中这里的赋值符号不是=，而是<=，这在前面其实将结果是非阻塞赋值的意思，这里我们还不用深究，暂时可以把它视为普通的赋值语句。

那么接下来我们来尝试为这个寄存器增添一个复位端，使其能够恢复到最初始的状态。我们前面学到了复位有两种方式：

- 同步复位：只有在clk处于上升沿时可以进行复位
- 异步复位：只要reset=1，那么无论是clk是否处于上升沿都可以强制进行复位，也就是说只要reset处于有效沿，那么就可以执行复位代码。

这里我们给出两种不同复位方式的寄存器建模代码：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210425195615.png)

我们可以看到对于同步复位功能的寄存器，他的敏感事件只有clk，因此只有clk处于有效沿时才能执行always内部的代码，因此只有在clk有效时才可能进行reset的判断以及复位。但是对于异步复位的寄存器，敏感事件有两个即新增了一个reset，也就是说此时只要reset或者clk处于有效沿，都可以执行过程块内部的语句，因此此时是异步复位。

{% note info, 

一定要注意senitivity list只要有一个事件满足就可以进行过程块下的代码，因此条件之间是或的关系

%} 

进一步我们还可以为具有复位功能的寄存器添加一个使能端，只有使能端en=1时才能将Q更新为采样的输入值D：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210425200125.png)

#### 锁存器建模

接下来我们再来实现以下锁存器的建模，实际上并不是所有的综合工具都能够很好地支持锁存器，除非你能明确的知道那些工具支持锁存器，否则最好不要优先使用锁存器，而是使用边沿触发器来替代。同时我们还要防止HDL意外生成锁存器。

我们思考一下锁存器的功能，实际上就是只有在clk=1有效状态时，才能让Q时刻跟随采样的输入值D变化，否则就维持之前的值。因此建模代码很简单：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210425200422.png)

```verilog
module latch(input logic clk,
			input logic[3:0] d,
			output logic[3:0] q);
		always_latch
			if(clk) q<=d;
endmodule
```

#### 阻塞赋值语句`=` VS 非阻塞赋值语句`<=`

我们前面学习过非阻塞赋值语句和阻塞赋值语句区别：

- `<=`是非阻塞赋值语句，他的特点是可以和其他的语句同时执行
- `=`是阻塞赋值语句，他的特点是按照语句的在代码中的顺序依次工作

但是当时我们很难理解两者的应用上有何异同，接下来我们使用一个案例来分析一下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210425200822.png)

我们发现上面的两个建模代码很相似，只是在赋值的时候使用了不同的赋值语句，最终对应的电路图有很大的区别，这就是非阻塞赋值语句和阻塞赋值语句造成的。首先我们分析一下左侧使用非阻塞赋值语句的建模代码，由于非阻塞赋值语句是并行执行的，而不是阻塞式的串行，因此上面两个赋值代码是同时执行的，也就是说q被赋予的是n1还没被更新成d的值。举个例，假设初始时n1=0,d=1，那么执行上面的非阻塞赋值语句后n1=1,q=0，我们发现q的值是n1之前的值0，而不是被更改为d后的1值，这是因为n1和q同时更新值，从q的视角来看，此时n1还是0值，只有当q更新为0以后n1才变成了新的值1。

而阻塞赋值语句就很好理解了，就是我们通常意义上的与C和java等高级软件编程语言都类似的串行赋值，因此n1先更新成了1，然后q才被赋予了n1的值也就是1，因此对于右侧阻塞赋值语句最终的结果q=n1=1。

我们发现正是这两种不同的赋值语句导致了最终实现的电路图是不同的，左侧最终实现的是两个串联的D触发器，而右侧的是一个D触发器。我们还可以进一步尝试将左侧的非阻塞赋值语句用阻塞赋值语句来表示：

```verilog
//下面两个代码是等同效果的
n1<=d;
q<=n1;
//等同于
q=n1;
n1=d;
```

#### 赋值语句使用规则

因此我们可以对各种建模方式的赋值语句进行一个总结：

当使用同步时序逻辑电路要使用always_ff @(posedge clk)和非阻塞赋值语句是代码如下：

```verilog
always_ff @(posedge clk)
	q<=d;
```

而当对于简单的组合逻辑电路中可以使用赋值语句assign

```verilog
assign y=a&b;
```

而对于使用always_comb和阻塞赋值语句=的描述复杂组合逻辑电路的语句如下：

```verilog
always_comb begin
	p=a^b;
	g=a&b;
	s=p^cin;
	cout=g|(p&cin)
end
```

{% note info, 

注意不要在多于1个always语句块或者连续赋值语句中对同一个信号赋值

%} 

#### 计数器建模

N位二进制计算器如下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210425202159.png)

他的输入有时钟信号clk,复位信号reset，同时输出就是一个N位二进制计数结果。功能是每次在时钟上升沿到达时将结果加1并输出。能够实现循环计数：000,001,010，...。因此这是一个时序逻辑器件，他常用数字时钟和程序计数器（PC）中。

下面我们来对他进行建模：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210425202424.png)

```verilog
module counter #(paramer N=8)
				(input logic clk,
				input logic reset,
				output logic [N-1:0] q);
		//很明显是异步复位
		always_ff @(posedge clk,posedge reset)
		if(reset)q<=0;
		else q<=q+1;
endmodule
```

注意上面的赋值语句虽然使用阻塞赋值语句也不会有问题（这是因为每种情况只会有一个赋值代码），但是为了规范可以在任何综合工具上都能综合，因此还是要求使用`<=`来进行赋值。

#### 移位寄存器

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210425202907.png)

移位寄存器输入有时钟信号clk,串行输入信号Sin,输出由串行输出Sout以及N位并行输入的Qn-1:0。移位寄存器的功能就是在时钟信号的每一个上升沿，从Sin移入一个新的位，并将寄存器的整体向前（高位）移动一位，因此最前面（最高位）会出来位移如Sout。我们可以将其看成是一个串行到并行的转换器，每一个周期从Sin输入一位，N个周期后可以通过Qn-1:0直接访问N位输入。因此在将内容整体移位时很明显是需要并行同时执行赋值更新操作的，因此是用非阻塞赋值语句的同步时序逻辑来实现，使用的实现器件就是将N个D触发器串联即可。

下面我们对这个移位寄存器进行优化，使其可以并行加载，什么意思？

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210425203401.png)

此时输入增加了Load信号和并行输入信号Dn-1:0。我们思考一下，之前如果我们想要先将这个N位寄存器加载一个N位数，那么需要先执行N次移位操作，才能将这个N为二进制码加载进去，这很麻烦，因此使用并行输入信号同一时刻并行的为每一个位进行赋值从而实现单位时间不用移位就完成移位寄存器对于一个N为二进制数的加载。此时功能是：

- Load=1时，并行加载一个N位二进制数
- Load=0时，移位寄存器进行移位操作，每一次clk上升沿整体向高位移动一次，最低位由Sin填入

那么此时可以实现串行转并行：Sin到Qn-1:0，同时还有并行转串行Dn-1:0到Sout。那么此时我们来实现一个建模：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210425203748.png)

```verilog
module shiftreg #(parameter N=8)
				(input logic clk,
				input logic reset,load,
				input logic sin,
				input logic [N-1:0] q,
				output logic [N-1:0] q,
				output logic sout);
		//很明显又是一个异步复位
		always_ff @(psoedge clk,posedge reset)
			//复位
			if(reset)q<=0;
			//同时并行赋值同一时刻完成N位二进制数的加载
			else if(load)q<=d;
			//移位，注意要将sin拼接到最低位
			else q<={q[N-2],sin};、
			//同时记录sout值
			assign sout=q[N-1]
endmodule
```

#### 有限状态机建模

我们之前学习的建模都是只是将最核心的同步时序电路部分进行了建模，使用的是always_ff实现的，但是实际上对于一个状态机来说，他在状态寄存器的两侧还存在输入到现态的计算的组合逻辑电路，还有右侧连接的根据现态计算出输出的组合逻辑电路，因此实际上在对一个有限状态机进行建模时即需要alwalys_ff的同步时序过程块，也需要alwyas_comb组合逻辑过程块。如下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210425204642.png)

这是一个最简单的3分频计数器，他就是一个moore型的有限状态机，输入是一个时钟输入信号，一个输出，功能是每3个周期后输出产生一个周期的高电平。因此状态转换图如上图，输出是时钟的3分频。因此建模代码如下：

```verilog
module divideby3FSM(input logic clk,
					input logic reset,
					output logic q);
	//枚举类型集合的声明,类似于结构体的声明
	typedef enum logic [1:0] {S0,S1,S2} statetype;
	//statetype枚举集合的实例化
	statetype [1:0] state,nextstate;
	//核心状态寄存器使用同步时序逻辑
	always_ff @ (posedge clk,posedge reset)
		if(reset) state<=S0;
		else stats<=nextstate;
	//次态的计算使用次态组合逻辑计算
	always_comb
		case(state)
			S0:nextstate=S1;
			S1:nextstate=S2;
			S2:nextstate=S0;
			default:nextstate=s0;
		endcase
	//输出逻辑
	assign q=(state==S0);
endmodule
```

我们会发现上面又添加了两个组合逻辑过程块分别同来计算输入到次态和现态到输出，同时由于SystemVerilog HDL硬件语言具有并行性的特点，因此nextstate虽然先在always_ff的同步时序逻辑过程块中使用了，但是其具体值其实是通过下面的次态组合逻辑过程块计算得到的。

{% note info, 

一定要注意SystemVerilog HDL的代码具有并行性的特点，因此信号的调用和声明赋值无先后顺序。

%} 

#### 存储器阵列

接下来我们学习一个重要的器件--存储器阵列，他是一种有效的可以存入大量数据的模块，每一个N位地址都可以读出或者写入M为数据。

- 数据：存储的内容
- 地址：数据的索引

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210425205654.png)

存储器由一个二维存储单元阵列构成，每一各位单元存储一位数据，每一行存储的是一个M位二进制码数据，由于地址编码是N为，因此一共有2\^N行，也就是说可以存储2^N个M位二进制码数据。

对一个N位地址M位数据的阵列：

- 有2^N行和M列
- 深度（Depth)：阵列的行数
- 宽度（Width)：阵列的列数
- 阵列的总大小（Array Size)：深度×宽度=2^N×M
- 字（Word)：每行数据成为一个字

例如一个2位地址和3位数据的存储器阵列：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210425210723.png)

他的阵列深度会是4行，同时数据字个数也就是4个，每一个字的字长是3位。如上图所示，10地址存放的数据就是100。

