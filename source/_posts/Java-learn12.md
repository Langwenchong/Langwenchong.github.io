---
title: Java学习笔记-第十二讲
comments: false
top: false
date: 2021-04-09 16:28:01
tags: [java]
categories: 
	- [个人笔记,Java基础]
---

记录翀翀🧐学习Java面向对象程序设计的核心笔记与思考，努力学习的过程，就像在黑屋子里洗衣服，你不知道洗干净没有，只能一遍一遍尽力去洗，等到了考场上那一刻，灯光亮了，你会发现，只要认真洗过，那件衣服就会光亮如新，愿你我都能够坚持学习。

<!-- more -->

#### java中的线程

我们在[《操作系统》](https://coolchong.cn/2020/12/17/opsys-note4/)已经学习过线程的相关知识了，这里不再赘述。在java中我们之前所学习的程序的指令都是串行执行的，也就是每一条语句一次执行。但是有时候Java中会使用到线程来实现程序的指令并行执行。

因此我们这里来学习以下java中线程的相关知识。首先就是创建一个线程了，这里有两种实现方法。

##### 继承Thread类来创建线程

```java
public class TestThread1 {
	public static void main(String args[]) {
		Thread t = new MyThread1(100);
		t.start();
		System.out.println("Main thead end!");
	}
}

// MyThread是一个继承于Thread类的线程类
class MyThread1 extends Thread {
	private int n;

	public MyThread1(int n) {
		this.n = n;
	}

	public void run() {
        //这里写任务
		for (int i = 0; i < n; i++) {
			System.out.print(" " + i);
			if ((i + 1) % 20 == 0) {
				System.out.println("");
			}
			try {
				Thread.sleep(200);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
```

上面的代码中我们创建了一个接受参数的线程类MyThread，他的功能是按增序打印i，但是是每隔0.2s打印一个，我们通过实例化MyThread对象来创建了一个线程，因此我们可以将任务写在一个继承于Thread类的自定义类中，然后通过每次实例化这个自定义类来创建一个任务线程，这些线程之间是并行执行，但是对于一个任务线程来说，他的任务执行还是串行的。

{% note info, 

注意我们需要在run()方法中定义我们要多线程执行的特有任务，当这个线程对象start时会自动执行run()中的任务。

%} 

##### 向Thread()构造方法传递Runnable对象创建线程

我们可能并不想使用自己定义的线程类，而是还使用Thread类来创建任务线程，那么我们可以将自己定义的任务类直接实现Runnable接口从而使之可以传入Thread的构造方法来创建线程，如下：

```java
public class TestThread2 {
	public static void main(String args[]) {
		//先实例化任务对象
		MyThread2 mytask = new MyThread2(100);
		//由于实现了Runnable接口，因此可以传入Thread()来创建线程
		Thread t = new Thread(mytask);
		t.start();
	}
}

//MyThread2不是直接继承于Thread类而是实现了Runnable接口
class MyThread2 implements Runnable {
	private int n;
	public MyThread2(int n) {
		this.n = n;
	}
    //这里定义我们要执行的多线程任务
	public void run() {
		for (int i = 0; i < n; i++) {
			System.out.print(" " + i);
			if ((i + 1) % 20 == 0) {
				System.out.println("");
			}
			try {
				Thread.sleep(200);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
```

上面的代码中还是实现了每隔0.2s打印一个i的功能，但是创建线程的方法不同了。两个方法没有优劣之分，根据个人习惯使用。

{% note info, 

注意无论是继承于Thread还是实现Runnable接口的任务线程，最终启动线程方法的是调用start()方法，而不是run()方法，run方法只是含有线程特有的任务会在start后自动执行。

%} 

#### 多线程的应用

我们上面的代码示例中，只创建了一个线程，因此和直接执行没有什么区别，并没有体现出多线程执行任务的优点，下面我们以一道例题来了解多线程并行执行任务的优点。

```java
public class SumMain {

	// 这是一个计算从0加到1e10的求和程序，注意1e10超范围了需要开long
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		// 所开的线程数，当为1时就是通常下的单线程串行执行求和
		int threadCount = 100;
		// 最终结果，用double，否则会超范围
		double sum = 0;
		// 记录所有线程的运行时间之和
		long mill = System.currentTimeMillis();
		// 这里存储线程数组
		SumThread[] threads = new SumThread[threadCount];
		long start = 0;
		long end = 1000000000L;
		// 为每一个线程发布求和任务的范围
		for (int i = 0; i < threads.length; i++) {
			// 第i个线程需要求和的起始数值和结束数值
			long threadStart = start + (end - start) / threadCount * i;
			long threadEnd = start + (end - start) / threadCount * (i + 1);
			// 给Thread对象传进对应的求和任务(这个SumThread是我在另一个程序实现的自定义任务线程类)
            //实例化任务，这里使用的是第一种继承Threads来实现的创建线程
			threads[i] = new SumThread(threadStart, threadEnd);
			// 启动线程开始执行任务
			threads[i].start();
		}
		for (int i = 0; i < threads.length; i++) {
			try {
				// 等待每一个任务的执行结束
				threads[i].join();
				// 然后记录线程的返回值
				sum = sum + threads[i].getSum();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		// 输出任务所消耗的时间以及最终结果
		System.out.println((System.currentTimeMillis() - mill) + " ms cost!");
		System.out.println("sum=" + sum);

	}

}

```

上面是一个多线程求和的程序，如果我们就串行执行，那么线程数就是1，然后我们再分别使用10,50,100个线程去尝试运行这个程序，会发现，线程越多，并行执行求和的任务越多，相应的总执行时间就会越少，一下是1,10,50,100线程时的时间对比（注意，求和结果肯定是一样的）。

| 创建的线程数 | 程序执行时间 |
| :----------: | :----------: |
|      1       |    1199ms    |
|      10      |    180ms     |
|      50      |    168ms     |
|     100      |    164ms     |

我们发现确实线程越多执行效率越高，但是总运行时间并不是理想状态下的一值递减下去趋于0，而是到达一定的线程阈值后时间缩短的变化很小了。因此我们在使用多线程运行程序时，没有必要一味追求线程的多少，寻求一个空间和时间的平衡点最好。这里我们学习到了以下几个新知识：

- System.currentTimeMillis():记录程序的总运行时间
- threads[i].join()：等待线程的结束

{% note info, 

注意，这里的threads[i].join是在异常try-catch语句中执行的，因为很有可能线程不会正常停止，此时需要及时报告异常以便于我们发现错误点。

%} 

#### 用线程实现的“奇葩排序”

这里我们可以联想到一种很独特的排序方法，当然现实工程问题中不要使用：

```java
public class MySort extends Thread {
	private List<Integer> list;
	private int value;

	// 自己定义的排序，需要接受两个参数
	public MySort(List<Integer> list, int value) {
		this.list = list;
		this.value = value;
	}

	// 重写了runz执行的任务
	@Override
	public void run() {
		try {
			// 让线程阻塞value时间
			this.sleep(value);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		// 当线程唤醒后即阻塞了value后
		// list中加入这个value
		list.add(value);
	}

	public static void main(String[] args) {
		int[] arrays = { 1230, 571, 340, 454, 1, 30, 60, 300, 89, 1999, 765 };
		List<Integer> list = new ArrayList<Integer>();
		MySort[] threads = new MySort[arrays.length];
		// 创建对应数量的线程
		// 注意按照传进来的数值value来定义线程的阻塞时间
		for (int i = 0; i < arrays.length; i++) {
			threads[i] = new MySort(list, arrays[i]);
		}
		// 启动所有线程执行
		for (int i = 0; i < arrays.length; i++) {
			threads[i].start();
		}
		// 一定不要忘记最终等待所有的线程结束
		// 如果没有正常结束需要抛出异常
		// 否则这个线程会一直占用资源
		for (int i = 0; i < arrays.length; i++) {
			try {
				threads[i].join();
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		for (int i = 0; i < list.size(); i++) {
			System.out.print(list.get(i) + ",");
		}

	}
}
```

实际上上面的排序很好理解，假设有n个混序的不用大小的数值，那么我们可以创建n个线程，每一个线程都阻塞睡眠对应value的时间，先唤醒的线程就将睡眠时间的value值加入到list中，最终list就会存储的是一个升序的元素数值列表。我们想一想这种方法明显不合理，加入有一个数是1e20，那么就需要在1e20/10^3秒以后才排好序，这明显不现实。同时我们还需要注意我们并不能保证所有的线程同时启动，即使是上面的使用for循环逐一启动线程，也会有一定的时间差， 因此上面的排序程序中对于数值相近的数会随机排序，比如4在第一个线程，3在第200个线程，那么虽然第一个线程会阻塞4ms，第200个线程会阻塞3ms，但是由于第200个线程需要等待2ms，最终会导致4先于3加入到list中，从而导致未正常排序。这里我们主要是借此学习一下创建多个线程并同时启动，最终逐一调用join等待线程结束的使用。

#### Daemon线程和非Daemon线程

- Daemon线程：主程序终止，那么线程也终止
- 非Daemon线程：主程序终止，线程不终止，继续执行直至任务完成

我们可以使用setDaemon(Bolean x)来设置某个线程是否为Daemon线程，true是Daemon线程，下面我们来看一个例子。假设此时我们要在main中创建一个线程来每隔0.5s打印一个递增数值i，同时main程序在创建这个线程2s以后终止。假设此时这个线程是Daemon线程：

```java
public class TestThreadDaemon {
	public static void main(String args[]) {

		Thread t1 = new MyThread();
		// 此时t1是Daemon线程
		t1.setDaemon(true);
		t1.start();
		try {
			//main程序主线程阻塞2s
            //所以Thread表示主程序线程
			Thread.sleep(2000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//然后输出这句话以后主程序main线程终止
		System.out.println("main thread end");
	}
}

//每隔0.5s打印一个数的线程
class MyThread extends Thread {
	static int id = 0;

	MyThread() {
		id++;
	}

	public void run() {
		System.out.println("Start");
		//理论上打印完100个数才停止
		for (int i = 0; i < 100; i++) {
			System.out.println(i);
			try {
				//每次打印一个数以后阻塞0.5s
				Thread.sleep(500);
			} catch (InterruptedException e) {
			}
			// yield();
		}
	}
}
```

最终的结果必定是没有打印完100个数就停止了t1线程，所以运行结果如下图：

![](https://langwenchong.gitee.io/figure-bed/20210409204321.png)

那么对于非Daemon线程，当main终止以后，这个t1线程还会继续执行任务直至打印完这100个数（我们只需要将setDaemon()改为false即可）。最终的结果是：

![](https://langwenchong.gitee.io/figure-bed/20210409204455.png)

##### 思考：除了上面的使用非Daemon线程以外，还有什么方法可以使得100个数都打印出来？

首先我们要明确main会等待2s是因为我们设置了一个main线程阻塞2s的方法，因此我们可以选择将main线程多阻塞一段时间比如400s等，那么也是可以在main终止前保证t1打印100个数值的线程完成任务。或者我们可以使用前面刚刚学到的thread.join()方法让main等待t1执行完成以后在终止，如下：

```java
public class TestThreadDaemon {
	public static void main(String args[]) {

		Thread t1 = new MyThread();
		// 此时t1是Daemon线程
		t1.setDaemon(true);
		t1.start();
		try {
			// main程序等待t1执行完再终止
			t1.join();
			// 然后输出这句话以后主程序main线程终止
			System.out.println("main thread end");
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

// 每隔0.5s打印一个数的线程
class MyThread extends Thread {
	static int id = 0;

	MyThread() {
		id++;
	}

	public void run() {
		System.out.println("Start");
		// 理论上打印完100个数才停止
		for (int i = 0; i < 100; i++) {
			System.out.println(i);
			try {
				// 每次打印一个数以后阻塞0.5s
				Thread.sleep(500);
			} catch (InterruptedException e) {
			}
			// yield();
		}
	}
}
```

此时main会等待t1执行完成以后再终止，因此thread.join()方法经常会用到用来等待某一个线程的结束。

##### 思考：如果main函数什么也不加，创建完成以后就输出main thread end会怎样？

很明显如果t1此时是Daemon线程，那么main创建并启动t1线程以后就会立即结束，那么t1线程可能还来不及输出任何一个数就结束了。但是当一个线程没有显式声明为Daemon线程时，默认都是非Daemon线程，因此如果t1未显式声明为Daemon线程，那么即使此时main终止，t1还是会继续执行完任务。

#### 多线程访问冲突

这个问题很好理解，一般是涉及到了多个线程同时对一个临界资源访问修改导致的冲突异常。如下是一个典型的多线程访问的冲突问题：

我们假设此时要用两个线程对num对象的x和y值进行同时相加的操作，那么任一时刻x和y的值应该永远相同，因此我们每隔1s在main中检验x和y的值是否相同，以下是会造成多线程访问冲突的代码：

```java
class SyncCounter0 {
	public static void main(String[] args) {
		//注意只实例化了一个num对象
		Num num = new Num();
		//两个线程接收到的都是这个Num对象
		//因此两个线程是对同一个num对象的成员变量x和y进行修改
		Thread counter1 = new Counter(num);
		Thread counter2 = new Counter(num);
		//启动两个线程，肯定不是同时启动的，会有细微的时间差
		counter1.start();
		counter2.start();
		for (int i = 0; i < 10; i++) {
			//每隔0.1s查看一次x和y的值是否相同
			num.testEquals();
			try {
				//是通过阻塞main从而实现的每隔0.1s检查x和y的
				Thread.sleep(100);
			} catch (InterruptedException e) {
			}
		}
	}
}

//nam类
class Num {
	//有两个变量
	private int x = 0;
	private int y = 0;

	//同时相加，因此每一时刻两者都应该相等
	void increase() {
		x++;
		y++;
	}

	//检验方法
	void testEquals() {
		System.out.println(x + "," + y + " ：" + (x == y));
	}
}

//counter线程类
class Counter extends Thread {
	private Num num;

	//构造方法
	Counter(Num num) {
		this.num = num;
	}

	//对num对象的x和y不断更新值的任务
	public void run() {
		while (true) {
			//每隔0.1s进行一次x和y的相加
			num.increase();
			// num.testEquals();
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
			}
		}
	}
```

最终出现的结果是：

![](https://langwenchong.gitee.io/figure-bed/20210410105657.png)

我们发现起初x和y还是相等的，但是经过一段时间以后x和Y就出现了差值，并且y大于了x，原因是由于两个线程启动的时间有一个细微的时间差，所以此时两个线程不是同时对x和y进行加1操作的，线程2会晚于线程1访问x和y来修改值，因此起初x和y会正常更新值相等，但是一段时间以后的某一时刻线程1和线程2会出现同时访问x的情况，此时由于x只能被一个线程访问，所以两个线程出现了冲突，其中一个线程胜出对x和y进行了修改，而另一个线程未能抢到x,因此只对y进行了修改（当然也有可能两者出现y的冲突），最终造成了x小于了y。

我们发现这种冲突是不允许存在的，究其原因是两个线程同时对于一个传进的参数进行任务执行，由于两者同时需要访问临界资源，因此造成了冲突，因此我们需要避免这种冲突的发生，最好的方法就是当需要同时访问临界资源时多个线程排队等待，保证每一次只有一个线程对临街资源进行修改。因此我们引入了关键字synchronized，他可以用来修饰对象的方法或者对象的方法，保证需要访问临界资源的方法每次只能允许一个线程调用，这样就解决了多线程访问冲突的问题。

```java
synchronized void method();//锁加在对象的方法中
static synchronized void method();//锁加在类的方法中
```

因此此时我们修改上面的代码，将num的increase方法加锁，那么此时increase方法只能同时被一个线程调用，也就保证了x和y同时只能被一个线程进行修改，因此此时就避免了多线程冲突的问题：

```java
class Num
{
	private int x=0;
	private int y=0;
	//加锁
	synchronized void increase(){ 
		x++; 
		y++; 
	}
	//加锁
	synchronized void testEquals(){
		System.out.println( x + "," + y +" ：" + (x==y));
	}
}
```

此时在运行的结果是：

![](https://langwenchong.gitee.io/figure-bed/20210410110659.png)

x和y永远是一致的了。上面的代码中多线程冲突会造成两个数字最终的结果不同，这还只是小问题，更严重的是当多线程同时对堆栈等进行更新时如果发生冲突会发生严重的异常，如下：

我们此时假设有10个线程和一个临界资源栈，每一个线程会随机产生一个数，如果这个数>0.5，那么就会将这个线程放入栈中，否则从栈中弹出一个阻塞线程。那么此时如果我们不加锁，可预见必定会出现多个线程同时抢占栈中最后一个位置的冲突，以及多个线程同时想要弹出栈中最后一个元素的冲突：

```java
public class MyStackUserThread extends Thread {
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		// 一个栈实例，临界资源
		MyStack stack = new MyStack();
		// 创建10个线程
		int threadCount = 10;
		MyStackUserThread[] threads = new MyStackUserThread[threadCount];
		for (int i = 0; i < threads.length; i++) {
			// 10个线程接收到的都是同一个stack栈
			threads[i] = new MyStackUserThread(stack);
		}
		// 10个线程同时启动，实际上有细小的时间差
		for (int i = 0; i < threads.length; i++) {
			threads[i].start();
		}

	}

	private MyStack stack;

	MyStackUserThread(MyStack stack) {
		this.stack = stack;
	}

	@Override
	public void run() {
		// TODO Auto-generated method stub
		for (int i = 0; i < 100; i++) {
			if (Math.random() > 0.5) {
				// 当此线程产生的随机数>0.5,将自己这个线程放入
				System.out.println(Thread.currentThread().getName() + " push!");
				stack.push("test");
			} else {
				// 否则弹出栈中最近进入的线程
				System.out.println(Thread.currentThread().getName() + " pop!");
				stack.pop();
			}
		}
	}
}

//栈类
public class MyStack {
	//大小仅为1，因此只能存储一个线程
	private static int SIZE = 1;
	private int index = 0;
	private Object[] data = new Object[SIZE];

	//将元素压入栈中
	public boolean push(Object obj) {
		//当栈不是空的时候
		if (!this.isFull()) {
			dosth();
			//存入
			data[index++] = obj;
			return true;
		}
		return false;
	}

	//弹出元素
	public Object pop() {
		if (!this.isEmpty()) {
			dosth();
			return data[--index];
		}
		return null;
	}

	public void dosth() {
		try {
			//等待10ms
			Thread.sleep(10);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public boolean isFull() {
		return index >= SIZE;
	}

	public boolean isEmpty() {
		return index == 0;
	}
}
```

此时由于多个线程会同时访问栈进行压入元素或者弹出元素的操作，那么可能会造成栈已满却要继续压入元素，或者栈已空却还要弹出元素的异常，因此此时会抛出异常：

![](https://langwenchong.gitee.io/figure-bed/20210410111724.png)

因此我们需要对push()和pop()上锁从而保证每一次栈只会被一个线程访问进行更新操作，从而避免了多线程访问的冲突，如下：

```java
public synchronized boolean push(Object obj) {
		if (!this.isFull()) {
			dosth();
			data[index++] = obj;
			return true;
		}
		return false;
	}

	public synchronized Object pop() {
		if (!this.isEmpty()) {
			dosth();
			return data[--index];
		}
		return null;
	}
```

此时在运行就不会抛出异常了：

![](https://langwenchong.gitee.io/figure-bed/20210410111918.png)

##### 思考：synchronized是如何实现避免多线程访问的？

我们在学习OS时学到过PV互斥锁，实际上synchronized就是用来与对象的互斥锁联系的。每一个对象都会携带一个锁，当使用symchronized关键字修饰后，指定的方法就会成为一个上锁的临界区，每次只能允许一个线程进行调用。

#### synchronized造成的死锁现象

既然在OS中PV锁会造成死锁的出现，那么Java也不例外，当使用synchronized不正确时可能会造成代码逻辑上的死锁现象出现（[《死锁是什么》](https://coolchong.cn/2020/12/26/opsys-note10/)请看这里）：

假设此时有两个线程分别执行自己的任务方法，其中他们自己的方法都已经上锁了，如下代码：

```java
public class DeadLockTest {
	public static void main(String args[]) {
        //两个任务对象，都有自己的上锁的method方法
		Operator o1 = new Operator();
		Operator o2 = new Operator();

        //同时两个任务对象的anotherOperator是对方
		o1.anotherOperator = o2;
		o2.anotherOperator = o1;

		Thread t1 = new Thread(o1);
		Thread t2 = new Thread(o2);
		t1.start();
		t2.start();
		
	}
}

//任务对象
public class Operator implements Runnable {

    //存储的是另一个对象
	Operator anotherOperator;

    //注意是上锁的method
	synchronized public void methodA(int depth) {
		System.out.println(Thread.currentThread().getName() + ":begin methodA");
		if(depth<=0) {
			return;
		}
		try {
			 Thread.sleep(100);
		} catch (Exception e) {
		}
		System.out.println(Thread.currentThread().getName() + ":call another methodA");
        //尝试调用对方的method方法
		anotherOperator.methodA(--depth);
		System.out.println(Thread.currentThread().getName() + ":end methodA");
	}

	public void run() {
		methodA(1);
		
	}

}
```

此时上面的程序最终的输出结果是：

![](https://langwenchong.gitee.io/figure-bed/20210410113948.png)

出现这种情况的原因是两个线程都启动运行时，都会执行自己的method方法，因此此时线程1进入了自己的method方法，同时线程2进入自己的method方法，此时线程1想调用线程2的method(0)方法，线程2想调用线程1的method(0)方法。但是由于对方线程的method方法是加了锁的同时对方线程正在运行这个方法，因此两个线程都在同时等待对方先结束自己运行的任务，也就造成了线程1等待线程2，线程2等待线程1的死锁现象出现，此时就和OS中所讲的死锁问题一样了。

![](https://langwenchong.gitee.io/figure-bed/20210410114333.png)

在Java中不监测也不试图避免死锁情况，因而保证不发生死锁就成了程序员的责任。这里我们可以借鉴OS中的避免死锁的方法，控制锁的范围或者按序分配资源从而避免死锁现象的发生，当死锁出现时要能够抛出提示信息从而方便我们找到。具体的[《死锁预防和避免》](https://coolchong.cn/2020/12/26/opsys-note10/)请看这里。

#### 线程的状态和生命周期

在一个线程的生命周期中，他总处于某一个状态，线程的状态表示了线程正在进行的活动以及在这段时间内线程完成的任务。

![](https://langwenchong.gitee.io/figure-bed/20210410114637.png)

我们可以一个线程的状态细化为：

![](https://langwenchong.gitee.io/figure-bed/20210410114816.png)

其中在java中每一个线程状态都是一个枚举类型，我们可以通过一定的方法监视线程所处的状态，方法请参考：[《获取线程状态》](https://www.runoob.com/java/thread-status.html)

#### notify()和notifyAll()方法

有时候我们可以手动选择唤醒某个正在阻塞的线程，这里有如下两个方法：

```java
notify()//用来选择并唤醒等候进入监视器的线程
notifyAll()//用来唤醒所有等待的线程
```

但是我们要注意无论是哪种方法，只有获得锁以后，我们才有权利notify()等待的线程。

#### wait()方法

wait()方法使当前线程处于线程，知道别的线程调用notify()方法来唤醒当前线程。

#### 终止线程

有时候我们想要在线程任务完成之前终止这个线程，此时我们可以调用stop()方法来强制结束线程，但是由于这种方法是不安全的，因此目前stop()方法终止线程的策略已经废弃了。实际编程中，我们一般是定义一个标志变量，然后通过程序来改变标志变量的值，从而控制线程从run()方法中自然退出。如

```java
public class ThreadTerminateByFlag {
	public static void main(String args[]) {
		Timer timer = new Timer();
		Thread thread = new Thread( timer );
		thread.setName( "Timer" );
		thread.start();
		for( int i=0; i<100; i++ ){
			System.out.print("\r" + i );
			try{
				Thread.sleep(100);
			}catch( InterruptedException e ){}
		}
		timer.stopRun();
	}
}

class Timer implements Runnable {
	boolean flg = true;
	public void run() {
        //任务执行的前提是flg标志变量为true
		while(flg){
			System.out.print( "\r\t" + new Date() + "..." );
			try{
				Thread.sleep(1000);
			}catch( InterruptedException e ){}
		}
		System.out.println( "\n" + Thread.currentThread().getName() + " Stop" );
	}
	public void stopRun(){
        //通过改变flg来结束run的任务
        //从而使得线程自然终止退出
		flg = false;
	}
}
```

上面的终止线程的方法也可以实现与stop()类似的效果，并且这种方法无安全隐患，因此使用标志变量来终止线程是常用的策略。实际上这种方法是利用线程执行完任务自然结束的特点，只是我们使用标志变量让其成为任务能够执行的前提，当前提不满足是，任务也就自然停止了从而实现线程的自然终止。

#### 线程的优先级

我们知道对于一个多核cpu来说，他的线程同时运行的数量也是有一个最大上限的，因此必定会出现线程的排队，那么此时那些线程优先执行，就可以借用setPriority()来设置线程的优先级，我们可以自己设定优先级权值，也可以使用Java提供的优先级常量：

```java
Thread.setPriority(int num)//为线程设置优先级权值
MAX_PRIORITY//默认为10
NORM_PRIORITY//默认为5
MIN_PRIORITY//默认为1
```

如下图就是一个使用线程优先级的例子：

```java
public class TestThreadPriority {
	public static void main(String args[]) {
		Thread[] threads = new Thread[10];
		for (int i = 0; i < threads.length; i++) {
			threads[i] = new Thread(new MyRunner(i));
            //线程的编号为3的倍数的优先级最高
			if (i % 3 == 0) {
				threads[i].setPriority(Thread.MAX_PRIORITY);
			} else if (i % 3 == 1) {
				threads[i].setPriority(Thread.NORM_PRIORITY);
			} else {
				threads[i].setPriority(Thread.MIN_PRIORITY);
			}
		}
		for (int i = 0; i < threads.length; i++) {
			threads[i].start();
		}
	}
}

class MyRunner implements Runnable {
	int id;

	MyRunner(int id) {
		this.id = id;
	}

	public void run() {
		double t = 0;

		for (int j = 0; j < 100000000; j++) {
			t = t + j;
			// if (j % 100 == 0) {
			// Thread.currentThread().yield();
			// }
		}

		System.out.println(id + " finished!");
	}
}
```

最终的运行结果为：

![](https://langwenchong.gitee.io/figure-bed/20210410120641.png)

#### TimerTask计时任务

实际上TimerTask可以看成是js中的setTimeout和setInterval的结合体，他的原型是：

```java
Timer timer=new Timer();
timer.schedule(<任务>TimerTask方法，<开始执行时间>L,每次任务运行的间隔时间L);
```

因此我们不难看出TimerTask是一个无线循环执行的任务，除非我们使用flg等手动停止这个线程任务。他有两种写法：

##### 直接在timer.schedule()方法中定义任务

```java
public class TimerTaskDemo {

	public TimerTaskDemo() {
		// TODO Auto-generated constructor stub
	}

	// public static void main(String[] args) {
	// Timer timer = new Timer();
	// timer.schedule(new MyTimerTask(), 0, 1000L);
	// }

	public static void main(String[] args) {
        //先声明一个timer
		Timer timer = new Timer();
        //调用timer.schedule
        //直接在内部定义匿名类任务
        //10s以后每隔1s调用一次TimerTask
        //因此会每隔一秒打印一个数值i
		timer.schedule(new TimerTask() {
			int i = 0;

			public void run() {
				System.out.println(i++);
			}
		}, 10000L, 1000L);
	}
}
```

![](https://langwenchong.gitee.io/figure-bed/20210410122640.png)

实际上此时new TimerTask就是一个匿名类，这种实现方法很常见。

##### 定义类继承于TimerTask

```java
public class TimerTaskDemo2 extends  TimerTask {
	private int i=0;
	public TimerTaskDemo2() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		Timer timer = new Timer();
		timer.schedule(new TimerTaskDemo2(), 0, 1000L);
	}
	public void run() {
		System.out.println(i++);
	}
}
```

这个方法是将demo类继承于TimerTask从而使得一个timer.schedule可以调用main方法。

{% note info, 

注意两个代码实现的效果完全相同，并且时间单位是ms,时间后面要加上L。

%} 

#### ThreadLocal

ThreadLocal和Thread的不同之处就在于用此类实例化的线程对象之间的变量互不干扰，即每一个线程独享一个属于自己的变量。假设有1000个线程，那么我们肯定不能先创建1000个变量再传递给每一个线程，此时我们可以使用ThreadLocal来实现。如下：

```java
public class MyThreadLocal extends Thread {
    //一个MyThreadLocal线程对象的任务
	public void run() {
        //一个MyThreadLocal一共创建5个ThreadLocal线程
		for(int i=0;i<5;i++){
			try {
                //获取当前线程的名字
				Thread.currentThread().getName();
                //value值是线程名字+i
				String value=this.getName()+" "+i;
                //调用MyValue创建一个ThreadLocal并赋值value
                //因此这个MyValue对象自己拥有了一个value变量
				MyValue.getSession().set(value);
				Thread.sleep(1000);
                //输出所有的ThreaLocal接收到的value值
				MyFunction.print();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}			
		}
	}
	public static void main(String[] args) {
		for (int i = 0; i < 2; i++) {
            //创建了两个MyThraedLocal线程
            //注意MyThreadLocal是Thread的对象
			new MyThreadLocal().start();
		}
	}	
}

//MyValue是返还一个ThreadLocal对象
public class MyValue {
	private static final ThreadLocal<String> session = new ThreadLocal<String>();

	public static ThreadLocal<String> getSession() { 
		return session;
	}
}

public class MyFunction {
	public static void print() {
		System.out.println(MyValue.getSession().get());
	}
}
```

此时每一个Thread线程MyThreadValue各创建了5个ThreadLocal线程MyValue，同时这10个ThreadLocal线程MyValue接收到的变量value的值各不相同，同时注意虽然传递的都是value，但是此时ThreadLocal线程MyValue都会将这个value作为自己的一个变量，即各个ThreadLocal线程MyValue并不是共用一个value值，当某一个MyValue线程修改了value值并不会影响到其他的TheadLoacal线程的value值。

{% note info, 

我们可以简单的理解为每一个ThreadLocal会将接收到的参数存储到一个存储单元，只有自己指向这个存储变量。而Thread是会指向相同的存储变量的单元。这就是ThreadLocal和Thread的本质区别。

%} 