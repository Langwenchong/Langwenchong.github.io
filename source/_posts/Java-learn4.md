---
title: Java学习笔记-第四讲
comments: false
top: false
date: 2021-03-12 16:15:48
tags: [note,Java]
categories: 
	- [学习笔记]
	- [编程语言,Java]
---

记录翀翀🧐学习Java面向对象程序设计的核心笔记与思考，努力学习的过程，就像在黑屋子里洗衣服，你不知道洗干净没有，只能一遍一遍尽力去洗，等到了考场上那一刻，灯光亮了，你会发现，只要认真洗过，那件衣服就会光亮如新，愿你我都能够坚持学习。

<!-- more -->

#### 包

其实我们在第一讲就有所介绍包的感念，实际上他就是一个文件夹，里面放有许许多多的Java类文件，这种用包（Package)来管理类名空间的方法，为管理文件提供了一种命名机制和可见性限制机制。

包是一种松散的类的集合，一般不要求处于同一个包中的类有明确的相互关系，如包含、继承等，但是由于同一包中的类在默认情况下可以互相访问，所以为了方便变成和管理，通常需要在一起工作的类放在一个包里。

#### Package语句

Package是用来对一个类进行打包然后放到指定地方的指令，实际上他和import的作用刚好相反。假如我们现在有两个相同名称的类dog，那么我们如果直接使用的话会出现不知道使用的是哪个类的问题，此时我们可以使用package将两个类放到两个不同的包A和B中即两者路径不同。那么我们想使用哪个类的时候，只需引入A中或B中的类即可：

```java
//第一个含dog类的Java1文件
//将Java1中的dog类放到了文件夹worlds/animals/male下
package worlds.animals.male;
public class dog{
    ...
}

//第二个含dog类的Java2文件
//将Java2中的dog类放到了文件夹worlds/animals/female下
package worlds.animals.female;
public class dog{
    ...
}
```

那么上面的两个dog类就会被放到不同的包中，一个在male下，一个在female下，如果现在我们现在想在主程序Java文件中调用Java2中的dog类，那么就引入即可：

```java
//主程序文件Java
//引入female包的dog类
import worlds.animals.female.dog;
```

{% note info, 

注意假如此时Java2中同时有两个类比如dog和cat，那么它们都会被打包存储到female下，如果此时我们想一次引用Java2中的所有类，只需要用通配符*类匹配：

```java
//同时引入包female中Java2的所有类
import worlds.animals.female.*
//注意实际上此时是引入female下的所有类
//加入此时female下有20个Java文件，那么这20个Java中的类都会被引入
```

%} 

我们可以理解为package就是自报家门的行为，他通常是将自己这个Java文件打包成为一个package以方便其他Java文件调用它所包含的类。所以package要加上他自己的所在路径，一般package的路径是从大到小写的，即

```java
package pkg1[.pkg2[.pkg3]]
//那么pkg1范围会大于pkg2范围
//pkg2范围大于pkg1范围
```

包及子包的定义实际上就是为了解决名字空间、名字冲突，他并没有显示类的继承关系，即子类与父类可以放到不同的包中，子包所在的包位置可以在父类包的上层级。

在Java中jdk提供的提供的包包括：java.applet,java.awt,java.awt.image,java.awt.peer,java.io,java.lang,java.net,java.util,java.swing等。包层次的根目录是由环境变量CLASSPATH来确定的，在简单情况下，java源文件默认为package语句，这时称为无名包，无名包不能由子包。

##### 思考：package和import的个数问题？

一个Java文件中，必须有一个package语句，他一般是位于Java文件的首行，调用他的类时必须严格按照他的package语句的路径引入。import是引入需要的其他包中类时使用的语句，一般一个Java文件可能会有许多个import语句引入各种需要的包。同时我们可以再回忆一下一个Java文件只能有一个public class XXX类，这个类的名字必须和文件名相同，严重区分大小写，他是这个文件的主类，里面有一个public static void main函数作为入口程序。但是一个Java中并不是只有一个主类，他也可以有许多和自己创建的类，每一个类同样可以有许多个main入口函数。 所以我们可以总结为：一个Java只能有一个同名的类，可以有多个其他类，每一个类都可以有main，但每次只能有一个main运行，一个Java必须有一个package,可以有许多个import语句。

