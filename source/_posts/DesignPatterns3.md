---
title: Jave学23种设计模式(3)--行为型模式
comments: false
top: false
date: 2021-11-09 11:37:51
tags: [设计模式,java]
categories: 
	- [知识分享,学习心得]
headimg: https://langwenchong.gitee.io/figure-bed/20211109214312.png
---

记录翀翀对23种设计模式的思考与总结📜，本章介绍11种重要的行为型模式。

<!-- more -->

### 行为型模式

{% note quote, 上一章我们学习了7大结构型模式，本章我们来学习11种重要的行为型模式，行为型模式描述了多个类或对象之间怎么相互协作共同完成单个对象都无法完成的任务，涉及算法与对象间职责的分配。同样他也分为类行为模式和对象行为模式，为了满足`合成复用原则`，我们尽量选择使用聚合方式的对象行为模式。 %}

我们也是首先给出11种行为型模式的特点和重要功能，方便我们在学习时能随时带着思考学习：

1. 模板方法模式：定义一个操作中的算法结构，将算法的一些步骤延迟到子类中，使得**子类可以在不改变算法结构的情况下重新定义该算法的某些特定步骤**。
2. 命令模式：将一个请求封装为一个对象，**使发出请求的责任和执行请求的责任分隔开**。
3. 迭代器模式：提供一个方法来顺序访问聚合对象中的一系列数据，而不**暴露聚合对象的内部表示**。
4. 观察者模式：多个对象之间存在一对多关系，当一个对象发生改变时，**把这种改变通知给其他多个对象**，从而影响其他对象的行为。
5. 中介者模式：定义一个中介者来简化原有对象之间的复杂交互关系，降低系统中对象间的耦合度，**使得原有对象之间不必相互了解**。
6. 备忘录模式：在**不破坏封装性的前提下，获取并保存一个对象的内部状态**，以便以后恢复他。
7. 解释器模式：提供如何**定义语言的文法**，以及**对语言句子的解释方法**，即解释器。
8. 状态模式：允许一个**对象在其内部状态发生改变时改变其行为能力**。
9. 策略模式：定义一系列算法，并**将每一个算法封装起来，使得它们可以相互替换**，且算法的改变不会影响使用算法的客户。
10. 职责链模式：把**请求从链中的一个对象传到下一个对象**，直到请求被相应为止。通过这种方式去除对象之间的耦合。
11. 访问者模式：在不改变集合元素的前提下，为一个集合中的每个元素提供多种访问方式，即**每一个元素有多个访问者对象访问**。

{% note info,

上面的11种行为型模式中，除了模板方法模式和解释器模式是类行为模式，其他的全部为对象行为型模式。

%}

#### 模板方法模式

模板方法模式我们非常熟悉，在日常开发中实际上我们就已经经常使用这个模式了他针对的是一些操作流程大致相同，只是具体的某些特定步骤的操作细节不同的应用场景，此时我们可以将大体的流程在抽象类中定义，然后相同操作的流程也可以在抽象类中实现，但是对于那些具体操作细节不太相同的步骤延迟到子类实现，这就是模板方法模式。比如炒菜的步骤是固定的，分为倒油、热油、倒蔬菜、倒调理品、爆炒等步骤，现在我们将制作炒包菜和炒菜心两个菜品，很明显他们的大体步骤是相同的，但是在倒蔬菜、倒调料品和爆炒三个环节略有不同，此时我们就可以使用模板方法来实现。UML图如下

