---
title: Java学习笔记-第九讲
comments: false
top: false
date: 2021-03-29 16:24:02
tags: [java]
categories: 
	- [个人笔记,Java基础]
---

记录翀翀🧐学习Java面向对象程序设计的核心笔记与思考，努力学习的过程，就像在黑屋子里洗衣服，你不知道洗干净没有，只能一遍一遍尽力去洗，等到了考场上那一刻，灯光亮了，你会发现，只要认真洗过，那件衣服就会光亮如新，愿你我都能够坚持学习。

<!-- more -->

#### TreeSet类

TreeSet类采用树状结构来存储数据，数据打印出来是有序的。当向TreeSet集合中加入一个对象时，会把它插入到有序的对象集合中，即按照一定的顺序规则进行元素的插入。

TreeSet支持两种排序方法：自然排序和自定义排序。默认情况下采用的是自然排序。

##### 自然排序

使用自然排序的TreeSet集合要求被排序的对象实现了Comparable接口的compareTo(Object o)方法才可以插入。其方法规则如下：

```java
public int x.compareTo(y){
    //比较的是存储单元
	x==y 返回0
   	x>y 返回正数
    x<y 返回负数
}
```

针对不同的变量类型，jdk类库中已经实现了Comparable接口的一些类，这些类可以不用手动实现Comparable接口即可直接使用：

|                    类                     |                             排序                             |
| :---------------------------------------: | :----------------------------------------------------------: |
| Byte、Double、Float、Integer、Long、Short |                       按照数字大小排序                       |
|                 Character                 |                 按照字符Unicode值的大小排序                  |
|                  String                   | 先比较长度，如果长度相等，按照字符串中第一个不同字符的Unicode值大小排序 |

其他的类型如Object和Entry等都是需要手动实现comparable接口并且显示声明根据哪一个成员变量来定义比较规则。

例如：