#### import语句

实际上前面我么已经讲差不多了，import就是用来引入其他包中类的语句。他同样也是使用下面这种路径引入：

```java
import package1[.package2].(classname|*);
```

{% note info, 

我们一定要千万注意，import最终指向的必须是一个类，所以如果想引入某个包A下的所有类，必须是import A.\*而不是import A。同时还要注意*只是匹配这个包下的所有类，而不匹配他的子包的类，因此假设现在A下有一个子包B，那么如果我们想引入B的所有类必须使用：

```java
import A.B.*
//如果仅仅是import A.*那么B子包的类不会被引入
```

%} 

Java编译器已经为所有程序自动引入包java.lang，因此不必用import语句引入他所包含的类，但是若需要使用其他包中类，必须用import语句引入。

#### Java中的访问控制符

接下来我们将详细讨论一下访问控制符的访问权限，如下：

|          | 同一个类中 | 同一个包中 | 不同包中的子类 | 不同包中的非子类 |
| :------: | :--------: | :--------: | :------------: | :--------------: |
| private  |     √      |     ×      |       ×        |        ×         |
|   默认   |     √      |     √      |       ×        |        ×         |
| potected |     √      |     √      |       √        |        ×         |
|  public  |     √      |     √      |       √        |        √         |

什么意思呢？对于private是对于信息的保护，但是如果两个成员属于同一个类，那就属于一家人，没有private隐秘一说，因此所有同一类下的成员可以互相访问。而对于不同类，那么就是两家人，所以如果类A的成员想访问类B的private就不可以了，因为无权限，此时只能调用类B提供的getter函数来间接访问。而对于不同包的子类，子类会自动继承父类的public成员，但是此时他也不能访问父类的private变量，也需要父类提供的getter函数间接访问，同时由于不在一个包，所以默认访问是无法获取的。因此我们可以总结为：private是针对于以类为单位的访问权限的，而public是针对于以包为单位的访问权限的，如果一个变量被设置为了private了，那么就只能允许同一类下的成员访问，如果一个变量被设置成了public，那么它允许被其他包的方法等访问。默认变量只能同一包下访问，而protected就是解决了子类无法访问父类默认变量问题的，因此protected和默认修饰符（即无修饰符）相比只是多了一个允许不同包子类访问的权限。

#### 类的访问控制符

实际上控制符可以修饰类、方法、变量。例如：

```java
//一般类都是public修饰以便其他的Java文件引入这个包中的该类
public class Man(){
	private String name;//只能man类下的成员访问
	protectd String address;//只能同一个包下的成员或者子类成员访问
	String email;//默认修饰符，只能同一个包下的成员访问
	//这个类的入口程序函数,必须用public static修饰后面会介绍到原因
	public static void main(String[] args){
		...
	}
}
```

#### setter和getter函数

在Java编程中，有一种常见的做法，是将所有的或部分的域用private修饰，从而更好地将信息进行封装和隐藏。用setXXXX和getXXXX方法对类的属性进行存取，分别称为setter与getter。这种方法有以下优点：

1. 属性用private更好地封装和隐藏，外部类不能随意存取和修改。
2. 提供方法来存取对象的属性，在方法中可以对给定的参数的合法性进行检验。
3. 方法可以完成其他必要的工作（如清理资源、设定状态等等）
4. 只提供getXXXX方法，而提供setXXXX方法，可以保证属性是只读的。

但是要注意，get方法只是复制变量并返还，因此如果使用obj.getAge()=20这种代码是错误的，因为getter返还的就是一个确切的常量值而不是变量，因此无法修改，并且想用上面的代码修改obj的Age属性值也是不可能的，因为不是引用型，而是复制型，所以obj的Age是不会改变的。

```java
private String name;
private int age;

public String getname(){
	return name;
}

public void setName(Srting name){
	this.name=name;
}

public int getAge(){
	return age;
}

public void setAge(int age){
	this.age=age;
}
```

