---
title: Java学习笔记-第六讲
comments: false
top: false
date: 2021-03-18 16:19:46
tags: [note,Java]
categories: 
	- [学习笔记]
	- [编程语言,Java]
---

记录翀翀🧐学习Java面向对象程序设计的核心笔记与思考，努力学习的过程，就像在黑屋子里洗衣服，你不知道洗干净没有，只能一遍一遍尽力去洗，等到了考场上那一刻，灯光亮了，你会发现，只要认真洗过，那件衣服就会光亮如新，愿你我都能够坚持学习。

<!-- more -->

#### 变量的传递

我们在调用对象方法时，需要传递参数，在传递参数时，Java是默认按值传递的，即在调用一个方法时，是将表达式的值复制给形式参数，而对于引用型变量，传递的值是引用值（可以理解为内存地址）。两者的区别就在于按值传递时，函数对传进来的参数进行修改操作不会影响到原参数，即可以将原参数和函数接受的参数看成两个单独的变量互不影响，而按引用传递时一旦函数内对变量进行了修改实际上就是对原变量进行修改，因此函数的接受参量和原变量是一个内存映射实体，两者互相影响。

例如下面的代码：

```java
public class TransByValue{
    //如果a变量声明在这里，那么就不用手动初始化
    //因为此时a是TransByValue的一个静态变量，会有默认初始值0
    //private static int a;
    public static void main(String[] args){
        //注意a和b都是static修饰的变量(都属于static方法中的变量)
        //因此a和b的修改函数也必须是静态方法才有权限进行修改
        //同时要注意因为a是基本数据类型变量并不会有默认值初始化
        //必须手动初始化赋予初值
        //因为传进的是一个变量，因此使用第一个modify函数
        modify(a);
        System.out.println(a);//0
        
        //注意b之所以不需要初始化
        //是因为数组属于引用数据类型数据
        //会自动携带默认值0
        int b[]=new int[1];
        //因为传进的是一个数组，所以使用第二个modify函数
        modify(b);
        System.out.println(b[0]);//1
        System.out.println(b.length);//1
    }
    public static void modify(int x){
        //按值传递接收到的参数，所以不会影响main中a的值
        x++;
    }
    public static void modify(int[] y){
        //是引用型传递，所以会影响main中的b数组属性
        //b[0]会变为1
        y[0]++;
        y=new int[5];
    }
}
```

##### 思考：为什么b数组没有变成长度为5的数组？

其实这是因为按引用型传递仅仅是在初始化形参时使用了传进来的参数的地址，但是当对这个地址指针赋予一个新的对象时，那么这个函数内的参数也就随之发生了地址变化，此时在修改函数的参数就不会影响到原参数了。

##### 思考:到底什么是按引用传递？

我们可能之前学习时只是仅仅牢记了按值传递会改变原参数，按引用类型不会改变原参数的说法。实际上这种说法并不准确，因为按引用传参时也可能会由于某些操作导致函数内参数不会再影响原参数。我们首先来读一下按值传递的定义：对于基本数据来说，在进行传递的时候， 将数据的值复制了一份进行的传递。所以我们参考这句话给按引用型传递定义：而对于引用类型，因为该对象本身指向的是它在内存中的地址，所以方法调用的时候，实际上是创建的地址的副本，所以在方法中对其值进行改变的时候，他的地址没有变，值也就跟着改变了，而当你重新创建一个对象的时候，它指向的便是另一个对象的地址了。什么意思？实际上在上面的代码中

```java
 public static void modify(int[] y){
        //是引用型传递，所以会影响main中的b数组属性
        //b[0]会变为1
        y[0]++;
        y=new int[5];
    }
```

y=new int[5]可以视为是将y参数（实际上就是对b数组的地址的拷贝副本）指向了一个新的5长度数组的地址，所以此后y参量就不在是b数组的起始地址了，所以此后再修改y就不会影响都b了，因此b长度还是1，只是此时y不再代表b数组了。我们来验证一下：

```java
public static void modify(int[] y){
        //是引用型传递，所以会影响main中的b数组属性
        //b[0]会变为1
        y[0]++;
        y=new int[5];
        y[0]=6;
    }
```

此时我们再执行modify(b)会发现b[0]还是保留的之前被更改过的1，而之后再次更改的6却不会影响到b数组的第1个值，这就是因为y此时不再存储的是b数组的起始地址了，而是一个5长度数组的起始地址了，也就是说y存储了一个新的数组对象了。

