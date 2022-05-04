---
title: 编译原理分析器实验
comments: false
top: false
date: 2021-11-15 08:39:04
tags: [编译原理]
categories: 
	- [知识分享,项目总结]
headimg: https://langwenchong.gitee.io/figure-bed/20211115162718.png
---

使用自动机理论编写C语言词法分析器，并使用自上而下或者自下而上的语法分析方法编写语法分析器。我们选择使用vue.js纯前端的方法完成编写，具体的分析器代码使用js完成🥂。

<!-- more -->

### 效果演示

点击下方链接即可查看分析器最终效果

{% link 编译原理大作业 , https://compile.coolchong.cn %}

### 词法分析器

#### 实验要求

完成 C--语言的词法分析器，词法分析器的输入为 C--语言源代码，输出识别出单词的二元属性，填写符号表。单词符号的类型包括关键字，标识符，界符，运算符，整数， 浮点数，单字符，字符串。每种单词符号的具体要求如下：

- 关键字：while,for,continue,break,else,if,float,int,char,void,return
- 运算符(OP)：+、-、*、/、%、=、>、<、==、<=、>=、!=、++、--、&&、||、-=、+=、*=、*=、/=等
- 界符(SE)：（、）、{、}、；、，、[、]等
- 整数(IDN)、浮点数（FLOAT）的定义与C相同
- 单字符(CHAR)定义与C语言相同为单引号字符，例如'C'
- 字符串(STR)定义与C语言相同为双引号字符串，例如'STRING'

要能够对输入进行识别分析并生成词素和token序列，一个demo如下：

![](https://langwenchong.gitee.io/figure-bed/20211115085315.png)

![](https://langwenchong.gitee.io/figure-bed/20211115085346.png)

#### 设计原理

**识别表达式**

首先我们先给出不同类型词法单元的识别表达式，如下图：

![](https://langwenchong.gitee.io/figure-bed/20211115090124.png)

##### NFA

然后我们采用识别自动机原理，首先根据上图绘出NFA图如下

![](https://langwenchong.gitee.io/figure-bed/20211115090206.png)

##### 最简DFA

然后我们对他进行确定化为DFA再进行最小化得到最简DFA图如下

![](https://langwenchong.gitee.io/figure-bed/20211115090239.png)

##### 代码设计

因此我们就得到了不同类型词法单元的识别流程，接下来我们参考上面的最简DFA进行代码设计，我们设计了如下几个方法，他们的功能如下

1. analyze()：词法分析器入口方法，负责对接收的程序字符串进行分割等操作，然后逐字符读取，当遇到空格即空字符时停止读取进行简单关键字的判断
2. isKeyWord(str)：具体是否为关键字的判断方法，原理很简单，读取的str和已定义好的集合进行包含关系判断即可完成
3. updateComponentAndToken(str)：生成词素和token序列的方法

具体的工作流程图如下

![工作原理流程图](https://langwenchong.gitee.io/figure-bed/20211115090806.png)

同时我们对简单的错误进行了判断处理，可以在词法分析阶段就识别出非法变量，字符串、字符错误并进行报错。同时优化程序输入方式，可以在线使用云编辑器编辑或者上传txt程序文件进行程序输入。

### 语法分析器

#### 实验要求

采用LL(1)自上而下的方法完成语法分析，要能够根据动态输入的文法进行分析，生成First集合Follow集，同时要能够根据生成的First集合Follow集自动生成预测分析表。最后要能够输入自上而下的归约序列。一个简单的示例如下

![](https://langwenchong.gitee.io/figure-bed/20211115091234.png)

![](https://langwenchong.gitee.io/figure-bed/20211115091253.png)

![](https://langwenchong.gitee.io/figure-bed/20211115091353.png)

#### 原理设计

首先我们给出First集和Follow集的求解算法

##### First集求解算法

![](https://langwenchong.gitee.io/figure-bed/20211115091907.png)

##### Follow集求解算法

![](https://langwenchong.gitee.io/figure-bed/20211115091931.png)

##### 预测分析表求解算法

![](https://langwenchong.gitee.io/figure-bed/20211115092034.png)

##### 数据结构设计

| 数据结构名称 |  类型  |             功能             |
| :----------: | :----: | :--------------------------: |
|  grammarStr  | Array  |         存储输入文法         |
|  production  |  Map   |     存储非终结符的产生式     |
|   FirstMap   |  Map   |  存储每一个符号的First集合   |
|  FollowMap   |  Map   |  存储每一个符号的Follow集合  |
|    VnSet     |  Set   |         存储非终结符         |
|    VtSet     |  Set   |          存储终结符          |
|    stack     | Array  | 用数组模拟预测分析时使用的栈 |
|    inStr     | String |       要进行分析的语句       |
|    table     | Array  |          预测分析表          |
|    token     | Array  |         存储归约序列         |



##### 代码设计

我们使用了如下的几个方法，他们的功能分别如下：

1. dividechar()：对输入的文法进行处理，首先是对复杂的文法语句进行分解，然后识别出非终结符和终结符并存储到VnSet和VtSet并且将每一个非终结符的右侧推导产出式存储到production表中。
2. First()：求解First并赋值给FirstMap的入口程序
3. getFirst(ch)：具体的对每一个符号进行First集合求解的方法
4. getFirstX(s)：具体的对一个字符串进行First集合求解的方法
5. Follow()：求解Follow并赋值給FollowMap的入口程序
6. getFollow(ch)：具体的对每一个符号进行Follow集合求解的方法
7. createTable()：创建预测分析表并对预测分析表进行初始化，插入生成式的入口程序
8. insert(X,a,s)：向预测分析表插入生成式的方法
9. processLL1()：生成归约序列的入口程序
10. displayLL()：将每一个归约步骤存储到token数组中

具体的工作流程图如下

![](https://langwenchong.gitee.io/figure-bed/20211115100149.png)

### 致谢

历时将近两个月的时间终于完成了编译原理大作业，在开发过程中遇到了许多的困难和障碍，但是在开发小组的共同努力下我们最终圆满完成了实验，非常感谢两位开发者[wenchog](https://coolchong.cn/)😁和[yizhe](https://cheeseburgerim.space/)😣。同时本次作业的完成离不开姜佳君老师👨‍💼的支持与帮助，在此向您辛勤的付出表示衷心的谢意！