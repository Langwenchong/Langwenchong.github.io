---
title: Jave学23种设计模式(1)--创建型模式
comments: false
top: false
date: 2021-10-21 08:47:21
tags: [设计模式,java]
categories: 
	- [知识分享,学习心得]
headimg: https://langwenchong.gitee.io/figure-bed/20211022212512.png
---

记录翀翀对23种设计模式的思考与总结📜，本章介绍设计模式概览和5种创建型模式。

<!-- more -->

### 概念介绍

首先我们要知道设计模式传授的是前辈对23种复杂应用场景下最优策略的经验总结，他们是一种编程的套路，而不是语法规定，我们在学习应用23种设计模式之后可以提高代码的可复用性和可维护性。

总体上我们可以将23种设计模式划分成三类：

- 创建型模式(5)：单例模式、工厂模式、抽象工厂模式、建造者模式、原型模式
- 结构性模式(7)：适配器模式、桥接模式、装饰模式、组合模式、外观模式、享元模式、代理模式
- 行为型模式(11)：模板方法模式、命令模式、迭代器模式、观察者模式、中介模式、备忘录模式、解释器模式、状态模式、策略模式、职责链模式、访问者模式。

他们无一例外都在尝试使得我们的代码符合以下7大原则：

|   原则名称   |                           原则内容                           |
| :----------: | :----------------------------------------------------------: |
|   开闭原则   |                    对扩展开发，对修改关闭                    |
| 里氏替换原则 |        继承必须确保父类所拥有的的性质在子类中仍然成立        |
| 依赖倒置原则 |                要面向接口变成而非面向实现编程                |
| 单一职责原则 |           控制类的粒度大小，将对象解耦，提高内聚性           |
| 接口隔离原则 |               要为各个类建立他们需要的专用接口               |
|  迪米特原则  |             只与你的直接朋友交谈，不跟陌生人说话             |
| 合成复用原则 | 尽量使用组合或者聚合关联关系来实现，其次才考虑使用继承关系来实现 |

### 创建型模式

{% note quote, 由于篇幅有限，我将分成三章来记录设计模式的学习笔记，本章先介绍5大创建型模式，他的主要关注点都是“如何创建对象”，主要目标就是让**对象的创建和对象的使用分离**。在创建型模式中，使用者不需关注创建的细节，对象的创建由相关的工程来完成。 %}

我们首先给出5大创建型模式的特点，方便我们在学习时随时尝试感悟他们的特点：

1. 单例模式：**某个类使能生成一个实例**，该类提供了一个全局访问点供外部获取该实例，其拓展是有限多例模式
2. 工厂方法模式：定义一个用于创建产品的接口，由子类决定生产什么产品，**即局限于一种产品的创建**
3. 抽象工厂模式：提供一个创建产品族的接口，其每个子类可以生产一系列相关的产品，**即可以生产多种不同的产品**
4. 建造者模式：将一个复杂的对象拆解成相对简单的部分，然后根据不同需要分别创建他们，最后构建该复杂对象。
5. 原型模式：将一个对象作为原型，通过对其进行复制而克隆出多个和原型类似的新实例

{% note info,

以上的5中创建型模式，除了工厂方法模式属于类创建型模式，其他的全部属于对象创建型模式。

%}

#### 单例模式

单例模式是比较简单的一种创建型模式，我们仅仅针对内存的占用以及线程安全性两方面来学习单例模式。

首先我们观察以下代码，他被称为`饿汉式`单例，原因是一旦他被创建立刻会占用相对应大小的内存，类似于`饿汉`疯狂吃内存：

```java
//饿汉式单例
public class Hungry {
    //假设他有以下成员数组变量
    private byte[] arr1 = new byte[1024 * 1024];
    private byte[] arr2 = new byte[1024 * 1024];
    private byte[] arr3 = new byte[1024 * 1024];
    private byte[] arr4 = new byte[1024 * 1024];

    //构造器为私有，只能自己创建保证了全局只有一个实例即单例
    private Hungry() {

    }

    private final static Hungry h = new Hungry();

    //一个对外公开的接口提供单例的调用
    public static Hungry getInstance() {
        return h;
    }
}
```

上面的代码是一个饿汉式单例的创建类，此时他有4个byte数组，并且每一个byte数组都是1MB大小，那么此时当饿汉式创建后就已经占用了4MB的内存了，即使此时可能还没有其他模块会调用这个单例，因此此时的代码并不完美，最好是再有其他模块调用这个单例时我们再初始化这个单例的内存空间。因此出现了下面的更加完美的`懒汉式`单例创建:

```java
/懒汉式单例模式，有名为DLC单例
public class Lazy {
    //假设他有以下成员数组变量
    private byte[] arr1 = new byte[1024 * 1024];
    private byte[] arr2 = new byte[1024 * 1024];
    private byte[] arr3 = new byte[1024 * 1024];
    private byte[] arr4 = new byte[1024 * 1024];

    private Lazy() {
        System.out.println(Thread.currentThread().getName() + "ok");
    }


    //先创建的，但是并没有初始化，因此此时l是null不占用很大的空间
    private static Lazy lazy;

    public static Lazy getInstance() {
        //当外部模块调用这个单例对象时再进行初始化
        if (lazy == null) {
            l = new Lazy();
        }
        return lazy;
    }


    //但是多线程并发情况下有问题
    public static void main(String[] args) {
        for (int i = 0; i < 10; i ++) {
            new Thread(() -> {
                lazy.getInstance();
            }).start();
        }
    }
}
```

上面的代码就是`饿汉式`单例模式的，但是他只在单线程情况下完美运行，我们发现此时多线程运行时会出现错误，原因是多个线程并发情况下会造成访问冲突同时调用getInstance()并且此时在每一个线程的视角下l都是未初始化的，因此许多线程进行初始化造成了错误，因此我们需要在源代码的基础上上锁，保证当l未初始化时只会有一个线程对这个l进行初始化，而其他的线程则等待初始化后直接获取即可：

```java
public static Lazy getInstance() {
        //当外部模块调用这个单例对象时再进行初始化
        if (lazy == null) {
            synchronized (Lazy.class) {
                //双重null判断加快效率
                if (lazy == null) {
                    lazy = new Lazy();
                }
            }
        }
        return lazy;
    }
```

此时理论上没有问题了，但是我们运行以后发现结果是只有一个线程运行成功了如下图：

![](https://langwenchong.gitee.io/figure-bed/20211021181721.png)

这是因为涉及到了指令重排的问题，一个实例的创建（即new的过程)并不是一个原子事务，它是由一下三个步骤完成的：

1. 分配内存空间
2. 执行构造函数，初始化对象
3. 将对象引用指向预分配的空间

正常情况下cpu并不会真正的按顺序执行，他会有指令重排的情况，即可能这个实例的创建初始化过程的顺序是132或者123，或者213。那么假设此时线程A先调用了getInstance()方法发现lazy是null，于是尝试new这个实例，但是new的过程中cpu进行了指令的重排造成按照132的顺序执行了。但是A刚刚执行到3的步骤，此时已经分配了空间并且先占用了这个空间，还差构建实例到这个内存空间的步骤。恰巧此时线程B也调用了getInstance()方法，由于synchronized是根据空间是否已经创建占用来判断的，因此此时虽然内存空间内还没有创建初始化真正的实例，但是从synchronized视角来看空间已经被占用，那么线程B就会认为此时lazy已经创建完成了于是走return路线，可是此时A还并没有初始化这个lazy对象，造成了线程B返回的是一个`虚无实例`造成异常。因此我们需要保证线程在new这个实例时必须是禁止指令重排的，只需要在创建语句中加入`volatile`关键字即可，因此最终完美的`懒汉式`单例代码如下：

```java
//懒汉式单例模式，有名为DLC单例
public class Lazy {
    //假设他有以下成员数组变量
    private byte[] arr1 = new byte[1024 * 1024];
    private byte[] arr2 = new byte[1024 * 1024];
    private byte[] arr3 = new byte[1024 * 1024];
    private byte[] arr4 = new byte[1024 * 1024];

    private Lazy() {
        System.out.println(Thread.currentThread().getName() + "ok");
    }


    //先创建的，但是并没有初始化，因此此时l是null不占用很大的空间
    private static volatile Lazy lazy;

    public static Lazy getInstance() {
        //当外部模块调用这个单例对象时再进行初始化
        if (lazy == null) {
            synchronized (Lazy.class) {
                //双重null判断加快效率
                if (lazy == null) {
                    lazy = new Lazy();
                }
            }
        }
        return lazy;
    }


    //此时多线程情况下就没有问题了
    public static void main(String[] args) {
        for (int i = 0; i < 10; i++) {
            new Thread(() -> {
                lazy.getInstance();
            }).start();
        }
    }
}
```

{% note info,

我们一定要时刻注意单例模式中实例只能创建一次，所有的模块通过一个对外开放的接口来调用这个单例进行接下来的操作。

%}

#### 工厂模式

工厂模式主要特点就是实现了创建者和调用者的分离。在介绍工厂模式之前，我们先介绍一下`简单工厂模式`，简单工厂模式就是类似工厂的一种开发模式，但是特并没有满足`开闭原则`。而工厂模式就是对简单工厂模式的改进，首先我们先来通过下面的代码了解一下简单工厂模式：

{% tabs 简单工厂模式 %}
<!-- tab Consumer.java -->

