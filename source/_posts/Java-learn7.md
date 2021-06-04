---
title: Java学习笔记-第七讲
comments: false
top: false
date: 2021-03-19 16:21:13
tags: [Java]
categories: 编程语言
---

记录翀翀🧐学习Java面向对象程序设计的核心笔记与思考，努力学习的过程，就像在黑屋子里洗衣服，你不知道洗干净没有，只能一遍一遍尽力去洗，等到了考场上那一刻，灯光亮了，你会发现，只要认真洗过，那件衣服就会光亮如新，愿你我都能够坚持学习。

<!-- more -->

#### 异常处理

我们在C语言中打开一个文件的代码通常是这样的：

```c
File * fp=fopen("D:\\demo.txt","rb");
if(fp==NULL){
    printf("Error on open D:\\demo.txt file");
    exit(1);
}
```

上面的代码中我们加入了空文件时的判断以保证fp非空指针，但是实际上如果不加这个特判，C语言也不会报错，这就意味着这个fp有可能会以空指针的形式进行后面的操作，此时就会造成严重的错误，结果不可预料。因此我们需要对这种异常情况进行判断并做出处理。此时我们可能会想到使用if进行各种异常的情况的特判然进行处理，但是实际开发中可能会有各种异常情况，我们不可能对所有的特殊情况都单独添加一个特判函数，并且有一些异常情况我们不好预料，只有触发以后才能发现，所以我们需要一个可以自动发现异常并抛出异常以便我们进行处理的功能类。而Java就提供了各种异常情况的类，他们可以发现异常并抛出提示开发人员进行处理，一般异常情况有以下三种：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210322103629.png)

异常分为三类，第一种就是Error，准确说应该是错误，即非常严重的错误，此时就需要优先处理错误了。然后是Checked异常，即代码自身具有逻辑错误导致的异常，此时就需要我们来进行处理了，一般这种情况都是根据不同的代码逻辑有不同的异常，所以我们可以给这种异常进行不同的类的创建，然后命名为我们定义的异常情况，当然Exception是所有自定义异常的父类，然后最后一种就是自身代码逻辑没有问题，而是调用者或者代码接受的参数有问题，那么此时属于Runtime异常，这种异常一般是确定的，一定是这几种子异常情况之一，所以直接使用提供的即可。

比如我们现在将任务比喻成辅导员派我们取打印店打印一个文件，那么Exception即红色圈圈中的异常就是自定义异常，一般是由于执行者自身的问题导致的，比如打印店未开门，我们忘带钱了，或者钱不够等异常问题，那么我们都可以将这些异常进行命名（比如我们自定义为NotOpenEcxeption,LostMoneyException等)然后处理。而对于辅导员给的文件时空文件这种就属于Runtime下已经有定义的NULLPointerException，直接抛出这个异常即可。而系统错误就好比打印时发生了第三次世界大战，那么显然此时异常不重要了，亟待解决的是系统自身的重大错误比如虚拟机崩溃等。

{% note info, 

总结来说，系统错误是非常严重的，此时就需要优先解决。Checked异常时自身代码有问题，我们可以对这种异常进行自定义，而对于RuntimeExecption通常是已经定义好的异常，我们不需要再自己创建命名可以直接使用这个异常类。并且异常Exception不需要再单独引入包。

%} 

异常一般和try-catch语句结合使用，如下图：

```java
Public class ExceptionDemo{
    
    //定义一个Exception异常
	public int getBalance(String username) throws Execption{
        if(username.equals("张三")){
            return 10000;
        }
        //抛出异常，必须是抛出一个实例化异常的对象
		throw new Execption("用户"+username+"不存在"!);
    }
    
    public static void main(String[] args){
        String name="李四";
        ExceptionDemo demo=new ExceptionDemo();
        try{
            //执行下面这句话可能会出现异常
            int balance=demo.getBalance(name);
            //如果发生了异常下面这句话不会被执行
            System.out.println("The balance of"+name+"is :"+balance);
        }
        catche(Exception e){
            //只有发生了异常下面这句话才会被执行
            System.out.println("出事了"+e.getMEssage());
            //打印错误堆栈
            //继承于Exception类
            //作用是输出接受到的异常信息以及此时栈中的内容
            e.printStackTrace();
        }
    }
}
```

