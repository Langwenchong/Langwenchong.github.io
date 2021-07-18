---
title: Java学习笔记-第八讲
comments: false
top: false
date: 2021-03-26 16:22:53
tags: [note,Java]
categories: 
	- [学习笔记]
	- [编程语言,Java]
---

记录翀翀🧐学习Java面向对象程序设计的核心笔记与思考，努力学习的过程，就像在黑屋子里洗衣服，你不知道洗干净没有，只能一遍一遍尽力去洗，等到了考场上那一刻，灯光亮了，你会发现，只要认真洗过，那件衣服就会光亮如新，愿你我都能够坚持学习。

<!-- more -->

#### equals()函数

equals()函数时用来比较两个对象引用（即存储地址）是否相同，如果相同，则返回true否则返回false,他比较的是两个对象是否指向同一个存储单元。

我们来看一下不同类型的数据的equals()轮子函数：

##### Object默认实现

```java
//一般只要是属于对象类的equals函数默认都是这个实现：
//就是比较两个对象是否存储地址相同
public boolean equals(Object obj){
    return (this==obj);
}
```

##### Integer.equals实现

```java
//整数的equals覆盖了默认函数
//他是比较两个对象的value值是否相同（也是对象的比较）
public boolean equals(Object obj){
	if(obj instanceof Integer){
		return value==((Integer)obj).intValue();
	}
	return false;
}
```

##### String.equals实现

```java
public boolean equals(Object obj){
    //首先比较两个对象是否所有成员全部相同
	if(this==Obj){
        //如果相同，那么就不用比了，很明显字符串也想通
        return true;
    }
    //如果obj是String类
    if(obj instanceof String){
        //暂存这个字符串对象
        String anotherString=(String)obj;
        //获取自己存储的字符串长度
        int n=this.value.length;
        //如果长度相同，再逐位比较每一个字符是否相同
        //否则直接返回false
        if(n==anotherString.value.length){
            //将其分别存为字符数组形式
            char v1[]=value;
            char v2[]=anotherString.value;
            int i=0;
            while(n--!=0){
                //逐位比较
                if(v1[i]!=v2[i])
                    return false;
                i++;
            }
            return true;
        }
    }
    return false;
}
```

我们发现equals函数总是先比较两个对象是否完全相同，如果完全相同，那么可以看成是两个来自于同一地方的东西，即完全一样，因此就直接返还true了。如果不完全相同，那么再进行值的比较检验。

{% note info, 

equals()方法默认比较的是对象的地址值，但是Integer等基本类型包装类以及String类中已经重写了equals()方法，比较的是对象内存中的内容，返回值是boolean型，在java中==表示的是判断两个指向地址是否相同，即是否来自于同一个存储单元。因此只有Object类的equals默认的功能和连等相同都是比较存储地址单元，而其他类型equals一般比较的是内容，连等比较存储单元。

%} 

我们来看一个例子理解一下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210326202602.png)

上面的name1和name分别是通过实例化两个String类从而得到的两个不同的字符串对象指向变量，因此name1会指向一个存储内容为LiMing的对象的存储单元X，而name2会指向另一个存储内容为LiMing的对象的存储单元Y。所以虽然内容相同，但是由于两个变量引用指向了不同的存储单元，因此第一个判断返还了false,而第二个通过equals判断返还true就不难理解了，因为两个对象的状态完全相同，因此equals返还的是true。那么底下的该如何解释呢？下面的name3相当于指向了一个内容为LiMing的对象的存储单元Z，但是当再次使用String name4="Li"+"Ming"时首先java会进行简单的数据处理将其右边的值就处理为一个字符串“LiMing",然后他会现寻找是否一定有一个存储相同内容的对象的存储单元，如果有，那么就不会再次创建一个相同内容的对象（除非你是用new再次声明一个对象），而只是将这个引用指向已经存在的存储大院，所以此时name4引用会指向已经存储了LiMing的对象的存储单元，因此此时name3和name4实际上指向的是同一个存储单元Z。因此此时使用连等判断就会正确，当然equals也会正确。

#### getClass()函数

getClass()方法是final方法，因此不能够被重载，他返还一个对象在运行时所对应的类的表示，从而可以得到相应的信息。下面的方法借用getClass()得到并显示对象的所属类名：

```java
void PrintClassName(Object obj){
	System.out.println("The object's class is"+obj.getClass().getNmae());
}
```

#### toString()函数

toString()方法是用来返还对象的字符串表示，可以用来声明一个对象。例如：

