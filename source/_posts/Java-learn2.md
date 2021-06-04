---
title: Java学习笔记-第二讲
comments: false
top: false
date: 2021-03-05 16:11:36
tags: [Java]
categories: 编程语言
---

记录翀翀🧐学习Java面向对象程序设计的核心笔记与思考，努力学习的过程，就像在黑屋子里洗衣服，你不知道洗干净没有，只能一遍一遍尽力去洗，等到了考场上那一刻，灯光亮了，你会发现，只要认真洗过，那件衣服就会光亮如新，愿你我都能够坚持学习。

<!-- more -->

#### Java数据类型

<img src="https://gitee.com/Langwenchong/figure-bed/raw/master/20210305164117.png" style="zoom: 150%;" />

Java的数据类型可以分为两大类，一类是基本数据类型，另一类是引用数据类型。后者相当于是对象。这里还要注意Java中byte也是整型的一种，他是比short字长还短的1字节。同时boolean是布尔型，而不是bool。

我们对于这八种基本数据类型可以分为4类：

1. 逻辑性--boolean
2. 文本型--char
3. 整数型--byte,short,int,long
4. 浮点数型--float,double

#### boolean型

在Java中布尔类型不可以用1和0来表示true和false。并且一定要注意声明时是boolean

```java
boolean b=false;
if(b==true){
	//do something
}
```

#### char型

char型用来表示字符，并且要用单引号括起来。由于Java采用Unicode编码，每一个字符占两个字节，所以可以使用十六进制编码形式表示。同时还允许使用转义字符'\'来进行转义。

```java
char c= 'A'; //字符A
char c1= 'u0061'; //十六进制表示
char c2= '\n'； //转义后为换行符
```

这里我们列举出转义符的含义：

| 转义字符 |           含义           |
| :------: | :----------------------: |
|   \ddd   |  1到3位八进制数表示字符  |
|  \uxxxx  | 1到4位十六进制数表示字符 |
|    \'    |        单引号字符        |
|   \\''   |        双引号字符        |
|   \\\    |        反斜杠字符        |
|    \r    |           回车           |
|    \n    |           换行           |
|    \t    |       横向跳格tab        |
|    \f    |         走纸换页         |
|    \b    |           退格           |

之所以回车和换行是两个，是因为在近代打字机刚发明时回车和换行是两个操作，所以这里就沿袭下来了。\r回车是光标回到本行的最首段，\n是光标切换到下一行。

#### 整数类型

整数类型根据不同的字长分为了以下几种，他们都有固定的表数范围和字段长度，而且不受具体操作系统的影响，以保证Java的可移植性。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210305165621.png)

Java中整型有三种表示分别是：

1. 十进制数，例如12，-314,0。
2. 八进制数，要求以0开头（正好和十进制不存在0开头的数区分开），如：012
3. 十六进制数，要求以0x或者0X开头，如0x13

同时注意Java中的整型常量默认为int型即4字节。如

```java
int i=3;
```

并且每整型不能超过自己的类型表数范围，比如下面就是错误的

```java
byte i=128
```

{% note info, 

一定要注意，负数比正数能多表示一位，学过机组原理后我们知道负数是用补码表示的，所以1000000表示的是最小负值，因此会多表示一位。

%} 

同时对于long声明可以在后面的数值加上l或者L，如

```java
long i=3L;
```

#### 浮点型

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210305170302.png)

在学过机组原理的浮点型IEEE754标准以后我们已经知道了表数范围的由来，主要是移码导致的。在Java中浮点类型有两种表示范围：

1. 十进制数表示，必须含有小数点，例如：

   3.14，314.0，.314

2. 科学计数法形式，比如：

   3.14e2，3.14E2，314E2

并且Java浮点型常量默认是为double型，如果要声明一个常量为float型，则需要在数字后面加上f或者F。

```java
double d=3.14;
float f=3.14f;
//如果不加上f会报错
```

#### Java有效标识符

首字母可以是a-z,A-Z,$和_

其余字母可以是a-z,A-Z,$，_和数字

#### Java算术运算符

这里只给出特殊的情况，其他默认和C一样：

^在Java中不是乘方的意思，而是按位异或的意思，表示2的5次方需要写成

```java
Math.pow(2,5); 2^5
```

#### Java逻辑运算符

这里我们需要区分一下|,&与||,&&的区别，他们都可以用来if判断句中，但是作用不同，一个字符就是理解上的进行取或和相与的操作，但是||和&&是短路或和短路与的意思。我们用一段代码区分：

```java
if(A&&B)//如果已知A是false了那么就不执行B了
if(A&B)//即使知道A是false了那么还要执行B
if(A||B)//如果知道A是true了那么就不执行B了
if(A|B)//即使知道A是true那么还要执行B
```

由于上面的逻辑符号的含义，会造成如下情况：

```java
//如果dog对象存在，那么下面的语句没问题
//即使dog对象不存在，那么下面语句也不会报错，因为短路与了
if((dog!=NULL)&&(dog.getAge()>1))
//此时下面的语句如果dog对象也没错
//但是如果dog对象不存在，那么会报错
//这是因为即使知道了dog!=NULL返还false了还会去尝试调用后面的函数getAge()
//但是实际上此时根本就不存在这个函数
if((dog!=NULL)&(dog.getAge()>1))
```

同时~有按位取反的意思，所以下面的语句在语言中是用来判断num是否为-1的

```c
if(!~num){
	System.out.println("负数");
}
```

这是因为只有num是负数时，按位取反为0，再取非整体结果为true才会输出语句。

#### 移位运算符

<<和>>都是算术移位，可以参考机组算术移位规则。而<<<和>>>就是逻辑移位全部填0。同时要注意：

```
a>>b//如果a是int型，需要b模32,以防a右移32位将a移位清零了
a>>b//如果a是long型，需要b模64,以防a右移64位将a移位清零了
```

同时还要时刻注意加减法的优先级大于移位的优先级。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210305172435.png)

#### 表达式中的类型转换

一定要保证转换以后在表示范围之内，转换方法就是和C一样，前面有一个括号包裹的新的变量声明符号。比如：

```java
byte a=30;
int i=(int )(a+3);
```

并且要注意在浮点数中即使赋值了一个整型，他也会变成浮点型，所以最终输出的结果会是一个小数，比如：

```java
double d=1;
System.out.println(2*d);//2.0
```

还有就是以下这种超出范围的会报错

```java
int i=256;
byte j =(byte)i;
```

还有就是要注意字符和整型之间的转化，字符转换成整型只是转换成ASCII码值，因此如果是数字应该要减去一个字符0

```java
char c='9';
int i=(int)(c-'0'); //9
```

```java
char c='A';
int i=(int)c; //65
```

#### Java循环语句

大部分都和C相同，但是有一个地方更好，那么就是continue和break都可以跳转到指定位置了。

```java
public static void main(String args[]) {
	round1 : for(int i=0;i<10;i++){
		round2 : for(int j=0;j<10;j++){
			if(j%2!=0)
				//直接continue到round2
				continue round2;
			if(i%2==0)
				//直接continue到round1
				continue round1;
			System.out.println("i="+i+"\t j="+j);
		}
	}
	System.out.println("Game over!");
}
```

```java
public static void main(String args[]) {
	label1 : for(int i=0;i<5;i++){
		label2 : for(int j=0;j<5;j++){
			if(j==3){
				continue label2;
			}
			if(i==3){
				//break出label1即整个循环停止
				break label1;
			}
			System.out.println("i="+i+" j= "+j);
		}
	}
}
```