![](https://langwenchong.gitee.io/figure-bed/20211109150720.png)

代码也很简单，就是一个抽象类然后被两个具体实现继承即可，因此模板方法是类行为型模式，但是这种类行为型模式是有必要的，他不能通过接口来实现，这是因为往往多个具体实现类还会有一些相同的成员属性，那么此时我们就可以在抽象类中定义好这些成员变量，但是接口却无法实现。

{% tabs 模板方法模式 %}

<!-- tab Client.java -->

```java
public class Client {
    public static void main(String[] args) {
        //炒包菜
        ConcreteClass_BaoCai baoCai = new ConcreteClass_BaoCai();
        //炒菜
        baoCai.cookProcess();
        System.out.println("===============");
        ConcreteClass_CaiXin caiXin = new ConcreteClass_CaiXin();
        caiXin.cookProcess();
    }
}
```

<!-- endtab -->

<!-- tab AbstractClass.java -->

```java
public abstract class AbstractClass {

    //模板方法定义
    public final void cookProcess() {
        pourOil();
        heatOil();
        pourVagetable();
        fry();
    }

    //基本方法
    //第一步
    public void pourOil() {
        System.out.println("倒油");
    }

    //第二步热油是一样的，直接实现
    public void heatOil() {
        System.out.println("热油");
    }

    //第三步要倒的菜是不同的，因此这里方法维持抽象
    public abstract void pourVagetable();

    //第四步倒的调料不一样，也抽象
    public abstract void pourSauce();

    //第五步翻炒是一样的，直接在这里实现
    public void fry() {
        System.out.println("炒啊炒啊炒啊吵到熟啊");
    }
}
```

<!-- endtab -->

<!-- tab ConcreteClass_BaoCai.java -->

```java
//炒包菜类
public class ConcreteClass_BaoCai extends AbstractClass {

    @Override
    public void pourVagetable() {
        System.out.println("下锅的是包菜");
    }

    @Override
    public void pourSauce() {
        System.out.println("下锅的是辣椒");
    }
}

```

<!-- endtab -->

<!-- tab ConcreteClass_CaiXin.java -->

```java
public class ConcreteClass_CaiXin extends AbstractClass {
    @Override
    public void pourVagetable() {
        System.out.println("下锅的是菜心");
    }

    @Override
    public void pourSauce() {
        System.out.println("下锅的是蒜蓉");
    }
}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211109151333.png)

#### 命令模式

命令模式初看感觉没有什么明显的作用，很难理解他的做法。但是我们在联想C/S的HTTP请求模型以后就很好理解了，命令模式实际上就是类似于请求与执行分离的开发模式，他的主要目的就是为了使得命令发起者和命令的执行者想分开，两者独立工作，通过命令这个请求来建立联系。这样我们就可以很好的去实现复杂应用场景下高并发复杂请求的接收->执行->响应的调度过程了。我们以餐厅为案例学习，在日常生活中，我们出去吃饭都会遇到如下面的场景：

![](https://langwenchong.gitee.io/figure-bed/20211109151744.png)

此时一个客户就类似于以应用进程，许许多多个客户（应用进程）发起了多个异步请求（多个订单），此时需要由服务员这个调度这接收所有请求然后合理的分配给命令执行者（厨师）完成订单（请求）。这就是一个典型的命令模式，这里的订单就是命令，我们发现从客户的角度来看，他并不知道具体的订单（命令）是由哪位厨师（命令执行者）完成的并且他也并不关心，只要菜品（响应）及时正确的返回就可以了。而从厨师的角度来看，他也并不知道订单（命令）的请求者（上层应用）是谁并且他也并不关心，他只需要及时完成订单（执行命令）即可。而订单（命令）的调度分配有调度者（服务员）完成。UML图如下

![](https://langwenchong.gitee.io/figure-bed/20211109152248.png)

我们注意上面的UML类图，服务员调度者可以间接的调用分配命令和命令执行者，这与显示生活中的开发场景非常类似。代码如下

{% tabs 命令模式 %}

<!-- tab Client.java -->

```java
public class Client {
    public static void main(String[] args) {
        Order order1 = new Order();
        order1.setDiningTable(1);
        order1.setFood("西红柿鸡蛋面", 1);
        order1.setFood("小杯可乐", 2);

        Order order2 = new Order();
        order2.setDiningTable(2);
        order2.setFood("尖叫肉丝盖饭", 1);
        order2.setFood("小杯雪碧", 1);


        //创建厨师
        SeniorChef receiver = new SeniorChef();
        //创建命令对象
        OrderCommand cmd1 = new OrderCommand(receiver, order1);
        OrderCommand cmd2 = new OrderCommand(receiver, order2);
        //创建服务员
        Waitor waitor = new Waitor();
        waitor.setCommand(cmd1);
        waitor.setCommand(cmd2);
        waitor.orderUp();
    }
}
```

<!-- endtab -->

<!-- tab Command.java -->

```java
public interface Command {
    void execute();
}
```

<!-- endtab -->

<!-- tab Order.java -->

```java
public class Order {
    //下订单的餐桌号码
    private int diningTable;
    //所下的菜品及份数
    private Map<String, Integer> foodDir = new HashMap<String, Integer>();

    public int getDiningTable() {
        return diningTable;
    }

    public void setDiningTable(int diningTable) {
        this.diningTable = diningTable;
    }

    public Map<String, Integer> getFoodDir() {
        return foodDir;
    }


    public void setFood(String name, int num) {
        foodDir.put(name, num);
    }
}
```

<!-- endtab -->

<!-- tab OrderCommand.java -->

```java
public class OrderCommand implements Command {

    //持有接受者对象
    private SeniorChef receiver;
    private Order order;

    public OrderCommand(SeniorChef receiver, Order order) {
        this.receiver = receiver;
        this.order = order;
    }

    @Override
    public void execute() {
        System.out.println(order.getDiningTable() + "的订单：");
        Map<String, Integer> foodDir = order.getFoodDir();
        Set<String> keys = foodDir.keySet();
        for (String foodName : keys) {
            receiver.makeFood(foodName, foodDir.get(foodName));
        }
        System.out.println(order.getDiningTable() + "桌的饭菜准备完毕");
    }
}
```

<!-- endtab -->

<!-- tab SeniorChef -->

```java\
public class SeniorChef {
    public void makeFood(String name, int num) {
        System.out.println(num + "份" + name);
    }
}

```

<!-- endtab -->

<!-- tab Waitor.java -->

```java
public class Waitor {
    //持有命令对象,但是一个服务员可以发布多个命令，因此持有多个命令对象
    private List<Command> commands = new ArrayList<Command>();

    public void setCommand(Command cmd) {
        //将cmd对象存储到List中
        commands.add(cmd);
    }

    //发起命令的功能，喊订单来了
    public void orderUp() {
        System.out.println("美女服务员说：大厨，新订单来了！");
        //遍历List集合
        for (Command command : commands) {
            if (command != null) {
                command.execute();
            }
        }
    }
}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211109153018.png)

#### 迭代器模式

迭代器模式有什么作用？通常情况下我们使用的都是array或者list来存储，那么它们会面临一种风险，即全局暴露和被更改，这种风险隐患很大，在许多对安全要求极高的应用场景下是需要避免的，那么此时我们就会使用到迭代器模式，他是一种由开发者完成确保安全的情况下主动向外暴露的一个迭代器的模式，这种情况下我们主动规避了可更改的权限，保护了数据。假设现在我们要采用迭代器模式来顺序打印一个存储学生信息对象的容器，那么UML图如下