```java
//显示当前的线程(通过字符串的方式显示)
System.out.println(Thread.currentThread().toString());
```

上面通过重载toString()方法可以适当地显示对象的信息进行调试。但是总的来说toString()函数就是用来将其他类型变量转换成字符串形式的。这里我们给出几种不同的其他数据类型（这里以double为例）与String互相转换的方法：

##### double转换成String

```java
double d=3.14159;
s=""+d;
s=Double.toString(d);
s=new Double(d).toString();
s=String.valueOf(d);
```

##### String转换成double

```java
String s="3.14159";
d=Double.parseDouble(s);
d=new Double(s).doubleValue();
d=Double.valueOf(s).doubleValue();
```

#### Math类

我们再来讲一讲Math类中的一些常用方法和成员：

```java
public final static double E;//数学常量e
public final static double PI;//圆周率常量
public static double abs(double a);//取绝对值
public static double exp(double a);//参数次幂
public static double floor(double a);//不大于参数的最大整数
public static double IEEEremainder(double f1,double f2);//求余
public static double log(double a);//自然对数
public static double max(double a,double b);//最大值
public static double min(float a,float b);//最小值
public static double random();//产生0和1（不含1）之间的随机数
public static double rint(double a);//四舍五入
public syayic sqrt(double a);//平方根
```

#### System类

当然System类也需要适当了解

```java
print static long currentTimeMillis();//取得当前毫秒
public static void gc();//强制垃圾回收(建议作用)
//将src数组从srcPos位置往后的长度为length的数据复制(覆盖)到dest数组的从destPos开始的位置
public void arraycopy(Object src,int srcPos,Object dest,int destPos,int length);
public static exit(int status);//系统退出
```

#### 字符串

在C语言中我们学过String表示字符串，在Java中我们略有变化。程序中用到的字符串可以分为两大类，一类是创建以后不会再做修改和变动的字符串常量，另一类是创建之后允许再做更改和变化的字符串。前者是String类，后者是StringBuffer/StringBuilder类。

在Java API中提供了四个处理字符数据的类：

- Character：这个类的实例可以容纳单一的字符数值，该类还定义了一些简洁的方法来操作或者检查单一字符数据
- String：这个类用于处理由多个字符组成的不可变数据
- StringBuffer：这个类用于存储和操作由多个字符组成的可变数据
- StringBuilder：这个类和StringBuffer很类似，只是两者在线程上有区别，后面会讲

##### Character类

就是char，Character(char)是Character类唯一的构造器，它创建一个字符对象，其中包含由参数提供的值，一旦创建了Character对象，它包含的值就不会改变了。

compareTo(Character)方法是比较两个字符对象包含的值，这个方法返回一个正数值，表示当前对象中的值和另一个对象包含的值的大小关系。大于1，小于-1，等于0。

equals(Object)方法比较当前对象包含的值与参数对象包含的值是否值相同，相同返回true。（一定要注意是比较两个对象的内容）。

toString()这个实例方法将此对象转换成字符串对象。

charValue()方法以原始char值的形式返回此字符对象包含的值。

当然他还有一些其他常用的函数，比如isUpperCase,isLowerCase,isWhitespace，以后用到时再查即可。

##### String类

使用字符串常量时，需要用String创建对象，他和其他对象不同，可以使用简单的赋值语句创建一个字符串String对象：

```java
String s="123";
//实际上就是在实例化一个String对象，等于
String s=new String("123");
```

所以s指向的是一个存储字符串对象的存储单元。这里也有几个常用函数：

length()获取一个字符串长度，注意有括号因为他是一个String对象的实例方法。注意在Java中获取数组的长度是length，没有括号。如：

```java
int[] arr={1,2,3,4,5};
int s=arr.length;
```

charAt()截取一个字符，这里我们要注意由于不同于C，java中String是一个类，所以不能使用获取数组某一个值的方式来获取一个，而是需要调用这个charAt方法来截取某个指定字符。如果想要像C一样那样截取字符串的某个指定字符，那么首先需要将String转换成char数组。

toCharArray()将String转换成char数组。这里我们来演示一下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210326211044.png)

equals()和equalsIgnoreCase()都是比较两个字符串的内容是否相同（前面讲过了比较引用要用==）。

regionMatches()用来比较一个字符串中特定区域与另一特定区域，他有一个重载的形式允许在比较重忽略大小写。

```java
//当前字符串从startIndex开始的后numChars位字符和dest字符串从destStartIndex开始后的字符进行比较
boolean regionMatches(int startIndex,String dest,int destStartIndex,int numChars);
//重载为忽略大小写
boolean regionMatches(boolean ignoreCase,int startIndex,String dest,int destStartIndex,int numChars);
```