{% note info, 

小贴士：在eclipse中，有一键生成setter和getter函数，如下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210313134656.png)

他会自动将XXXX换成参量名字：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210313134729.png)

%} 

#### static修饰符

接下来我们来详细讲解一下static修饰符的作用。static只可以修饰变量、方法。

首先static修饰的变量就称为静态变量、类变量，归属于整个类，而不归属于某个类的实例。static方法也是又称为静态方法、类方法，归属于整个类，而不属于某个类的实例。访问static变量和static方法可以通过"类名.变量""类名.方法"来实现，static方法中，只能访问static变量和方法，不能访问实例变量或实例方法，而实例方法中，既能访问static变量和static方法，又能访问实例变量和实例方法。

{% note info, 

一定要注意static方法中是禁止使用this的，原因很简单。this永远指向的是一个类的实例化对象,然而static方法只属于类，他不是一个对象的方法，因此也就不能使用this。

%} 

##### 思考：为什么Java中main入口函数一定要public static void main(String[] args)?

这个问题很难解释，但是我们可以使用上面的知识简单理解一下。首先由于main加上static后会变成静态方法属于类而不是实例对象，因此JVM调用这个函数就不用了创建包含这个main的实例了，而是可以直接调用main方法进入程序。其次，假设我们现在不用static修饰main函数，那么包含main函数的类在被实例化以后每一个对象都会有一个程序入口函数，这明显不行，而且我们知道实例的初始化构造函数是可以重载的，那么也就意味着main函数可以存在于多个不同重载的实例对象中，这也不行。所以main函数被static修饰是合理的，其次他要修饰为public是因为这样其他Java文件就可以通过引入调用这个main函数。

#### final修饰符

final修饰符可以修饰类，方法和变量。final修饰的类说明这个类是不能被继承的（也就是顾名思义的最后一个类），即不能有子类。final修饰的方法就是不能被子类覆盖的方法，也就是说子类从父类继承得到的final修饰的函数是不可以自己修改覆盖的，只能原封不动的使用。final修饰的变量可以理解为不能被修改的变量。

{% note info, 

一定不要混淆，final可以是三种类型的修饰符，只有当他都是类的时候，这个类才可以没有子类。当他在一个public类中A修饰一个成员方法时，那么A还是可以被继承的，只是A的这个final方法不能被修改而已。所以要理解修饰符在不同类型的情况下修饰的作用也不同。

%} 

##### 思考：static final同时修饰的变量是什么？

实际上static final修饰的变量就是一个只属于类且不能被修改的变量，那么很明显实例不能拥有它也不能修改它，但是可以使用它。所以此时这个变量就是一个全局常量。如Integer.MAX_VALUE(表示最大正数)、Math.PI(表示圆周率)就是这种常量。在程序中，通常用static于final一起修饰来指定一个常量。

在定义static final时，必须在定义这个常量时赋值。final变量要么定义变量时赋予初始值（即在类的定义时就赋予值），要么就是在构造函数中赋值（即实例化的过程中赋值）。

{% note info, 

static final和final static无区别，那个习惯用哪个。

%} 

##### 思考：static final和final变量的区别？

首先我们要知道实际上都可以用来表示常量，因为他们都是不能被修改的，但是static final更像是全局常量，即只有类有这一个无法修改的值。而final变量虽然也是无法修改，但是每一次实例化这个类，他的对象和子类以及子类的对象都会自己也有一个这个无法修改的值。

#### abstract修饰符

abstract只能修饰类和方法。被abstract所修饰的抽象方法，抽象方法的作用在为所有子类定义一个统一的接口。对抽象方法只需声明，而不需实现，及用分号";"而不是"{}"结尾。格式如下：

```java
abstract returnType abstractMethod([paramlist]);
```

我们可以这样理解abstract方法，就好像老师留了一篇作文《我的Java学习之路》，那么老师不需要具体写出作文，只是统一了每一个学生必须按照这个标题来写，而学生按照这个标题标准来写出作文内容，作文内容可以不同。因此我们就可以理解为abstract修饰的方法只是同一了每一个子类的方法类型和参量，但是每一个子类可以对于这个函数有不同的实现功能。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210316183321.png)