![](https://langwenchong.gitee.io/figure-bed/20211109153545.png)

我们会发现我们是将学生对象存储到了一个列表中，同时这个列表又是**Aggregate实例的一个隐私成员变量，是不允许外界访问获得甚至修改的**，那么很显然此时这些数据时被安全保护的，那么现在如果我们需要顺序打印他们，并不能直接通过for循环访问列表，而是需要使用开发者定义的一个迭代器来完成，同时这个迭代器返还的并不是对象引用，而是一个复制对象，那么也就是说我们在使用这个开发者提供给我们的迭代器后也是无权访问源数据的，可见安全性极高。代码如下

{% tabs 迭代器模式 %}

<!-- tab Client.java -->

```java
public class Client {
    public static void main(String[] args) {
        //创建聚合对象
        StudentAggregateImpl studentAggregate = new StudentAggregateImpl();
        //添加元素
        studentAggregate.addStudent(new Student("张三", "001"));
        studentAggregate.addStudent(new Student("李四", "002"));
        studentAggregate.addStudent(new Student("王五", "003"));
        studentAggregate.addStudent(new Student("赵六", "004"));
        //1.获取迭代器对象
        StudentIterator studentIterator = studentAggregate.getStudentIterator();
        //2.遍历
        while (studentIterator.hasNext()) {
            System.out.println(studentIterator.next().toString());
        }
    }
}
```

<!-- endtab -->

<!-- tab Studentjava -->

```java
public class Student {
    private String name;
    private String number;

    public Student() {
    }

    public Student(String name, String number) {
        this.name = name;
        this.number = number;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNumber() {
        return number;
    }

    @Override
    public String toString() {
        return "Student{" +
                "name='" + name + '\'' +
                ", number='" + number + '\'' +
                '}';
    }

    public void setNumber(String number) {
        this.number = number;
    }
}
```

<!-- endtab -->

<!-- tab StudentAggeragate.java -->

```java
public interface StudentAggregate {
    //添加学生功能
    void addStudent(Student student);

    //删除学生功能
    void removeStudent(Student student);

    //获取迭代器对象功能
    StudentIterator getStudentIterator();
}
```

<!-- endtab -->

<!-- tab StudentAggregateImpl.java -->

```java
public class StudentAggregateImpl implements StudentAggregate {

    private List<Student> studentList = new ArrayList<Student>();

    @Override
    public void addStudent(Student student) {
        studentList.add(student);
    }

    @Override
    public void removeStudent(Student student) {
        studentList.remove(student);
    }

    @Override
    public StudentIterator getStudentIterator() {
        return new StudentIteratorImpl(studentList);
    }
}
```

<!-- endtab -->

<!-- tab StudentIterator.java -->

```java
//抽象迭代器角色接口
public interface StudentIterator {
    //判断是够还有元素
    boolean hasNext();
    //获取下一个元素

    Student next();
}
```

<!-- endtab -->

<!-- tab StudentIteratorImpl.java -->

```java
//具体的迭代器角色类
public class StudentIteratorImpl implements StudentIterator {


    private List<Student> studentList;
    //用来记录遍历时的位置
    private int position;

    public StudentIteratorImpl(List<Student> studentList) {
        this.studentList = studentList;
    }

    @Override
    public boolean hasNext() {
        return position < studentList.size();
    }

    @Override
    public Student next() {
        Student student = studentList.get(position);
        position++;
        return student;
    }
}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211109154231.png)

#### 观察者模式

观察者模式解决的就是一个一对多通知变化的应用场景，优点类似于广播的形式。由于通知发起者需要向全部观察者发起变更通知，所以跟容易想到他肯定是有一个列表聚合存储了其他观察者实例，UML图如下

![](https://langwenchong.gitee.io/figure-bed/20211109154523.png)

{% tabs 观察者模式 %}

<!-- tab Client.java-->

```java
public class Client {
    public static void main(String[] args) {
        //1.创建公众号对象
        SubscriptionSubject subscriptionSubject = new SubscriptionSubject();
        //2.订阅公众号
        subscriptionSubject.attach(new WeixinUser("孙悟空"));
        subscriptionSubject.attach(new WeixinUser("猪悟能"));
        subscriptionSubject.attach(new WeixinUser("沙悟净"));
        //3.公众号更新发送推送消息
        subscriptionSubject.notify("传至黑马的专栏更新了");
    }
}
```

<!-- endtab -->

<!-- tab Observer.java -->

```java
//抽象观察者类
public interface Observer {
    void update(String msg);
}
```

<!-- endtab -->

<!-- tab Subject.java -->

```java
//抽象主题角色类
public interface Subject {
    //添加订阅者或者观察者对象
    void attach(Observer observer);

    //删除订阅者
    void detach(Observer observer);

    //通知观察者更新消息
    void notify(String msg);
}
```

<!-- endtab -->

<!-- tab SubscriptionSubject.java -->

```java
public class SubscriptionSubject implements Subject {


    //定义一个集合用来存储多个观察者对象
    private List<Observer> weixinUserList = new ArrayList<Observer>();

    @Override
    public void attach(Observer observer) {
        weixinUserList.add(observer);
    }

    @Override
    public void detach(Observer observer) {
        weixinUserList.remove(observer);
    }

    @Override
    public void notify(String msg) {
        for (Observer observer : weixinUserList) {
            observer.update(msg);
        }
    }
}
```

<!-- endtab -->

<!-- tab WeixinUser.java -->

```java
public class WeixinUser implements Observer {

    private String name;

    public WeixinUser(String name) {
        this.name = name;
    }

    @Override
    public void update(String msg) {
        System.out.println(name + "-" + msg);
    }
}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211109154804.png)

实际上上面和这个案例还有点简单，因为他是单方向的通知，即多个订阅观察者订阅专栏，当专栏变化时其他订阅观察者获取到通知，这是一个单方向的案例。但是我们常用的一般是双向甚至多向的案例，比如现在有一个战地小分队，所有的队员都在同一个频道，任何一个队员受到攻击都可以告知其他的同组队友地方战斗信息，这种多向的应用场景下使用观察者模式优点更加明显，如果有兴趣你可以尝试实现。

#### 中介模式

中介模式很容易理解，因为我们在日常生活中经常会观察到这个模式的应用，他就是为了解决多个对象之间关系过于复杂的场景，由中介者引入管理所有的通信简化关系网是最优设计模式，我们用两个图可以清晰感知到他的强大之处。

