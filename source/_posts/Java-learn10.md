---
title: Java学习笔记-第十讲
comments: false
top: false
date: 2021-03-31 16:25:11
tags: [java]
categories: 
	- [个人笔记,Java基础]
---

记录翀翀🧐学习Java面向对象程序设计的核心笔记与思考，努力学习的过程，就像在黑屋子里洗衣服，你不知道洗干净没有，只能一遍一遍尽力去洗，等到了考场上那一刻，灯光亮了，你会发现，只要认真洗过，那件衣服就会光亮如新，愿你我都能够坚持学习。

<!-- more -->

#### 自定义Comparator的使用

在Java中有一个Comparator类可以用于对set,list等进行排序，他调用compare(x,y)方法来对set和list中的元素进行大小比较，比如：

![](https://langwenchong.gitee.io/figure-bed/20210403154156.png)

我们调用Collection.sort方法对list进行排序，由于list我们存储的是键值对，因此不是默认实现Comparable的元素，我们需要自己定义一个针对于键值对的排序方法，因此实例化一个新的Comparator类的实例对象，并且我们重写这个对象的比较方法compare，这里我们实现的是从大到小排序。

在java.util.Comparator\<Type\>接口提供的具体排序方法，\<Type\>指定被比较对象的类型，Comparator有个compare（Type x,Type y)方法，用于比较两个对象的大小。

compare(x,y)的返回值有三种情况：

- 返回值为0，那么就是x=y
- 返回值为<0，那么x<y
- 返回值>0，那么x>y

只有当返还的是>0的值时才会交换x和y的位置。

我们来分析一下上面的方法是如何实现从大到小降序排序的。正常来讲，默认的键值对比较方法应该是

```java
Collections.sort(list, new Comparator<Map.Entry<Character, Integer>>() {
    //比较arg0和arg1
			public int compare(Map.Entry<Character, Integer> arg0, Map.Entry<Character, Integer> arg1) {
                //此时arg0-arg1的返回值表示arg0和arg1的大小关系
				return arg0.getValue() - arg1.getValue();
			}
		});
```

很显然，此时是默认的升序，当arg0的值小于arg1的值时，那么返还的arg0.getValue() - arg1.getValue()确实是<0的，当arg0的值大于arg1的值时，那么返还的rg0.getValue() - arg1.getValue()确实是>0的。因此会实现升序的排序方法，但是当我们重写compare方法如下：

```java
Collections.sort(list, new Comparator<Map.Entry<Character, Integer>>() {
    //比较arg0和arg1
			public int compare(Map.Entry<Character, Integer> arg0, Map.Entry<Character, Integer> arg1) {
                //此时arg1-arg0的返回值表示arg0和arg1的大小关系
				return arg0.getValue() - arg1.getValue();
			}
		});
```

那么此时就是降序的了，因为此时当arg0<arg1时，返还的arg1.getValue() - arg0.getValue()是>0，因此会交换arg0和arg1的位置，也就是说大的值会排在前面，因此此时就是降序排序了，差一点只不过是交换了一下return的计算公式的参数。

{% note info, 

注意Entry表示的是键值对类型，通过重写compare函数和Comparator是对对象的排序，我们可以轻松实现对任意一个set，或者list或者map等数据结构的排序。但是一定要注意此时我们要声明泛型来定义传进的参数类型。

%} 

当然如果集合下的元素实现了comparable接口，那么可以直接使用compareTo()来进行排序，我们假设这里的student类还是重写了equals(),hashCode()和compareTo():

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