```java
public class Consumer {
    public static void main(String[] args) {
        //原先如果要购买两辆车，需要如下声明
        //需要了解所有的先关的车接口和实现类
        //相当与自己创建车
        //每次创建参数都要重新再填写一次
//        Car car1 = new WuLing(200, 30000, 2);
//        Car car2 = Tesla(280, 40000, 6);;
//
//        car1.name();
//        car2.name();

        //现在我们只需要调用CarFactory的接口即可获取
        //可以和显示生活中的购买车类比
        //车工厂负责造车，消费者只买车
        //简化了多次填写重复参数的过程
        Car car3 = CarFactory.getCar("五菱");
        Car car4 = CarFactory.getCar("特斯拉");
        car3.name();
        car4.name();
    }
}
```

<!-- endtab -->
<!-- tab Car.java -->

```java
//抽象接口，不写具体的实现
public interface Car {
    void name();
}
```

<!-- endtab -->

<!-- tab WuLing.java -->

```java
public class WuLing implements Car {
    @Override
    public void name() {
        System.out.println("五菱宏光!");
    }

    private int weight;
    private int price;
    private int capacity;

    public WuLing(int weight, int price, int capacity) {
        this.weight = weight;
        this.price = price;
        this.capacity = capacity;
    }
}
```

<!-- endtab -->

<!-- tab Tesla.java -->

```java
public class Tesla implements Car {
    @Override
    public void name() {
        System.out.println("特斯拉!");
    }

    private int weight;
    private int price;
    private int capacity;

    public Tesla(int weight, int price, int capacity) {
        this.weight = weight;
        this.price = price;
        this.capacity = capacity;
    }
}
```

<!-- endtab -->

<!-- tab CarFactory.java -->

```java
public class CarFactory {
    public static Car getCar(String car) {
        if (car.equals("五菱")) {
            return new WuLing(200, 30000, 2);
        } else if (car.equals("特斯拉")) {
            return new Tesla(280, 40000, 6);
        } else {
            return null;
        }
    }
}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211108151010.png)

我们发现这种类似于工厂的代码开发模式有一个非常显著的特点，那就是new创建的过程和调用是分离，当我们需要一台新车的时候，并不需要自己去new来创建一个车，而是直接从CarFactory工厂提供的getCar()接口取提车即可。但是这又和普通的new有什么区别呢？我们观察上面的代码发现此时WuLing和Tesla的构造器需要传递三个参数，这是因为车的幸好总是在发生变化，很显然我们在创建车时需要给出车的参数，但是实际生活中我们往往需要传递上万个参数，那么此时这种简单工厂模式的优点就很明显了，在CarFactory我们只需要填写一次参数即可，而相比于多次new都需要再填写以便上万个参数，很显然这种模式更加人性化，并且后期代码进行参数修改时也很简单，只需要修改CarFactory的构造器的参数即可。

##### 思考：简单工厂模式有没有什么缺陷？

我们发现我们是在CarFactory中对传进的车型进行判断，然后调用对应的车构造器来创建车再返还的，那么当需要添加1000+种不同的车型时，那么我们需要在这个类中写上万个同级的if-else判断！！很显然这是典型的`判断膨胀`现象，既不优雅也不高效。同时简单工厂模式也并不符合开闭原则，即假设此时我们需要再加入一个新的车型大众时，那么我们需要修改原先写好的CarFactory类，扩展性并不好，因此产生了下面更加优秀的工厂方法模式。

我们简单的绘画一下简单工厂模式图：

![](https://langwenchong.gitee.io/figure-bed/20211021220826.png)

此时我们是通过车工场进行判断然后车工场来生产不同的车返回给我们消费者，全过程中我们消费者并不需要关心车的具体构建，但是此时我们要新添加一个车型，势必要修改车工厂的，为了解决这个违背开闭原则的缺陷，我们并不能直接对车工厂进行修改，解决策略就是对车工厂在进行一层封装如下图：

![](https://langwenchong.gitee.io/figure-bed/20211021221224.png)

这个更加符合现实生活中生产商的情形，即不同的车型都有自己的工厂，消费者提取不同的车只需要去不同的车工厂提车即可，此时当我们再新添加大众品牌车时，很显然我们并未对其他的工厂类进行修改，满足了开闭原则。那么接下来我们就给出代码：

{% tabs 工厂模式%}

<!-- tab Consumer.java -->

```java
public class Consumer {
    public static void main(String[] args) {

        //获取不同类型的车

        Car car1 = new WulingFactory().getCar();
        Car car2 = new TeslaFactory().getCar();
        car1.name();
        car2.name();
    }
}
```

<!-- endtab -->

<!-- tab Car.java -->

```java
//抽象接口，不写具体的实现
public interface Car {
    void name();
}
```

<!-- endtab -->

<!-- tab CarFactory.java -->

```java
public interface CarFactory {
    Car getCar();
}
```

<!-- endtab -->

<!-- tab Wuling.java -->

```java
public class WuLing implements Car {
    @Override
    public void name() {
        System.out.println("五菱宏光!");
    }

    private int weight;
    private int price;
    private int capacity;