如果我们理解了以后，下面的代码也就不难理解了：

```java
public class TestValue {
	public static void main(String[] args) {
		String str = "a";
		modify(str);
		System.out.println(str);//a

		StringBuffer buf = new StringBuffer("a");
		modify(buf);
		System.out.println(buf.toString());//a+1
	}
	public static void modify(String s) {
		s = s + "1";
	}
	public static void modify(StringBuffer buf) {
		buf.append("1");
	}
}
```

这里的modify(str)并不会改变，我们分析一下：首先modify的参数s接收到的是引用传递的str的地址，然后我们执行s=s+1，实际上这个代码的含义等同于：

```
s=new String(s+"1");
```

所以此时modify函数内的s不在存储str的地址，而是一个新的字符串对象“s+1”的地址，因此str还是a并不会发生变化。但是对于第二个样例，由于调用了append方法，这才是真正的会将字符串进行拼接的函数，那么此时buf就会变成s+1。

{% note info, 

一定要注意在Java中数组和字符串都是引用型变量，即使一个类的对象。

%}

##### 思考:实例变量与局部变量的区别？

从语法角度看，实例变量属于类或接口（即不属于函数的变量），他们可以用public,static,final修饰符修饰，而局部变量是在方法中定义的变量或方法的参变量，只能由final修饰。从存储的角度来看，实际变量是对象的一部分，而对象是存在与堆中，因此实例变量存储在堆中，而局部变量是存储与栈中。并且实例变量的声明周期通常长于局部变量，并且实例变量可以自动赋初值，局部变量则必须显式赋值,并且局部变量只有显式赋值以后才可以使用。

{% note info, 

注意，数组和字符串变量都是实例变量，即使他们在方法中声明也属于实例变量，因为他们都是通过自己的类String和Array构造函数实例化构造的。而对于一般的变量，在类中的才是实例变量：

```java
pulic class Object{
	public int a;//实例变量
	public static void main(String[] args){
		int a=6;//局部变量
	}
}
```

%}

#### 变量的返回

我们可以通过return语句返回我们构造的一个对象，比如：

```java
Object getNewObject(){
	Object obj=new Object();
    obj.name="Alice";
    return obj;//返还了一个引用对象
}

Object hahaha=getNewObject();
//hahah对象是Object的一个对象，并且默认携带了一个Alice名字
```

#### 多态

实际上前面我们在父类和子类的强制转换以及方法覆盖处的知识点都隐隐约约有触及到多态的知识。这里我们详细讲解一下。

子类对象可以当做父类对象，对于重载的方法，Java运行时根据实际情况调用正确的方法，就叫“多态性法”。所有的final/static/private方法都可以实现多态。多态能够使对象所编写的程序，不用做修改就可以适应于其所有的子类，调用方法时，程序会正确的调用子对象的方法。接下来我们用一个例子来说明：

假设此时我们有如下继承链：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210322163647.png)

即以上animal变量被定义为Animal类，但实际上有可能引用Dog或Cat的实例。在Feeder类的feed()方法中调用animal.eat()方法，java虚拟机会执行animal变量所引起的实例的eat()方法。可见animal变量有多种状态，一会变成狗，一会变成猫，这就是多态的体现。即一个父类的对象可以在子类中切换。

```java
public class Feeder{
	public void feed(Animal animal,Food food){
        animal.eat(food);
    }
}

Feeder feeder=new Feeder();
Animal animal=new Dog();
Food food=new Bone();
//给狗喂骨头
feeder.feed(animal,food);

animal=new Cat();
food=new Fish();
//给猫喂鱼
feeder.feed(animal,food)
```

多态的特点大大提高了程序的抽象性和简洁性，最大限度的降低了类和程序模块之间的耦合性，提高了类模块的封闭性，使得他们不需要了解对方的具体细节，就可以很好的工作，这个优点对于程序的设计、开发和维护都有很大的好处。

但是我在学习多态时却又产生了一个疑惑，分享在这里：

```java
public class Father{
	public int height=170;
	public int weigh=150;
	public int getHeight(){
		retun this.height;
	}
}

public class son extends Father{
    public int height=190;
    public int weight=130;
    public int getHeight(){
        return this.height;
    }
    public String cry(){
        System.out.pintln("www");
    }
}

Father obj=new Son();
```