![](https://langwenchong.gitee.io/figure-bed/20210403155715.png)

此时我们调用的就是list.sort函数来实现排序，由于list.sort是使用compareTo()方法对对象进行比较，并且我们重写了compareTo()是比较id的引用存储单元是否相同，因此此时会按照id的升序排序如上图结果。

当然对于TreeSet集合类在插入时即可自动直接使用compareTo()进行排序：

![](https://langwenchong.gitee.io/figure-bed/20210403160358.png)

实际上上面的排序方法就是默认调用了comparable下的compareTo方法进行了自然排序规则的插入。因此我们可以总结一下排序的方法：

1. 如果对象实现了comparable接口，那么就可以直接使用compareTo方法进行排序

   ```java
   public interface Comparable<T>{
   	public int compareTo(T obj);
   }
   ```

2. 如果排序的对象未实现comparable或者我们要重写排序规则，那么需要自定义comparator的compare方法进行排序

   ```java
   public interface Comparator<T>{
   	int compare(T obj1,Tobj2);
   }
   ```

{% note info, 

注意对于一般我们常见的元素(整型，字符串等）都是默认实现了comparable的，但是obj和Entry等含有多个变量的类型数据需要我们手动实现comparable接口并且显示重定义compareTo(),hashCode()和equals()方法，通常我们使用comparator是为了重置排序规则（比如降序，或者按照某个特定的comparable元素进行排序等）。

%} 

##### 思考：Collections和Collection的区别？

我们注意到在使用自定义排序规则代码语句为：

```java
Collections.sort(obj.comparator);
```

但是我们学习的明明是Collection，那么Collections和Collection有什么区别？Collections才是几个类，而Collection只是集合类的上级接口，继承了Collection接口的主要由List类和Set类，同时List类和Set类还都是Collections的子类。因此我们在使用自定义comparator时的语句是：

```java
//传进一个对象和一个排序规则对象
Collections.sort(list,comparator);
```

即是调用了父类的方法对对象本身进行排序，同时传进去了一个自定义的排序规则对象。而当我们调用list自己的排序方法时就是使用

```java
//这里的obj是排序规则对象
list.sort(comparator);
```

#### 再谈==,equals(),hashCode()，compareTo()和comparator()

==方法永远比较的都是两个变量的引用是否相同即是否指向同一个存储单元。

而equals()在object中和连等功能相同，是比较两个对象的引用是否相同，而对于Integer,String等重定义为了比较内容是否相同。

hashCode()是根据一定的规则给出某个元素的一个存储关系以便款速查找（典型的就是HashSet的应用），由于hashCode()使用整数表示，因此一定会出现元素不同但是hashCode()相同的情况。还有就是必须保证hashCode()满足一个条件：当equals()返还true时，hashCode()返还的值必须相同，但是hashCode()返还值相同时，equals()可以是true也可以是false。当然hashCode要求传进来的参数是一个单一变量，对于含有多个成员变量的obj，需要显示声明根据具体的哪一个成员变量来返还HashCode。

compareTo()就是按照equals()规则比较元素大小，同样对于obj，需要显示声明根据具体的哪一个成员变量来进行大小比较。

comparator()就是直接进行数值计算来返还大小，同时返还值>0时交换两个元素的位置，对于复杂的含有多个变量的obj数据，同样需要自定义比较规则。

#### List/Set/Map总结

我们学习完成以后知道了List，Set都是Collections的子类，同时他们都实现了Collection接口，因此List和Set有许多相同的来自于Collection接口的方法：

![](https://langwenchong.gitee.io/figure-bed/20210403162531.png)

同时List还又增加了一些特有方法：

![](https://langwenchong.gitee.io/figure-bed/20210403162559.png)

而Map也是Collections的子类（实际上所有的存储集合类都属于Collections），他的特点是键值必须是唯一的，并且每一个元素是一个Entry键值对，当给出键对象时即可返还值对象，排序时默认是按照键对象进行比较排序，我们通常用map来进行频率统计。

![](https://langwenchong.gitee.io/figure-bed/20210403162831.png)

我们可以通过以下方法快速找到最大值对象所对应的键对象：

```java
Collection<Integer> coll = map.values();
int max = Collections.max(coll);
//一种更加简单的迭代器迭代方法
for (Map.Entry<String, Integer> it : map.entrySet()) {
    if (it.getValue() == max) {
        return it.getKey();
    }
}
```

我们发现上面的代码逻辑就是先将map的value对象存储到一个collection中，然后通过调用collections的max方法寻找最大值，最后在爆搜寻找对应的键对象。

- HashSet:如果集合中对象所属的类重新定义了equals()方法，那么这个类也必须重新定义hashCode()方法，并且保证当两个对象用equals()方法比较的结果为true时，这两个对象的hashCode()方法的返回值相等。
- HashMap:要求其中的key键对象又有HashSet的特点
- TreeSet:如果对集合中的元素进行自然排序，则要求对象所属类实现Comparable接口，并且保证这个类的compareTo()和quals()方法采用相同的比较规则来比较两个对象是否相等。
- TreeMap:要求其中的key键对象又有TreeSet的特点

#### 编程建议

总之为了增强程序的健壮性，在编写java程序时要养成以下的好习惯：

1. 如果java类重新定义了equals()方法，那么这个类也必须重新定义hashCode()方法，并且保证当两个对象用equals()方法比较的结果为true时，这两个对象的hashCode()方法的返回值必须相等。但是当hashCode()返还值相同时，equals()可以可能是返回false。
2. 如果java类实现了Comparable接口，那么就应该重新定义compareTo()、equals()方法和hashCode()方法（毕竟obj的比较规则我们需要自己定义），保证compareTo()和equals()采用相同的比较规则来比较两个对象是否相等，并且保证当两个对象使用equals()方法比较结果为true时，这两个对象的hashCode()方法返还值相等。
3. HashMap和HashSet具有较好的性能，是Map和Set的首选实现类，只有在排序的场合，才考虑使用TreeSet和TreeMap。LinkedKist和ArrayList各有优点，如果经常对元素进行插入和删除操作，那么使用LinkedList，如果经常随机访问元素，那么使用ArrayList。不要忘记LinkedHashSet可以按照插入的先后顺序对元素进行存储。

#### 思考几个小问题

> 如果定义了一个类，其hashCode()方法统一返回0，这个类在HashSet()中或者HashMap的key会发生什么现象？

首先肯定不会造成什么错误，只是会导致HashSet中的所有这个类的对象元素都存储一个线性表内，同样的HashMap中以这个类的对象为键的元素都会存储在一个线性表中，后果就是完全没有发挥hashCode()的分散快速查找的优点，使得查找方式又变回了顺序查找（和LinkedList一样），查找效率低。

> 如果定义了一个类，其hashCode()方法统一返回0，这个类在TreeSet()或者TreeMap的key，会发生什么现象？

没有任何影响，因为本身TreeSet或者TreeMap就是顺序查找。