![](https://langwenchong.gitee.io/figure-bed/20210331194610.png)

我们在TreeSet中插入0,5,2,01这几个数，最终打印发现输入的是0,1,2,5。首先我们不难看出确实是按照排序规则打印输出的，其次我们发现1和01只存了一次，说明集合认为这两个元素是相同的，因此可知Java将01先进行了预处理为1，然后比较时发现已经存储过一次了，所以就只存储了一次1。

{% note info, 

一定要记住Java会对一些简单的变量先进行预处理，比如字符串的拼接，数字优化等。

%} 

![](https://langwenchong.gitee.io/figure-bed/20210331194948.png)

很明显这三个对象元素是不同的，因此这三个对象都存入集合，同时输出时是按照第一个字符串的大小排序规则进行输出的。

假设我们重定义了student类的equals()和compareTo()和hashCode()方法，都是比较第一个字符串成员变量：

```java
//一定要记住此时的student类重写了以下方法
@Override
	public int compareTo(Object o) {
		// TODO Auto-generated method stub
		if (o instanceof Student) {
			Student that = (Student) o;
            //重新修改为比较对象的第一个字符串成员变量的compareTo
			return this.id.compareTo(that.id);
		} else {
			return -1;
		}

	}

	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		//重写为比较id的hashCode，因此相同id的对象hashcode会相同
		return id.hashCode();
		// return name.hashCode();
		//return 0;
	}

	@Override
	public boolean equals(Object obj) {
		// TODO Auto-generated method stub
		if (obj instanceof Student) {
			Student that = (Student) obj;
            //修改为比较第一个字符串变量id的引用
			return that.id == this.id;
		} else {
			return false;
		}

	}
```

按未改变之前的情况下，每一个新创建的对象应该都是指向一个新的存储单元，因此下面的三个对象应该都能存储进去，但是，此时由于compareTo()重定义了为比较第一个字符串成员，因此set会将第一个对象和第三个对象看成是相同的，因此他们的字符串成员变量id相同即指向同一个存储单元，compareTo会返还true，即表示判断为相同。

![](https://langwenchong.gitee.io/figure-bed/20210331195201.png)

因此上面的集合set会只存两个对象。

{% note info, 

一定要注意当重新定义了compareTo()、equals()方法和hashCode()方法，必须保证compareTo()和equals()采用相同的比较规则来比较两个对象是否相等，并且保证当两个对象使用equals()方法比较结果为true时，这两个对象的hashCode()方法返还值相等。

%} 

#### Set集合类的遍历

我们有时候想输出Set中所有的元素，但是Set又不是数组，此时我们需要学习几种常用的遍历方法。

##### 方法1：先转换成数组

既然不是数组类型，那么我们就将其转换成数组即可，如下:

```java
Set set=new TreeSet();
set.add(new Integer(0));
int sum=0;
//注意这里的强制转换必须写
//并且强制转换的类型要和声明的类型相同
Integer[] list =(Integer[])set.toArray(new Integer[0]);
for(int i=0;i<list.length;i++){
    sum+=list[i];
}
```

我们需要说明，这种方法并不是最好的，但是可以作为参考。他是将set集合转成了数组，因此可以按照数组的形式进行遍历。但是我们发现此时必须显示声明要转成的数组类型，并且强换转换的语句必须写还要和声明类型相同。首先这种非常具体只针对某一个类型的编程方法不好，其次我们说过set是可以存储多种类型的数据的，显然，这种方法并不符合。

##### 方法2：对数据处理时再转换

这种方法也不好，但是也介绍一下，实际上和上面的方法类似，只是此时将强制数据类型转换的语句写到了对数据进行处理的地方。

```java
Set set=new TreeSet();
set.add(new Integer(0));
int sum=0;
Integer[] list =(Integer[])set.toArray();
for(int i=0;i<list.length;i++){
    sum+=(Integer)list[i];
}
```

这两种方法了解即可，我们后面会介绍更好的迭代器方法。

#### List接口

我们总结一下set类的用处，他一般是用来保存/统计不重复的对象元素的。比如：

- 判断一个文本有多少不同的字符
- 判断一个文本有多少不同字符单词、汉字
- 判断一个对象是否已经存在了

同时我们还可以借助TreeSet进行快速排序。但是Set类只能存储不同不重复的数据，并且排序只是他的一个附加功能，通常情况下Set的数据都是无需存储的。这明显不适用于一些需要按某种顺序存储可重复元素的情况。因此此时我们可以使用List类。

List的主要特征是按照元素以线性方式存储，允许集合中存放重复元素。List接口的主要实现类包括ArrayList和LinkedList两种。

ArrayList实际上和顺序线性表类似，是通过数组来存储元素的，他的优点就是随机查找很快（只要给出键值i，可以快速找到List[i]），可以进行快速的随机查找，但是向ArrayList中插入和删除元素的速度就较慢了。

而LinkedList就类似于链表，他的随机访问速度略慢，但是查找和删除元素就很快。如下图：

![](https://langwenchong.gitee.io/figure-bed/20210331200855.png)

每一个元素存储在一个存储块中，每一个存储块有一个指向下一个存储块的方法（注意不是指针，因为Java中没有指针概念）。那么很明显这种查找方式只能从前向后，速度慢，所以就有了双向链表形式。

![](https://langwenchong.gitee.io/figure-bed/20210331201057.png)

这种组合形式插入和删除的速度快，随机访问的速度略有增强，但是还是慢于ArrayList。他单独具有addFirst(),addLast(),getFirst(),getLast(),removeFirst(),removeLast()方法。

List中的对象按照索引位置排序，程序可以按照对象在集合中的索引位置来检索对象。比如：

```java
List list=new ArrayList();
list.add(new Integer(3));
list.add(new Integer(4));
list.add(new Integer(3));
list.add(new Integer(2));
for(int i=0;i<list.size();i++){
    System.out.print(list.get(i)+" ");//3,4,3,2
}
```

我们需要注意对于ArrayList虽然是通过数组实现的，但是毕竟不是数组，他在取列表的某个元素时需要使用list.get(int index)方法，并且同样的获取大小是使用list.size()方法。对于链表形式的列表我们也可以使用这个方法来获取元素。

因此List会保持原来加入时候的顺序来排列元素，同时List中可以存储重复的元素。同时我们还发现List本身并不具备排序的功能，但是Collection类是对Java集合类库的辅助类，他提供了操纵集合的各种静态方法。又因为List是Collection的子类

![](https://langwenchong.gitee.io/figure-bed/20210327104244.png)

因此List可以调用Collection.sort(List list)方法对List中的对象进行自然排序（也就是和TreeSet的排序规则相同）。同样对于无需的Set我们也可以调用Collection.sort(Set set)来对set进行自然规则的排序。

我们发现List下还有一个vector类，由于在Java中Vector类和ArrayList类几乎相同，并没有突出的性能，已经不提倡使用了。

我们发现相对于数组来说，ArrayList和TreeSet更加方便，可以以后尝试使用。

#### 迭代器Iterator

我们前面讲过迭代器遍历Coleection集合类实际上更加方便，这里我们来详细学习一下。首先我们先介绍一席不考虑泛型（后面会讲）的Iterator定义：

```java
public interface Iterator{
    boolean hasNext();
    Object next();
    void remove();
}
Public interface Coleection extends Iterable;
Public interface Iterable{
    Iterator iterator();
}
```

我们发现Collection接口继承了Iterable接口，因此Set，List都是可以使用迭代器进行遍历的。

##### 思考：Collection和Iterator接口的关系？

在Collection接口中声明了适用于java集合（只包括Set和List)的通用方法，因此Set和List对象可以调用以上方法，但是Map对象不可以。

而Iterator接口隐藏了底层集合的数据结构，向客户程序提供了遍历各种数据集合的统一接口，因此Iterator既可以用于Set和List的遍历，还可以用于Map等类的遍历。因此Iterator具有普适性。但是要注意Iterator只用于遍历，如果集合元素就没有排序，那么Iterator遍历集合中元素的顺序也是无序的。

##### Iterator遍历Set

常用的Set的遍历方法就是使用Iterator了：

```java
Set set = new TreeSet();
set.add(new Integer(0));
int sum=0;
Iterator it = set.iterator();
while(it.hasNext()){
    sum+=(Integer)it.next();
}
```

上面的方法就是使用Iterator进行Set的遍历，首先他需要实例化一个迭代器it并且声明它属于一个set集合，那么这个it就只用于遍历这个特定的set，同时it.hasNext()方法是检验是否还有下一个元素，有返回true,没有返回false。这里要注意Iterator.next()方法是将迭代器移动到下一个元素的位置，因此每调用一次Iterator.next()方法都会导致迭代器移动到下一个元素的位置，这很容易导致bug,如果要对某个下一个元素进行多次处理，最好先用一个临时变量存储以防出现多次调用next()方法而导致bug。

- 调用 it.next() 会返回迭代器的下一个元素，并且更新迭代器的状态。
- 调用 it.hasNext() 用于检测集合中是否还有元素。
- 调用 it.remove() 将迭代器返回的元素删除。

###### 思考：Iterator需要强制转换吗？

你可能会疑惑上面的Iterator方法不是也进行强制转换了吗？千万要注意这里的强转并不是Iterator必须的，而是因为sum统计求和需要Integer类型，因此才进行的强制转换。实际上Iterator不需要添加强制转换语句就可以遍历集合的所有不同类型的元素。

{% note info, 

一定要注意Iterator.Next()方法会在还有下一个元素的条件下返还下一个元素后直接使迭代器移动到下一个元素的位置。

%} 

我们分析一下下面出现错误的原因：

![](https://langwenchong.gitee.io/figure-bed/20210331205324.png)

实际上就是用多次调用next()方法导致的。首先我们在HashSet()中添加了1,2,3,4,5这五个数，然后通过下面的Iterator进行遍历。报错原因如下：

1. it实例化以后并不是直接指向1，而是一个空值，此时it.next()就是1
2. 因此在第一次执行sum求和后sum变成了1，因此打印sum结果为1，同时it移动到了1的位置处
3. 然后打印it.next()，因此此时打印1后面的元素2，然后因为此时有调用了next，因此此时it移动到了2的位置处
4. 然后while()判断发现2后面还有元素，因此此时再次进入循环
5. 再次sum求和加上2后面的元素3，因此打印sum结果为4，然后it移动到了元素3的位置处
6. 然后再次打印it.next()，因此此时打印的是3后面的元素4，然后it移动了元素4的位置
7. 然后再次while()判断发现4后面还有元素，因此再次进入循环
8. 执行sum求和加上4后面的元素5，因此打印sum结果为9，然后it移动到了元素5的位置
9. 此时注意5后面没有元素了，因此打印it.next()报错

我们发现上面的报错是因为迭代器不能再向后移动了因为后面没有元素了，这就说明hesNext()方法并没有保证next()方法安全调用，这是因为我们在一次hasNext()方法后进行了两次next()方法，显然特不能保证安全调用。其次输出和求和结果也和我我们预期的不同，这是因为每一次next()方法都会导致it一次后移，当我们要对一个元素进行多次操作时，需要先存储下来，以防出现上面的跳跃bug。即修改为：

![](https://langwenchong.gitee.io/figure-bed/20210331211518.png)

此时结果就正确了。然后我们再来说明一下Iterator自身并不具备排序功能，当他在遍历一个集合时，会按照集合的存储规则遍历：

![](https://langwenchong.gitee.io/figure-bed/20210331211721.png)

我们先在List中添加了“天津”和“大学”两个字符串，那么很明显List会按照插入的先后存入两个字符串，所以Iterator遍历List时也是先输出“天津”再输出“大学”。但是当我们是用Set存储时，他会按照Set的存储规则遍历输出：

![](https://langwenchong.gitee.io/figure-bed/20210331211953.png)

此时HashSet将“大学”排在了前面，因此Iterator遍历时先输出了“大学”。

当然还有一种迭代器的写法与for更加相似：

```java
//it被声明为String类型，并且属于Set集合
for(String it:Set){
	//迭代打印，当没有下一个元素自动退出for循环
	System.out.println(it);
}
```

#### Map(映射)

接下来我们再学习一下Map，Map集合中的每一个元素包含一对键对象和值对象，集合中没有重复的键对象，值对象可以重复。

![](https://langwenchong.gitee.io/figure-bed/20210331212252.png)

每一次向Map中使用Map.put()方法加入元素，加入元素时，必须提供一对键对象和值对象，Map有HashMap和TreeMap两类。实际上Map最基本的用法，就是类似于字典的功能，在Map中检索元素时，只要给出键对象，就会返还值对象：

```java
Map map=new HashMap();
map.put("1","Monday");
map.put("one","Monday");//值对象可以相同
map.put("1","HAHA");//会报错，因为已经有重复的键对象了
map.put("3","Wensday");
System.out.println(map.get("1"));//返还Monday
System.out.println(map.get("one"));//返还Monday
```

同样的我们也可以使用Iterator对Map进行遍历，在遍历时，我们需要先获得Map中的数据集合，这里有两个方法都可以获得Map的数据集合。

- Set.keySet()：返还键的集合来遍历
- Set.entrySet()：返还“键值对”的集合来遍历

我们来分别看一下两个不同方法的迭代方式：

这是一个统计语句中出现最高频率的单词的demo：

![](https://langwenchong.gitee.io/figure-bed/20210331213450.png)

我们在用String.split(" ")将单词存入word数组以后，使用map统计每一个单词的出现次数，其中单词是键对象，值对象是单词的出现次数。那么对于map中已经存在的键值，那么就说明这个单词是重复出现，只需要将次数+1即可，对于第一次出现的单词加入到map中并设置频率为1。统计完以后，我们遍历map，这里注意it的实例化语句，是map.keySet().iterator()，所以返还的是map中键对象的集合，所以it.next()是遍历的每一个键对象。

![](https://langwenchong.gitee.io/figure-bed/20210331213826.png)

而此时的情况是使用的map.entrySet().iterator()，所以返还的是键值对集合，此时it.next()遍历的时每一个键值对，因此首先我们需要先用entry存储每一个键值对，然后在使用entry.getKey()和entry.getValue()来分别获取一个键值对的键索引对象和值对象。

Map中的两大类HashMap和TreeMap的区别就是：

- HashMap按照哈希算法(根据键的哈希值）来存取键值对象
- TreeMap按照排序规则对keySet进行排序

{% note info, 

注意HashMap和TreeMap都会导致存入的元素不是按照存入的先后顺序排序，因此还有一种LinkedHashMap，他可以按照存入的先后顺序对元素进行排序。

%} 

无论是哪个，都是按照键进行一定规则的存储。这里我们来学习一下TreeMap的排序方法：

![](https://langwenchong.gitee.io/figure-bed/20210331214335.png)

我们发现再存入元素后，Map按照键的字符串大小排序规则进行了排列。

#### 泛型Generic

我们回忆一下之前遍历set集合的方法：

```java
//set存入的是字符串型1
set.add("1");
//转换成数组时要求转换成整型，这样才能存入新的数值0
Integer[] list=(Integer[]) set.toArray(new Integer(0));

//set转换成了对象类型
Object[] list =set.toArray();
//但是求和时需要为整型，因此要转换类型
sum=sum+(Integer)list[i];

Iterator it=set.iterator();
//同上
sum+=(Integer)it.next();

map.put("1",1);
//获取的it迭代器是键值对，不是字符串或者整型
Iterator it=map.keySet().iterator();
while(it.hasNext()){
    //因此获取键对象和值对象并转换成字符串型
	String key=(String)it.next();
	String value=(String)map.get(key);
}
```

我们发现上面的迭代并进行数据处理时，总是需要频繁的进行数据类型强制转换，但是这种强制转换只限于可以进行转换的情况，如果两个类型不能进行转换但是我们仍然加上了强制转换的语句也并不会被编译器检查错误，如下：

```java
Set set=new HahSet();
set.add(new StringBuffer("Mike"));
Iterator it =set.iterator();
while(it.hasNext()){
	String str=(String)it.hasNext();
    //两者不能转换，转换失败，但是不会被编译器检查出错误
    //编译时不会报错，运行时会抛出ClassCastException
    System.out.println(str);
}
```

对于这种bug异常，我们希望越早发现越好，从而提高软件的健壮性，因此为了做到这一点，在jdk中引入了泛型的概念，他可以把ClassCastException运行时异常转变为编译时类型不匹配的错误从而帮助我们在开发阶段阶段就发现错误。

实际上泛型和C中的模型很类似，声明方法也是在变量后面加上一个<>，内部声明一个数据类型。如下：

```java
//集合中元素必须为String
Set<String> set=new HashSet<String>();
set.add("Tony");//合法
set.add(new StringBuffer("Mike"));//编译错误，类型不匹配
```

上面的代码中我们使用了泛型，这样可以在插入数据时只能插入匹配类型的数据，从而增强安全性，同时泛型还可以在强制转换时帮助我们发现错误：

```java
//元素必须为String
List<String> list = new ArrayList<String>();
list.add("Tony");//合法
String name=list.get(0);//合法，无需强制类型转换
Object obj=list.get(0);//合法，允许向上转换类型
//编译出错，无法类型转换
StringBuffer sb=(StringBuffer)list.get(0);
```

上面的代码中我们使用泛型还可以保证强制转换仅在合法的情况下进行，对于非法的强制转换可以直接被编译器所发现，从而在开发阶段就帮助我们排查了错误。

当然我们也可以用泛型来实现和C中一劳永逸的模板开发模式，如下：

```java
public class MySet<T,K>{
	T t;
	K ok;
	public MySet(){
	}
	public void set(T t,K ok){
		this.t=t;
		this.ok=ok;
	}
	public T get_t(){
		return this.t;
	}
	public K get_k(){
		return this.k;
	}
}

MySet<String,Boolean> myset=new MySet<String,Boolean>();
```

上面的代码中我们用泛型创建了一个支持匹配T,K类型的MySet集合类，其中T和K是我们需要定义的数据类型。这样在开发中我们只需要修改下面的MySet的数据类型就可以动态改变所有MySet类的对象的数据类型匹配规则，高效并且还增强了软件的健壮性。例如：

```java
//map填充的数据必须是String-Integer形式的键值对元素
Map<String,Integer> map=new HashMap<String,Integer>();
//迭代器必须是String类型
Iterator<String> it=new map.keySet().iterator();
map.put("a",1);
while(it.hasNext()){
	String key=it.next();
	Integer value=map.get(key);
}

```

所以泛型的优点是帮助我们在开发时取消了强制转换（只允许向上转换），同时对于非法的强制转换在编译时就发现。