首先，上面这段代码是正确的，没有错误。之所以Father obj=new Son()没有报错我们前面已经讲过了，父类的对象可以使用子类的规则进行初始化，只是父类没有声明的函数他会暂时将特有的方法进行屏蔽，因此这个对象obj还是属于Father类的对象但是他暂时不能使用cry函数（注意，他还是有的，只是被屏蔽了，多态的体现）。那么此时如果我们使用以下语句：

```java
System.out.println(obj.height);//170
System.out.println(obj.getHeight)//190
```

我们会发现一个特别奇怪的现象，就是这个obj的身高是170，但是他的getHeight返还的却是190。这是为什么？所以我们需要进一步深入理解继承的特点。

##### 思考：继承的特点？

继承的特点是它仅仅对于方法有重载的特性，什么意思？就是说，如果一个对象obj，他是按照子类的规则进行的初始化同时声明为了父类的对象。那么假如父类和子类有一个相同的函数A，且父类方法A的存储地址是X，那么此时这个对象obj的方法会优先使用就近的方法进行重载，也就是说此时他会就近使用子类的方法A，直接将父类方法存储单元X处的方法覆盖修改为子类的方法，当这个方法是子类独有的，那么这个存储单元存放的方法地址暂时屏蔽不能使用。然而对于父类和子类都有的相同变量B，那么是不会覆盖的，仅仅是使用两个存储单元单独存储了这两个相同名称的变量，当他转换成哪一个类的对象是就是用哪一个单元对应的变量B。并且要注意变量也会就近寻找，假如son自己没有height值，而他接收到了Father和GrandFather的两个height值，那么son的this.height会优先使用更近的Father赋予的height,而GrandFather赋予的height就会被屏蔽。

我们来以上面的例题解释一下这句话，首先obj是父类的对象，所以他会有父类的成员变量height=170和weight=150。同时由于他还按照子类的规则进行初始化，所以同时他也会有子类的height=190和weight=130，也就是说此时他会有4个存储单元帮他存储这4个变量（两组相同名称的变量）。当他被声明为Son的对象时，那么他就使用height=190和weight=130暂时屏蔽父类的两个变量，但是当他被声明为父类的对象时他就会使用父类的height=170和weight=150，暂时屏蔽子类的height和weight。所以此时obj的height和weight使用的是父类的170和150,因此obj.height=170。但是这仅仅是变量会出现不同的地址存储不同类的相同变量值，但是对于方法，就会进行覆盖，所以此时他会使用Son类的getHeight覆盖父类的getHeight即这个对象真的就只有一个方法，不存在被屏蔽的另一个同名方法，所以又因为此时obj确实拥有子类的height=190，所以他会使用来自Son类赋予的getHeight也就是返还子类的this指向的子类赋予height=190，所以obj.getHeight=190。所以此时如果使用obj.weight会返还150，同时如果有

```java
Son _obj=(Son)obj;
```

即\_obj使用的是obj强制转换成Son直接对象的成员，那么此时\_obj就可以cry，并且_obj的height=190,weight=130,getHeight=190。

所以我们可以总结出：当一个父类的对象使用子类的规则初始化时，那么会同时拥有父类与子类的成员变量并且优先使用离自己更近的父类声明的变量（毕竟他是父类的对象），先屏蔽子类给的同名变量。而对于从子类获得的特有函数，如果对象是被声明为了父类对象，那么这个方法暂时不能使用被屏蔽，当他被转换成子类对象后就可以使用这个特有函数了。同时对于父类与子类都有的相同函数，他就会使用子类的函数覆盖父类的函数，即虽然是父类的对象，但是同名函数使用的是子类所赋予的。即成员变量是就近+屏蔽原则，而方法是覆盖原则。这就是我对继承的一些思考。下面我们在做个变式：

```java
public class Father{
	public int height=170;
	public int weigh=150;
	public int getHeight(){
		retun this.height;
	}
}

public class son extends Father{
    public int height=190;
    public int weight=130;
    public String cry(){
        System.out.pintln("www");
    }
}

Son obj=new Son();
son.getHeight();//170
```

