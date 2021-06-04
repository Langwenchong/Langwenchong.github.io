---
title: Java学习笔记-第一讲
comments: false
top: false
date: 2021-03-04 16:09:18
tags: [Java]
categories: 编程语言
---

记录翀翀🧐学习Java面向对象程序设计的核心笔记与思考，努力学习的过程，就像在黑屋子里洗衣服，你不知道洗干净没有，只能一遍一遍尽力去洗，等到了考场上那一刻，灯光亮了，你会发现，只要认真洗过，那件衣服就会光亮如新，愿你我都能够坚持学习。

<!-- more -->

### JAVA第一讲-2021.03.04

#### Java编程语言的主要特性

1. 面向对象
2. 可移植性，跨平台
3. 支持分布式的网络应用
4. 安全性和健壮性

#### Java虚拟机的概念

Java虚拟机是在实际的计算机上通过软件模拟来实现的，虚拟机有自己想象中的虚拟硬件提供给应用层

#### Java的功能

1. 提供垃圾回收功能
2. 提供运行环境

#### 思考：什么是跨平台特性？

Java与C最大的不同在于，Java编写为.class文件以后，可以到任何一个操作系统中直接运行，无需再次编译。而C/C++文件在windows上编写、编译成exe文件运行以后，同样的代码在linux操作系统中需要再次编编译成为可执行文件。原因是因为win和linux对于c文件的可执行文件类型是不同的，而java在任何的一个操作系统中的可执行文件都是.class文件。

究其原因是因为.class文件永远运行在java虚拟机上，所以任何一个操作系统上都有java虚拟机可以直接用来执行java可执行文件class文件，如下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210305155215.png)

#### Java程序运行模式

Java可以有如下三种方式运行：

1. 网页中的Applet，依托浏览器运行，目前已经很少使用了
2. web方式（需要依托webserver如tomcat/websphere...)
3. Application最常见的就是eclipse,当然vscode+jdk配置也可以。

{% note info, 

如果还未安装Java的运行程序，那么强烈推荐安装eclipse，你可以食用本篇文章：《eclipse的安装》。当然你也可以尝试使用VSCODE但是环境搭建比较复杂。

%} 

#### Java应用常识

对于一个java文件HelloWorldApp.java，我们将这个文件新建到src/ch02文件夹下。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210305161151.png)

那么src文件夹下存放的是许许多多个包package(可以理解为vue中的vue组件)，那么首先我们要在第一行引入如上图package ch02。然后下方是一个大的类并且名字必须和java文件相同，所以也是HelloWorldApp。最后里面必须至少有一个main类，它相当于一个代码进入入口。

{% note info, 

注意一个java文件内可能会有许多个main，也就是说允许有多个入口，但是一次性只能启动一个main，也就是只能进入一个入口。main名称是固定的必须是

```java
public static void main(String args[]){
	//code
}
```

%} 

那么现在我们联系一下，要在src/com/huawei/classroom/student/h01下建立一个Home01.java文件并且输出hello world，那么最终应该如下图:

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210305161747.png)

注意package处的路径是使用.来间隔的

#### 关于包package

那么我们可能会好奇什么是包？实际上包可以类比C中的库文件和自定义的.h文件或者类比于vue中的vue组件，他们都是对应了源程序的一个目录，每一个包也可以有子包（子目录）。其中有一些是官方提供的如JDK的Java类库中的几个重要包：Java.lang,java.io,java.awt,java.net,java.util。当然也有自己定义的，比如我们现在在h02文件夹下新建了一个Home02.java并且也编写了一个功能函数getSum()。那么我们如果想让Home01.java调用Home02.java中的getSum函数首先需要引入这个h02包，所以此时只需要加上一段代码：

```java
package com.huawei.classroom.student.h02
```

所以包会有不同的层级，使用.分割正如目录使用/分割。同时一个包下可以包含若干类文件或子包。比如现在h01下有一个Home01.java文件，h02下有一个Home02.java文件，h01和h02各是一个包。同时com同时含有h01和h02两个包。

#### 关于Java文件

实际上Java文件存放的是源代码，他在编译后生成为.class文件可以在Java虚拟机上被解释并运行。因此以.java后缀的Java文件是源文件，他存有源代码等，他是一个类的声明文件这种说法来自于其形式很像一个类的定义，但是实际上这种说法并不准确。

#### 关于main方法

实际上就类似于c文件中的main函数，是整个文件代码运行的入口函数，但是并不是只能有一个，实际上可以存在多个main，在运行时会根据不同的情况选择一个main作为入口。

{% note info, 

但是要注意，一个java文件中只能有一个public类，并且这个类的名字要和java文件名一致。但是注意public声明的main函数是可以有多个的。

%} 

#### Java基本语法

```java
{ code }   //程序段
; //语句结束必须加
//单行注释
/*
多行
注释
*/
System.out.println(); //输出并且换行
System.out.print(); //输出不换行
System.in.read(); //读入键盘输入的数据
```
