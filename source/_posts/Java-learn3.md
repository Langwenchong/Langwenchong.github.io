---
title: Java学习笔记-第三讲
comments: false
top: false
date: 2021-03-08 16:13:56
tags: [java]
categories: 
	- [个人笔记,Java基础]
---

记录翀翀🧐学习Java面向对象程序设计的核心笔记与思考，努力学习的过程，就像在黑屋子里洗衣服，你不知道洗干净没有，只能一遍一遍尽力去洗，等到了考场上那一刻，灯光亮了，你会发现，只要认真洗过，那件衣服就会光亮如新，愿你我都能够坚持学习。

<!-- more -->

#### 一维数组的声明与初始化

Java的声明方法要比C/C++的声明方法复杂的多，要多注意。首先我们学习一下Java中一维数组的声明方法：

```java
int a[];
int[] a1;
double b[];
```

上面Java的数组声明代码格式，注意中括号中不可以填写数，也就意味着在Java的数组声明过程不可以定义数组的长度，而是在初始化数组时才能定义长度。那么定义数组长度的方法有显示和隐式两种。显示就是直接给出数组的长度，隐式就是给出初始化的数据，那么数据的个数就是数组的长度，隐式和显示只能选择一种。如下：

```java
int[] a=new int[5]; //显式直接给出数组的长度
int a[]=new int[5];//中括号放到int后或者数组名后面都可以
a[0]=0;
a[1]=1;
a[2]=2;
a[3]=3;
a[4]=4;
a[5]=5;
//那么在填写数据时就只能如上面这样一个个赋值
//注意这种写法是不正确的
int[] b=new int[3];
b={1,2,3};
//因为没有一个个赋值，非法
```

```java
int[] a=new int[]{1,2,3,4,5};
int a[]=new int[]{1,2,3,4,5};
//隐式给出数组长度，由于初始化的数据时5个整数，因此数组长度就是5
//当然隐式声明下面这种简写方式也正确
int a[]={1,2,3,4,5};
int[] a={1,2,3,4,5};
```

但是一定要注意显示隐式混合在一起就不正确了比如：

```java
int a[5]={1,2,3,4,5};//同时有数据和整数定义长度
int[] a=new int[5]{1,2,3,4,5}//同时有数据和整数定义长度
```

{% note info, 

一定要注意数组的初始化长度问题，我们可以简单地即为有数据不能有数长度，有数长度不能有数据。

%} 

并且数组是引用类型，它的元素就是相当于数组类的成员变量，因此数组一经分配空间，其中的每个元素也会被按照成员变量同样的方式被隐式初始化被赋予一个默认值，比如String是空字符串，整型是0，字符型是'0\\'等。

```java
int a[]=new int[5];
System.out.println(a[3]);//0
```

##### 思考：定义和初始化有什么本质区别？

可能我们在学C++时不加以区分，但是在Java中数组的声明和初始化有很大区别。我们要知道定义时仅仅是告诉编辑器有一个数组a，但是他什么样子？数组长度是多少？数据是什么？都不能知道。只有初始化时才可以定义数组长度和填充数据为其分配空间。所以也就是说我们可以声明一个数组，但是仅仅是声明不能定义它的数据和长度。但是初始化时就同时也声明了这个数组，并且可以初始化定义它的数组长度以及填充数据。因此下面这个代码是错误的也就可以理解了：

```java
int a[5];//定义的时候不能定义长度
```

但是下面这个就是正确的：

```java
int a[]=new int[5];//初始化时定义了长度是5
int a[]=new int[]{1,2,3,4,5};//初始化填充了5个数据，因此长度就是5
int a[]={1,2,3,4,5};//数组初始化的简写形式
```

#### 获取一维数组的长度以及元素

定义并用运算符New为之分配空间后，才可以引用数组中的元素。数组的元素的引用方式是使用arrayName[index]即索引值获取，有效值是0~arrayLength-1。注意获取数组的长度是length，不是length()。

```java
int a[]={1,5,7};
int b=a.length;//3
System.out.print(a[b-1]);//7
```

#### 多维数组的声明与初始化

Java中将多维数组视为数组的数组处理，因此首先需要定义高维数组的长度，然后才可以定义低维的。如下：

```java
int t[][]=new int[4][];
t[0]=new int[5];
t[1]=new int[3];
```

其中t[0]，t[1]都可以看成是一个数组类型的成员变量，所以首先需要定义初始化存储这些数组变量的数组长度即高维数组的长度。所以下面这种定义初始化的方法就是错误的：

```java
int t[][]=new int[][4];
```

当然还有如下定义方法也都是正确的，可以参考一维数组的定义：