abstract还可以修饰类使之成为抽象类，这个抽象类可以不包含abstract方法。但是一旦某个类中包含了abstract方法，那么这个类就必须声明为abstract类。抽象方法大在子类中必须被实现，否则这个子类必须仍然是abstract的。

{% note info, 

abstract不能和private,static,final,native同时修饰。abstract方法只能存在于abstract类中，所以有abstract方法并且无具体实现内容的类必须是abstract类。abstract类中可以没有abstract方法。一个子类如果继承自abstract类并且有abstract方法，那么他如果不是abstract类必然是因为他将全部的abstract方法的具体实现内容都已经实现了，那么这个子类的子类就也不是abstract类了。

%} 

#### 接口

我们考虑一下几种情况该如何定义继承关系？

- 四边形：四条边
- 平行四边形：四条边&&对边平行
- 菱形：四条边&&对边平行&&邻边相等
- 长方形：四条边&&对边平行&&四个角是直角
- 正方形：四条边&&对边平行&&邻边相等&&四个角是直角

那么如果我们想写正方形类，怎样写继承关系呢？？有以下几种方法：

1. 四边形->平行四边形->菱形->正方形
2. 四边形->平行四边形->长方形->正方形

我们发现有许多种可以的继承关系，但是无论是哪个方案貌似都有点奇怪，难道这几个几何图形就一定是继承关系吗？一定谁是谁的父类吗？貌似并不是，这是有一些共同特点和异同点而已，并无强烈的继承关系。再比如：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210313144257.png)

那么难道游客就不是孩子吗，售货员就不能同时是父母吗？这些都是难以用继承关系来写清楚的，究其原因是因为他们只是一些具有异同点的同级兄弟子类而已。而不是父子类关系。所以我们引出了接口的概念。

Java通过接口使得处于不同层次，甚至毫不相关的类可以具有相同的行为。接口就是方法定义和常量值的集合，他的主要用处体现在以下几个方面：

1. 通过接口可以实现不相关类的相同行为，而不需要考虑这些类之间的层次关系。
2. 通过接口可以指明多个类需要实现的方法。
3. 通过接口可以了解对象的交互界面，而不需要了解对象所对应的类。

说这么多，实际上我们可以将接口理解为标签，他不是强烈的继承特点，而仅仅只是异同点划分的体现。在接口中定义某些类共同的行为，然后由每一个类分别实现这些行为（注意，接口我们一般称为实现接口，类我们一般称为继承父类）。

与C++不同，Java不支持多重继承，一个子类只能单纯继承自一个父类，那么此时如果一个子类有多个类的特点，那么剩下的那些不能继承而来的特点就可以通过使用接口来实现，这样做比直接多重继承更加强大合理。原因是多重继承是指一个类可以是多个类的子类，即他可以继承于多个父类（有好多父亲，哈哈哈）。那么就会使得类的层次关系不清楚（比如B是A的子类，同时C是B和A的子类，那么C和A的关系就很奇怪），而且当多个父类同时拥有相同的变量和方法时，子类的行为是不确定的，这给变成带来了困难。单一继承原则就清楚的表明了层次关系，指明了子类和父类的行为，而接口就是弥补了单继承无法实现的多继承的那些优点。

同时接口可以多继承，且一个类可以有多个接口，这种机制既实现了多继承的所有优势，同时还避免了多继承的缺点。接口中只能包含public、static、final和没有修饰符类型的成员变量和public、abstract和没有修饰符类型的成员方法。同样的，接口不能定义任何实现，这意味着接口指定的方法也是抽象的,但是KKD8以后，添加了一个新功能，就是默认方法（即没有修饰符的方法）在接口中可以定义默认实现功能，而子类实现接口后可以拥有这个方法并且重定义修改。

##### 思考：接口和abstract抽象类的异同？

首先两者都是只能定义方法标准，不实现具体方法内容。其实我们可以将接口看成一种不算类的抽象类，这样他也就不属于多继承，当一个子类继承了一个类以后，如果部分功能还需要从其他地方获得，但是碍于单继承标准不能获得时，就可以使用接口来实现获得，所以接口实际上很像一种可以不算为类的抽象类，并且接口可以有许多个所以功能很强大。

