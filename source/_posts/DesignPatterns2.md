---
title: Jave学23种设计模式(2)--结构型模式
comments: false
top: false
date: 2021-11-08 15:44:14
tags: [设计模式,java]
categories: 
	- [知识分享,学习心得]
headimg: https://langwenchong.gitee.io/figure-bed/20211108213345.png
---

记录翀翀对23种设计模式的思考与总结📜，本章介绍UML图和7种重要的结构型模式。

<!-- more -->

### UML图基本概念

在学习结构型模式之前，我们先来学习一下UML图。肯定会有人问我们为什么要学习这些鬼画符似的图谱？实际上学习UML图后不会增强我们的coding能力，但是他可以有助于我们快速把握理解一个代码设计的整体架构特点，也就是易于大家互相理解对方的代码设计逻辑，因此学习UML图是很有必要的，并且UML图非常简单，学习20%的概念以后我们就可以解决超过80%的应用场景，还不快和我学起来😁？

{% note info, 本部分参考了肖继潮大大的[《30分钟学会UML类图》](https://zhuanlan.zhihu.com/p/109655171)文章，特此鸣谢！%}

#### UML图表示法

首先我们要学会如何表示一个类或者一个接口。每一个类或者接口一般对应一个java文件，因此我们可以通过类和接口的表示快速把握多个java文件之间的内部联系。

##### UML图表示具体类

![](https://langwenchong.gitee.io/figure-bed/20211108160432.png)

类在类图中使用矩形框表示，同时矩形框分成三层，从上到下依次是类名、类的成员变量、类的方法。同时成员变量和方法前的修饰符可以用下面的三个符号表示：

- `+`表示public
- `-`表示private
- `#`表示protected
- 不带符号表示default

##### UML图表示抽象类

![](https://langwenchong.gitee.io/figure-bed/20211108160854.png)

抽象类实际上和具体类写法很类似，仅仅是**类名**以及**抽象的方法名**使用斜体字表示而已，但是我们在绘制时很难区分正体和斜体字，为了不混淆具体类和抽象类，我们还可以在抽象类类名下方最右侧加上`abstract`字样。

![](https://langwenchong.gitee.io/figure-bed/20211108161117.png)

##### UML图中表示接口

![](https://langwenchong.gitee.io/figure-bed/20211108161152.png)

接口只有两层即接口名称和需要实现类重写的方法，同时在接口名称上面我们还要加上`<<interface>>`字样表示接口。

##### UML图中表示包

![](https://langwenchong.gitee.io/figure-bed/20211108161309.png)

了解即可一般用不到。

#### UML图表示关系

![](https://langwenchong.gitee.io/figure-bed/20211108161356.png)

类图之间存在不同的关系，我们可以将其整体上划分成5种主要关系。这部分内容肖继潮大大介绍的十分详细，我这里仅仅使用简洁的语言总结一下不同关系的特点和区分方法。

##### 实现关系

![](https://langwenchong.gitee.io/figure-bed/20211108161556.png)

不用多做介绍也知道什么意思，可以直接对应java中的关键字`implements`，实现接口的类矩形指向接口矩形框。

##### 泛化关系

![](https://langwenchong.gitee.io/figure-bed/20211108161709.png)

也不用多做介绍，就是对应java中关键字`extends`，即父子类的关系，子类指向父类。

##### 依赖关系

![](https://langwenchong.gitee.io/figure-bed/20211108161827.png)

依赖关系是一种弱关联关系，如果A依赖于B，那么就是A类指向B类，一般可以用`A use a B`来表示这种弱关系，具体表现形式一般为**B是A的构造器或方法中的局部变量、方法或构造器的参数、方法的返回值**等，或者**A调用B的静态方法**。

##### 聚合关系

![](https://langwenchong.gitee.io/figure-bed/20211108162145.png)

聚合关系比依赖关系联系性要强，如果A聚合B，那么就是白菱形在A这边，箭头(可画可不画)指向B，一般可以用`A has a B`表示，即A类的对象内部使用了B类的实例作为成员变量，同时这个**B是可以被多个实例聚合，即B不独属于A且A不需要知道B的生命周期也无需负责B的声明周期**。

##### 组合关系

![](https://langwenchong.gitee.io/figure-bed/20211108162703.png)

又被称为`强聚合关系`，因此联系性比聚合关系更强，如果A组合B，那么就是黑菱形在A这边，箭头(可画可不画)指向B，一般可以用`A contains a B`表示，即A类的对象内部使用B类的对象作为成员变量，同时**这个B是A的一部分且独属于A，即只有这个A完全拥有B，其他对象的B和A的B不是一个存储地址，并且A知道B的声明周期且负责B的声明周期**。

{% note info, 

组合关系和聚合关系通常很难区分。我们可以把聚合关系理解为雇员和雇主的关系，一个雇员可以有多个雇主，并且雇员随时可以离开雇主并且不会影响到雇主，而组合关系类似于人和器官的关系，一个器官只能属于一个人，并且这个器官通常是不能转移的并且离开后会影响到人的生活。通常在画UML图时当我们不确定是聚合或组合关系时，使用聚合关系总是不会出错的😁~

%}

### 结构型模式

{% note quote, 上一节我们详细学习了5种创建型模式。本章我们继续学习7种重要的结构型模式，结构型模式可以分为类结构型模式和对象结构型模式，前者采用继承机制来组织接口和类，而后者采用组合或者聚合来组合对象。由于组合关系或聚合关系比继承关系耦合度低，满足`合成复用原则`，因此我们接下来介绍的模式大多都是对象结构型模式 %}

我们首先给出7种结构型模式的特点和主要功能，方便我们在学习时能随时带着问题思考，感悟他们的特点：

1. 适配器模式：将一个类的接口转换成客户希望的另外一个接口，使得原本由于接口不兼容而不能一起工作的那些类在一起工作，**主要就是解决兼容性问题**。
2. 桥接模式：将抽象与现实分离，使他们可以独立变化。他是使用组合关系代替继承关系来实现的，从而降低了抽象和显示着两个可变维度的耦合度，**使得两个维度独立变化互不影响**。
3. 装饰模式：动态的给对象增加一些职责而不会修改原对象，**即增加其额外的功能**，解决功能扩展性问题。
4. 组合模式：**将对象组合成树状层次结构**，使用户对单个对象和组合对象具有一致的访问性。
5. 外观模式：为多个复杂的子系统提供一个一致的接口，**使得外部可以更加容易的去访问操作这些子系统**。
6. 享元模式：运用共享技术来有效地支持大量细粒度对象的复用，**解决的是复用缩小空间浪费的问题**。
7. 代理模式：为对象提供一种代理以控制对该对象的访问，即客户端通过代理间接地访问该对象，从而限制、增强或修改对象的一些特征，**类似于封装分层的模型以解决直接访问源对象**。

#### 适配器模式

适配器模式有分成了类适配器模式和对象适配器模式，类适配器模式使用了继承关系来获取第三方库的功能，而对象适配器使用聚合关系来获取第三方库的功能。两者最终达到的目的是一致的，但是对象适配器的可扩展性更好，更加符合`合成复用原则`。

现在我们以一个案例来具体学习一下适配器模式，假设现在我们有一台电脑，他只能读取SD卡，但是现在我们需要读取TF卡中的内容，显然现在TF卡提供的读数据接口并不能被电脑所使用，即第三方接口无法被客户主机兼容，那么我们就需要引入适配器了即SDAdapterTF适配器，他可以读取TF卡中的数据，然后再为电脑提供SD卡接口，电脑此时通过适配器就可以获取到TF卡中的数据了。

##### 类适配器模式

![](https://langwenchong.gitee.io/figure-bed/20211108163655.png)

上面就是类适配器的UML图了，后面的Client都表示测试程序即含有`main()`方法的测试文件。代码如下：

{% tabs  类适配器模式 %}

<!-- tab Client.java -->

```java
//类适配器违背了合成复用原则
public class Client {
    public static void main(String[] args) {
        Computer computer =new Computer();
        //读取sd卡中的数据
        String msg=computer.readSD(new SDCardImpl());
        System.out.println(msg);

        System.out.println("==============================");

        //使用该计算机去读取TFCard中的数据，明显需要适配器
        //定义适配器类

        String msg1=computer.readSD(new SDAdapterTF());
        System.out.println(msg1);
    }
}
```

<!-- endtab -->

<!-- tab Computer.java -->

```java
/计算机只能读sd卡
public class Computer {
    //从SD卡读取数据
    public String readSD(SDCard sdCard){
        if(sdCard==null){
            throw new NullPointerException("sd card can not  be null");
        }
        return sdCard.readSD();
    }

}
```

<!-- endtab -->

<!-- tab SDCard.java -->

```java
//目标者接口
public interface SDCard {
    //从SD卡中读取数据
    String readSD();
    //向SD卡写数据
    void writeSD(String msg);
}
```

<!-- endtab -->

<!-- tab SDCardImpl.java -->

```java
public class SDCardImpl implements SDCard {
    @Override
    public String readSD() {
        String msg = "SDCard read msg: hello world!";
        return msg;
    }

    @Override
    public void writeSD(String msg) {
        System.out.println("SDCard write msg:" + msg);
    }
}
```

<!-- endtab -->

<!-- tab TFCard.java -->

```java
//适配者类的接口
public interface TFCard {
    //从TF卡中读取数据
    String readTF();
    //向TF卡中写数据
    void writeTF(String msg);
}
```

<!-- endtab -->

<!-- tab TFCardImpl.java -->

```java
//实现适配者接口
public class TFCardImpl implements TFCard{
    @Override
    public String readTF() {
        String msg="TFCard read msg: hello world TFCard!";
        return msg;
    }

    @Override
    public void writeTF(String msg) {
        System.out.println("TFCard write msg: "+msg);
    }
}
```

<!-- endtab -->

<!-- tab SDAdapterTF.java -->

```java
//适配器
//使用继承不太好，造成了违背合成复用原则
public class SDAdapterTF extends TFCardImpl implements SDCard {

    @Override
    public String readSD() {
        System.out.println("adapter read tf card");
        //实际上适配器是去读TF卡中的数据
        return readTF();
    }

    @Override
    public void writeSD(String msg) {
        System.out.println("adapter write tf card");
        writeTF(msg);
    }
}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211108164933.png)

我们思考一下类适配器的缺点有什么？很明显这里类适配器使用的是继承TFCardImpl来获取到具体的调用readTF()方法读取TF卡中的数据，但是由于java中是单继承的，因此当前和这个适配器只能适配SD2TF的类型了，假设现在我们需要一个适配器，他能同时支持多种卡数据转SD接口的功能，那么显然此时类适配器做不到，因为他不可能继承多个不同卡型的类，因此类适配器的扩占性并不好。因此我们引出了对象适配器的模式。

##### 对象适配器模式

![](https://langwenchong.gitee.io/figure-bed/20211108165336.png)

此时我们使用了聚合的方法来获取到TFCard的接口方法，那么由于我们聚合是将TFCard实例作为一个Adapter的成员变量，因此此时如果需要进行多个卡型的适配，也是可以做到的，无非就是在Adapter类中对每一种卡型都初始化一个实例作为成员变量即可了，需要读取K型卡的数据，就调用K实例的readK()方法即可了。代码如下

{% tabs 对象适配器模式 %}

<!-- tab Client.java -->

```java
//比类适配器要好
public class Client {
    public static void main(String[] args) {
        Computer computer = new Computer();
        //读取sd卡中的数据
        String msg = computer.readSD(new SDCardImpl());
        System.out.println(msg);

        System.out.println("==============================");

        //使用该计算机读取TFCard中的数据
        //创建适配器类对象
        SDAdapterTF sdAdapterTF = new SDAdapterTF(new TFCardImpl());
        String msg1 = computer.readSD(sdAdapterTF);
        System.out.println(msg1);
    }
}
```

<!-- endtab -->

<!-- tab  Computer.java -->

```java
//计算机只能读sd卡
public class Computer {
    //从SD卡读取数据
    public String readSD(SDCard sdCard){
        if(sdCard==null){
            throw new NullPointerException("sd card can not  be null");
        }
        return sdCard.readSD();
    }

}
```

<!-- endtab -->

<!-- tab SDCard.java -->

```java
//目标者接口
public interface SDCard {
    //从SD卡中读取数据
    String readSD();
    //向SD卡写数据
    void writeSD(String msg);
}
```

<!-- endtab -->

<!-- tab SDCardImpl.java -->

```java
public class SDCardImpl implements SDCard {
    @Override
    public String readSD() {
        String msg = "SDCard read msg: hello world!";
        return msg;
    }

    @Override
    public void writeSD(String msg) {
        System.out.println("SDCard write msg:" + msg);
    }
}
```

<!-- endtab -->

<!-- tab TFCard.java -->

```java
//适配者类的接口
public interface TFCard {
    //从TF卡中读取数据
    String readTF();
    //向TF卡中写数据
    void writeTF(String msg);
}
```

<!-- endtab -->

<!-- tab TFCradImpl.java -->

```java
//实现适配者接口
public class TFCardImpl implements TFCard {
    @Override
    public String readTF() {
        String msg="TFCard read msg: hello world TFCard!";
        return msg;
    }

    @Override
    public void writeTF(String msg) {
        System.out.println("TFCard write msg: "+msg);
    }
}
```

<!-- endtab -->

<!-- tab SDAdapterTF.java -->

```java
//适配器
//不需要使用继承
public class SDAdapterTF implements SDCard {

    //声明适配者类
    private TFCard tfCard;

    public SDAdapterTF(TFCard tfCard) {
        this.tfCard = tfCard;
    }

    @Override
    public String readSD() {
        System.out.println("adapter read tf card");
        //实际上适配器是去读TF卡中的数据
        return tfCard.readTF();
    }

    @Override
    public void writeSD(String msg) {
        System.out.println("adapter write tf card");
        tfCard.writeTF(msg);
    }
}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211108164933.png)

学习完上面的案例后，我们对适配器模式有了透彻的了解，他可以帮助我们解决兼容性问题，此时客户可以通过适配器调用一切第三方模块了。同时通过类适配器模式和对象适配器模式的对比我们感受到了聚合关系相较于继承关系的优越性，这也是`合成复用原则`优点的体现。

#### 桥接模式

我们现在看一个案例，假设现在我们需要开发一个跨平台视频播放器，可以在不同操作系统平台（如Windows、Mac、Lnux等）上播放多种格式的视频文件，常见的视频格式包括RMVB、AVI等类型。每一个系统都支持这两种类型视频的解码播放，假设我们现在对于具体的操作系统类和抽象的视频文件类两个维度都使用继承来实现，那么会如下图所示：

![](https://langwenchong.gitee.io/figure-bed/20211108171504.png)

此时有一个很明显的弊端，无论是新增添一种视频解码类型还是一种新的操作系统，都会至少需要添加2个子类，即无论是操作系统维度还是视频解码类型维度变化，都会造成另外一个维度的变化，从而导致子类的变化过多，不易维护使用。因此我们引入了代理模式的概念，他的根本目的就是为了保证两个维度之间的变化互补干涉，从而减少重复子类的创建，如下图就是桥接模式下对该案例的设计：

![](https://langwenchong.gitee.io/figure-bed/20211108170855.png)

此时视频解码方法使用了实现接口的方式，然后最重要的是操作系统具体类**聚合了视频解码类**，这样又符合了`合成复用原则`，我们发现此时任意一个维度的变化都不会影响另一个维护，因此每一次增加也只会新添加一个子类，非常的简单易维护。代码如下

{% tabs 桥接模式 %}

<!-- tab  Client.java -->

```java
public class Client {
    public static void main(String[] args) {
        //创建mac系统对象
        OperatingSystem system = new Mac(new AviFile());
        //开始使用操作系统播放视频文件
        system.play("战狼3");
    }
}

```

<!-- endtab -->

<!-- tab OperatingSystem.java -->

```java
//抽象的操作系统类，抽象化角色
public abstract class OperatingSystem {
    //声明VideoFile变量
    protected VideoFile videoFile;

    public OperatingSystem(VideoFile videoFile) {
        this.videoFile = videoFile;
    }

    public abstract void play(String fileName);
}
```

<!-- endtab -->

<!-- tab Windows.java -->

```java
//扩展抽象化角色
public class Windows extends OperatingSystem {
    public Windows(VideoFile videoFile) {
        super(videoFile);
    }

    @Override
    public void play(String fileName) {
        videoFile.decode(fileName);
    }
}
```

<!-- endtab -->

<!-- tab Mac.java -->

```java
public class Mac extends OperatingSystem {
    public Mac(VideoFile videoFile) {
        super(videoFile);
    }

    @Override
    public void play(String fileName) {
        videoFile.decode(fileName);
    }
}
```

<!-- endtab -->

<!-- tab VideoFile.java -->

```java
//视频文件格式，实现化角色
public interface VideoFile {
    //解码功能
    void decode(String fileName);
}

```

<!-- endtab -->

<!-- tab RmvbFile.java -->

```java
//rmvb视频文件类，具体实现化角色
public class RmvbFile implements VideoFile {
    @Override
    public void decode(String fileName) {
        System.out.println("rmvb视频文件：" + fileName);
    }
}
```

<!-- endtab -->

<!-- tab AviFile.java -->

```java
//avi视频文件，具体的实现化角色
public class AviFile implements VideoFile {

    @Override
    public void decode(String fileName) {
        System.out.println("avi视频文件：" + fileName);
    }
}

```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211108173009.png)

#### 装饰模式

装饰模式在游戏开发中是经常使用的第一个模式，比如角色切换装备会实时刷新角色的属性值，就是使用的装饰模式。但是我们不用游戏角色的案例来学习，因为那个太复杂了，我们以炒饭🍚和炒面🍜为例，假设现在有一个快餐店，提供炒饭和炒面这些快餐，同时可以额外附加鸡蛋、火腿、培根等配菜，当然添加配菜需要额外价钱，同时每一种配餐的价钱通常也不一样，那么计算总价会变得非常复杂，此时我们就可以使用装饰模式来完成。首先我们看一下UML图

![](https://langwenchong.gitee.io/figure-bed/20211108200518.png)

可以看到比较复杂，我这里简单讲解一下，我们一定要注意Garnish装饰者并不是向Fastfood添加配菜，而是聚合Fastfood即拿到炒饭或者炒菜进行添加配菜处理，最终返还的一个添加好配菜的炒饭或者炒面。因此这里的Egg和Bacon最终返还的不是鸡蛋或者培根，而是添加了鸡蛋或者培根的炒饭、炒面。接下来我们看一下代码

{% tabs 装饰模式 %}

<!-- tab Client.java -->

```java
public class Client {
    public static void main(String[] args) {
        //创建mac系统对象
        OperatingSystem system = new Mac(new AviFile());
        //开始使用操作系统播放视频文件
        system.play("战狼3");
    }
}
```



<!-- endtab -->

<!-- tab FastFood.java -->

```java
//快餐类,抽象构建角色
public abstract class FastFood {
    private float price;//价格
    private String desc;//具体的描述

    public abstract float cost();

    public FastFood() {
    }

    public FastFood(float price, String desc) {
        this.price = price;
        this.desc = desc;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }


}
```

<!-- endtab -->

<!-- tab FriedRice.java -->

```java
//炒饭，具体构建角色
public class FriedRice extends FastFood{
    public FriedRice(){
        //基础价格和描述
        super(10,"炒饭");
    }
    @Override
    public float cost() {
        return getPrice();
    }
}
```

<!-- endtab -->

<!-- tab FriedNoodles.java -->

```java
//炒面，具体构建角色
public class FriedNoodles extends FastFood {

    public FriedNoodles() {
        super(12, "炒面");
    }

    @Override
    public float cost() {
        return getPrice();
    }
}
```

<!-- endtab -->

<!-- tab Garnish.java -->

```java
//装饰类,抽象，因为会有许多不同的具体装饰配料，抽象装饰
public abstract class Garnish extends FastFood {
    //声明快餐类变量
    private FastFood fastFood;

    public FastFood getFastFood() {
        return fastFood;
    }

    public void setFastFood(FastFood fastFood) {
        this.fastFood = fastFood;
    }

    public Garnish(FastFood fastFood) {
        this.fastFood = fastFood;
    }

    public Garnish(FastFood fastFood, float price, String desc) {
        super(price, desc);
        this.fastFood = fastFood;
    }


}
```

<!-- endtab -->

<!-- tab Egg.java -->

```java
//第一个装饰配料鸡蛋，具体装饰者角色
public class Egg extends Garnish {
    public Egg(FastFood fastFood) {
        super(fastFood, 1, "鸡蛋");
    }

    @Override
    public float cost() {
        return getPrice() + getFastFood().cost();
    }

    @Override
    public String getDesc() {
        return super.getDesc() + getFastFood().getDesc();
    }
}
```

<!-- endtab -->

<!-- tab Bacon.java -->

```java
//第二个装饰配料培根，具体装饰者角色
public class Bacon extends Garnish {
    public Bacon(FastFood fastFood) {
        super(fastFood, 2, "培根");
    }

    @Override
    public float cost() {
        return getPrice() + getFastFood().cost();
    }

    @Override
    public String getDesc() {
        return super.getDesc() + getFastFood().getDesc();
    }
}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211108201131.png)

我们可以看到此时即使是多重装饰的应用场景，装饰模式也可以应对自如，同时并不需要重复的创建子类，因此满足`合成复用原则`。使用装饰模式后，代码的复用性很高，值得学习。

#### 组合模式

![](https://langwenchong.gitee.io/figure-bed/20211108201935.png)

初读组合模式很难理解**用户对单个对象和组合对象具有一致的访问性**这句话的含义，并且也很难联想到应用场景。实际上有一个我们日常可见的应用就是使用组合模式完美实现的，那就是文件目录，假设我们在访问一些管理系统时，经常可以看到类似的菜单，一个菜单可以包含菜单项（菜单项是指不在包含其他内容的菜单条目），也可以包含带有其他菜单项的菜单文件夹，此时虽然菜单项和菜单形式上略有区别，但是他们的访问权限是一致的刚好和组合模式很恰当。现在有一个需求是针对一个菜单，打印出其包含的所有菜单项以及子菜单下的菜单项。我们第一个想到的方法就是递归打印，但是实际上使用了组合模式后，由于文件之间已经隐含了树的关系，因此我们可以轻松的根据树展开完成需求而无需再使用递归。

![](https://langwenchong.gitee.io/figure-bed/20211108202017.png)

由于菜单和菜单项的用户访问性是一致的并且他们有很多共同的方法和属性，因此他们都继承了一个核心MenuComponent组件，然后再在其基础上重写了自己特有的方法。这就是组合模式，关系很简单，代码如下：

{% tabs 组合模式 %}

<!-- tab Client.java -->

```java
public class Client {
    public static void main(String[] args) {
        //创建菜单树
        MenuComponent menu1 = new Menu("菜单管理", 2);
        menu1.add(new MenuItem("页面访问", 3));
        menu1.add(new MenuItem("展开菜单", 3));
        menu1.add(new MenuItem("编辑菜单", 3));
        menu1.add(new MenuItem("删除菜单", 3));
        menu1.add(new MenuItem("新增菜单", 3));
        MenuComponent menu2 = new Menu("权限管理", 2);
        menu2.add(new MenuItem("页面访问", 3));
        menu2.add(new MenuItem("提交保存", 3));
        MenuComponent menu3 = new Menu("角色管理", 2);
        menu3.add(new MenuItem("页面访问", 3));
        menu3.add(new MenuItem("新增角色", 3));
        menu3.add(new MenuItem("修改角色", 3));

        MenuComponent component = new Menu("系统管理", 1);
        component.add(menu1);
        component.add(menu2);
        component.add(menu3);


        //打印菜单名称，如果有子菜单一同打印
        //不用再使用递归了，直接一步打印即可
        component.print();

    }
}
```

<!-- endtab -->

<!-- tab MenuComponent.java -->

```java
//菜单组件，属于抽象根节点
public abstract class MenuComponent {
    //菜单组件的名称
    protected String name;
    //菜单组件的层级
    protected int level;

    //添加子菜单
    public void add(MenuComponent menuComponent) {
        throw new UnsupportedOperationException();
    }

    //移除子菜单
    public void remove(MenuComponent menuComponent) {
        throw new UnsupportedOperationException();
    }

    //获取指定的子菜单
    public MenuComponent getChild(int index) {
        throw new UnsupportedOperationException();
    }

    //获取菜单或者菜单项的名称
    public String getName() {
        return name;
    }

    //打印菜单名称(包含所有子元素)
    public abstract void print();
}
```

<!-- endtab -->
<!-- tab Menu.java -->

```java
//菜单类，属于树枝节点角色
public class Menu extends MenuComponent {
    //菜单可以有多个子菜单或者子菜单项
    private List<MenuComponent> menuComponentList = new ArrayList<MenuComponent>();

    public Menu(String name, int level) {
        this.name = name;
        this.level = level;
    }

    @Override
    public void add(MenuComponent menuComponent) {
        menuComponentList.add(menuComponent);
    }

    @Override
    public void remove(MenuComponent menuComponent) {
        menuComponentList.remove(menuComponent);
    }

    @Override
    public MenuComponent getChild(int index) {
        return menuComponentList.get(index);
    }

    @Override
    public void print() {
        //因为是菜单，所以要先打印菜单名称
        for (int i = 0; i < level; i++) {
            System.out.print("--");
        }
        System.out.println(name);
        //然后还要打印子菜单或者子菜单项名称
        for (MenuComponent component : menuComponentList) {
            component.print();
        }
    }
}
```

<!-- endtab -->

<!-- tab MenuItem.java -->

```java
//菜单项类，叶子节点角色
public class MenuItem extends MenuComponent {
    public MenuItem(String name, int level) {
        this.name = name;
        this.level = level;
    }

    public void print() {
        for (int i = 0; i < level; i++) {
            System.out.print("--");
        }
        System.out.println(name);
    }

}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211108202439.png)

{% note info,

一定要注意组合模式总是有一个基础的公共组件抽象类被所有实现类继承，这样保证了所有的实现类都有类似的性质，访问性一致同时对于具有存储功能的实现类还要再聚合这个抽象类实例。

%}

#### 外观模式

外观模式或者门面模式很好理解，他就是将许多复杂的子系统接口封装成了一个统一的外部接口被其控制，这样简化了客户的操作难度。比如现在假设小明的爷爷已经60岁了，一个人在家生活，每次回到家都需要打开灯、打开电视、打开空调，睡觉时需要关闭灯、关闭电视、关闭空调。操作起来比较麻烦，因此小明给爷爷买了智能音箱，可以通过语音直接控制这些智能家电的开启和关闭，此时就可以使用外观模式，其UML图如下：

![](https://langwenchong.gitee.io/figure-bed/20211108203104.png)

这个应用很简单，模式设计也很好理解，就是使用Facade去聚合所有的子系统实例，然后由他来操作完成这些复杂的步骤，而只向客户提供一个统一的操作接口，这样就大大简化了用户的操作难度。代码如下

{% tabs 外观模式 %}

<!-- tab Client.java -->

```java
public class Client {
    public static void main(String[] args) {
        //创建一个智能音箱即可
        SmartApplianceFacade smartApplianceFacade = new SmartApplianceFacade();
        smartApplianceFacade.say("我想打开家电");
        System.out.println("=========================");
        smartApplianceFacade.say("我困了，想关闭家电");
    }
}
```

<!-- endtab -->

<!-- tab Light.java -->

```java
//电灯类
public class Light {
    //开灯方法
    public void on() {
        System.out.println("打开电灯");
    }

    public void off() {
        System.out.println("关闭电灯");
    }
}
```

<!-- endtab -->

<!-- tab TV.java -->

```java
public class TV {
    public void on(){
        System.out.println("打开电视");
    }

    public void off(){
        System.out.println("关闭电视");
    }
}
```

<!-- endtab -->

<!-- tab AirCondition.java -->

```java
public class AirCondition {
    public void on() {
        System.out.println("打开空调");
    }

    public void off() {
        System.out.println("关闭空调");
    }

}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211108203442.png)

#### 享元模式

享元模式实际上优点类似于共享自行车的概念，他就是将基础的公共组件提供给不同的用户，然后用户用这个公共的组件进行进一步的处理完成功能，因此这些功能肯定都是极其类似的，这样共享的好处就是省去了许多重复相似类的创建节省了大量的空间。

![](https://langwenchong.gitee.io/figure-bed/20211108203750.png)

我们以俄罗斯方块为例，在俄罗斯方块游戏中，每个不同的方块都是一个实例对象，这些对象就要占很多的内存空间，同时不同的方块有不同的颜色，如果我们为每一个不同颜色不同类型的方块都创建一个类，那么空间多道无法想象，此时我们就可以使用享元模式完成这个需求。UML图如下

![](https://langwenchong.gitee.io/figure-bed/20211108204002.png)

这个BoxFactory可千万不要理解为一个不断创建实例的工厂！他并不是真的一直在创建实例，而仅仅是为每一个形状的方块类只实例化了一个单例，然后一直在不断地根据传入的参数重复的返还这三个实例😲，因此节省了许多的空间。代码如下：

{% tabs 外观模式 %}

<!-- tab Client.java -->

```java
public class Client {
    public static void main(String[] args) {
        //获取I图形
        AbstractBox box1 = BoxFactory.getInstance().getShape("I");
        box1.display("灰色");

        AbstractBox box2 = BoxFactory.getInstance().getShape("L");
        box2.display("绿色");

        AbstractBox box3 = BoxFactory.getInstance().getShape("O");
        box3.display("红色");

        AbstractBox box4 = BoxFactory.getInstance().getShape("O");
        box4.display("黄色");

        System.out.println("两次获取到的O图形对象是否为同一个对象" + (box3 == box4));
        //颜色是外部状态，并不会真正的修改内部的状态，同一个形状类型的对象共享，节省空间
    }
}
```

<!-- endtab -->

<!-- tab AbstractBox.java -->

```java
//抽象享元角色
public abstract class AbstractBox {
    //获取图形的方法
    public abstract String getShape();

    //显示图形和颜色
    public void display(String color) {
        System.out.println("方块形状:" + getShape() + "," + "颜色：" + color);
    }
}
```

<!-- endtab -->
<!-- tab IBox.java -->

```java
public class IBox extends AbstractBox {

    @Override
    public String getShape() {
        return "I";
    }
}
```

<!-- endtab -->
<!-- tab LBox.java -->

```java
public class LBox extends AbstractBox {

    @Override
    public String getShape() {
        return "L";
    }
}
```

<!-- endtab -->

<!-- tab OBox.java -->

```java
public class OBox extends AbstractBox {

    @Override
    public String getShape() {
        return "O";
    }
}

```

<!-- endtab -->

<!-- tab BoxFactory.java -->

```java
//工厂类，将该类设计为单例
public class BoxFactory {
    public HashMap<String, AbstractBox> map;

    //在构造方法中进行初始化操作
    //单例，因此工厂私有
    private BoxFactory() {
        map = new HashMap<String, AbstractBox>();
        map.put("I", new IBox());
        map.put("L", new LBox());
        map.put("O", new OBox());
    }

    public static BoxFactory getInstance() {
        return boxFactory;
    }

    //饿汉式
    private static BoxFactory boxFactory = new BoxFactory();

    //根据名称获取图形对象
    public AbstractBox getShape(String name) {
        return map.get(name);
    }

}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211108204610.png)

一定要注意享元模式的最大特点就是**许多对象是共用的**，比如上面的两个不同颜色的O形方块，实际上他们都是先从工厂拿到了同一个存储地址的O形方块然后进一步上了不同的颜色而已。因此上面的代码案例中仅仅使用了三个对象，即使是有上万种颜色，也仅仅使用了三个对象的空间！享元模式的优越性不言而喻。

#### 代理模式

##### 静态代理模式

![](https://langwenchong.gitee.io/figure-bed/20211108205202.png)

注意代售点是聚合了火车站，因此实际上他调用的还是火车站的sell()方法，即代售点并不是最终修改票数的操作者，实际上还是火车站进行火车票数的修改，因此这和CSR三层封装模型很类似，代理只不过是基于最底层的类进行了封装代理而已，最终的根本操作还是由底层类实现。代码如下

{% tabs 静态代理模式 %}

<!-- tab Client.java -->

```java
public class Client {
    public static void main(String[] args) {
        //创建代售点对象
        ProxyPoint proxyPoint = new ProxyPoint();
        proxyPoint.sell();
    }
}
```

<!-- endtab -->

<!-- tab TrainStation.java -->

```java
//火车站类
public class TrainStation implements SellTicket {
    @Override
    public void sell() {
        System.out.println("火车站卖票");
    }
}
```

<!-- endtab -->

<!-- tab SellTicket.java -->

```java
//卖火车票的接口
public interface SellTicket {
    void sell();
}
```

<!-- endtab -->

<!-- tab ProxyPoint.java -->

```java
//火车票代售点
public class ProxyPoint implements SellTicket {
    //声明火车站类对象
    private TrainStation trainStation = new TrainStation();

    @Override
    public void sell() {
        System.out.println("代售点收取一定的服务费用");
        trainStation.sell();
    }
}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211108205631.png)

##### JDK动态代理模式

我们发现上面的代理类是写死的，即这个代售点就只能代理火车站的卖票功能，但是现实生活中我们知道售报亭等小摊也是可以买到火车票的，同时他们还是报刊代售点、充值卡代售点，即集成了多个功能的复杂代理对象，显然静态代理实现不了，因此我们此时可以借用jdk提供的Proxy类实现动态代理，我们还是以代售点代售火车票为例，代码如下

{% tabs jdk动态代理模式 %}

<!-- tab Client.java -->

```java
public class Client {
    public static void main(String[] args) {
        //获取代理对象
        //1.创建代理工厂对象
        ProxyFactory factory = new ProxyFactory();
        //2.使用factory对象的方法获取代理对象
        SellTicket proxyObject = factory.getProxyObject();
        //3.调用卖调用的方法
        proxyObject.sell();
    }
}
```

<!-- endtab -->

<!-- tab TrainStation.java -->

```java
//火车站类
public class TrainStation implements SellTicket {
    @Override
    public void sell() {
        System.out.println("火车站卖票");
    }
}
```

<!-- endtab -->

<!-- tab SellTicket.java -->

```java 
//卖火车票的接口
public interface SellTicket {
    void sell();
}
```

<!-- endtab -->

<!-- tab ProxyFactory.java -->

```java
//获取代理对象的工厂类
public class ProxyFactory {
    //声明目标对象
    private TrainStation trainStation = new TrainStation();

    //获取代理对象的方法
    public SellTicket getProxyObject() {
        //返回代理对象
        //jdk提供的动态代理方法
        /*
        ClassLoader loader: 类加载器,用于加载代理类,可以通过目标对象获取类加载器
        Class<?>[] interfaces: 代理类实现的接口字节码对象
        InvocationHandler h :代理对象调用处理程序
         */
        SellTicket proxyObject = (SellTicket) Proxy.newProxyInstance(
                trainStation.getClass().getClassLoader(),
                trainStation.getClass().getInterfaces(),
                new InvocationHandler() {
                    @Override
                    /*
                    Object proxy: 代理对象，和proxyObject是同一个对象，在invoke方法中基本不用
                    Method method:对接口中的方法进行封装的method对象
                    Object[] args:调用方法的实际参数

                    返回值就是调用方法的返回值
                     */
                    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
//                        System.out.println("invoke方法执行了");
                        System.out.println("代售点收取一定的服务费用(jdk)动态代理");
                        //执行目标对象的方法
                        //此时sell方法无传递值，因此args是空
                        Object obj = method.invoke(trainStation, args);
                        //由于sell方法没有返回值，因此实际上obj这里就是null
                        return obj;
                    }
                }
        );
        return proxyObject;
    }
}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211108210218.png)

动态代理还有一种就是CGLIB代理，这里我就不讲了。如果您对此感兴趣可以自行搜索学习。

##### 思考：静态代理模式和装饰者模式的区别？

我们发现静态代理模式和装饰者模式的UML图非常类似，他们有如下相同点：

1. 都要实现与目标类相同的业务接口
2. 在两个类中都要声明目标对象（即聚合目标对象）
3. 都可以在不修改目标类的前提下增强目标方法（比如炒饭加鸡蛋增加费用，代售点售票还要多收服务费）

那么两者难道不是一样的吗？显然是有区别，首先两者的**目的不同**，装饰者模式添加额外的功能是为了增强目标对象，而静态代理模式是为了保护和隐藏目标对象才要添加新的代码，同时两者的**获取目标对象构建的地方也不同**，我们回忆一下装饰模式他的目的对象并不是提前在内部定义好的，而是由外界传进来的，这也是装饰模式可以重复装饰的原因，而静态代理模式的目标对象却是在代理类内部创建的，即代理对象实例化创建后就已经聚合了写死的目标对象实例。因此两者区别还是大大滴~

**您可以点击下方链接获取上面教程所使用的代码,同时可以参考本篇博客完成homework02实验巩固学习😊**

{% link 设计模式代码仓库 , https://github.com/Langwenchong/DesignPattern %}