```java
//高维和低维同时定义初始化,那么最外层数组是长度3，
//t[0]长度为2,t[1]长度为3,t[2]长度为4
int t[][]=new int[][]{{1,2},{1,2,3},{5,6,7,8}};
//当然同样的也可一件简写成
int t[][]={{1,2},{1,2,3},{5,6,7,8}};
```

但是同样的，也是要求整数型显式初始化数组长度方法和数据个数隐式初始化数组长度的方法只能选择一种，所以如下的方法就不正确了：

```java
//高维数组长度同时有显式和隐式定义初始化数组长度
int t[][]=new int[3][]{{1,2},{1,2,3},{5,6,7,8}};
//那么很明显低维长度同时有显示和隐式定义初始化也不行
int t[][]=new int[3][3]{{1,2},{1,2,3},{5,6,7,8}};
//下面更是大错特错,因为低维长度先于高维长度定义了
int t[][]=new int[][3]{{1,2},{1,2,3},{5,6,7,8}};
//下面这种简写方式也错误,错因同上
int t[3][]={{1,2},{1,2,3},{5,6,7,8}};
int t[][3]={{1,2},{1,2,3},{5,6,7,8}};
int t[3][3]={{1,2},{1,2,3},{5,6,7,8}};
```

同时我们可以发现在Java中声明多维数组时不必要求是规则的矩阵型，而可以每一个数组成员变量的长度各不相同，比如：

```java
int t[][]=new int[4][];
t[0]=new int[5];
t[1]=new int[3];
```

这真是太新奇了，同时如果我们如下定义时：

```java
int t[][]=new int[5][5];
t[0]=new int[]{1,2};
t[1]=new int[]{1,2,3};
t[2]=new int[]{1};
t[3]=new int[]{1,2,3,4};
t[4]=new int[]{1,2,3,4,5,6};
```

我们发现虽然此时定义t二维数组长度时是5×5的，但是赋值的时候却没有给每一个数组变量都添加了5个值，此时我们可能会误认为未添加的值会填写默认值0，但是实际上只有填写值后才会为其分配空间，因此即使前面声明为5×5，但是实际上对于t[0]由于只填写了2个数据因此定义长度就是2，所以他只有两个数即1和2，如果此时我们此时输出t[0]\[4\]会报错数组越界。

