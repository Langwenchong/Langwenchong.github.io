---
title: Java学习笔记-第十四讲
comments: false
top: false
date: 2021-04-15 21:47:42
tags: [note,Java]
categories: 
	- [学习笔记]
	- [编程语言,Java]
---

记录翀翀🧐学习Java面向对象程序设计的核心笔记与思考，努力学习的过程，就像在黑屋子里洗衣服，你不知道洗干净没有，只能一遍一遍尽力去洗，等到了考场上那一刻，灯光亮了，你会发现，只要认真洗过，那件衣服就会光亮如新，愿你我都能够坚持学习。

<!-- more -->

#### 什么是Java反射reflect?

我们本次将要学习java的一个重要概念反射，他的作用是可以动态的创建一个类，动态的调用一个方法和检查一个类的所有方法。反射实际上并不是真正意义上的创建一个新的类，他仍然是使用提前声明好的类的方法来构造一个对象，但是此时我们可以随时转换参量名来创造属于不同类的对象。其灵活性更大，能够提高java代码编程的效率。

#### 动态调用无参构造函数创造对象

这里我们演示一下如何使用反射来创造一个对象，现在我们假设我们已经提前写好了两个java文件，两个文件位于同一个ch11下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210416090302.png)

Student.java文件中存储了我们提前写好的Student类：



```java
package ch11;

public class Student {
	private String name;
	private String school;
	private Integer age;
	private Integer id;
	public Student() {
		this("unset", 0);
		System.out.println("=============================");
	}
	public Student(String name, Integer id) {
		super();
		this.name = name;
		this.id = id;
	}
	
	

	public String getName() {
		return name;
	}

	@Override
	public String toString() {
		return "Student [name=" + name + ", id=" + id + "]";
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	public void sayHellow() {
		System.out.println("hellow my name is "+this.name);
	}
}
```

我们在Demo文件中动态创建一个obj:

```java
public class DynamicCreate01 {

	public static void main(String[] args) {
		try {
			// 要动态创建的类的全名
            //实际上引入的应该是路径
			String className = "ch11.Student";
            //动态创建clazz为Student类
			Class clazz = Class.forName(className);
			// 实例化，本例子要求"ch11.Student"必须有无参数的构造方法。
            //多态，构造了一个clazz对象，实际上就是Student的对象
			Object obj = clazz.newInstance();
			Student student = (Student) obj;
            //由于是学生对象，因此可以打招呼
			student.sayHello();
			System.out.println("obj.class=" + obj.getClass().toString());
			System.out.println("student.class=" + student.getClass().toString());
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}

}
```

最终的运行结果是：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210416090735.png)

我们发现此时动态的创建了一个student对象，但是区别于直接使用new Student()创建，而是使用了动态创建的方法，最终实现的实例化一个student。我们现在思考几个问题：

##### 思考：为什么要使用动态创建？

动态创建的好处是此时我们创建对象的构造方法和所属类并不是写死的，而是可以随时根据参数className变化更改。比如此时假设ch11下面还有一个Teacher类，那么此时如果我们还想创建一个老师对象，那么只需要将className更改为ch11.Teacher赋值给clazz即可：

```java
String className = "ch11.Teahcer";
//此时clazz绑定变成了Teacher类
Class clazz = Class.forName(className);
//实例化obj1为老师对象
Object obj1 = clazz.newInstance();
```

##### 思考：如何动态绑定一个类并实例化对象的？

我们这里使用了如下方法来动态的将clazz绑定一个类并创建对象的：

```java
//根据路径找到对应的类文件赋值给clazz
Class clazz = Class.forName(className);
//然后使用多态语句(引用为父类Object)初始化
//然而构造规则使用的是clazz绑定的类的
//newInstance()可以接受参数来构造对象
Object obj = clazz.newInstance();
```

##### 思考：为什么初始化要使用多态?

我们发现上面的代码中初始化并不是使用Student关键字，而是Object，原因是因为此时obj可能是任何一个类的对象，那么前面的关键字很明显不能写死，同时obj的指向引用还必须满足语法规则即引用是构造类的父类或者本身。因此此时使用Object最合适不过，因为Object类是所有类的父类，永远不会出现语法错误：

```java
//引用Object是所有类的父类
//因此这里也是clazz的父类，多态语法规则成立
Object obj=clazz.newInstance()
```

##### 思考：为什么obj可以强制转换为Student类的对象？

我们知道对于一般的父类对象是不能直接向下强转为子类对象的，因为可能出现父类对象没有子类特有的成员变量从而造成运行错误，但是这里确实可以进行强转的，原因是我们使用多态语句构造obj以后，obj虽然是Object的对象，但是他的初始化却是按照Student规则构造的（因为clazz是Student)。因此实际上此时obj是拥有Student要求的特有成员变量的，只是在直属于Object类下时暂时屏蔽了这部分特有成员变量，因此我们可以强转成功。因此我们也不难知道如果obj是直接使用new Object()构造时，那么就不能直接强转为Student类的对象了：