上面就是一个典型的异常和try-catch协作将异常输出的语句，首先try语句内部执行的是有可能导致异常的语句。然后我们可以自定义异常子类情况，他需要继承自Exception类（所以不难看出异常是一个特殊类），当出现异常时需要new一个异常对象，然后使用throw抛出。当try中语句有异常出现时，那么异常语句后面的代码就不会执行了，而是直接通过catch接受到抛出的异常，然后执行catch内部的异常处理语句。

{% note info, 

一定要注意是可能会有异常的方法使用throws关键字+Exception来抛出异常，并且对于有风险的代码要包裹在try语句中。

%} 

所以try-catch语句格式如下：

```java
try{
	//可能导致异常的语句
}
catch(Exception){
	//发生了异常，执行这里
}
```

但是其实还有finally语句即：

```java
try{
	//可能导致异常的语句
}
catch(Exception){
	//发生了异常，执行这里
}
finally{
    //不管是否发生异常最终都要执行
    //注意一般finally中不写return
}
```

比如上面的那个例子，我们可以在最后统一执行finally语句来结束。

```java
public static void main(String[] args){
        String name="李四";
        ExceptionDemo demo=new ExceptionDemo();
        try{
            //执行下面这句话可能会出现异常
            int balance=demo.getBalance(name);
            //如果发生了异常下面这句话不会被执行
            System.out.println("The balance of"+name+"is :"+balance);
        }
        catche(Exception e){
            //只有发生了异常下面这句话才会被执行
            //这句话的是输出异常提示
           	//e.getMessage是继承于Exception类的函数
            //他是打印红色语句的函数，一般是打印异常情况
            System.out.println("出事了"+e.getMEssage());
            //打印错误堆栈
            //同样继承于Exception类
            e.printStackTrace();
        }
    	finally{
            //不管是否发生异常，下面代码都会执行
            System.out.println(name+"试图访问账户余额");
        }
    }
```

#### 三种可抛出类的区别

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210322103629.png)

我们前面给出的那张图中有三个可以抛出并接受的Throwable类型，他们分别是Error,Exception和RuntimeException，只有他们的对象或者他们子类的对象可以使用throw和catch来进行抛出和接收。这里我们详细讲解一下如何区分一个异常时属于哪一个类。

##### Error及其子类

Error类表示Java运行时内部的系统内部错误或资源耗尽等严重错误。这种错误通常是程序无法控制和解决的，如果发生了这种错误，通常的做法是通知用户并终止程序的执行。这种异常情况已经超出了程序员能力范围，没有解决办法，只能程序直接退出，编译器会检查处理。例如：NoClassDefFoundError,OutOfMemoryError等。

##### Exception及其子类

又称为“可检异常”或“非运行时异常”，这种异常是程序能处理的异常，错误完全在程序员的意料之中，有应对的解决办法，通常此类异常我们可以进行自定义创建。例如：IOException,SQLException，当然自定义的有口令错误异常，余额不足异常等。编译器会检查处理。

##### RuntimeException及其子类

RuntimeException又称为“运行时异常”，通常是发生在JRE内部，也称为“非必检异常”。如NullPointerException，IndexOutOfBoundsException，这种异常的特点是Java编译器不会检查，也就是说即使没有try-catch语句，出现异常时也会抛出这个错误。我们了解一下他的几个子类异常情况：

ArithmeticException算术异常

```java
int a=12/0
```

NullPointerException空指向异常

```java
Date d=null;
System.out.println(d.toString)
```

ArrayIndexOutOfBoundsException数组越界访问异常

```java
int[] array=new int[4];
array[4]=1
```

