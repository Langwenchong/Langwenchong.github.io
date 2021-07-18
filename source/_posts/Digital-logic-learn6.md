---
title: 数字逻辑与数字系统笔记-第六讲
comments: false
top: false
date: 2021-03-23 16:40:22
tags: [note,机组原理]
categories: 
	- [学习笔记]
	- [408,计算机系统]
---

记录翀翀🥺学习数字逻辑与数字系统的核心笔记与思考，由于这门课程和计算机系统基础的知识点联系性较强，可以作为408机组原理的补充学习。这里分享一段话：要么出众，要么出局，乾坤未定，你我皆是黑马，同是寒窗苦读，怎愿甘拜下风。

<!-- more -->

#### 行为建模

在SystemVerilog HDL中，行为建模是指将数字逻辑电路的功能以较高的抽象形式描述出来，他通过输入和输出之间的因果关系直接建立电路模型，行为建模包括两种描述风格：

- 基于持续赋值语句（assign）的建模
- 基于过程块（always和initial）的建模

基于过程块语句的建模相比基于持续赋值语句的建模具有更高的抽象层次，编程也更加便捷。

##### 基于持续赋值语句的建模

基于持续赋值语句的建模是指根据信号量之间的逻辑关系，采用持续赋值语句（assign）描述数字逻辑电路的方式，也称为数据流建模，其使用方法如下：

```
assign <#延迟量> 信号名=逻辑表达式//<#延迟量>可以缺省
```

比如：

```verilog
logic [3:0]out1,out2,A,B;
assign out1=A+B;
//经过5个单位时间延迟后赋值给out2
assign #5 out2=~(A&B);
```

我们注意到行为建模语句主要是基于已经定义的变量，来定义输入变量和输出变量之间的某种关系，即为行为建模。基于持续赋值语句的建模的特点是只要“=”右侧表达式中的任意变量发生变化，那么这个表达式就会立即重新计算并赋值给左边的变量。如果定义了延迟量，那么赋值将在相应的单位时间内（默认为纳秒，ns）后再完成。

{% note info, 

一定要注意延迟量主要用于仿真，是不可以综合的。

%} 

并且持续赋值语句左侧可以是变量类型（如logic)的信号，也可以是线网类型（如tri）信号，也可以是信号的拼接形式。对于持续赋值语句，任何输入的变化都会立即影响输出结果，体现了组合逻辑电路的特征，即变化瞬时性，因此，基于持续赋值语句的建模只能用来描绘组合逻辑电路。而且基于持续赋值语句的建模方式提供了使用逻辑表达式描述电路的一种方式，不必考虑电路的组成结构以及元组之间的连接。

刚刚上面我们已经给出了基于持续赋值语句的建模例子了，建模语句主要是用来描述信号之间的行为关系，下面我们给出基于持续赋值语句的建模模板：

```verilog
module 模块名 (端口列表);
	//中间变量声明
	logic 信号1，信号2...
	
	//逻辑功能定义
	assign 赋值语句1;
	assign 赋值语句2;
	...
	assign 赋值语句n;
endmodule
```

下面我们以一道例题来讲解如何进行基于赋值语句的建模，我们这里以译码器为例，我们前面学习过译码器是根据接收的信号所组成的编号，从而让特定的输出信号输出高电平真值。比如2线-4线译码器：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210325185745.png)

我们可以根据真值表列出不同信号取真值的表达式（简单的当然也可以使用卡诺图进行简化），然后定义译码器模块来进行建模：

```verilog
module dec2to4(input EN,A,output Y);
	logic EN;
	logic [1:0] A;
	logic [3:0] Y;
	assign Y[0]=EN&~A[1]~A[0];
	assign Y[1]=EN&~A[1]&A[0];
	assign Y[2]=EN&A[1]&~A[0];
	assign Y[3]=EN&A[1]&A[0];
endmodule
```

当然我们还可以通过这个方法来实现机组原理中讲到的一位全加器：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210325190238.png)

他的建模语言代码如下：

```verilog
module fulladder(A,B,cin,sum,cout);
	input logic A,B,cin;
	output logic sum,cout;
	
	assign sum=A^B^cin;
	assign cout=(A^B)&cin;
endmodule
```

如果我们在基于持续赋值建模中的代码中使用了延迟量，那么虽然最后得到的电路完全相同，但是在仿真综合时是会出现不同的结果的，我们前面学习了最终仿真综合平台的结果会以脉冲的形式显示在图上，那么当增加了延迟后，脉冲出现的时间就会发生改变，如下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210325190726.png)

未加延迟量的结果：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210325190756.png)

增加了延迟量的结果：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210325190818.png)

##### 基于过程块的建模

前面我们介绍了基于持续赋值语句的建模方式，接下来我们来学习一下另一种建模方式--基于过程块的建模。基于过程块的建模关注数字逻辑电路输入输出的因果关系（行为特性），即在何种输入条件下，产生何种输出（即完成什么操作），并不关注电路的内部结构细节。这种建模适用于规模庞大、复杂的电路设计，配合EDA工具，构成了现代超大规模集成电路（VISI）的设计基础。

基于过程块的建模使用关键字initial和always定义，通过块标识符begin...end（相当于大括号）包围起来的过程块对电路进行描述。initial主要用于仿真验证，always则主要用于电路建模，也可以用于仿真。always过程块是一个无限循环，每一个always块描述了一个独立的电路功能。

always过程块分为三中类型：always_comb（描述组合逻辑），always_ff和always_latch（描述时序逻辑）。这里我们主要关注always_comb。他的代码模板如下：

```verilog
module 模块名 (端口列表);
	//中间变量声明(如果需要)
	logic 信号1，信号2，...,信号n;
	
	//逻辑功能定义（过程块）
	always_comb begin
		过程赋值语句
		高级语言结构
	end
endmodule
```

基于过程块的建模最重要的就是一定记住块标识符类型的声明以及begin...end包裹。这里我们给出二路选择器的建模板子：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210325191918.png)

我们发现上面的代码中是使用条件语句结构推动描述某几个信号之间的因果关系来进行行为建模的，但是仅仅使用条件语句明显是无法完成建模行为描述的，他也可以像基于持续赋值语句建模一样使用过程赋值语句即对某些变量信号进行赋值，但是他不需要使用assign声明，并且“=”左边的信号必须是变量类型（如logic类型），并且不能是线网类型，“=”右边的信号的类型无限制。如下：

```verilog
module adder(input a,b,cin,output[1:0] out);
	logic half_sum,half_carry;
	always_comb begin
		//正确
		half_sum=a^b^cin;
		//正确
		half_carry=a&b|a&~b&cin|~a&b&cin;
		//错误，端口信号如果不显示声明为变量类型
		//那么默认为wire类型，即线网类型
		out={half_carry,half_sum};
		//下面的是正确的语句
		logic out;
		out={half_carry,half_sum};
	end
endmodule
```