![](https://langwenchong.gitee.io/figure-bed/20210308210456.png)

因此我们可以理解为数组是一个不规则的形状，如下图：

![](https://langwenchong.gitee.io/figure-bed/20210308210550.png)

实际上有绿√的地方申请了空间，其他地方是不存在的，如果访问就会越界。

#### 复制数组

Java.lang.System类的arraycopy()方法提供了数组元素复制功能。

```java
源数组
int source[]={1,2,3,4,5,6};
//目的数组
int dest[]={10,9,8,7,6,5,4,3,2,1};
//那么会将source从index=0位置以后的所有元素
//复制并粘贴到dest从index=0以后的位置
//目的数组之前的数据会被新的复制元素覆盖
System.arraycopy(source,0,dest,0,source.length);
//最后dest变成了{1,2,3,4,5,6，4,3,2,1};
```

#### String和char初步认识

在Java中char是一个基本数据类型，可以用''保存一个字符且一个字符占两个字节，并且如果想将char型转换成Int型只需强制转换即可。而String是一个类，可以保存0个或者更多的char，用""包裹，如果想要将char转换成String需要特定的函数String.valueOf()函数。

```java
char c='a';
int num=(int)c;//num=65
String s=String.valueOf(c);//s2变成"a"字符串
```

+运算在char和字符串中的意义完全不一样，在字符char中由于他永远会用ASCII码识别成一个字符，因此相加是看成ASCII码相加形成的新字符。而String是会进行拼接计算，同时只要有一个字符串，那么整个这行代码就会将所有的数据转换成字符串进行拼接。如下：

```java
//整型中就是最普通的数值计算
int i=300+5;//i=305;
//字符会看成ASCII码相加形成的新字符
char c='1'+'1';//c的ASCII码变为49*2=98，所以c变成了字符'B'
//字符串是进行拼接，并且会强行将其他非字符串操作转换成字符串
String s="hello,"+'1'+'1'+i+"号"//hello,11305号
String s="hello,"+c+i+"号"//hello,B305号
```

只有基本数据类型之间可以强制转换，而String是一个类不是基本数据类型，因此String和int之间同样也不能强制转换，而需要特定的函数，如下：

```java
String s1="abc";
//将String转换成char[]的方法
char[] charArray=s1.toCharArray();
//把char[]转换成String的方法
//实际上就可以看成把char[]的元素赋值给字符串
String s2=new String(charArray);
//获取字符串长度是length()
int len=s1.length();
int num1=123;
//int转换成String
String s3=String.valueOf(num1);
//把字符串转换成整数
int num2=Integer.valueOf(s3);
```

{% note info, 

实际上我们不难发现任何一个元素转换成String大都是使用String.valueOf()函数，而同样的String要转换成int也是调用Integer.valueOf()函数。但是String和char[]两个非基本数据的转换却比较特殊，需要特殊记忆。

%} 

#### 字符串的比较

判断两个字符串内容是否相等调用的是equals或者equalsIgnoreCase()函数，相等时返还true不等时返还false。而要比较两个字符串的大小可以使用compareTo()函数，他首先比较长度，如果长度小返还-1，如果长度大返还1，如果长度相等，那么逐位比较字符，当全部相同时说明两个字符串完全相同返还0，否则返还第一个不同的字符的ASCII码之差

```java
String s1="abs";
String s2="abd";
String s3="absd";
s1.equals(s2);//false
s1.compareTo(s2)//15,因为's'='d'=15
s1.compareTo(s3)//-1,s1比s3短
```

{% note info, 

一定要注意在Java中比较两个字符串是不能使用==比较的，因为Java中字符串不是基本数据类型，需要调用特定的函数equals来判断

%} 

#### String其他常见操作

```java
String s1="abcdefg";
//取得字符串长度
System.out.println("s1.length()="+s1.length());
//大小写转换
System.out.println("s1.toUpperCase="+s1.toUpperCase());
System.out.println("s1.toLowerCase="+s1.toLowerCase());
//是否包含某种字符串，实际上是返还第一个出现的位置
//注意\"是双引号内再次使用双引号需要转义符号\
System.out.println("s1.indexOf(\"ce\")="+s1.indexOf("ce"));
//截取子串，但是注意不包含结束位置字符，因此是截取了2和3位置
System.out.println("substr="+s1.substring(2,4));
```

#### String类null和“”的区别

null是空的意思，即没有地址空间的意思，而""是字符为空的字符串，只是没有内容，但是却有地址空间。因此下面的代码会出现以下结果

```java
String s1 = null;
String s2 = "";
System.out.println(s1 == null);//true
System.out.println(s2 == null);//false
```

#### 类和对象有关的等价名词

- 类/class
- 实例/对象。类的一个具体化
- 方法/函数。在Java中等价
- 实例变量/成员变量/实例属性/成员属性/域。
- static变量/类变量/静态变量
- override覆盖
- overload重载
- 父类/超类/superclass

#### 类

类是组成Java程序的基本要素，它封装了一类对象的状态和方法，是这一类对象的原型。例如下面是一个Person对象：

```java
public class Person{
	public int age;
	public double height;
	private int weight;
	public int getWeight(){
		return weight;
	} 
}
```

#### 实例变量

实际上就是成员变量又称为域变量，组成类的属性，比如上面的age,height,weight等，他们可以使用private/public/protected修饰或者一个也不用也可以，但是不同于C++没有friend修饰符。同时实例变量不能重名，比如Person只能有一个age实例变量，不能再有一个age。如果没有给实例变量赋值，那么会有默认值，字符串为null,整数为0，浮点数为0.0。

#### 构造函数

构造函数，顾名思义就是根据原型的属性，构造一个对象，其中构造函数可以接受参数并赋值给这个新建的对象。比如上面的Person由于我们都没有赋值，所以现在都是默认值age=0,height=0.0,weight=0。那么现在我们要写一个构造函数，可以对新建的对象赋值如下：

```java
public class Person{
	public int age;
	public double height;
	private int weight;
	public int getWeight(){
		return weight;
	} 
	//构造函数要和class同名并且要在类内部定义
	public Person(int a,double h,int w){
		age=a;
		height=h;
		weight=w;
	}
}
```

{% note info, 

一定要注意构造函数必须和类同名且定义在类中（这也是为什么构造函数可以直接使用类中的参量，因为他在类的作用域内），同时构造函数不能有任何返回值，void也不行，因此他没有定义符。区分类定义和构造函数定义的方法是是否有()，由于构造函数需要接受参数，所以有()即使没有参数也要写上()。

%} 

下面是构造函数错误的写法：

```java
public class Dog{
	public Dog(){...}//正确,没有参数也要加上()
	public Dog(String name){...}//正确
	public void Dog(){...}//错误，有void
	publoc createDog(){...}//错误,名称不一致，会被识别为一个实例方法
}
public Dog(){...}//错误，未在类内部定义
```

{% note info, 

注意构造函数可以有许多个，他们可以根据不同的传入参数种类，参数个数自行判断调用相对应的构造函数，比如上面的前两个都是构造函数，当没有传参时，会调用第一个构造函数，如果传入了name变量，那么就会调用第二个构造函数。实际上这几个构造函数都是重载函数。

%} 

#### 实例方法

实例方法又称为成员方法、对象方法。由于只是类携带的普通函数方法，因此有定义符，同时他也可以被修饰符修饰。方法和构造函数的最大区别就是他必须要有返回类型（如果什么都不返回则返回void）。如下图：

```java
public class Person{
	public int age;
	public double height;
	private int weight;
	public int getWeight(){
		return weight;
	} 
    public void sayHello(){
        System.out.println("Hello world!");
    }
	//构造函数要和class同名并且要在类内部定义
	public Person(int a,double h,int w){
		age=a;
		height=h;
		weight=w;
	}
}
```

sayHello和getWeight函数都是实例方法。

#### 类的实例化

前面我们所讲的都是有关类的定义，下面我们来示范一下类的实例化，即使用构造函数创建一个对象。我们使用上面的Person函数创建一个小翀翀。

```java
public class Person{
	public int age;
	public double height;
	private int weight;
	public int getWeight(){
		return weight;
	} 
    public void sayHello(){
        System.out.println("Hello world!");
    }
	//构造函数要和class同名并且要在类内部定义
	public Person(int a,double h,int w){
		age=a;
		height=h;
		weight=w;
	}
}

public static void main(String[] args){
	//Person是一个类,翀翀是Person类的一个实例
	Person chongchong=new Person(20,185.0,120);
	//注意调用方法前缀是对象
	chongchong.sayHello();
	chongchong.getWeight();
}
```

也就是说类的定义以及他的实例方法在main外面定义即可，但是类的实例化需要在main中进行，同时实例化以后相当于这个实例就拥有了原型的方法，同时通过构造函数它拥有了自己特有的属性值。这就是一个简单的类实例化过程。

{% note info, 

注意Java和C++不同，对象new完后不需要释放，即Java中不用写析构函数，系统会自动释放废弃资源。这大大提升了写代码的效率，程序猿再也不用担心内存泄漏等问题了。

%} 

#### 类的封装

应该尽量只能通过对象变量来访问这个对象的变量或方法，不能通过引用变量就访问其中的变量或方法。那么对于访问者来说，这个对象就是一个封装的整体，这正体现了面向对象对象设计的“封装性”。什么意思？加入现在我们想要知道chongchong的体重，那么直接访问weight或者调用getWeight()是无法获得的，而是必须通过加上对象前缀才能够得知，即chongchong.weight或者chongchong.getWeight()，所以对于访问者来说，chongchong就是一个封装体，想要获取他的信息就必须使用的对象变量或者调用他的对象实例方法。

#### 重载函数

即多个函数拥有相同的名字，但是写函数的参数必须不同，可以是参数个数不同，也可以是参数类型不同。不能仅仅是返回值不同。比如下面几个都是重载函数：

```java
//参数个数不同
public void f1();
public void f1(String p1);
//参数的类型不同
public void f1(String a,int b);
public void f1(int b,String a);
//参数的类型不同
public void f1(String b)
private void f1(int a);
```

##### 思考：什么是参数类型不同？

一定要透彻了解，参数类型不同不是指名字或者传进来的参数集合类型不同，在比较两个函数的参数类型时，他会逐位核对每一个参量的类型（不看形参名称），当出现不同的时候即为参数类型不同，如果类型都相同，只是形参名称不同，那么不属于参数类型不同。比如：

```java
//不是重载函数，因为参数类型相同
public void f1(String a,String b,int c);
public void f1(String c,String a,int b);
```

我们发现上面的两个函数不能构成重载函数，因为他们的参数每一位类型都相同，仅仅是形参名称不同，因此实际上这两个函数相同。但是下面的就是参数不同：

```java
//第一个参数就类型不同,所以是重载函数
public void f1(String a,int b);
public void f1(int b,String a);
```

{% note info, 

还有要注意如果两个方法仅仅是修饰符不同，那么也不能构成重载，比如：

```java
//仅仅是修饰符不同，所以不是重载函数
public void f1(String p);
private void f1(String p);
```

%} 

#### this的用途

实际上this在许多语言中都存在，他总是指向当前的对象。他可以解决局部变量与实例同名的问题，在之前的Person的构造函数中：

```java
public Person(int a,double h,int w){
		age=a;
		height=h;
		weight=w;
	}
```

我们是将Person类的成员变量age,name,weight分别赋值为a,h,w。但是如果此时形参和实例变量同名时，下面这样写会报错：

```java
public Person(int age,double height,int weight){
		age=age;
		height=height;
		weight=weight;
	}//会报错
```

因为他会被两个同名的变量混淆，不知道区分，所以此时我们应该写为对象名字，比如对象为chongchong，那么就应该是chongchong.age，如果是myself，那么就应该是myself.age即应该在前缀加上实例对象名称，但是我们在构造函数中不能得知实例对象的名称并且不能写死，所以就用this来代替，这样他总是指向实例对象，就可以完美解决问题。如下：

```java
public Person(int age,double height,int weight){
		this.age=age;
		this.height=height;
		this.weight=weight;
	}
//chongchong成员函数中的this指向chongchong
Person chongchong = new Person(20,180.0,120);
//pengpeng成员函数中的this指向pengpeng
Person pengpeng = new Person(19,185.0,160);
```

{% note info, 

但是要注意在static方法中不能使用main，比如public static void main中就不能使用this,因为main是静态方法，不是类的一个实例化对象，因此不能调用。

%} 

同时this还有另一个功能：在一个构造函数里面调用另一个构造函数最常见的就是在重构造函数中使用。比如下面的代码：

```java
//第一个构造函数
Public Dog(String name,int weight ){
	this.name=name;
	this.weight=weight;
}
//第二个构造函数
Public Dog(int weight,String name){
	this(name,weight);
}
```

实际上我们发现第二个构造函数接受的参数只是和第一个构造函数需要的传参顺序反了，那么我们调用this(name,weight)实际上就相当于调用了第一个构造函数Dog(name,weight),同时我们交换了参数顺序，因此第二个重载的构造函数实际上只是调换了以下参数顺序使得可以使用第一个构造函数创建实例对象。再比如：

```java
//第三个构造函数
Public Dog(int weight){
	this("noname",weight);
}
```

但三个构造函数的功能是只传入weight即可，名字会赋予默认值noname，同样也是通过this调用了第一个构造函数进行的Dog类的实例化。其实我们也可以不用this实现后两个构造函数的功能，只是需要再次构建功能类似的代码，不如this来得方便并且使用this是一个更加优雅的编程风格，代码利用率高。

#### 类的继承

继承是面向对象的程序设计中最重要的特征之一，有继承而得到的类为子类（subclass)，被继承的称为父类或超类（superclass)，父类包括所有直接或间接被继承的父类。