    public WuLing(int weight, int price, int capacity) {
        this.weight = weight;
        this.price = price;
        this.capacity = capacity;
    }
}
```

<!-- endtab -->

<!-- tab Tesla.java -->

```java
public class Tesla implements Car {
    @Override
    public void name() {
        System.out.println("特斯拉!");
    }

    private int weight;
    private int price;
    private int capacity;

    public Tesla(int weight, int price, int capacity) {
        this.weight = weight;
        this.price = price;
        this.capacity = capacity;
    }
}
```

<!-- endtab -->

<!-- tab WulingFactory.java -->

```java
public class WulingFactory implements CarFactory {
    public Car getCar() {
        return new Wuling(200, 30000, 2);
    }
}
```

<!-- endtab -->

<!-- tab TeslaFactory.java -->

```java
public class TeslaFactory implements CarFactory {

    public Car getCar() {
        return new Tesla(280, 40000, 6);
    }
}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211108151048.png)

上面的代码就是工厂方法模式的代码，他对简单工厂模式进行了优化，现在就符合了开闭原则了，但是这又会导致另一个问题即`类膨胀`，此时每一个相似结构不同类型的产品都需要一个自己的工厂类，会导致出现许多功能类似的工厂，但是当代码量很大时，这种工厂方法模式整体来看性能还是较优的。

#### 抽象工厂模式

前面我们所学习的`简单工厂模式`和`工厂方法模式`都是针对同一个产品的开发模式，只是工厂方法模式的可扩展性更强。那么假设我们现在需要一种可以生产许多种产品的工厂又该如何实现呢？此时就产生了`抽象工厂模式`的概念，实际上可以把他理解成一种生产工厂的工厂，如下图是一个基于`抽象工厂模式`的生产手机产品和路由器产品的工厂示例：

