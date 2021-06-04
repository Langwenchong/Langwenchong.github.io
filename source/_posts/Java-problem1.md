---
title: Java报错:No enclosing instance of type XXX is accessible.
comments: false
top: false
date: 2021-03-13 19:07:02
tags: [Java]
categories: 教程
---

记录一次做题时Java报错的原因，报错提示：No enclosing instance of type XXX is accessible. Must qualify the allocation with an enclosing instance of type XXX (e.g. x.new A() where x is an instance of XXX).

<!-- more -->

今天做题的时候，作业代码如下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210313190957.png)

我在Test下新建了一个Apple类，然后在main函数中实例化一个对象apple，结果构造语句居然报错了，如下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210313191124.png)

上网搜索后，错因如下：因为Apple是Test类下声明的一个类，而static main函数只能调用属于Test类的成员变量和方法，而此时Apple未被声明为static静态类，所以main函数无权使用Apple类和构造函数。改正方法就是将Test下创建的类Apple等前面加上修饰符static即可，这样main函数就会将其视为Test下的一个成员，就可以使用了。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210313191713.png)

当然除非必要，我们也可以选择更好的方法，就是每一个Java文件只声明一个java类，其他的类单独存储于一个同名java文件，将这几个java文件放到同一个包下，通过public修饰符使得他们之间可以互相调用对方的成员变量和方法，当然如果放在了不同的包也没关系，我们只需要使用import语句引入以下即可。

{% note info, 

顺便一提，要注意只有Test这个文件下的主类可以用public修饰，即只有和文件名同名的类可以使用public修饰，其他的类不能使用。

%} 