ClassCastException类转换异常

```java
//Dog和Cat是Animal的子类
Animal animal=new Dog();
//显然无法转换，类的转换仅限于子类和父类之间
Cat cat=(Cat)animal;
```

#### 创建用户自定义异常类

实际上前面的demo演示已经给出了一个自定义异常类的创建过程了。我们总结一下：

- 声明一个新的异常类，使用throws关键字使之以Exception类或其他某个已经存在的系统异常类或用户异常类为父类。
- 为新的异常类定义属性和方法，或重载父类的属性和方法，是这些属性和方法能够体现该类所对应的错误的信息。

自定义异常类也是一个特殊的Exception的子类，所以我们在创建自定义异常类时就是与平常的子类创建一样，只是他需要继承自Exception或者其他的已存在的异常类。如下就是一个自定义异常类的使用：

```java
public class Test {

	public Test() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		LoginUtil loginUtil = new LoginUtil();
		try {
			// LoginUtil是一个登录的类，分别输入用户口令
            //当用户名为"a",口令为"a",不抛出异常
            //否则抛出InvalidUserExcetpion(InvalidUserExcetpion需要你自己定义)
			loginUtil.login("a", "a");
			System.out.println("做对了第1步");
			// 作对第1步
			loginUtil.login("b", "b");
			// 如果程序还能执行到这里 就要扣分了

		} catch (InvalidUserExcetpion e) {
			System.out.println("做对了第2步");
			// 做对了第2步

		}
	}

}
```

上面的InvalidUserExcetpion是一个自定义异常类需要我们自己创建，我们创建一个InvalidUserExcetpion.java文件来存放这个异常类：

```java
//自定义创建类最终一定是Exception的子类
public class InvalidUserExcetpion extends Exception {
    //里面可以写特有函数或者重写Exception的方法
	public InvalidUserExcetpion() {
		System.out.println("InvalidUserExcetpion");
	}
}
```

#### 负责异常处理的方法

一个代码在遇到异常时，可以自己立刻处理，也可以选择不管继续throw让别的代码来处理（但是这个方法还是要throws Exception)，总之谁先catch到谁处理。如下图是一个自己触发了异常后自己立刻处理的情况：

```java
public class ExceptionDemo {
	public int getBalance(String username) throws Exception {
		// 这个地方实际上应该访问数据库查询，为了简单，我们直接判断
		if (username.equals("张三")) {
			return 10000;
		}
		// 不是什么都能throw
		throw new Exception("用户" + username + "不存在！");
	}

	public int getNewBalance1(String username, int amount) {
		int orgBalance = 0;
		try {
			orgBalance = this.getBalance(username);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return orgBalance - amount;
	}

	public static void main(String[] args) {
		String name = "张三8";
		ExceptionDemo4 demo = new ExceptionDemo4();

		int balance = demo.getNewBalance1(name, 100);
		System.out.println("The new balance of " + name + " is:" + balance);

	}

}
```

他的运行结果是：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210322152438.png)

即getNewBalance1中try语句执行了this.getBalance触发了异常，此时他就会立刻catch到抛出的异常然后输出错误信息，然后再返回到main函数继续执行（注意异常并不意味这程序结束，除非是资源不足或者虚拟机崩溃）。

当然也有的是自己触发了异常后置之不理，让其他的函数来善后，比如：

```java
public class ExceptionDemo {
	public int getBalance(String username) throws Exception {
		// 这个地方实际上应该访问数据库查询，为了简单，我们直接判断
		if (username.equals("张三")) {
			return 10000;
		}
		// 不是什么都能throw
		throw new Exception("用户" + username + "不存在！");
	}

    //注意，即使他不处理异常也要记上throws Exception，只要是有风险的函数都要加上
	public int getNewBalance2(String username, int amount) throws Exception {
		int orgBalance = this.getBalance(username);
		return orgBalance - amount;

	}

	public static void main(String[] args) {
		String name = "张三8";
		ExceptionDemo5 demo = new ExceptionDemo5();

		try {
			int balance = demo.getNewBalance2(name, 100);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// demo.getBalance(name);
	}

}
```