```java
//此时按照Object规则初始化
//因此不会拥有Student类特有的成员变量和方法
Object obj =new Object();
Student student =(Student) obj;//报错
```

{% note info, 

我们统一规定对于动态创建类时，参数使用clazz来表示。

%} 

当然我们也可以使用另一种形式的动态创建类的方法，代码如下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210416105933.png)

#### 动态调用含参构造函数创造对象

前面我们学习的都是无参构造对象，但是有时候我们需要传参创建对象，比如上面的实例中当我们不传参时没有名字因此sayHellow()时名字为unset。因此此时我们需要传参。下面就是动态调用传参构造对象的方法：’

```java
public class DynamicCreate03 {

	public static void main(String[] args) {
		try {
			String className = "ch11.Student";
			Class clazz = Class.forName(className);
			Class[] classes = new Class[2];
            //注意此时只是声明要传进的参数类型
			classes[0] = String.class;
			classes[1] = Integer.class;
			// clazz.getConstructor(classes) 寻找Student的带有参数的构造函数
			// 且构造函数的第一个是参数String,第二个是Integer。
			// .newInstance("tom", 123)： 用"tom", 123 实例化
			Object obj = clazz.getConstructor(classes).newInstance("tom", 123);
			Student student = (Student) obj;
			System.out.println("obj.class=" + obj.getClass().toString());
			System.out.println("student.class=" + student.getClass().toString());
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}

}
```

我们不难看出getConstructor()并不是要获取构造对象时传进的参数，而只是传参的类型，而newInstance(“Tom”，123)才传参。我们可以总结为：

1. getConstructor()只是确认要传参的类型
2. newInstance()是要传进的参数，并且传进的参数必须和getConstructor()中声明的参数类型保持一致

#### Java中不定长参数

有时候我们也无法确定要接受的参数是多长，因此需要使用...来表示，此时会将不定长的所有参数传进存储到一个数组中，如下：

```java
public class VariantParams {
	public static void main(String[] args) { 
		//asList事先并不知道要接受几个参数
		//那么传进几个就接受几个
		List<String> list =  asList("a", "b", "c");
		for(String str:list) {
			System.out.println(str);
		}
	}
	//...a会将虽有传进的参数存储到数组a中
	public static <T> List<T> asList(T... a) {
		//不定长参数 a是一个数组
		java.util.ArrayList<T> list = new ArrayList<T>();
		for (int i = 0; i < a.length; i++) {
			list.add(a[i]);
		}
		return list;
	}
}
```

#### 动态调用接受不定长参数构造方法创建对象

有时候一个Student，他的身高，名字，体重我们都设置了默认值，当构造一个student对象时，如果没有传进参数那么就是用默认值，但是如果传进了对应的参数就要覆盖默认值，那么我们可以根据传进的参数的长度不同调用不同的构造方法，此时我们就需要用到不定长参数来记录传进的对象成员变量：

```java
public class DynamicCreate04 {

	public static void main(String[] args) {
		try {
			String className = "ch11.Student";
			//用变长参数调用
			//要传进className,同时直接传参aaa名字和456值
			Object obj = createObject4(className, "aaa", 456);
			Student student = (Student) obj;
			System.out.println("obj.class=" + obj.getClass().toString());
			System.out.println("student.class=" + student.getClass().toString());

		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}
	//接受不定长参数，其中className显示存储到一个形参中，剩下的不定长参数都存储到values数组中并且类型为Object
	public static Object createObject4(String className, Object... values)
			throws ClassNotFoundException, InstantiationException, IllegalAccessException, IllegalArgumentException,
			InvocationTargetException, NoSuchMethodException, SecurityException {
		Class clazz = Class.forName(className);
		Class[] classes = new Class[values.length];
		for (int i = 0; i < classes.length; i++) {
			//获取每一个参数的类型
			classes[i] = values[i].getClass();
		}
		//此时classes中就动态存储 了values中参数对应的类型了，因此可以通过newInstance创建对象了
		Object obj = clazz.getConstructor(classes).newInstance(values);
		return obj;
	}

}
```

#### 动态调用无参数方法

前面我们学习的都是动态创建一个类，那么同样的我们也可以动态的调用方法，如下：

```java
public class DynamicInvoke01 {
	public static void main(String[] args) {
		//创建了一个Jack学生
		Student student = new Student("jack", 123);
		try {			
			System.out.println(dynamicInvokeMethod(student,"getName"));
			//动态调用getName()方法获取学生名字
			Object result=dynamicInvokeMethod(student, "getName");
			System.out.println(result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}

	//接受类名和方法名
	public static Object dynamicInvokeMethod(Object obj, String methodName) throws IllegalAccessException,
			InvocationTargetException, NoSuchMethodException, SecurityException {
		//动态调用方法，获取obj的所属类的methodName方法
		Method method = obj.getClass().getMethod(methodName);
		//记住这里必须这样写
		return method.invoke(obj);
	}

}
```

我们同样可以知道不同的方法返还不同类型的结果值，因此我们可以统一使用Object来定义动态调用方法最终返还的结果。同时我们注意最终的return语句，前面我们只是进行了方法的获取，最终还需要唤醒调用这个方法获得结果。