我们发现此时的obj对象就是一个最普通的Son类实例化对象，但是此时Son类自己并没有getHeight()方法，他使用的是继承自Father的getHeight()。那么此时，调用son.getHeight()方法会返回170即父亲的身高，原因同上，是因为此时obj会有两个变量height，一个是Father的height=170,还有一个是Son的height=190，那么此时obj使用的是继承自父类的getHeight()方法，他并没有重载这个函数，那么此时这个函数的this.height指向的还是父类的height=170，所以虽然此时son.height=190，son.getHeight()方法还是会返还170。

#### Class类的信息获取

对象可以通过getClass()方法来获得运行时的信息，getClass是java.lang.Object的方法，而Object是所有类的父类，所以任何对象都可以用getClass()方法。比如：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210321190606.png)

并且getClass()方法获得对象运行时的类信息后，即一个Class类的对象，还可以通过getFields()和getMethosd()方法进一步获得更加详细的信息。

#### 构造方法的执行过程

对于一个复杂的对象，构造方法的执行过程遵照以下步骤执行：

1. 先调用本类或父类的构造方法，直至最深一层派生类
2. 按照声明顺序执行域的初始化赋值
3. 执行构造函数中的个语句

{% note info, 

构建器的调用顺序非常重要，是先父类构造（保证了子类继承父类的所有的成员），再本类成员赋值，最后再执行构造方法中的语句。

%}

这里我们需要注意，在构造子类的一个对象时，子类构造方法会调用父类的构造方法，同时如果父类的构造方法中调用到对象的其他方法，如果调用的方法又被子类所覆盖的话，他可能实际上调用的是子类的方法，只是动态绑定决定的。从语法上来说，这是合理的，但是有时候可能会造成不合理的情况，所以构造方法在调用对象的方法时要小心，比如：

```java
class ConstructInvoke 
{
	public static void main(String[] args){ 
		Person p = new Student("李明", 18, "北大");
	}
}

class Person
{
	String name="未命名"; 
	int age=-1;
	Person( String name, int age ){
		this.name=name; this.age=age; 
        //父类的构造函数调用了子类对象的sayHello();
		sayHello();
	}
	void sayHello(){
		System.out.println( "我是一个人，我名叫：" + name + ",年龄为："+ age );
	}
}

class Student extends Person
{
	String school="未定学校";
	Student( String name, int age, String school ){
        //显示声明了调用父类的一个重载构造函数
		super( name, age );
		this.school = school;
	}
    //重载父类的sayHello函数
	void sayHello(){
		System.out.println( "我是学生，我名叫：" + name + ",年龄为："+ age + ",学校在：" + school );
	}
}
```

最终输出的结果是：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210321191522.png)

我们来分析一下造成school为null的原因。首先子类构造函数通过super调用父类的构造函数，然而父类中的构造函数又执行了对象的hello函数，此时由于这个对象使用的是从子类覆盖得到的子类的sayhello函数，所以会报自己的学校，但是此时还在父类构造函数中，所以还没有对school进行赋值，所以此时会出现school为null的现象。所以只有当父类的构造函数全部语句执行完返回以后才会再执行子类构造函数中this.school=school。这种父类构造函数调用对象的覆盖方法的情况要多加小心。

#### 对象清除与垃圾回收

我们在学习C++时知道当new一个对象后，最后要使用析构函数进行废弃对象的回收，这很麻烦，而java可以做到自动清除废弃变量（不仅仅限于对象），清除过程称为垃圾回收。对象回收时有Java虚拟机的垃圾回收线程来完成的，系统中的任何一个对象都有一个引用计数器（我们知道new出来的变量类型都是一个变量类的对象，因此可以保证new出来的变量都在被计数器监视），当其值为0即不再被使用时，说明这个对象可以回收了。当然我们也可以使用System.gc()方法要求系统进行垃圾回收，但是它仅仅有建议权，最终还是由系统来决定是否回收这个垃圾变量（但是最终系统一定保证回收所有的垃圾变量，使用System.gc()只是可以在特殊的时间、情况下建议系统回收）。同时Java中也是有类似于C++中的析构函数即finalize()方法，我们可以通过Object的finalize()方法来实现关闭打开的文件、清除一些非内存资源等工作需要，系统在回收废弃对象时就是通过自动调用对象的finalize()方法来实现的。一般情况下，子类的finalize()方法中应该调用父类的finalize()方法，以保证父类的清理工作正常进行。但是程序不能只依赖于finalize()函数来进行资源释放的管理工作，因为finalize()函数不可控，有时候会造成巨大的bug,所以我们为了准确安全的释放资源，应该用try-cache-finally语句或者AutoCloseable()（后面会学习）。