他的运行结果是

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210322152828.png)

此时getBalance2中的this.getBalance触发了异常，但是他自己并不catch这个异常处理，而是继续执行，当返还到main函数中以后main会catch这个异常然后进行处理。上面的这两种都可以，看自己的代码习惯。当然有的时候未必只有一个异常，可能会有多个异常，如下图可以对于不同的异常都有一个对应的catch：

```java
public class ExceptionDemo {
	public int getBalance(String username) throws InvalidUserException {
		if (username.equals("张三")) {
			return 10000;
		}
		throw new InvalidUserException("用户 " + username + " 不存在！");
	}

	public int buy(String username, int amount) throws BalanceException, InvalidUserException {
		int orgBalance = this.getBalance(username);
		if (orgBalance < amount) {
			throw new BalanceException("余额不足 ！");
		}
		return orgBalance - amount;
	}

	public static void main(String[] args) {
		String name = "张三o";
		ExceptionDemo6 demo = new ExceptionDemo6();
		try {
			int balance = demo.buy(name, 100000);
			System.out.println("购物成功！当前余额：" + balance);
		} catch (InvalidUserException e) {
            //catch到InvalidUserException进行处理
			System.out.println("用户不存在：" + e.getMessage());
		} catch (BalanceException e) {
            //catch到BalanceException进行处理
			System.out.println("没钱别买东西：" + e.getMessage());
		} finally {
			// 不管发生什么情况，都要执行如下代码
			System.out.println(name + " 试图访问账户余额");
		}
	}

}
```

{% note info, 

我们要注意，只有Exception和其子类并且是非RuntimeException的子类的异常才需要使用throws关键字，如果是Error或者RuntimeException的子类那么就不需要throws关键字即可直接catch。因为我们自定义创建的异常类都是Exception的子类且不属于RuntimeException的子类，所以都需要加上throws关键字。而且要注意RuntimeException是Exception的一个特殊子类，他和Exception并不是同级关系。

%} 

接下来我们看一个不需要throws关键字的异常类，比如：

```java
public class ExceptionDemo {
	public int myDiv(int i1,int i2) {
		if(i2==0) {
			throw new Error("除数不能为0");
			//throw new SQLException("");
		}
		return i1/i2;
	}
	public ExceptionDemo10() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		ExceptionDemo10 demo = new ExceptionDemo10();
		try {
			int result=demo.myDiv(10,0);
			System.out.println("result="+result);
			// 不是什么都能catch
		} catch (Exception e) {
			System.out.println("出错拉！");
			System.out.println(e.getMessage());
			// e.printStackTrace();
		}
	}

}
```

他的运行结果是：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210322153837.png)

我们发现上面的例子中并没有throws关键字声明异常类，但是他仍然可以catch到，因为这是一个除0的算术异常属于RuntimeException的子类，同时由于RuntimeException是Exception的子类，所以catch写成catch(Exception e)就可以接受到这个算术异常。

{% note info, 

一定要注意catch和throw的都是异常类的一个对象。

 %}

异常功能极大的降低了程序的调试难度，我们可以借助异常抛出点准确定位错误。并且也可以强制用户在编译阶段就发现一些未被发现或者未解决的错误，提高了程序的健壮性。

#### 类的终止引发的问题

首先我们知道finally是无论是否异常都要执行的语句，其实这种说法不准确，如果在try的结尾或者catch结尾就返还终止了这个函数，那么funally语句的代码就不会被执行。如下图：

```java
public class ExceptionDemoExit {

	public ExceptionDemoExit() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String args[]) {
		try {
			System.out.println("Begin");
			// 退出系统 类似C语言中的 exit();
			System.exit(0);
		} finally {
			//这句话 永远不会被执行 因为系统退出了
			System.out.println("Finally");
		}
		//这句话 永远不会被执行 因为系统退出了
		System.out.println("End");
	}

}
```