#### 动态调用含参数方法

前面的方法中我们只能动态调用无参方法来获取返还值，但是实际上有时候实例有一些需要传参的方法，此时我们可以如下使用：

```java
public class DynamicInvoke02 {
	public static void main(String[] args) {
		Student student = new Student("jack", 123);
		try {			
			//动态调用方法
			dynamicInvokeMethod (student, "setName", "tom");
			System.out.println(student.getName());
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}	 
	//接受对象名称，方法名称和参数，此时接受的参数就是String类型的tom
	public static Object dynamicInvokeMethod (Object obj, String methodName, Object... values)
			throws IllegalAccessException, IllegalArgumentException, InvocationTargetException, NoSuchMethodException,
			SecurityException, ClassNotFoundException {
		Class[] classes = new Class[values.length];
		for (int i = 0; i < values.length; i++) {
			classes[i] = values[i].getClass();
		}
		Method method = obj.getClass().getMethod(methodName, classes);
		return method.invoke(obj, values);
	}

}
```

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210416103811.png)

核心步骤用来判断并获取传进的参数的类型，然后存储到classes数组中。我们可以发现只是在getMethod()时也类似于动态创建类的getConstructor()一样传进了一个数组用来声明要传参的类型，然后invoke指定方法时传进参数而已，同样的，传进的参数要和getMathod()中classes数组中定义的参数类型相一致。

我们需要特别注意上面的这种getClass()方法获取数据类型仅限于传递数据类型（如String,Object,Arrays)。当时基本数据类型时，那我们需要显示的声明基本数据类型如下是一个动态调用含参数方法的例子：

```java
/**
 * 这个例子展示了如何动态调用带有原始数据类型的函数
 */
public class DynamicInvoke03 {
	public static void main(String[] args) {
		StudentPrime student = new StudentPrime("jack", 123);
		try {
			//此时传递的参数是int类型20，而不是String
			dynamicInvokeMethod1(student, "setAge", 20);
			dynamicInvokeMethod2(student, "setAge", 20);
			System.out.println(student.getAge());
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}

	/**
	 * 这个方法是错误的，无法调用原始数据类型的方法
	 */
	public static Object dynamicInvokeMethod1(Object obj, String methodName, Object... values)
			throws IllegalAccessException, IllegalArgumentException, InvocationTargetException, NoSuchMethodException,
			SecurityException, ClassNotFoundException {
		Class[] classes = new Class[values.length];
		for (int i = 0; i < values.length; i++) {
			//此时会运行错误，因此传递进来的参数不是引用类型，而是基本数据类型Int
			//此时getClass()无法正确回去int变量的类型
			classes[i] = values[i].getClass();
		}
		Method method = obj.getClass().getMethod(methodName, classes);
		return method.invoke(obj, values);
	}
	
	/**
	 * 这个方法可以调用包含int参数的方法
	 */
	public static Object dynamicInvokeMethod2(Object obj, String methodName, Object... values)
			throws IllegalAccessException, IllegalArgumentException, InvocationTargetException, NoSuchMethodException,
			SecurityException, ClassNotFoundException {
		Class[] classes = new Class[values.length];
		for (int i = 0; i < values.length; i++) {
			if (values[i] instanceof Integer) {
				//下面这两种写法都是正确的
				//对于基本数据类型例如Int我们只能自己显示声明参数类型
				classes[i] = Integer.TYPE;
				classes[i] = int.class;
			} else {
				classes[i] = values[i].getClass();
			}
		}
		Method method = obj.getClass().getMethod(methodName, classes);
		return method.invoke(obj, values);
	}

}
```

当然我们也可以全部自己显式声明传递进来的参数类型，但是无论如何基本数据类型只能使用显式声明，不能通过getClass()判断。其实很容易理解getClass()只是获取一个变量的原型类，但是基本数据类型并不是一个类的对象，因此自然无法用getClass()来判断。同时注意上面的代码中我们显式声明int类型时有两种方法：

1. int.class
2. Integer.TYPE

#### 动态调用属性

当然我们还可以动态获取一个属性名，例如：

```java
public class DynamicField {
	public static void main(String[] args) {
		Object obj = new StudentPublic("jack", 123);
		try {
			//传进的参数是name变量,我们要将其数值位tom
			dynamicField(obj, "name", "tom");
			//因此最终获取的getName()返回值是tom
			System.out.println(((StudentPublic) obj).getName());
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}
	public static void dynamicField(Object obj, String fieldName, Object value) throws IllegalAccessException,
			IllegalArgumentException, InvocationTargetException, NoSuchMethodException, SecurityException, NoSuchFieldException {
		//取得所有public类型的属性
		//获取到name属性
		Field field = obj.getClass().getField(fieldName);
		//直接设置属性值
		//设置obj的name属性的值为tom
		field.set(obj, value);
	}
}
```

{% note info, 

要注意只能取得public修饰的属性，private只能通过get()方法获取并使用set()方法修改

%} 