{% note info, 

注意接口不能有静态方法，但是抽象类可以有静态方法，这是因为接口不是一个类，所以他没有独属于他的静态方法。

%} 

#### 接口的定义和实现

接口的定义是用interface关键字：

```java
//接口前面也可以有域修饰符
//他也可以继承其他接口
public interface name (extends other interfaces){
	//声明变量和方法的语句
	...
}
```

接口的实现

一个类使用接口也很简单，使用implements关键字：

```java
//A类继承于B，同时还要实现多个接口interface1,interface2等
public class A extends B implements inetrface1,interface2...{
	//里面要将所有的接口函数内容全部实现
    ...
}
```

#### 抽象类和接口的合作使用

可能你现在有点晕了，那我们就来用一个场景模拟一下抽象类和接口的使用：我们就来模拟一下下面这个功能：狗和猫都能吃睡，但是狗1可以唱歌，狗2可以跳舞，猫1可以唱跳，猫2可以唱，跳，rap和篮球。并且狗睡觉发出呜呜呜声，吃饭狼吞虎咽，猫睡觉发出嘤嘤嘤声，吃饭小口慢吃。那么现在我们来实现以下：

```java
public abstract class Animal{
    //抽象方法，需要在继承类中实现
	abstract void eat();
	abstract void sleep();
}

public interface Sing{
    //jdk8以后默认方法可以在接口里实现
    void sing(){
        sing...;
    }
}

public interface Dance{
    void dance(){
        dance...;
    }
}

public interface Rap{
    void rap(){
        rap...;
    }
}

public interface Basketball extends Sing,Dance,Rap{
    //由于继承了，所以篮球接口同时也有唱，跳，rap方法
    void basketball(){
        play basketball...;
    }
}

public class Dog1 extends Animal implements Sing{
    //需要实现abstract方法，同时他还有了接口唱的唱方法
    void sleep(){
        System.out.println("呜呜呜");
    }
    void eat(){
        System.out.println("狼吞虎咽");
    }  
}

public class Dog2 extends Animal implements Dance{
    //需要实现abstract方法，同时他还有了接口唱的跳方法
    void sleep(){
        System.out.println("呜呜呜");
    }
    void eat(){
        System.out.println("狼吞虎咽");
    }  
}

public class Cat1 extends Animal implements Sing,Dance{
    //需要实现abstract方法，同时他还有了接口唱和跳的唱和跳方法
    void sleep(){
        System.out.println("嘤嘤嘤");
    }
    void eat(){
        System.out.println("小口慢吃");
    }
}

public class Cat2 extends Animal implements Basketball{
    //需要实现abstract方法，同时他还有了接口篮球的唱，跳，rap和篮球方法
    void sleep(){
        System.out.println("嘤嘤嘤");
    }
    void eat(){
        System.out.println("小口慢吃");
    }
}
```

我们发现实际上接口不继承也可以实现，只是这样一个类就可能需要好多个接口，我们可以先将大部分接口的内容继承给一个接口，然后这个类就只需要实现一个接口了。

{% note info, 

并且要注意，接口可以继承同时他可以继承多个接口，即接口是多重继承。

%} 

并且我们可以抽象的理解为接口是一个不可实例化的抽象类，而实现这个接口的类就是其的一个子类，因此我们可以使用接口实现类似于多态形式的对象实例化。如下：

```java
public class Test {

	public Test() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		A a = new D();
		C c = new D();
		D d = new D();
		 
		System.out.println("pass 1");
		
		B b = c;
		System.out.println("pass 2");
		
		a = d;
		System.out.println("pass 3");
		
		c=new E();
		System.out.println("pass 4");
		
		a=new A();
		if (!(a instanceof B)) {
			System.out.println("pass 5");
		}
		
		if (!(c instanceof A)) {
			System.out.println("pass 6");
		}
		if (!(c instanceof D)) {
			System.out.println("pass 7");
		}

	}
}
```