我们发现由于try最后面有System.exit(0)语句也就导致了可能try语句执行完就退出了。我们一定要注意这个问题，他经常在有返还类型的函数中导致编译错误，原因是因为返回出口的缺失或者某些代码无法。比如下面的代码：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210322154949.png)

上面的报错原因是在catch语句执行完以后没有返还值，所以我们最好在这种有返还值的函数中在最下方加上finally代码块，这个代码块即使没有其他操作也可以输入一个return语句以保证函数的出口没有缺失。

#### catch语句的顺序问题

我们知道接收异常的catch语句可以有许多个来接受不同的exception,但是我们要注意catch永远是第一个匹配的执行，然后其他的后面catch就不再执行了，因此必须保证catch的顺序是从小范围到大范围排列，比如下面这种就会出新编译错误：

```java
try{
	throw new java.io.IOException("ie");
}
catch(Exception e){
    System.out.println("Exception");
}
catch(IOException ie){
    //永远接收不到exception
    System.out.println("IOException");
}
```

上面这段代码就会出现编译报错，原因是下面的catch永远不会接收到异常，这是由于Exception是最大的异常类，所有的异常都属于Exception类，所以第一个catch就会优先接收到所有满足条件的异常，即使是IOException的异常，由于IOException也是Exception的一个子类，因此也会再第一个catch处被捕获，而第二个catch也就永远不会有作用了。因此我们必须是按照从小范围到大范围的顺序对catch语句进行排列，即：

```java
try{
	throw new java.io.IOException("ie");
}
catch(IOException ie){
	//当时IOException时会优先捕获
    System.out.println("IOException");
}
catch(Exception e){
	//其他的任何异常还是他捕获
    System.out.println("Exception");
}
```

{% note info, 

我们从上面的代码还可以看出在throw一个异常时，可以在构建这个异常对象时传入一个String参数，来提供错误信息。即

```java
throw new Exception(String);
//抛出这个实例化的异常对象的同时，还会让这个异常对象携带一个信息
```

%} 

#### 异常中的初始化问题

在异常的处理过程中，我们可能会用到一些局部变量，那么这些局部变量必须都已经初始化了才可以使用，如下面这个代码就会出错：

```java
public void buy2(String username, int amount) throws Exception {
		int orgBalance;
		try {
			orgBalance = this.getBalance(username);
			if (orgBalance < amount) {
				throw new BalanceException("余额不足！");
			}
		} catch (Exception e) {
			System.out.println("余额不足:" + orgBalance);
			// 系统编译的时候认为try里面代码完全有可能一行都不被执行，所以必须要在try前面给变量赋值
		}
	}
```

原因是orgBalance在try代码块中的第一个赋值语句出现了异常导致orgBalance未初始化成功，然后就进如了catch代码块进行处理，此时由于orgBalance还没有被初始化所以是不能使用的。（永远记住局部变量必须先初始化再使用）。

#### 异常的输出问题

我们前面看了这么多异常的输出，那么到底什么时候会输出异常信息呢？实际上一般如果我们不添加错误信息，异常输出只会输出红色字内容即栈中的内容。而当我们在throw异常时给这个异常对象添加了Sting信息后，那么再执行e.getMessage和printStackTrace()就会输出错误信息和堆栈状态。

```java
public class ExceptionDemo {
	public int getBalance(String username) throws Exception {
		// 这个地方实际上应该访问数据库查询，为了简单，我们直接判断
		if (username.equals("张三")) {
			return 10000;
		}
		// 不是什么都能throw
		throw new Exception("用户" + username + "不存在！");
	}

	public int getNewBalance2(String username, int amount) throws Exception {
		int orgBalance = this.getBalance(username);
		return orgBalance - amount;

	}

	public static void main(String[] args) {
		String name = "张三8";
		ExceptionDemo5 demo = new ExceptionDemo5();

		try {
			int balance = demo.getNewBalance2(name, 100);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.getMessage();
            e.printStackTrace();
		}

		// demo.getBalance(name);
	}

}
```