![](https://langwenchong.gitee.io/figure-bed/20211022152309.png)

此时我们发现每一个工厂不再只能生产一种产品了，而是许多产品了。即在抽象工厂模式中可以提供了一个创建一系列相关或者相互依赖对象的接口，无需指定他们具体的类。在用代码实现应用场景之前，我们来理解一下产品族和产品等级的概念：

![](https://langwenchong.gitee.io/figure-bed/20211022152741.png)

即所有属于同一品牌的产品是同一个产品族的，但是不同类型的产品是属于不同的产品等级。那么我们可以将`抽象工厂模式`理解为此时的具体工厂可以生产同一个产品族了而不再是单一产品了。而抽象工厂是定义具体工厂可以生产的产品等级的工厂。如下代码：

{% tabs 抽象工厂模式 %}

<!-- tab Consumer.java -->

```java
public class Consumer {
    public static void main(String[] args) {
        System.out.println("小米系列产品");
        //小米工厂
        XiaomiFactory xiaomiFactory = new XiaomiFactory();
        //获取一台小米手机
        IphoneProduct iphoneProduct1 = xiaomiFactory.iphoneProduct();
        iphoneProduct1.callUp();
        iphoneProduct1.sendSMS();

        //获取一台小米路由器
        IRouterProduct iRouterProduct1 = xiaomiFactory.routerProduct();
        iRouterProduct1.openWifi();
        iRouterProduct1.setting();

        System.out.println("华为系列产品");
        //华为工厂
        HuaweiFactory huaweiFactory = new HuaweiFactory();
        //获取一台华为手机
        IphoneProduct iphoneProduct2 = huaweiFactory.iphoneProduct();
        iphoneProduct2.callUp();
        iphoneProduct2.sendSMS();

        //获取一台华为路由器
        IRouterProduct iRouterProduct2 = huaweiFactory.routerProduct();
        iRouterProduct2.openWifi();
        iRouterProduct2.setting();
    }
}
```

<!-- endtab -->

<!-- tab IphoneProduct.java -->

```java
//第一个产品等级产品--手机的抽象功能接口
public interface IphoneProduct {
    void start();

    void shutDown();

    void callUp();

    void sendSMS();
}
```

<!-- endtab -->

<!-- tab IRouterProduct.java -->

```java
//第二个产品等级产品--路由器的抽象功能接口
public interface IRouterProduct {
    void start();

    void shutDown();

    void openWifi();

    void setting();
}
```

<!-- endtab -->

<!-- tab IProductFactory.java -->

```java
//抽象产品工厂定义具体工厂可以生产的产品等级
public interface IProductFactory {
    //生产手机
    IphoneProduct iphoneProduct();

    //生产路由器
    IRouterProduct routerProduct();
}
```

<!-- endtab -->

<!-- tab Xiaomiphone -->

```java
//小米手机具体实现类
public class Xiaomiphone implements IphoneProduct {

    @Override
    public void start() {
        System.out.println("开启小米手机");
    }

    @Override
    public void shutDown() {
        System.out.println("关闭小米手机");
    }

    @Override
    public void callUp() {
        System.out.println("小米手机打电话");
    }

    @Override
    public void sendSMS() {
        System.out.println("小米手机发短信");
    }
}

```

<!-- endtab -->

<!-- tab Xiaomirouter.java -->

```java
public class Xiaomirouter implements IRouterProduct {

    @Override
    public void start() {
        System.out.println("打开小米路由器");
    }

    @Override
    public void shutDown() {
        System.out.println("关闭小米路由器");
    }

    @Override
    public void openWifi() {
        System.out.println("打开小米wifi");
    }

    @Override
    public void setting() {
        System.out.println("关闭小米wifi");
    }
}
```

<!-- endtab -->

<!-- tab Huaweiphone.java -->

```java
public class Huaweiphone implements IphoneProduct {
    @Override
    public void start() {
        System.out.println("打开华为手机");
    }

    @Override
    public void shutDown() {
        System.out.println("关闭华为手机");
    }

    @Override
    public void callUp() {
        System.out.println("华为手机打电话");
    }

    @Override
    public void sendSMS() {
        System.out.println("华为手机发短信");
    }
}
```

<!-- endtab -->

<!-- tab Huaweirouter.java -->

```java
public class Huaweirouter implements IRouterProduct {
    @Override
    public void start() {
        System.out.println("打开华为路由器");
    }

    @Override
    public void shutDown() {
        System.out.println("关闭华为路由器");
    }

    @Override
    public void openWifi() {
        System.out.println("打开华为wifi");
    }

    @Override
    public void setting() {
        System.out.println("关闭华为wifi");
    }
}
```

<!-- endtab -->

<!-- tab XiaomiFactory.java -->

```java
public class XiaomiFactory implements IProductFactory {
    //生产小米产品族，并且满足抽象工厂的开发模式，可扩展性强

    @Override
    public IphoneProduct iphoneProduct() {
        return new Xiaomiphone();
    }

    @Override
    public IRouterProduct routerProduct() {
        return new Xiaomirouter();
    }
}
```

<!-- endtab -->

<!-- tab HuaweiFactory.java -->

```java
public class HuaweiFactory implements IProductFactory {
    //生产华为产品族，并且满足抽象工厂的开发模式，可扩展性强

    @Override
    public IphoneProduct iphoneProduct() {
        return new Huaweiphone();
    }

    @Override
    public IRouterProduct routerProduct() {
        return new Huaweirouter();
    }
}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211108151129.png)

此时结构图如下图所示，我们会发现实际上抽象工厂模式不过就是对工厂进行了又一次的抽象封装，所以此时支持了工厂可以生产产品族了。

![](https://langwenchong.gitee.io/figure-bed/20211022160217.png)

##### 思考：简单工厂模式，工厂方法模式和抽象工厂模式的异同点？

学习完上面三种关于工厂模式的介绍，我们会发现实际上这三种开发模式都和现实生活中的开发模式非常类似，简单工厂模式首先提出了创建和应用分离，工厂方法模式在基础上优化了扩展性能，而抽象工厂模式支持了产品族的生产。但是这三者都会导致一定程度的`类膨胀`现象，所谓有利就有弊，但是在面对复杂场景下工厂模式总是最优解。

#### 建造者模式

建造者模式也是一种创造模式，但是他和工厂模式不同，他是将一个复杂对象的构建与表示分离，使得用户可以在不知道对象的建造过程和细节的情况下就可以完成复杂对象的创建。它主要的特点就是用户只需要给出指定复杂对象的类型和内容，建造者模式负责按顺序创建复杂对象， 把具体的内部的建造过程和细节隐藏起来，同时还支持携带默认值的复杂对象的创建。

举一个应用场景，现在我们已经有了轴承，发动机，轮胎等产品的工厂了，但是最终我们需要的是一辆车，那么此时我们就需要由`建造者`身份来保证我们完成最终的组件的拼装以及进一步加工，最终由他来向我们交付完成的汽车。

{% note info,

也就是说面对简单对象的创建时，我们是用不到建造者模式的。同时要注意所有的设计模式并不是单一使用的，而是互相依赖的，比如上面的过程中我们也用到了工厂模式。

%}

现在我们用代码来演示一下建造者模式的应用场景，假设现在我们需要建筑一栋大厦，那么首先我们需要找到一个建筑公司或者工程承包商（指挥者），由他来指挥工人（具体的建造者）来造房子（产品）。最终我们向建筑公司索要大厦产品。

![](https://langwenchong.gitee.io/figure-bed/20211022162801.png)

上图就是一个建造者模式的演示图，建筑公司就是Director，工人建造者就是具体的Builder,而抽象的Builder就是设计图纸，即指挥者给出抽象的建造顺序，建造者根据建造顺序具体实现建造或者产品的组装，最终指挥官将完成的产品交付给我们客户。代码如下：

{% tabs 建造者模式 %}

<!-- tab Consumer.java -->

```java
//我们客户身份
public class Consumer {
    public static void main(String[] args) {
        //创建一个指挥者
        Director director = new Director();
        //我们只需要命令指挥者开始搭建房子即可
        //具体后面的指挥者如何指挥工人搭建房子
        //甚至房子的组成结构我们一概不知也无需关心
        Product p = director.build(new Worker());
        System.out.println(p.toString());

    }
}
```

<!-- endtab -->

<!-- tab Product.java -->

```java
/具体的房子产品
public class Product {
    //房子有四个值需要建造填充
    private String buildA;
    private String buildB;
    private String buildC;
    private String buildD;

    public String getBuildA() {
        return buildA;
    }

    public void setBuildA(String buildA) {
        this.buildA = buildA;
    }

    public String getBuildB() {
        return buildB;
    }

    public void setBuildB(String buildB) {
        this.buildB = buildB;
    }

    public String getBuildC() {
        return buildC;
    }

    public void setBuildC(String buildC) {
        this.buildC = buildC;
    }

    public String getBuildD() {
        return buildD;
    }

    public void setBuildD(String buildD) {
        this.buildD = buildD;
    }


    @Override
    public String toString() {
        return "Product{" +
                "buildA='" + buildA + '\'' +
                ", buildB='" + buildB + '\'' +
                ", buildC='" + buildC + '\'' +
                ", buildD='" + buildD + '\'' +
                '}';
    }


}
```

<!-- endtab -->

<!-- tab Director.java -->

```java
//具体的指挥者，他来只会工人按顺序创建产品
//核心
public class Director {
    //指挥者有一个开始指挥构建产品的函数
    //他需要接收传进来一个工人即具体的实现Builder类实例
    public Product build(Builder builder){
        //他在指挥 着这个工人按照一定的顺序来盖房子
        //这里指挥工人按照A-B-C-D顺序构建房子
        //他负责具体的房子结构组装
        builder.buildA();
        builder.buildB();
        builder.buildC();
        builder.buildD();
        //最终从工人那里拿到盖好的房子
        //然后指挥者来向客户交付产品
        return builder.getProduct();
    }

}
```

<!-- endtab -->

<!-- tab Builder.java -->

```java
//抽象的Builder，不提供具体的建造实现
//仅仅定义建造的步骤
//注意这里使用接口或者抽象类都是相同的作用
//表示抽象的功能,这里用抽象类表示
public abstract class Builder {
    abstract void buildA();//地基
    abstract void buildB();//钢筋水泥
    abstract void buildC();//铺电线
    abstract void buildD();//粉刷

    //完工交付产品
    abstract Product getProduct();
}
```

<!-- endtab -->

<!-- tab Worker.java -->

```java
/具体的Builder实现
public class Worker extends Builder {
    //工人仅仅是会做这些工作的，但是如果没有人指挥他并不会做
    //即他不知道盖房子的具体步骤，只是会搭建房子的一系列操作

    private Product product;

    public Worker() {
        //一定要注意是工人这个具体Builder来创建产品
        //抽象的Builder仅仅定义方法和实现顺序
        product = new Product();
    }

    @Override
    void buildA() {
        //先达地基
        product.setBuildA("地基");
    }

    @Override
    void buildB() {
        product.setBuildB("钢筋工程");
    }

    @Override
    void buildC() {
        product.setBuildC("铺电线");
    }

    @Override
    void buildD() {
        product.setBuildD("粉刷");
    }

    @Override
    Product getProduct() {
        return product;
    }
}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211108151256.png)

上面实例时Builder建造者模式的常规用法， 其中指挥类Director在Builder模式中有很重要的作用，它用于指导建造者Worker如何按照顺序正确的创造产品，并且在完成产品生成后将产品返还给客户。

但是我们在现实生活中可能客户并不是真的不关心具体的实现操作，而是客户本身就是指挥者，因此此时我们并不需要来实现一个复杂的指挥者，只需要一个工人可以根据我们客户的只会进行产品的创建即可。因此通过静态内部类方式实现零件无需装配构造，这种方式更加灵活符合定义。当内部有复杂对象的默认实现，使用时可以根据用户需求自定义更改内容，并且无需改变具体的构造方式，就可以生产出不同复杂产品。下面我们通过麦当劳点餐的应用场景模拟一下这种方式，即服务员（具体的建造者）可以随意搭配任意几种产品（零件）组成一款套餐（产品），然后出售给客户，但是客户可以指挥服务员更改默认的套餐，这种方式把指挥者身份交给了用户自己来扮演，使得产品的创建更加简单灵活：

{% tabs 简化版建造者模式 %}

<!-- tab Consumer.java -->

```java
public class Consumer {
    public static void main(String[] args) {
        //我们自己扮演指挥者来更改套餐
        //首先需要创建一名服务员即建造者
        Worker worker = new Worker();
        //修改默认的套餐，将汉堡更改为上校鸡块
        //修改默认的套餐，可累更改为咖啡
        //最终我们从这个当前worker实例所携带的套餐实例product获取修改的套餐
        //即静态内部类的体现
        //同时这里也体现了链式变成的特点
        Product product = worker.buildA("上校鸡块").buildB("咖啡").getProduct();
        //输出套餐信息
        System.out.println(product.toString());
    }
}
```

<!-- endtab -->

<!-- tab Product.java -->

```java
//产品套餐
public class Product {
    //默认的套餐产品所拥有的的食物
    private String BuildA = "汉堡";
    private String BuildB = "可乐";
    private String BuildC = "薯条";
    private String BuildD = "甜点";

    public String getBuildA() {
        return BuildA;
    }

    public void setBuildA(String buildA) {
        BuildA = buildA;
    }

    public String getBuildB() {
        return BuildB;
    }

    public void setBuildB(String buildB) {
        BuildB = buildB;
    }

    public String getBuildC() {
        return BuildC;
    }

    public void setBuildC(String buildC) {
        BuildC = buildC;
    }

    public String getBuildD() {
        return BuildD;
    }

    public void setBuildD(String buildD) {
        BuildD = buildD;
    }
	
     @Override
    public String toString() {
        return "Product{" +
                "BuildA='" + BuildA + '\'' +
                ", BuildB='" + BuildB + '\'' +
                ", BuildC='" + BuildC + '\'' +
                ", BuildD='" + BuildD + '\'' +
                '}';
    }
}
```

<!-- endtab -->

<!-- tab Builder.java -->

```java
//抽象类，也可以使用接口，最终功能一致
public abstract class Builder {
    abstract Builder buildA(String msg);//汉堡

    abstract Builder buildB(String msg);//可乐

    abstract Builder buildC(String msg);//薯条

    abstract Builder buildD(String msg);//蛋挞

    abstract Product getProduct();
}
```

<!-- endtab -->

<!-- tab Worker.java -->

```java
//具体的建造者，服务员
public class Worker extends Builder{
    //这里体现了懒汉式单例创建
    private Product product;
    public Worker(){
        //注意产品的创建还是由创建者来完成
        product=new Product();
    }

    @Override
    Builder buildA(String msg) {
        //修改套餐的第一个食品
        product.setBuildA(msg);

        //注意这里优点不好理解
        //返回的是当前的worker实例，由于这个worker内部包含了一个产品
        //因此间接的这个worker所更改创建的套餐也返还了
        //这就是静态内部类的体现
        return this;
    }

    @Override
    Builder buildB(String msg) {
        product.setBuildB(msg);
        return this;
    }

    @Override
    Builder buildC(String msg) {
        product.setBuildC(msg);
        return this;
    }

    @Override
    Builder buildD(String msg) {
        product.setBuildD(msg);
        return this;
    }

    @Override
    Product getProduct() {
        //返还当前worker所携带的产品
        return product;
    }
}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211108151840.png)

通过上面的两个示例，我们可以看出建造者模式将复杂对象产品的创建步骤分解在了不同的方法中，使得创建过程更加清晰，同时使得客户无需在关心复杂对象的创建，具体的创建交付给了Builder和Director来完成。并且我们根据第二个例子可以看到建造者模式还可以提供默认产品值和他的链式修改方法，使得产品的自定义程度更高。但是我们发现这种模式也存在一定的弊端，即创建的产品要求一般具有较多的共同点，如果产品之间的差异较大时，则不适用于建造者模式。同时由于产品内部变化复杂，可能会导致需要定义很多具体的建造类来实现这种变化，导致系统变的很庞大（只是这里的例子中产品较为简单，因此只用了一个建造类即完成了复杂对象的创建）。

##### 思考：抽象工厂模式和建造者模式的区别？

其实我们很容易就可以感受到区别。抽象工厂模式是返还**一系列**产品，这些产品可以直接通过new即可创建完成，但是在建造者模式中的产品一般都很复杂，并不能一步new即可完成创建，他需要多个零件组装完成。因此如果将抽象工厂模式看成汽车配件生产工厂，生产一个产品族的产品，那么建造者模式就是一个汽车组装工厂，通过对部件的组装返还**一个**完整的车辆。

{% note info,

一般建造者模式是使用抽象工厂模式创建的各种产品零件进行组装完成一个复杂对象的创建，因此两个模式是相互合作的！

%}

#### 原型模式

所谓原型模式，说白了就是实例的赋值，类似于克隆动物。但是他要求克隆以后两个实例再也没有关系，即一个实例的变化不会再影响另一个实例即两个实例指向不同的内存空间，这其中涉及到了`浅拷贝`和`深拷贝`的区别。

##### 浅拷贝的克隆

{% tabs 浅克隆 %}

<!-- tab Video.java -->

```java
public class Video implements Cloneable {
    //1.实现Cloneable接口
    private String name;
    private Date createTime;

    //2.重写这个方法
    @Override
    protected Object clone() throws CloneNotSupportedException {
        return super.clone();
    }

    public Video() {

    }

    public Video(String name, Date date) {
        this.name = name;
        this.createTime = date;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "Video{" +
                "name='" + name + '\'' +
                ", createTime=" + createTime +
                '}';
    }


}
```

<!-- endtab -->

<!-- tab Bilibili.java -->

```java
//客户端：实现克隆
public class Bilibili {
    public static void main(String[] args) throws CloneNotSupportedException {
        //原型对象
        Date date = new Date();
        Video v1 = new Video("狂神说java", date);
        System.out.println("v1=>" + v1);
        System.out.println("v1=>hash" + v1.hashCode());

        //克隆v1
        Video v2 = (Video) v1.clone();
        //此时v2和v1内容会完全一致，并且存储到了不同的内存空间
        //发现此时HashCode确实不同，说明存储的内存空间不同
        //此时更改v2的名字确实不会改变v1的名字
        v2.setName("Clone:狂神说java");
        //但是此时有浅拷贝的情况，即v2和v1的date指向同一个位置
        //造成v2修改时间后v1的时间也会发生变化，这就是浅拷贝
        date.setTime(22131231);
        v2.setCreateTime(date);
        //此时v1和v2大的时间会保持一致，即v1的时间自动发生了变化和v2保持一致
        System.out.println(v2.getCreateTime().equals(v1.getCreateTime()));

    }

}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211108151956.png)