startsWith()方法决定是否以特定字符串开始

endsWith()方法决定是否以特定字符串结束

indexOf()查找字符或者子串第一次出现的地方

lastIndexOf()查找字符或者子串最后一次出现的地方

substring()截取字符串的一部分，他有两种形式：

```java
//从startIndex以后全部截取都要
String substring(int startIndex);
//从startIndex到endIndex截取都要
String substring(int startIndex,int endIndex);
```

concat()连接两个字符串（完全可以使用+号直接拼接）

trim()去掉起始和结尾的空格

valueOf()转换为字符串

toLowerCase和toUpperCase不用多说

replaceAll(String regex,String raplacement)替换字符串指向

split(String regex)以regex为间隔符进行字符串拆分

##### StringBuffer类

使用StringBuffer()构造，可以参数为空，或者int型或者String。但是要注意StringBuffer必须用new方式构造。没有简单的类似于赋值形式的构造方法。

append()将括号里的某种数据插入原buffer中

charAt()返还指定字符

delete()移除特定的子串中的字符

deletecharAt()移除指定的字符

insert()将括号中的某种数据类型的变量插入到StringBuffer

##### 思考：String和StringBuffer的区别？

我们前面一直在讲String是一个不可变字符串，StringBuffer是一个可变字符串，那么到底是什么意思呢？实际上两者是针对于存储单元的修改问题而不同。我们前面已经讲过了String修改的一个细节问题（详见[《按引用传递》](https://wenchong.space/2021/03/16/Java-learn4/)）：

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

在上面的代码中最终str还是a，而buf会变成a+1，我们前面讲过这个问题，实际上对于s=s+"1"，并不是在s后面插入了一个字符1，而是在另一个存储单元又创建了一个新的字符串对象，其存储单元为X，然后这个新的字符串对象存储的内容时a+1，而原s指向的字符串对象在另一个存储单元Y中，他的值并不发生改变还是a。此时s的修改可以看成是将新的内容复制给了另一个新的对象，所以原存储单元存储的内容并未发生改变，其实我们可以看出String无论怎样操作原存储单元的内容都是不可以改变的，他总是将修改后得到的新内容存储到一个新的存储单元中，因此String是不可变字符串类。那么StringBuffer和String正相反，它就类似于C中的String，可以在原存储单元处对字符串内容进行直接修改，因此上面的代码中buf变为了a+1，这就是String和StringBuffer的区别。

##### 思考：两者修改内容的速度性能？

实际上我们可以看成String每一次修改都类似于搬家，他总是要先将原字符串内容赋值到一个新的存储单元，然后再在这个新的存储单元进行相应的修改，很明显这种创建新的存储单元再存储的速度肯定是要慢于StringBuffer的，毕竟StringBuffer是直接在原存储单元处修改。

##### 思考：StringBuffer和StringBuilder的区别？

两者的功能是一样的，都是可变字符串类，只是实现方式略有不同，StringBuffer是线程安全的，而StringBuilder更加追求速度，所以是线程非安全的。因此三个类的修改速度性能是：StringBuilder>StringBuffer>StringBuilder。

#### java集合类的分类

在java中有几种不同的存储数据的集合类，他们的存储结构不相同，具体可以分为下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210327104244.png)

即集合类有set和list,他们都是将数据存储到一个集合中，但是存储方式是不同的。set集合类又可以分为TreeSset类和HashSet类，而Liset类同样也可以分为LinkedList类，Vector类和ArrayList类。我们以后会逐一学习。同时还有一种不是以数据为单位存储而是以key-value键值对存储数据的数据结构即Map:

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210327104552.png)

其中也可以分为HashMap和TreeMap。

##### 思考：三种不同存储数据的集合类有什么区别？

Set类要求数据数据唯一存在并且允许无序存储，而List类允许数据不唯一即多个重复元素存在但是要求数据有序存储。Map是以键值对为单位存储，很明显键值是唯一的，所以键值要求唯一，后面的存储至可以重复。

#### Set(集)

Set是最简单的集合，这个集合的对象不按照特定的方式排序，并且没有重复的对象。Set接口主要有两个实现类：HashSet和TreeSet。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210327104911.png)

Set集合中存储的都是对象，并且没有重复的对象。Java中实现Set接口的类有很多，HashSet只是其中一种，他的构建形式：

```java
Set set=new HashSet();//多态(Set是HashSet的父类)
//当然，也可以这样写：
HashSet set =new HashSet();
```