上面是一道例题，他要求我们定义接口或类A,B,C,D,E使得上面的所有代码同时能够编译运行。由于java中只能使用单继承，因此如果按照A,B,C,D,E全是类来写的话上面的例题是无法通过的（主要是继承链无法写出）。这也就说明上面的题中有几个是接口。首先由于接口不能直接通过new来实例化，因此凡是new X(),那么X必定是类，因此我们可以推断出A,D,E是类，所以B,C可以是接口。那么我们根据上面的代码逻辑可以写出继承链：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210405145729.png)

所以此时D实现了接口A和接口C，并且同时接口C继承于接口B，而类E又实现了接口C。那么此时上面的代码就可以解释为：

```java
public Test() {
	// TODO Auto-generated constructor stub
}

public static void main(String[] args) {
    //A是D的父类，因此这里是多态
	A a = new D();
    //注意C只能是接口，这样D就是单继承了
    //所以此时虽然是用接口C声明，但是实际上也类似于多态
    //可以将C看成D的父类，但是实际上并不是，所以不属于多继承
    //最终本质上还是接口
    //所以c也是一个D的对象实现
	C c = new D();
    //这就是最普通的实例化了一个D的对象d
	D d = new D();
	 
	System.out.println("pass 1");
	
    //由于B是C的父关系，同时C是接口
    //而接口只能继承接口，所以B也是接口
    //所以这里类似于接口的多态形式
    //但是最终得到还是一个D的对象b
	B b = c;
	System.out.println("pass 2");
	
    //很明显a被d赋值
	a = d;
	System.out.println("pass 3");
	
    //c重新赋值了E的对象
	c=new E();
	System.out.println("pass 4");
	
    //a重新被赋值为了A的对象
	a=new A();
    //此时a很明显和B没关系，因为a没有实现接口B
	if (!(a instanceof B)) {
		System.out.println("pass 5");
	}
	
    //c明显和A无关系，因此此时c是E类的对象
	if (!(c instanceof A)) {
		System.out.println("pass 6");
	}
    
    //c也和D无关
	if (!(c instanceof D)) {
		System.out.println("pass 7");
	}

}
```

我们不难看出可以使用类实现的接口来定义实例化一个对象，如：

```java
C c = new D();
```

并不会报错，实际上就等同于：

```java
D c=new D();
```

最终的效果是一样的。并且我们发现上面的继承链是唯一确定的，没有其他情况了。

##### 思考：什么时候使用抽象类？什么时候使用接口？

其实你会发现单独使用抽象类或者接口也未尝不可以实现上面的要求，一般我们对于是不是的问题使用抽象类来解决，对于某个行为有没有的问题我们使用接口来实现。接口只是为了在不同的模块/组件之间制定协议或契约，接口并不关心内部的状态。

#### instanceof函数的使用

instanceof函数可以判断一个实例是否属于一个类或者是否属于一个接口。比如

```java
String str="123";
if(str instanceof(String)){
	return true;
}//true
```

实际上就是说明str是属于String类的，所以他是String的一个实例对象，可以用来表示String。

#### 父类和子类之间的强制转换

我们给出如下几个规则：

1. 子类可以当做父类来使用
2. 父类不能当做子类来使用
3. 实现了某个接口的子类可以当这个接口用
4. 借口不能当子类用

可能不容易懂，这里我们用一个例子来说明：

```java
//str是String的一个实例对象
String str="abc";
if(str instanceof String){}//true

//此时Object是所有对象的父类所以Object是String的父类
//那么初始化obj时可以实例化时使用String的规则
//所以obj这里可以直接和str相同(可以视为一模一样)
//所以obj可能会具有一些特殊的成员(这些成员变量Object没有规定，但是子类String会特有)
Object obj=str;
//那么很明显此时obj不光是Object的实例化对象，同时它也属于String
//只是此时由于他还是Obj的对象，所以即使有String的特有方法也不能使用
//但是obj此时确实有String子类特有的函数
if(obj instanceof String){}//true

//但是如果一个obj初始化时使用的是Object的规则
//那么obj就不会具有子类String规定的一些特殊变量
//所以obj也就是只是属于Object父类，而不是子类String的一个实例化对象
obj=new Object();
if(obj instaceof String){}//false

//此时的情景式Frog是Swimmer的子类
//那么frog直接初始化为子类Frog的对象
//那么他同时也会属于Swimmer父类
Frog frog=new Frog();
if(frog instanceof Swimmer){}//true
```