上面之所以出现浅拷贝，是因为此时虽然两个对象各占用了不同的内存空间，并且name变量也确实占用了不同的空间，但是由于date默认是更改引用的，因此此时两个实例的date还是共享的，即指向了一个内存空间，导致了浅拷贝的情况。我们用图表示一下此时的情况：

![](https://langwenchong.gitee.io/figure-bed/20211022205047.png)

为了解决这个问题，我们需要修改clone方法改成所有的变量也全部都是使用不同的内存空间即深拷贝。

##### 深拷贝的克隆

{% tabs  深克隆 %}

<!-- tab Video.java -->

```java
//1.实现克隆接口
//2.重写一个方法即可完成克隆
public class Video implements Cloneable {
    //1.实现Cloneable接口
    private String name;
    private Date createTime;

    //2.重写这个方法
    @Override
    protected Object clone() throws CloneNotSupportedException {
//        return super.clone();
        //重写克隆方法
        Object obj = super.clone();
        Video v = (Video) obj;
        //将对象的属性也全部重新克隆一遍
        v.createTime = (Date) this.createTime.clone();
        //这里最终返回v或者obj都是可以的
        return obj;
        //return v
    }

    public Video() {

    }

    public Video(String name, Date date) {
        this.name = name;
        this.createTime = date;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "Video{" +
                "name='" + name + '\'' +
                ", createTime=" + createTime +
                '}';
    }


}
```

<!-- endtab -->

<!-- tab Bilibili.java -->

```java
//客户端：实现克隆
public class Bilibili {
    public static void main(String[] args) throws CloneNotSupportedException {
        //原型对象
        Date date = new Date();
        Video v1 = new Video("狂神说java", date);
        System.out.println("v1=>" + v1);
        System.out.println("v1=>hash" + v1.hashCode());

        //克隆v1
        Video v2 = (Video) v1.clone();
        //此时v2和v1内容会完全一致，并且存储到了不同的内存空间
        //发现此时HashCode确实不同，说明存储的内存空间不同
        //此时更改v2的名字确实不会改变v1的名字
        v2.setName("Clone:狂神说java");
        //更改为了深拷贝，因此此时更改v2的日期，v1的日期不会发生改变
        date.setTime(22131231);
        v2.setCreateTime(date);
        //因此此时下面为false
        System.out.println(v2.getCreateTime().equals(v1.getCreateTime()));

    }

}
```

<!-- endtab -->

{%  endtabs %}

此时的深拷贝的情况如下图所示，因此此时两个实例所有成员变量全部都指向了自己的内存空间，解决了浅拷贝的问题。当然我们也可以使用序列化/反序列化方法实现深拷贝，但是远没有这种修改clone方法简单。

![](https://langwenchong.gitee.io/figure-bed/20211022211206.png)

###### 思考：为什么重写的clone方法部分返还v和obj都可以？

我们要理解v和obj的区别，此时他们两个指向的是同一个内存空间，只不过是v有一个Video类型强转的过程，因此最终obj和v的date是同一个变量，它实现了重新克隆即完成了深拷贝，具体返还obj还是v都可以，因为最终他们返还都是这个新拷贝的对象实例的内存空间。

{% note info,

原型模式的应用场景很容易联想到，即工厂模式下工厂生产产品我们可以不再使用new来创建，而是选择clone的方法创建来提升效率。

%}

**您可以点击下方链接获取上面教程所使用的代码,同时可以参考本篇博客完成homework01实验巩固学习😊**

{% link 设计模式代码仓库 , https://github.com/Langwenchong/DesignPattern %}