但是一个类只能有一个直接父类，子类继承父亲的状态和行为，但是同时也可以修改父类的状态或重载父类的行为，并添加新的状态和行为。实际上状态就是成员变量，行为就是成员函数。采用继承的思想，我们可以提高程序的抽象程度，使之更接近于人的思维方式，同时代码重用率高，可以提高程序开发效率，降低维护成本。

在Java中继承的关键字是extends，子类会继承父类的变量和方法，同时子类如果想使用父类的方法只需要加上super，super指向父类。比如下面的代码：

```java
//父类Person定义
Public class Person{
	int age;
	String name;
	//sayHello行为
	public void sayHello(){
		System.out.println("Hello,world!");
	}
	//构造函数
	Public Person(String name,int age){
		this.name=name;
		int age=age;
	}
}
//Student子类继承于父类
Public clcss Student extends Person{
    //已经默认自带age,name,sayHello()
    //自己特有的成员变量
    int school;
    //重载sayHello()方法
    public void sayHello(){
        //先调用父类的sayHello,所以也会说hello world!
        super.sayHello();
        //同时还有子类特有的功能说自己的学校
        System。out.println("My school is"+school);
    }
    //子类的构造函数
    public Student(String name,int age,String school){
        //一部分构造通过父类的构造函数实现
        super(name,age);
        //同时还有自己独有的部分
        this.school=school;
    }
}
```

{% note info, 

同时还要注意继承必须由extends关键词，否则该类默认为java.lang.Object的子类，Java中所有的类都是通过直接或间接的继承java.lang.Object得到的。

%} 

在继承中我们可以总结出如下几个特点：

1. 父类的非私有方法也可以被子类自动继承并使用super调用（这也就说明私有方法不能直接调用），如Student自动继承父类Person的sayHello()方法。
2. 子类也可以重新定义与父亲同名同参数的方法来实现对父亲方法的覆盖，比如子类Student重载定义了继承于父类的sayHello()函数。
3. 子类可以自己添加独属于自己的新的成员变量和新的函数，比如Student在继承父类的构造函数后，又添加了自己的构造函数。