此时我们throw是加了一段话为"用户"+user+"不存在"，那么当catch后使用e.getMessage后就会得到这个信息，然后此时我们调用e.printStackTrace()就会输出错误信息和堆栈状态：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210322161338.png)

我们要注意e.getMessage只管接受错误信息，而e.printStackTrace()函数才是打印语句。当我们没有e.printStackTrace()函数时就不会有任何异常信息打印到控制台上。如：

```java
public int getNewBalance2(String username, int amount) throws Exception {
	int orgBalance = this.getBalance(username);
	return orgBalance - amount;

}

public static void main(String[] args) {
	String name = "张三8";
	ExceptionDemo5 demo = new ExceptionDemo5();

	try {
		int balance = demo.getNewBalance2(name, 100);
	} catch (Exception e) {
		// TODO Auto-generated catch block
        //没有打印语句
		e.getMessage();
	}

	// demo.getBalance(name);
}
```

最终的运行结果会是：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210322161630.png)

什么也没有，所以我们为了方便定位异常，最好catch异常时加上打印语句。

#### 方法的异常抛出出口问题

我们必须保证一个方法必须通过throw语句在方法的声明部分说明它可能抛出而并未捕获的所有的“必检异常”，如果没有这么做，就不能通过编译。如下：

```java
public void main(){
	throws SQLException,IOException{
        if(1>2){
            throw new IOException("IOException");
        }
        if(2>3){
            throw new IOException("SQLException");
        }
    }
}
```

总之每一个函数都必须保证每一种可能出现的异常都有一个相对应的异常抛出接口。

#### 什么时候捕捉异常？

首先对于每一个异常如果捕捉了必须输出异常信息或者打印堆栈状态，这样才能在控制台上输出错误信息以便于我们精准定位异常出现的位置。最忌讳的就是下面这样：

```java
catch(Exception e){

}
```

如果这样写就相当于你捕捉到了异常同时默不作声什么也不说，那么是很难定位到错误的。至少要在里面写一句System.out.println("Find an Exception")；或者打印堆栈状态。并且我们并不需要捕获所有异常，我们只需要捕获那些我们应该负责并且知道如何处理的异常即可，对于那些我们并不了解的异常，可以让他们一直向上抛异常直到其他会处理这个异常的开发者捕获进行处理。

#### 接口方法未定义throws Exception问题

我们要知道一个接口在实现类中是严格不允许更改的，所以如果接口函数定义时没有使用throws Exception，那么也就说明实现类内部的具体实现方法也不能抛出需要显示定义的异常，只能使用不需要显示声明的RuntimeException。如下：

```java
//严格要求不允许修改这个接口
public interface  AgeCheckInterface {

	public void checkAge(int age)  ;

}
```

```java
//这种行为会报错,因为实现函数增加了thrwos关键字
//接口函数没有加，那么实现函数也不能加
public class AgeCheck implements AgeCheckInterface thows Exception{

	public void checkAge(int age) {
		if (age < 0 || age > 200) {
            //这里返还的异常需要在方法定义使用throws显示声明
            //很明显无法使用
			throw new Exception();
		}
	}

}
```

但是我们必须要抛出这个异常，此时最佳的方案就是抛出一个不需要throws关键字声明的异常：

```java
//此时就不会报编译错误
public class AgeCheck implements AgeCheckInterface {

	public void checkAge(int age) {
		if (age < 0 || age > 200) {
            //RuntimeException是不需要throws声明的
			throw new RuntimeException();
		}
	}

}
```

#### 总结

最后我们再对异常进行一个简单的总结：

- 可以在不存在风险的情况下throws
- 不可以在不存在潜在风险的情况下catch
- override覆盖重写的时候要考虑Exception
- return的时候要考虑Exception