#### 内部类

我们前面学习过一个类最好单独放到一个java文件中，因为一个文件只能封装一个public类，但是有时候某些类只是在某一个类的内部使用并且体量很小，那么我们就可以使用内部类来实现。内部类是将类的定义置入一个用于封装他的类内部即可，内部类不能和外部类同名（否咋区分不了到底是内部类，还是外部的引入的类了）。在封装他的类的内部使用内部类，与普通类没有区别，直接调用即可，但是如果是其他地方使用，那么这个类前面要冠以外部类的名字，在用new创建内部类时，也要在new前面冠以对象变量，比如：

```java
//外部类
class TestInnerUse {
	public static void main(String[] args) {
        //调用Parcel的构造方法就普通方法即可
		Parcel p = new Parcel();
		p.testShip();

        //但是此时如果调用Parcel的内部类的构造函数
        //new前面要加上Parcel对象的名字
		Parcel.Contents c = p.new Contents(33);
		Parcel.Destination d = p.new Destination("Hawii");
		p.setValue(c, d);
		p.ship();
	}
}

//封装内部类的外部类
class Parcel {
	private Contents c;
	private Destination d;

    //Parcel的一个内部类
	class Contents {
		private int i;

		Contents(int i) {
			this.i = i;
		}

		int value() {
			return i;
		}
	}

    //Parcel的另一个内部类
	class Destination {
		private String label;

		Destination(String whereTo) {
			label = whereTo;
		}

		String readLabel() {
			return label;
		}
	}

    //Parcel的成员方法
	void setValue(Contents c, Destination d) {
		this.c = c;
		this.d = d;
	}

	void ship() {
		System.out.println("运输" + c.value() + "到" + d.readLabel());
	}

	public void testShip() {
		c = new Contents(22);
		d = new Destination("Tanzania");
		ship();
	}
}
```

我们可以看出内部类并不是只能让封装他的类使用，他也可以被其他的外部类使用，但是使用内部类构造函数进行实例化时，new前面需要加上封装他的类的对象的名称。

并且要注意内部类可以直接访问封装他的类的任何成员，即使是私有变量也可以（毕竟都是一家人），但是如果他想调用封装他的类的外部类的成员，需要在this前加上对象名称（必须由this),如果不加前缀，那么访问的就是自己的同名成员变量：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210321193947.png)

并且要注意外部类一般只能是public修饰或者不加修饰符（但是外部类的变量可以使用这些修饰符），内部类却可以使用这些修饰符比如protected,private，因为可以把内部类看成是封装他的外部类的一个成员。

{% note info, 

注意当这个内部类使用static修饰时，那么实际上他就是一个和封装他的类同级的外部类，毕竟static规定这个类只属于自己，不属于其他类因此也就是同级外部类了。

%}

##### 思考：static内部类的特点？

使用static后，内部类与封装他的外部类同级别了，所以此时再实例化这个内部类的对象时，就不需要在new前面再加上封装他的类的对象的前缀名称了。同时static内部类中也不能访问其他外部类的非static的域及方法了，也就是这个static内部类只能访问其他外部类的static成员了即使是public也不能访问了。同时static方法不能访问非static的域及方法，也不能够不带前缀的new一个非static内部类（这句话可能不好理解，请先看后面）。

#### 方法中的内部类

不但类中可以有内部类，方法中同样可以有内部类，在方法中定义的类称为方法的内部类。方法的内部类和局部变量类似，方法中的内部类不能使用public,private等修饰，因为这个内部类就是一个局部变量，而不是实例变量，前面讲过局部变量是不能使用修饰符修饰的，但是可以被final和abstract修饰。方法的内部类可以访问其外部类的成员，即和与封装他的方法的同级别的成员，同时如果这个内部类是static方法内的内部类，那么他可以访问外部类的static成员。方法中的内部类中，不能够访问封装他的方法的局部变量除非是final变量。

#### 匿名类

匿名类的特点：

- 不取名字，直接用父类的名字
- 类的定义与创建该类的一个实例同时进行，即类的定义前面需要有一个new,不使用关键字class
- 类名前面没有修饰符
- 因为没有名字，类中不能够定义方法，在构造对象时不能够带参数

{% note info, 

内部类和匿名类了解即可，一般不会用到。

%}