##### 思考:上面的强制转换规则能不能更加形象的表示？

实际上我们可以使用学院和班级来理解父类与子类的转换关系。首先我们规定计算机学院是父类，那么计算机学院的任何一个人员都是父类的一个实例化对象，比如软件工程学院院长，副院长，主任，老师，同时还有计算机学院学生。而软工学院会有许多班级，每一个班级都是一个子类，子类都有一个特点，即他们在学院的基础上还有一个特别属性那就是必须是学生。那么假设现在软工5班有一个学生chongchong，那么很明显chongchong是子类软工5班的一个实例化对象，他可以代表软工5班，同时他也是软工学院的一员，所以他也可以是代表软工学院，即chong同时也是软工学院实例化对象。但是软工学院院长只能是学院的实例化对象，他只能代表软件学院，而不能代表软工5班所以他不是软工5班的一个实例化对象。但是假如现在我们要在学院新添加一个实例化对象，那么他可以是一个软工5班的学生，因此软工学院的实例化对象可以直接初始化为软工5班子类的实例化对象。因此我们就可以总结出强制转换的规则了：

1. 子类的实例化对象同时属于子类和父类
2. 父类的实例化对象未必一定也属于子类
3. 但是父类的实例化对象在初始化时可以按照子类规则初始化那么此时他就同时属于子类和父类了
4. 按照父类规则初始化的对象一般就不属于子类了

现在我们再来看上上面的代码就不难理解了。str是子类String的一个实例化对象，所有str instanceof String和str instanceof Object都是正确的。并且obj初始化时可以按照子类String的规则初始化所以Object obj=str后obj同时属于Obj和String，但是如果obj初始化时按照Object规则初始化，那么obj就只属于父类Object而不属于子类String。

{% note info, 

一定要注意，当一个对象是被声明为父类的对象，但是初始化时是按照子类规则初始化的，那么他确实具有了子类特有的成员变量和方法，但是此时由于它是父类的对象，因此这些特有的成员变量和方法暂时被屏蔽不能使用了，而当他被强制转换成子类的对象后，这些特有的属性就会解除屏蔽，可以使用了。这也是为什么他可以同时属于父类和子类，但是如果一个对象一开始就是按照父类的规则声明初始化的，那么他是不属于子类的对象的，他也不能转换成子类的对象，因为他没有子类特有的方法。

%} 

#### 枚举型对象

接下来我们再来介绍一下枚举enum类，他有一些特殊的要求，首先我们来看一下代码：

```java
static class EnumDriection2{
	public enum EnumDirection2 {
		EAST("东"), SOUTH("南"), WEST("西"), NORTH("北");
		private EnumDirection2(String desc) {//私有类型构造函数
			this.desc = desc;
		}
		private String desc;//存放其他属性，其他属性可以随意增减
		public String getDesc() {//取得其他属性
			return desc;
		}
	}
	public static void main(String[] args) {
		for(int i=0;i<EnumDirection2.values().length;i++) {
			EnumDriection2 dir=EnumDirection2.values()[i];
			//ordinal()取得序号;getDesc()取得自定义描述
			System.out.println(dir+"="+dir.getDesc()+"\tindex="+dir.ordinal());
		}
	}
}
```

我们知道一般enum枚举类型可以对每一个成员变量赋予一个自定义描述值，比如上面的NORTH的描述值为"北''，那么在给这些成员变量赋值一般是通过构造函数初始化时赋值的，注意enum中构造函数必须是私有类型构造函数，public修饰会报错。

{% note info, 

一定要注意，enum枚举也是一个类，所以他一般也单独放到一个java类，然后其他java文件中的类想调用需要import。获取enum中的一个枚举变量就是enumName.varaible。

%} 