{% gallery , , one %}
![引入中介模式前](https://langwenchong.gitee.io/figure-bed/20211109155951.png)

![引入中介模式后](https://langwenchong.gitee.io/figure-bed/20211109160018.png)

{% endgallery %}

实际上我们在学习计网时，就曾经学习过，对于中介模式就是所谓的星形结构，他极大的简化了通信的复杂程度，但是这也对中介者这个中枢组件提出了高负荷情况下准确完美运行的极高要求。因为一旦中介者损坏，整个联络网将瘫痪。这里我们还是以中介，房东，租房者这个再常见不过的案例来模拟实现以下中介者模式，UML图如下

![](https://langwenchong.gitee.io/figure-bed/20211109160324.png)

很明显中介者是用来协调双方的，因此他MediatorStructure具体中介实现类聚合了Tenant租房者类和HouseOwner房东类。代码如下

{% tabs 中介模式 %}

<!-- tab Client.java -->

```java
public class Client {
    public static void main(String[] args) {
        //创建中介者对象
        MediatorStructure mediatorStructure = new MediatorStructure();

        Tenant tenant = new Tenant("李四", mediatorStructure);
        HouseOwner houseOwner = new HouseOwner("张三", mediatorStructure);
        mediatorStructure.setTenant(tenant);
        mediatorStructure.setHouseOwner(houseOwner);
        tenant.contact("我想租房子");
        houseOwner.contact("我可以租给你，5000一月");
    }
}

```

<!-- endtab -->

<!-- tab Person.java -->

```java
//抽象同事类
public abstract class Person {
    protected  String name;
    protected  Mediator mediator;

    public Person(String name, Mediator mediator) {
        this.name = name;
        this.mediator = mediator;
    }
}
```

<!-- endtab -->

<!-- tab Tenant.java -->

```java
//具体同事角色类
public class Tenant extends Person {
    public Tenant(String name, Mediator mediator) {
        super(name, mediator);
    }

    //和中介者联系方法
    public void contact(String msg) {
        mediator.contact(msg, this);
    }

    //获取信息的方法
    public void getMessage(String msg) {
        System.out.println("租房者" + name + "获取到的信息是：" + msg);
    }

}
```

<!-- endtab -->

<!-- tab HouseOwner.java -->

```java
//具体的同时角色类
public class HouseOwner extends Person {
    public HouseOwner(String name, Mediator mediator) {
        super(name, mediator);
    }

    //和中介者联系方法
    public void contact(String msg) {
        mediator.contact(msg, this);
    }

    //获取信息的方法
    public void getMessage(String msg) {
        System.out.println("房主" + name + "获取到的信息是：" + msg);
    }

}
```

<!-- endtab -->

<!-- tab Mediator.java -->

```java
//抽象中介者类
public abstract class Mediator {
    public abstract void contact(String msg,Person person);

}
```

<!-- endtab -->

<!-- tab MediatorStructure.java -->

```java
//具体的中介者角色类
public class MediatorStructure extends Mediator {
    //聚合房主和具体的租房者
    Tenant tenant;
    HouseOwner houseOwner;

    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
    }

    public HouseOwner getHouseOwner() {
        return houseOwner;
    }

    public void setHouseOwner(HouseOwner houseOwner) {
        this.houseOwner = houseOwner;
    }

    @Override
    public void contact(String msg, Person person) {
        if (person == houseOwner) {
            tenant.getMessage(msg);
        } else {
            houseOwner.getMessage(msg);
        }
    }
}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211109160844.png)

#### 备忘录模式

备忘录模式完成的就是状态的恢复类似于回滚，他在游戏开发中非常常见，比如副本挑战失败后回到挑战前的状态再次挑战，这时候我们就需要备忘录模式来完成了。备忘录模式分为白箱备忘录和黑箱备忘录模式，两者中后者安全性更好，但是无论是哪一种，他们的实现都是通过建立一个保存状态的备忘录对象用来存储到备忘录管理者对象中以便随时取出状态备忘录进行状态的恢复。现在假设游戏中的某个场景，一个游戏角色有生命力、攻击力和防御力等数据，在打boss前和打boss后一定会不一样，我们允许玩家如果感觉与boss决斗的效果不理想时让游戏恢复到决斗之前的状态，这就使用了备忘录模式，首先我们用白箱备忘录模式实现。

##### 白箱备忘录模式

![](https://langwenchong.gitee.io/figure-bed/20211109161626.png)

我们可以看到GameRole角色类可以存储状态，这个存储状态的数据对象就是RoleStateMento类的一个实例，但是我们知道可能有时候会存储许多个状态，允许多次回滚因此我们需要一个状态备忘录管理者即RoleStateCaretaker聚合了RoleStateMmento，用一个列表存储了许多个状态，当GameRole恢复时只需要从他这里获取即可。代码如下

{% tabs 白箱备忘录 %}

<!-- tab Client.java -->

```java
public class Client {
    public static void main(String[] args) {
        System.out.println("------------大战boss前----------");

        GameRole gameRole = new GameRole();
        gameRole.initState();//初始化状态的操作
        gameRole.stateDisplay();
        //将游戏角色状态进行备份
        RoleStateCaretaker roleStateCaretaker = new RoleStateCaretaker();
        roleStateCaretaker.setRoleStateMemento(gameRole.saveState());

        System.out.println("------------大战boss后----------------");
        //损耗严重
        gameRole.fight();
        gameRole.stateDisplay();
//        System.out.println("-------------恢复之前的状态-------------------");
        gameRole.recoverState(roleStateCaretaker.getRoleStateMemento());
        System.out.println("--------------恢复之后的状态---------------------");
        gameRole.stateDisplay();
    }
}
```

<!-- endtab -->

<!-- tab GameRole.java -->

```java
//游戏角色类，发起人角色
public class GameRole {
    private int vit;//生命力
    private int atk;//攻击力
    private int def;//防御力

    //初始化内部状态方法
    public void initState() {
        this.vit = 100;
        this.atk = 100;
        this.def = 100;
    }

    //战斗的方法
    public void fight() {
        this.vit = 0;
        this.atk = 0;
        this.def = 0;

    }

    //保存角色状态功能
    public RoleStateMemento saveState() {
        return new RoleStateMemento(vit, atk, def);
    }


    //恢复角色状态
    public void recoverState(RoleStateMemento roleStateMemento) {
        //将备忘录对象中存储的状态赋值给当前对象的成员
        this.vit = roleStateMemento.getVit();
        this.atk = roleStateMemento.getAtk();
        this.def = roleStateMemento.getDef();
    }

    //展示状态功能
    public void stateDisplay() {
        System.out.println("角色生命力：" + vit);
        System.out.println("角色生命力：" + atk);
        System.out.println("角色生命力：" + def);
    }

    public int getVit() {
        return vit;
    }

    public void setVit(int vit) {
        this.vit = vit;
    }

    public int getAtk() {
        return atk;
    }

    public void setAtk(int atk) {
        this.atk = atk;
    }

    public int getDef() {
        return def;
    }

    public void setDef(int def) {
        this.def = def;
    }


}
```

<!-- endtab -->

<!-- tab RoleStateMemento.java -->

```java
//备忘录角色类
public class RoleStateMemento {
    private int vit;//生命力
    private int atk;//攻击力
    private int def;//防御力

    public RoleStateMemento(int vit, int atk, int def) {
        this.vit = vit;
        this.atk = atk;
        this.def = def;
    }

    public RoleStateMemento() {
    }

    public int getVit() {
        return vit;
    }

    public void setVit(int vit) {
        this.vit = vit;
    }

    public int getAtk() {
        return atk;
    }

    public void setAtk(int atk) {
        this.atk = atk;
    }

    public int getDef() {
        return def;
    }

    public void setDef(int def) {
        this.def = def;
    }
}
```

<!-- endtab -->

<!-- tab RoleStateCaretaker.java -->

```java
//备忘录管理对象
public class RoleStateCaretaker {
    //声明RoleStateMemento类型的变量
    private RoleStateMemento roleStateMemento;

    public RoleStateMemento getRoleStateMemento() {
        return roleStateMemento;
    }

    public void setRoleStateMemento(RoleStateMemento roleStateMemento) {
        this.roleStateMemento = roleStateMemento;
    }
}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211109162048.png)

我们思考一下上面的这个白箱备忘录模式有没有什么缺陷，很明显，这个状态存储对象是有被修改的风险的！比如我们在存储当前状态为一个RoleStateMemento对象以后他是携带着对生命值、攻击力和防御力等数值的修改方法的，那么也就意味着他在传递的过程中可能会被恶意拦截然后修改数值的，这会造成我们的游戏存在被外挂恶意修改的风险，所以白箱备忘录有一个很明显的缺陷即安全性太低。因此我们接下来引入了黑箱备忘录模式。

##### 黑箱备忘录模式

![](https://langwenchong.gitee.io/figure-bed/20211109162620.png)

我们会发现此时RoleStateMemento类称为了GameRole类的私有类，同时他在传递保存的状态时使用了上层的接口Memento来实现的，而Memento接口确实一个没有任何方法的接口，这也就意味着在传递过程中使用的是Memento类型来传递保存的状态，那么由于Memento接口无方法，也就不可能直接对状态进行修改了。但是你肯定会反驳说只要把Memento强转为RoleStateMemento不就又可以进行数值修改了吗？但是实际上这是做不到的，原因有二：

1. 此时我们是以上帝视角来看设计的，因此我们知道Memento可以强转为RoleStateMemento类的，但是在实际上传输中，由于恶意拦截者并不是开发者，因此他并不知道Memento下的具体实现类类名是什么。
2. 即使恶意拦截者恰巧蒙对了，那他也无权在传输过程中进行强转修改，因为RoleStateMemento是GameRole的私有类。只有当Memento安全传到GameRole以后才能由GameRole进行强转，因此不存在恶意修改的风险了。

{% tabs 黑箱备忘录模式 %}

<!-- tab Client.java -->

```java
public class Client {
    public static void main(String[] args) {
        System.out.println("------------大战boss前----------");

        GameRole gameRole = new GameRole();
        gameRole.initState();//初始化状态的操作
        gameRole.stateDisplay();
        //将游戏角色状态进行备份
        RoleStateCaretaker roleStateCaretaker = new RoleStateCaretaker();
        roleStateCaretaker.setMemento(gameRole.saveState());

        System.out.println("------------大战boss后----------------");
        //损耗严重
        gameRole.fight();
        gameRole.stateDisplay();
//        System.out.println("-------------恢复之前的状态-------------------");
        gameRole.recoverState(roleStateCaretaker.getMemento());
        System.out.println("--------------恢复之后的状态---------------------");
        gameRole.stateDisplay();
    }
}
```

<!-- endtab -->

<!-- tab GameRole.java -->

```java
//游戏角色类，发起人角色
public class GameRole {
    private int vit;//生命力
    private int atk;//攻击力
    private int def;//防御力

    //初始化内部状态方法
    public void initState() {
        this.vit = 100;
        this.atk = 100;
        this.def = 100;
    }

    //战斗的方法
    public void fight() {
        this.vit = 0;
        this.atk = 0;
        this.def = 0;

    }

    //保存角色状态功能
    public RoleStateMemento saveState() {
        return new RoleStateMemento(vit, atk, def);
    }


    //恢复角色状态
    public void recoverState(Memento memento) {
        RoleStateMemento roleStateMemento = (RoleStateMemento) memento;
        //将备忘录对象中存储的状态赋值给当前对象的成员
        this.vit = roleStateMemento.getVit();
        this.atk = roleStateMemento.getAtk();
        this.def = roleStateMemento.getDef();
    }

    //展示状态功能
    public void stateDisplay() {
        System.out.println("角色生命力：" + vit);
        System.out.println("角色生命力：" + atk);
        System.out.println("角色生命力：" + def);
    }

    public int getVit() {
        return vit;
    }

    public void setVit(int vit) {
        this.vit = vit;
    }

    public int getAtk() {
        return atk;
    }

    public void setAtk(int atk) {
        this.atk = atk;
    }

    public int getDef() {
        return def;
    }

    public void setDef(int def) {
        this.def = def;
    }

    private class RoleStateMemento implements Memento {
        private int vit;//生命力
        private int atk;//攻击力
        private int def;//防御力

        public RoleStateMemento(int vit, int atk, int def) {
            this.vit = vit;
            this.atk = atk;
            this.def = def;
        }

        public int getVit() {
            return vit;
        }

        public void setVit(int vit) {
            this.vit = vit;
        }

        public int getAtk() {
            return atk;
        }

        public void setAtk(int atk) {
            this.atk = atk;
        }

        public int getDef() {
            return def;
        }

        public void setDef(int def) {
            this.def = def;
        }
    }
```

<!-- endtab -->

<!-- tab Memento.java -->

```java
//备忘录接口，对外提供窄接口
public interface Memento {

}
```

<!-- endtab -->

<!-- tab RoleStateCaretaker.java -->

```java
//备忘录管理对象
public class RoleStateCaretaker {
    //声明RoleStateMemento类型的变量
    private Memento memento;

    public Memento getMomento() {
        return memento;
    }

    public void setMemento(Memento memento) {
        this.memento = memento;
    }

    public Memento getMemento() {
        return memento;
    }
}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211109162048.png)

#### 解释器模式

这个模式并不常见也很难理解实现，他会将许多不同的原子操作进行文法定义，然后在调用时传进相对应的解释操作完成复杂的操作。我们以实现加减法的软件开发为例，UML图如下

![](https://langwenchong.gitee.io/figure-bed/20211109163811.png)

这里我们假设一个计算式为`a-(b+(c-d)`，那么很明显我们可以采用Minus(left,right)和Plus(left,right)两个基础操作叠加完成：

```java
new Minus(a, new Plus(b, new Minus(c, d)))
```

但是我们知道Minus的两个参数并不一定是参数，可能是一个子计算式，因此此时我们就需要引入解释器模式了，他可以对函数的参数进行解释，如果是一个变量，那么可以在一个解释查找表map中查找到对应的数值，将变量解释成对应的数值，如果没有查找到那么就是计算式，需要进一步拆分。因此每一步interpret解释我们都需要一个解释查找表即context，自此我们就设计完成了加减法软件

{% tabs 解释器模式 %}

<!-- tab Client.java -->

```java
public class Client {
    public static void main(String[] args) {
        //创建环境对象
        Context context = new Context();
        //给环境对象存储变量
        Variable a = new Variable("a");
        Variable b = new Variable("b");
        Variable c = new Variable("c");
        Variable d = new Variable("d");
        context.assign(a, 1);
        context.assign(b, 2);
        context.assign(c, 3);
        context.assign(d, 4);
        //获取抽象语法树
        AbstractExpression abstractExpression = new Minus(a, new Plus(b, new Minus(c, d)));
        int result = abstractExpression.interpret(context);
        System.out.println(abstractExpression + "=" + result);
    }
}
```



<!-- endtab -->

<!-- tab AbstractExpression.java -->

```java
//抽象表达式类
public abstract class AbstractExpression {
    public abstract int interpret(Context context);
}
```

<!-- endtab -->
<!-- tab Context.java -->

```java
//环境角色类
public class Context {
    //定义一个Map集合用来存储变量及对应的值
    private Map<Variable, Integer> map = new HashMap<Variable, Integer>();

    //添加变量的功能
    public void assign(Variable variable, Integer value) {
        map.put(variable, value);
    }

    //根据变量获取对应的值的方法
    public int getValue(Variable variable) {
        return map.get(variable);

    }
}
```

<!-- endtab -->

<!-- tab Minus.java -->

```java
public class Minus extends AbstractExpression {
    //减号两边的表达式
    private AbstractExpression left;
    private AbstractExpression right;

    public Minus(AbstractExpression left, AbstractExpression right) {
        this.left = left;
        this.right = right;
    }

    @Override
    public int interpret(Context context) {
        //将左边表达式的结果和右边表达式的结果进行相减
        return left.interpret(context) - right.interpret(context);
    }

    @Override
    public String toString() {
        return "(" + left.toString() + "-" + right.toString() + ")";
    }
}
```

<!-- endtab -->

<!-- tab Plus.java -->

```java
//加发表达式类
public class Plus extends AbstractExpression {
    //加号两边的表达式
    private AbstractExpression left;
    private AbstractExpression right;

    public Plus(AbstractExpression left, AbstractExpression right) {
        this.left = left;
        this.right = right;
    }

    @Override
    public int interpret(Context context) {
        //将左边表达式的结果和右边表达式的结果进行相加
        return left.interpret(context) + right.interpret(context);
    }

    @Override
    public String toString() {
        return "(" + left.toString() + "+" + right.toString() + ")";
    }
}
```

<!-- endtab -->

<!-- tab Variable.java -->

```java
//变量类，用于封装变量的类
public class Variable extends AbstractExpression {


    //声明存储变量名的成员变量
    private String name;

    public Variable(String name) {
        this.name = name;
    }

    @Override
    public int interpret(Context context) {
        //直接返回变量的值
        return context.getValue(this);
    }

    @Override
    public String toString() {
        return name;
    }
}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211109164829.png)

#### 状态模式

我们与状态模式的转换最先想到的办法就是多个if-else判断来实现，但是当状态多大百种时，在使用这种方法肯定不太合适了，而且每一次增加新状态都需要修改源代码，更别谈有时候不同的状态还有条件的限制，因此此时我们可以将每一个状态设置为一个类，然后使用类之间方法的调用实现状态的转换，同时每一个状态限制条件写到对应的类中即可，分成多个模块方便维护，最重要的是当天价新状态时我们无需频繁的去更改主函数代码。现在我们就以电梯来演示一下，假设电梯有开门，关门，运行和停止四个状态，同时要求电梯在开门时点击运行是无效的，运行过程中点击开门也是无效的，并且电梯频繁的在四个状态中进行切换，UML图如下

![](https://langwenchong.gitee.io/figure-bed/20211109181249.png)

{% tabs 状态模式 %}

<!-- tab Client.java -->

```java
public class Client {
    public static void main(String[] args) {
        //创建环境角色对象
        Context context = new Context();
        //设置当前电梯状态
        context.setLiftState(new RunningState());
        context.open();
        context.close();
        context.run();
        context.stop();
    }
}
```

<!-- endtab -->

<!-- tab Context.java -->

```java
//环境角色类
public class Context {
    //定义对应状态的对象常量
    public final static OpeningState OPENING_STATE = new OpeningState();
    public final static ClosingState CLOSING_STATE = new ClosingState();
    public final static RunningState RUNNING_STATE = new RunningState();
    public final static StoppingState STOPPING_STATE = new StoppingState();

    //当前状态变量
    private LiftState liftState;

    public LiftState getLiftState() {
        return liftState;
    }

    public void setLiftState(LiftState liftState) {
        this.liftState = liftState;
        //设置当前状态对象中的Context对象
        this.liftState.setContext(this);
    }

    public void open() {
        this.liftState.open();
    }

    public void close() {
        this.liftState.close();
    }

    public void run() {
        this.liftState.run();
    }

    public void stop() {
        this.liftState.stop();
    }
}
```

<!-- endtab -->

<!-- tab LiftState.java -->

```java
//抽象状态类
public abstract class LiftState {
    //环境角色类变量
    protected Context context;

    public void setContext(Context context) {
        this.context = context;
    }

    //电梯开启操作
    public abstract void open();

    //电梯关闭操作
    public abstract void close();

    //电梯运行操作
    public abstract void run();

    //电梯停止操作
    public abstract void stop();
}
```

<!-- endtab -->

<!-- tab OpeningState.java -->

```java
public class OpeningState extends LiftState {

    @Override
    public void open() {
        System.out.println("电梯开启");
    }

    @Override
    public void close() {
        super.context.setLiftState(Context.CLOSING_STATE);
        //调用当前状态中的context中的对应的close方法
        super.context.close();
    }

    @Override
    public void run() {

    }

    @Override
    public void stop() {

    }
}

```

<!-- endtab -->

<!-- tab RunningState.java -->

```java
public class RunningState extends LiftState {

    @Override
    public void open() {

    }

    @Override
    public void close() {

    }

    @Override
    public void run() {
        System.out.println("电梯开始运行");
    }

    @Override
    public void stop() {
        super.context.setLiftState(Context.STOPPING_STATE);
        super.context.stop();
    }
}
```

<!-- endtab -->

<!--tab StoppingState.java -->

```java
public class StoppingState extends LiftState {
    @Override
    public void open() {
        super.context.setLiftState(Context.OPENING_STATE);
        super.context.open();
    }

    @Override
    public void close() {
        super.context.setLiftState(Context.CLOSING_STATE);
        super.context.close();
    }

    @Override
    public void run() {
        super.context.setLiftState(Context.RUNNING_STATE);
        super.context.run();
    }

    @Override
    public void stop() {
        System.out.println("电梯停止");
    }
}
```

<!-- endtab -->

<!-- tab ClosingState.java -->

```java
public class ClosingState extends LiftState {
    @Override
    public void open() {
        super.context.setLiftState(Context.OPENING_STATE);
        super.context.open();
    }

    @Override
    public void close() {
        System.out.println("电梯门关闭");
    }

    @Override
    public void run() {
        super.context.setLiftState(Context.RUNNING_STATE);
        super.context.run();
    }

    @Override
    public void stop() {
        super.context.setLiftState(Context.STOPPING_STATE);
        super.context.stop();
    }
}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211109181654.png)

我们发现这种模式下，假设现在要添加一个停电和通电状态无需修改源代码，而只需要再添加新的状态。

#### 策略模式

假设现在有一家百货公司在定年度的促销活动，针对不同的节日（春节、中秋节、圣诞节）推出不同的促销活动，由促销员将促销活动展示给客户。那么我们可以如下设计：

![](https://langwenchong.gitee.io/figure-bed/20211109194841.png)

由于三种策略拥有的方法性质是一样的，只是实现不同，因此我们可以统一实现一个Strategy接口，然后售货员来聚合所有的策略，根据具体的情况来动态切换，这就是策略模式，非常容易理解。

{% tabs 策略模式 %}

<!-- tab Client.java -->

```java
public class Client {
    public static void main(String[] args) {
        //春节来了，使用春节促销活动
        SalesMan salesMan = new SalesMan(new StrategyA());
        salesMan.salesManShow();
        System.out.println("==============");
        //中秋节来了，使用中秋节活动
        salesMan.setStrategy(new StrategyB());
        salesMan.salesManShow();
        //圣诞节来了，使用圣诞节活动
        salesMan.setStrategy(new StrategyC());
        salesMan.salesManShow();
    }
}
```

<!-- endtab -->

<!-- tab SalesMan.java -->

```java
//环境类
public class SalesMan {
    //聚合策略类对象
    private Strategy strategy;

    public SalesMan(Strategy strategy) {
        this.strategy = strategy;
    }

    //由促销员展示促销活动给普通用户
    public void salesManShow() {
        strategy.show();
    }

    public void setStrategy(Strategy strategy) {
        this.strategy = strategy;
    }
}
```

<!-- endtab -->

<!-- tab Strategy.java -->

```java
//抽象策略类
public interface Strategy {
    void show();
}
```

<!-- endtab -->

<!--  tab StrategyA.java -->

```java
public class StrategyA implements Strategy {
    @Override
    public void show() {
        System.out.println("买一送一");
    }
}

```

<!-- endtab -->

<!-- tab StrategyB.java -->

```java
public class StrategyB implements Strategy {
    @Override
    public void show() {
        System.out.println("满200减50");
    }
}

```

<!-- endtab -->

<!-- tab StrategyC.java -->

```java
public class StrategyC implements Strategy {
    @Override
    public void show() {
        System.out.println("满1000元加一元购买任意200元以下商品");
    }
}

```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211109195445.png)

#### 职责链模式

职责链模式也很好理解，他有点类似于OS中的索引表，我们用一个请假的案例来学习：现在需要开发一个请假流程控制系统，请假一天以下的假只需要小组长同意即可，请假1天到3天的假还需要部分经理统一，请假3天到7天还需要总经理统一，请假7天以上不存在（想什么呢！请这么长时间的假你是想被开除吗😒）。同时当请假的天数超过审批者权限时，审批者会默认统一，因为反正你还需要由上级去判定你是否能请假成功，因此假设你要请假4天，那么小组长是一定会同意的，但是他还会将你的请假信息上报给部门经理，如果部门经理不同意，那么即使现在小组长同意了你也是请假失败。UML类图如下

![](https://langwenchong.gitee.io/figure-bed/20211109200211.png)

我们要注意每一个审批者都继承了Handler抽象类，然后他们都存储了上一级实例，以便向上级报告，但是他并不会存储上上级甚至上上上级的信息，即职责链模式是禁止跨级的，这也体现了`迪米特原则`。

{% tabs 职责链模式 %}

<!-- tab Client.java -->

```java
public class Client {
    public static void main(String[] args) {
        //创建请假条
        leaveResquest leaveResquest = new leaveResquest("小明", 6, "身体不适");
        //创建各级领导对象
        GroupLeader groupLeader = new GroupLeader();
        Manager manager = new Manager();
        GeneralManager generalManager = new GeneralManager();
        //设置处理链
        groupLeader.setNextHandler(manager);
        manager.setNextHandler(generalManager);
        //提交请假条
        groupLeader.submit(leaveResquest);
    }
}
```

<!-- endtab -->

<!-- tab Handler.java -->

```java
public abstract class Handler {
    protected final static int NUM_ONE = 1;
    protected final static int NUM_THREE = 3;
    protected final static int NUM_SEVEN = 7;

    //该领导处理的请假天数区间
    private int numStart;
    private int numEnd;

    //声明后继者（声明上级领导）
    private Handler nextHandler;

    public Handler(int numStart) {
        this.numStart = numStart;
    }

    public Handler(int numStart, int numEnd) {
        this.numStart = numStart;
        this.numEnd = numEnd;
    }

    //设置上级领导对象
    public void setNextHandler(Handler nextHandler) {
        this.nextHandler = nextHandler;
    }

    //各级领导处理请假条的方法
    protected abstract void handlderLeave(leaveResquest leaveResquest);

    //提交请假条
    public final void submit(leaveResquest leaveResquest) {
        //领导先进性审批是否通过
        if (this.nextHandler != null && leaveResquest.getNum() > this.numEnd) {
            //提交给上级领导进行审批
            System.out.println("提交至上级审核");
            this.nextHandler.submit(leaveResquest);
        } else {
            this.handlderLeave(leaveResquest);
            System.out.println("流程结束！");
        }
    }
}
```

<!-- endtab -->

<!-- tab GroupLeader.java -->

```java
//小组长类
public class GroupLeader extends Handler {

    public GroupLeader() {
        super(0, Handler.NUM_ONE);
    }

    @Override
    protected void handlderLeave(leaveResquest leaveResquest) {
        System.out.println(leaveResquest.getName() + "请假" + leaveResquest.getNum() + "天,理由是" + leaveResquest.getContent());
        System.out.println("小组长审批，审批同意");
    }
}
```

<!-- endtab -->

<!-- tab Manager.java -->

```java
public class Manager extends Handler {
    public Manager() {
        super(Handler.NUM_ONE, Handler.NUM_THREE);
    }

    @Override
    protected void handlderLeave(leaveResquest leaveResquest) {
        System.out.println(leaveResquest.getName() + "请假" + leaveResquest.getNum() + "天,理由是" + leaveResquest.getContent());
        System.out.println("部门经理审批，审批同意");
    }
}
```

<!-- endtab -->

<!-- tab GeneralManager.java -->

```java
public class GeneralManager extends Handler {
    public GeneralManager() {
        super(Handler.NUM_THREE, Handler.NUM_SEVEN);
    }

    @Override
    protected void handlderLeave(leaveResquest leaveResquest) {
        System.out.println(leaveResquest.getName() + "请假" + leaveResquest.getNum() + "天,理由是" + leaveResquest.getContent());
        System.out.println("总经理审批，审批同意");
    }
}
```

<!-- endtab -->

<!-- tab LeaveRequest.java -->

```java
//请假条
public class leaveResquest {
    //请假人员姓名
    private String name;

    //请假天数
    private int num;
    //请假内容

    private String content;

    public leaveResquest(String name, int num, String content) {
        this.name = name;
        this.num = num;
        this.content = content;
    }

    public String getName() {
        return name;
    }

    public int getNum() {
        return num;
    }

    public String getContent() {
        return content;
    }
}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211109201032.png)

#### 访问者模式

现在养宠物的人很多，当然宠物有狗、猫等等，要给宠物喂食的话，主人可以喂食，其他人也可以喂食，因此此时每一个宠物都会被许多访问者访问，但是我们不可能为每一个人都创建一个接口，此时就需要使用访问者模式了，他可以允许使用有限个方法使得该类实例被多种多样的实例所访问。UML图如下

![](https://langwenchong.gitee.io/figure-bed/20211109201508.png)

{% tabs 访问者模式 %}

<!-- tab Client.java -->

```java
public class Client {
    public static void main(String[] args) {
        //创建Home对象
        Home home = new Home();
        home.add(new Dog());
        home.add(new Cat());
        Owner owner = new Owner();
        home.action(owner);
    }
}
```

<!-- endtab -->

<!-- tab Animal.java -->

```java

//抽象元素角色类
public interface Animal {
    //接收访问者访问的功能
    void accept(Person person);


}
```

<!-- endtab -->

<!-- tab Cat.java -->

```java
public class Cat implements Animal {
    @Override
    public void accept(Person person) {
        //访问者喂食宠物猫
        person.feed(this);
        System.out.println("好好吃，喵喵喵");
    }
}
```

<!-- endtab -->

<!-- tab Dog.java -->

```java
public class Dog implements Animal {
    @Override
    public void accept(Person person) {
        //访问者喂食宠物猫
        person.feed(this);
        System.out.println("好好吃，汪汪汪");
    }
}

```

<!-- endtab -->

<!-- tab Person.java -->

```java
//抽象访问者角色类
public interface Person {
    //喂食宠物
    void feed(Cat cat);

    void feed(Dog dog);
}
```

<!-- endtab -->

<!-- tab Owner.java -->

```java
public class Owner implements Person {

    @Override
    public void feed(Cat cat) {
        System.out.println("主人喂猫");
    }

    @Override
    public void feed(Dog dog) {
        System.out.println("主人喂狗");
    }
}
```

<!-- endtab -->

<!-- tab Someone.java -->

```java
public class Someone implements Person {
    @Override
    public void feed(Cat cat) {
        System.out.println("其他人喂猫");
    }

    @Override
    public void feed(Dog dog) {
        System.out.println("其他人喂狗");
    }
}
```

<!-- endtab -->

<!-- tab Home.java -->

```java
public class Home {
    //声明一个集合对象用来存储元素对象
    private List<Animal> nodeList = new ArrayList<Animal>();

    //添加元素的功能
    public void add(Animal animal) {
        nodeList.add(animal);
    }

    public void action(Person person) {
        //遍历集合，获取每一个元素对象。让访问者访问每一个元素
        for (Animal animal : nodeList) {
            animal.accept(person);
        }
    }
}
```

<!-- endtab -->

{% endtabs %}

![](https://langwenchong.gitee.io/figure-bed/20211109201834.png)

**您可以点击下方链接获取上面教程所使用的代码,同时可以参考本篇博客完成homework03实验巩固学习😊**

{% link 设计模式代码仓库 , https://github.com/Langwenchong/DesignPattern %}