这样我们就创建了一个集合对象，我们把它当做抽象的集合接口来看待。使用接口的好处在于，实现类可以被替换，而程序不需要做很多改动。下面我们来看一下如何使用Set:

```java
public static void main(String[] args){
    Set set=new HashSet();
    String str="我是天津大学一名学生";
    //转换成char数组方便后面取值
    char[] chars=str,toCharArray();
    for(int i=0;i<chars.length;i++){
        //注意此时会自动去重，即'学'只会存储一次
        set.add(chars[i]);
    }
    //注意set获取数量用size()方法
    System.out.println("不同字符数量"+set.size());//9
}
```

##### HashSet类

HashSet类继承于Set类，他有一些特有功能，他是按照哈希算法来存取集合中的对象，具有很好的存取和查找性能。在向集合中加入一个对象时，HashSet()会调用对象的hashCode()方法来获取一个哈希码，然后根据哈希码进一步计算出对象在集合中的位置。

HashSet类使用散列技术进行存储，就是把对象的哈希码直接用一个固定的公式计算，得出存储的方法。这样很容易快速命中搜索的目标。如下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210327110117.png)

上图是一个例子，加入HashSet使用模9来计算存储位置，那么26就会被放到8处，24会被放到6处，22会被放到4处，但是此时发现15模9的余数也是6，但是此时6单元格已经存储了24，此时会产生冲突，所以解决冲突的方法就是对于每一个地方都使用链表来存储，所以这就是一个线性表了，此时15就会存储到24后面，也就是说此时的存储方式是6标志单元格->存储24的单元格->存储15的单元格，因此6也会加到15的后面，所以6标志单元格->存储24的单元格->存储15的单元格->存储6的单元格。而其他没有存储数据的单元格就占用极少的空间，空间复杂度并不高，同时查找时就不需要用极慢的顺序查找了，而是使用模9运算查找，比如现在要查找15，那么模9后为6，只需要在6链表进行逐位的顺序查找，速度会快很多。所以上面的存储中，24,15,6的哈希码都是6,22的哈希码是4,26的哈希码是8，显然哈希码不同的值是不同的元素。

##### 使用hashcode的优点与缺陷？

前面的方法使用hashcode确实可以区分出不同的元素，这种方法避免了在比较两个值是否相同时多次使用顺序查找而降低性能，使用hashcode可以显著提升查找性能。但是他貌似有一个缺陷：

我们思考一下这种运行方式的前提：

1. 两个我们认同相同的对象其hashCode()必须相同
2. 如使用equals()比较时肯定是返还true的。

如果不满足上面的要求，那么就会看成是不同的元素。我们思考一下上面的判断意义，首先假如24和15，他们是不同的值，在set中首先比较hashcode是否相同，发现hashcode都是6，那么会再次比较用equals，equals默认查找的是Integer对象内容是否相同，发现不同，所以24和15是不同的元素。我们发现这种方法很容易出现hashcode相同的情况，你可能会认为是模9计算hashcode导致的多次出现相同hashcode的情况出现，确实，在实际hashcode计算方法中，一般是根据一个对象在jvm堆的地址来计算hashcode使得元素的hashcode尽可能不同，但是hashcode是int型，是一个有限集合，无论怎样计算都难以避免出现hashcode相同的情况，所以我们还要使用equals函数进行进一步的判断。但是貌似对于不同地址的内容相同的对象此种方法就会出现bug:

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210327113408.png)

假设我们现在想要存储两个内容相同的并且存储于不同内存单元的st1和st2，我们的本意是这两个元素是不同的，因为他们的存储地址并不相同仅仅是内容相同，我们通过上面的==也可以看出这两个对象却是来自于不同的存储单元，但是在存储到set时我们发现只存储了一次。原因就是此时两个对象的hashcode相同了，但是此时调用equals仍然返还的是true,因为他们的内容相同，因此set会把他们识别为相同的元素，因此只会存储一次未能达到我们的预期。为什么这两个字符串刚刚好哈希code相同呢？这就和Java中字符串哈希code的设置方法有关了，他是首位字符再加上33，因此这两字符串刚好哈希数总是相同。

{% note info, 

我们可以用一句话记忆hashSet的特点：Hashcode相同未必equals()返还true，但是equals()返还true那么必定HashCode相同。

%} 

所以我们可以总结出利用hashcode和equals来进行去重的set只允许存储equals()返还false的元素。hashCode相同但equals()返还false的元素只是位于同一个线性表（此时查找速度快）。