---
title: Java学习笔记-第十一讲
comments: false
top: false
date: 2021-04-01 16:26:39
tags: [note,Java]
categories: 
	- [学习笔记]
	- [编程语言,Java]
---

记录翀翀🧐学习Java面向对象程序设计的核心笔记与思考，努力学习的过程，就像在黑屋子里洗衣服，你不知道洗干净没有，只能一遍一遍尽力去洗，等到了考场上那一刻，灯光亮了，你会发现，只要认真洗过，那件衣服就会光亮如新，愿你我都能够坚持学习。

<!-- more -->

#### File类

在java中提供了文件管理的类，比如java类，他提供了若干个处理文件，目录和他们基本信息的方法。注意java中目录也是文件（file）,java中没有Directory类。File类的构造方法有三种形式：

```java
//直接给出一个打开的文件所在的路径
//注意这个路径的最后一级应为打开的文件名（需要后缀）
File(String pathName);
//父文件的名字(一般是路径形式）和子文件（即要打开的文件名字）
File(String parent,String child);
//或者父文件obj和子文件的名字
File(File paraent,String child);
```

现在，我们看几个实例：

```java
//先定义一个File类的实例obj
//注意如果是局部变量，一定要先初始化
File f=NULL;
//打开寻找到的Test.java文件
f=new File("Test.java");
//父文件为ex，然后在他的层级下打开Test.java
//注意父文件路径的后面的\\要写
f=new File("E:\\ex\\","Test.java");
//当然也可以这样写：
//先打开ex文件夹
//然后再打开Test.java
File path=new File("E:\\ex\\");
File f=new File(path,"Test.java")
```

{% note info, 

注意new File()是创建一个新的File类的实例来指向当前所要访问的文件，并不是创建新文件，而是创建一个指向要访问文件的指向对象。创建新文件是createNewFile()，创建新文件夹是mkdirs()。

%} 

#### File类方法介绍

关于文件/目录名操作

|            方法名称            |                           方法作用                           |
| :----------------------------: | :----------------------------------------------------------: |
|        String getName()        |                        获取文件的名称                        |
|        String getPath()        |                      返回定义时的路径名                      |
|    String getAbsolutePath()    |                        返回绝对路径名                        |
|       String getParent()       | 返回父文件夹的路径名，如果此路径名未命名为父目录，则返回null。 |
| boolean renameTo(File newName) |           重命名，当失败时返回false，成功返回true            |

关于File测试操作

|       方法名称        |                           方法作用                           |
| :-------------------: | :----------------------------------------------------------: |
|   boolean exists()    |                       返回文件是否存在                       |
|  boolean canWrite()   |                         文件是否可写                         |
|   boolean canRead()   |                         文件是否可读                         |
|   boolean isFile()    | 当且仅当此抽象路径名表示的文件存在且是一个标准文件时,返回true;否则返回false |
| boolean isDirectory() |                         是否是文件夹                         |
| boolean isAbsolute()  |                 检查此抽象路径名是否是绝对的                 |

关于常规的文件信息操作

|      方法名称       |        方法作用        |
| :-----------------: | :--------------------: |
| long lastModified() | 返回上次修改文件的时间 |
|    long length()    |      获取文件大小      |
|  boolean delete()   |        删除文件        |

关于目录操作

|    方法名称     |                           方法作用                           |
| :-------------: | :----------------------------------------------------------: |
| boolean mkdir() |                          创建文件夹                          |
| String[] list() | 以字符串数组的形式返回所有文件的名称，这些字符串以文件路径表示 |

我们用一个例题来熟悉一下上面的几个常用函数的使用方法：

```java
public class UseFile {
	public static void main(String args[]) throws Exception {
		// 创建目录
		File dir1 = new File("D:/dir1");
		if (!dir1.exists()) {

			dir1.mkdirs();
		}

		// 在某个目录下 创建目录
		File dir2 = new File(dir1, "dir2");
		if (!dir2.exists()) {
			dir2.mkdirs();
		}

		// 在某个目录下 创建多层目录
		File dir4 = new File(dir1, "dir3\\dir4");
		if (!dir4.exists())
			dir4.mkdirs();

		// 在某个目录下 创建文件
		File file = new File(dir2, "test.txt");
		if (!file.exists()) {
			file.createNewFile();
		}

		file = new File("D:/dir1/mytest.txt");
		if (!file.exists()) {
			file.createNewFile();
		}
		listDir(dir1);

		deleteDir(dir1);
	}

	/**
	 * 察看目录信息
	 * 
	 * @throws IOException
	 */
	public static void listDir(File dir) throws IOException {
		if (dir.isFile()) {
			System.out.println(
					"文件:" + dir.getCanonicalPath() + "  修改日期:" + new Date(dir.lastModified()) + " 大小:" + dir.length());
			return;
		}
		File[] lists = dir.listFiles();
		// 打印当前目录下包含的所有子目录和文件的详细信息
		for (int i = 0; i < lists.length; i++) {
			File f = lists[i];
			// 如果为目录，就递归调用listDir()方法
			System.out.println("目录:" + f.getCanonicalPath() + "  修改日期:" + new Date(f.lastModified()));
			listDir(f);

		}
	}

	/** 删除目录或文件，如果参数file代表目录，会删除当前目录以及目录下的所有内容 */
	public static void deleteDir(File file) {
		// 如果file代表文件，就删除该文件
		if (file.isFile()) {
			file.delete();
			return;
		}
		// 如果file代表目录，先删除目录下的所有子目录和文件
		File[] lists = file.listFiles();
		for (int i = 0; i < lists.length; i++) {
			deleteDir(lists[i]); // 递归删除当前目录下的所有子目录和文件
		}
		// 最后删除当前目录
		file.delete();
	}
}
```

上面的代码中，我们首先创建了几个文件层级关系如下：

```
---dir1--dir2--test.txt
	  |--dir3--dir4
	  |--mytext.txt
```

创建完成后我们进行了打印文件和删除文件的操作，最终的代码运行结果如下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210404135731.png)

由于创建文件时，我们都是先创建了文件实例f，然后检验f是否存在，如果不存在，那么就创建这个f实例。因此我们可以知道new File(String Filename)只是创建一个文件实例，无论其是否存在都是可以创建的，只是如果这个文件不存在，那么是无法输出信息的，所以后面我们会先检验是否存在，不存在那么在将这个文件f创建，因此new File()一定会成功创建一个File对象，只是如果这个对象访问的文件存在，那么这个f就可以直接使用，否则是一个空对象，我们需要先通过createFile()创建这个文件。其次我们发现打印文件时，只传进去了dir1，但是最终所有的dir1文件夹下的所有子文件都被打印出来了，这里就是使用的递归来实现的，这是输出文件夹下所有文件的一个常用方法。我们写了两个输出信息的语句，如果是文件夹，那么就不打印大小，如果是文件，那么还需要打印这个文件的大小。我们可以看出是使用isFile()函数来判断一个文件是不是文件夹的，当isFile()为false时说明是一个文件夹，同样的，这里我们也可以通过使用isDirectory()函数来实现。并且我们从上面的输出信息还可以理解递归的特点，就是不断深入，外层函数等待内层函数执行并返回后才会继续执行。比如上面我们首先打印了dir1的信息，然后dir1下有dir2和dir3以及mytest.txt，接下来我们递归调用了list(dir2)，然后打印dir2下的文件，我们发现dir2下的test.txt打印了两次，一次没有输出大小一次输出了大小，这是因为第一次输出是调用的for循环语句打印dir2的所有文件list[i]，因此没有输出大小，然后再次递归调用list(test.txt)，发现test.txt不是文件夹，因此第二次的打印信息是通过isFile()下的打印语句输出的test.txt,所以第二次打印包含了大小信息，之后这个list(test.txt)结束，返回到list(dir2)下，发现list(dir2)也打印完了，然后再返回到list(dir1)递归执行dir(3)。所以我们发现递归调用可以只接受一个参数就可以打印其层级下的所有文件并自动结束。同样的，在删除时，我们也要注意，需要递归调用由低层级逐渐向高层级删除文件，即dir2想要删除，首先需要删除dir2下的所有文件，只有dir2,dir3,mytest全部被删除以后再删除dir1，很显然，删除同样是递归实现的。

#### 输入流/输出流

大部分程序都需要输入/输出处理，比如从键盘读取数据、向屏幕中输出数据从文件中读或者写数据、在一个网络连接上进行读写操作等。在java中，把这些不同类型的输入，输出源抽象为流stream。按照流的方向，我们将其分为了输入流和输出流：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210404141313.png)

我们不难看出输入输出流是通过数据流实现的，这里的数据流流有两种形式：

|      | 字节流（Byte) | 字符流（Char) |
| :--: | :-----------: | :-----------: |
| 输入 |  InputStream  |    Reader     |
| 输出 | OutputStream  |    Writer     |

{% note info, 

一定要注意在java中字符是占两个字节，因此字节流和字符流是有区别的

%} 

所以对于字节流使用的是InputStream输入类和OutputStream输出流来实现的，而字符流是通过Reader和Write来实现的。

{% note info, 

注意要透彻理解输入和输出流是什么，实际上输入流和输出流是对两个源头文件的抽象定义，输入流实际上就是要将自己的数据传递出去的文件，他要将自己的数据输出到数据流缓冲区中，然后数据流滴抵达输出流位置进行输出，所以输出流实际上是接受数据的文件，数据流要将自己缓冲区存储的数据输出到输出流文件中。因此输入流和输出流的定义实际上都是以快递员--“数据流”的视角来定义的。自始至终只有数据流在实现传递，输入流只是一直在将自己的数据输入到数据流，而输出流也一直只是在接受数据流输出的数据。

%} 

#### InputStream类

InputStream类最重要的方法是读数据的read()方法。read()方法是逐字节地以二进制的原始方式读取数据，他有三种形式：

```java
public int read();//将输入流中数据一个一个字节读入
public int read(byte b[]);//将输入流的所有数据全部读入到字节数组b中
/*将输入流中最多 len 个数据字节读入字节数组。尝试读取多达 len 字节，但可能读取较少数量。以整数形式返回实际读取的字节数。*/
public int read(byte[b],int off,int len);
```

最后一个可能不好理解，其实就是如果我们定义了一次读len个字符，那么尽可能读len个字节然后存放到从off处开始的位置，但是假如最后剩余的可读的数据不满足len个了，只剩下k个了，那么就读k个，因此最终会返还一个数值num表示真正读取的数据大小num。所以这里我们可以将字节数组b视为一个数据流缓冲区，他来运送数据。

#### OutputStream类

OutputStream类的重要方法就是write()，他的功能是将字节写入输出流中，write同样也有三种形式:

```java
//注意没写错，此时的缓冲区用int，因为int是4字节，因此只取最低一个字节即可
public void write(int b)//将参数b的低位字节写入到输出流
public void write(byte b[])//将字节数组b[]中的全部字节顺序写入到输出流
//将字节数组b[]从off开始的len个字节写入到流中
public void write(byte[] b,int off,int len)
```

其实和上面的InputStream是对应着的，同时OutputStream还有另外两个重要的方法：

```java
public void flush()//清空缓冲区的数据
public void close()//关闭输出流停止写
```

flush()方法很重要，他是把还在缓冲区的数据强制输出进行写操作，而close很好理解，就是关闭输出流并清空数据流的缓冲区，停止写操作。每一次close之前都需要flush()以避免出现缓冲区的数据还未来得及输出写到输出流就被清空的Bug出现。我们可以通过此篇文章[《Java中flush()作用》](https://blog.csdn.net/lsx991947534/article/details/45065773)来透彻理解flush()的作用。所以我们可以理解为数据流是一个中间传递者，InputStream的read只是将使得数据流从输入流中读取数据，而OutputStream的write只是将数据流缓冲区的数据输出写到输出流中，但是每次close之前，可能缓冲区中有一部分数据还没有被输出写进输出流，因此需要先flush将其输出保证所有数据全部输出写进了输出流以后再关闭。下面我们看一个例子来学习一下字节流的读入写出操作：

```java
public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
            //将
			copyFile("D:\\course\\course\\code_demo\\src\\ch08\\src.txt",
					"D:\\course\\course\\code_demo\\src\\ch08\\target.txt");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

/**
	 * 复制文件
	 * 
	 * @param fsrc
	 * @param fdest
	 * @throws IOException
	 */
public static void copyFile(String fsrc, String fdest) throws IOException {
		InputStream in = null;
		OutputStream out = null;
		try {
			in = new FileInputStream(fsrc);
			out = new FileOutputStream(fdest, true);
			copyIO(in, out);
		} finally {
            //一定一定要记得关闭输入输出流
			close(in);
			close(out);
		}
	}

/**
	 * 复制IO流
	 * 
	 * @param in
	 * @param out
	 * @throws IOException
	 */
	public static void copyIO(InputStream in, OutputStream out) throws IOException {
        public static int CHUNK_SIZE = 4096;
		byte[] buf = new byte[CHUNK_SIZE];
		/**
		 * 从输入流读取内容并写入到另外一个流的典型方法
		 */
		int len = in.read(buf);
		while (len != -1) {
			out.write(buf, 0, len);
			len = in.read(buf);
		}
	}

/**
	 * 关闭一个输入 输出流
	 * 
	 * @param inout
	 */
	public static void close(Closeable inout) {
		if (inout != null) {
			try {
				inout.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
```

上面的代码实际上是完成了一个copy操作，他是将src.txt的内容全部复制到了target.txt中。我们来具体分析一下这个过程。首先main函数中调用了copyFile()函数，然后进入copyFile函数，copyFile()函数中定义了输入流和输出流的对象，并且要注意因为是局部变量，所以先初始化为Null,然后输入流指向了src.txt，输出流指向了target.txt，接下来我们要完成两个流文件之间的数据传递了，因此调用copyIO()函数，这里是数据传递的核新代码，首先我们看一下Buf数据流缓冲区的大小为(4096，注意一般都是1024的整数倍，这样读入的就是整数个字节了)，所以buf一次性最多只能读入16个字节。然后我们通过

```java
//in指向了输入流文件src.txt
//buf就是数据流缓冲区，扮演快递员身份
//len是本次读入的数据大小，未必是4096
int len=in.read(buf);
```

来进行输入流的数据读取，一般情况下，能读满就将buf填充满，因此一般情况下一次性读入了16个字节，然后当len!=-1说明buf读取了新的数据，然后通过

```java
//将buf从0位开始的长度为len数据输出写入输出流文件中
out.write(buf,0,len)
```

我么需要注意由于buf总是从低位开始读入数据，所以每一次新的数据肯定是从低位到高位排列的，因此输出数据进行写新数据时总是从0位开始一直输出len长度。当最后一次读取时，可能数据不够16个字节了，也就是256长了，那么此时len就是256了，此时out.write()就只是将0~255的数据（即最后一次读入的新数据）写进输出流文件即可，然后下一次in.read()由于没有新数据了因此返还len=-1退出while()循环，接下来就是关闭流了，自此我们通过读入写出操作完成了复制文件操作。

我们注意到在对in和out赋予文件指向时构造函数使用的不是InputStream和OutputStream而是FileInputStream和FileOutStream，这里一定要注意，构造函数的名称是有一点点不同的，前面都要加上File前缀，还有就是FileOutStream可以接受一个boolean值，true代表在文件的尾部写入新的数据，而false是直接用新数据覆盖输出流文件的旧数据。

##### 思考：当最后一次读数据为0\~255时，那么buf的256~4095存的是什么？

加入第k次级最后一次读的数据只有256长，那么buf的0\~255的旧数据会被新的第k次读取的新数据覆盖，因此存储的第k次读入的新数据，而256\~4096由于没有被覆盖，因此存储的还是上一次第k-1次级倒数第二次写入的数据。从第k次的视角来看，此时的256~4095实际上是无用的数据，是不能输出写的，因此如果读了这部分无效内容的操作称之为脏读，一般是禁止出现的。我们不难看出实际上buf很像滚动数组，只是每一次都是从最低位0位开始重新滚动而已。

##### 什么时候可能会触发脏读？

最典型的就是当最后一次buf只读入了256而未读满，那么此时256~4095就是脏数据，如果此时我们写入输出流的方法是out.write(buf)而不是out.write(buf,0,len)，那么很显然，我们脏读了，会导致文件数据错乱。

#### Reader类

前面我们讲的都是针对于数据流为字节流的形式，那么下面这两个就是以字符流为单位的。Reader类与InputStream类相似，都是输入流，但是差别在于Reader类读取的是字符（char),而不是字节（实际上就是两个字节为为单位）。

同样的也有三个常用的方法：

```java
//每次就读入一个字符
public int read();
//每次读入一个字符数组
public int read(char b[]);
public int read(char[] b,int off,int len);
```

#### Writer类

Writer类和OutputStream类相似，都是输出流，但差别在于Writer类写入的是字符（char)，而不是字节。Writer类的方法有点多：

```java
//将参数b的低两字节写入到输出流
//注意没写错，此时缓冲区用int就可以，因此char才2个字节
//所以只需要取b的低2字节即可
public void write(int b);
public void write(char b[]);
public void write(char b[],int off,int len);
//显然字符数组可以同样用字符串来代替
public void write(String s);
public void write(String s,int off,int len);
```

同样的Writer类也会有刷新数据流和关闭流的操作：

```java
public void flush();
public void close();
```

##### 思考：数据流的缓冲区一般可以用什么来表示？

这里我们不难总结出，当每一次是单位字节或单位字符传递时使用int是最好的，而对于一次传递多个时可以考虑使用buf数组来传递，但是要适当的调用方法避免脏读，还有就是特殊地字符数组也可以使用String。

同样我们来看一下使用的例子：

```java
public static void main(String[] args) {
		String s = "";
		try {
            //这里我们先全部读入
			s = readFile("D:\\course\\course\\code_demo\\src\\ch08\\src.txt");
		} catch (IOException e) {
			e.printStackTrace();
		}

		System.out.println(s);
		try {
            //在全部写出
			writeFile("D:\\course\\course\\code_demo\\src\\ch08\\target.txt", s);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

/**
	 * 注意readFile和readFile2等效
	 * 
	 * @param fsrc
	 * @return
	 * @throws IOException
	 */
	public static String readFile(String fsrc) throws IOException {
		// 这句话是否可以写成Reader reader ;为什么？
        //答案是不可以，因为局部变量需要初始化为null
		Reader reader = null;
		try {
			reader = new FileReader(fsrc);
			StringBuffer buf = new StringBuffer();
			char[] chars = new char[CHUNK_SIZE];
			int readed = reader.read(chars);
			// 从一个流里面读取内容的经典写法
			while (readed != -1) {
				// 文件是size不能被CHUNK_SIZE整除，所以要记录每次读到的长度readed
				// 写入到buf的时候，不是用的 buf.append(chars);
				// 而是用buf.append(chars, 0, readed);
                //原因是为了避免脏读
				buf.append(chars, 0, readed);
				readed = reader.read(chars);
			}
            //一定要记住在这里关闭输入流
            close(reader)
			return buf.toString();
		} finally {
			// reader!=null的判断是否可以取消，为什么？
            //实际上这里不能实现正常的输入流关闭
            //原因是当try执行完后就return函数了，不会执行这里
            //代码逻辑有Bug会导致无法正常关闭reader输入流
			if (reader != null) {
				reader.close();
			}
		}
	}

/**
	 * 从一个文件中读取字符串
	 * 
	 * @param fsrc
	 * @return
	 * @throws IOException
	 */
	//这种写法更好
	public static String readFile2(String fsrc) throws IOException {
        //没有Catch语句，也就是说异常抛给其他函数接受处理
		try (Reader reader = new FileReader(fsrc);) {
			StringBuffer buf = new StringBuffer();
			char[] chars = new char[CHUNK_SIZE];
			int readed = reader.read(chars);
			// 从一个流里面读取内容的经典写法
			while (readed != -1) {
				buf.append(chars, 0, readed);
				readed = reader.read(chars);
			}
            //一定要记住关闭输入流
            close(reader);
			return buf.toString();
		}
	}


/**
	 * 把字符串写到文件中
	 * 
	 * @param fileName
	 * @param content
	 * @throws IOException
	 */
	public static void writeFile(String fileName, String content) throws IOException {
        //注意，同样的构造函数有前缀File
        //并且此时boolean值是false说明是覆盖重写输出流文件
		try (OutputStream out = new FileOutputStream(fileName, false)) {
			out.write(content.getBytes());
            //好习惯
			out.flush();
            //一定要记住关闭输出流
            close(out);
		}

	}

	/**
	 * 关闭输入输入流
	 * 
	 * @param inout
	 */
	public static void close(Closeable inout) {
		if (inout != null) {
			try {
				inout.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
```

一定要注意字符流的写法中Reader和Writer的构造函数前缀也要加上File。并且还发现缓冲区的传递变量还可以使用StringBuffer从而做到一次全部读入和一次全部读出。

#### 关于关闭流的时间节点

我们观察上面的两个例子，发现正常关闭输入和输出流文件很重要，当在某些不合适的地方写关闭流会造成无法正常关闭的情况（比如上面的finnaly语句中的关闭reader永远执行不到）。因此我们这里规定：

- 输入和输出流必须实现Closable接口
- 必须在try里面申请输入和输出流同时结束后要记住关闭流

#### 节点流和处理流

按照流是否直接与特定的地方（如磁盘，内存，设备等）相连，分为节点流和处理流两类。

- 节点流（Node Stream)：可以从或向一个特定的地方（节点）读写数据，如文件流FIileReader。
- 处理流（Processing Stream)：是对一个已存在的流的链接和封装，通过所封装的流的功能调用实现数据读、写功能。处理流又称为过滤流，如缓冲处理流BufferedReader。

所以我们知道处理流实际上并不是一个新定义的流，只是对于一个已经存在的流的封装。节点流和处理流的关系如下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210404165634.png)

节点流是直接可以接收数据helloworld(上图中不难看出是字符流)，但是处理流，确实将这个节点流封装了，我们使用时需要调用封装好的readLine()才能使用这个节点流的read()。所以节点流与节点（或文件）直接相连，而处理流对节点流或其他处理流进一步进行处理（如缓冲以平衡读写速度，封装成对象方便使用等等），总之处理流是有必要的。

所以处理流的构造方法肯定是需要传进一个其他的流（注意是其他的流，也就是说既可以是节点流，也可以是处理流）作为参数。如：

```java
//直接封装节点流FileReader
BufferedReader in=new BufferedReader(new FileReader(file));
//封装了一个处理流InputstReadraeder
//处理流InputstReadraeder有封装了节点流FileReader
BufferedReader in2=new BufferedReader(InputstReamreader(new FileInputStream(file)));
```

当一个流对象经过其他流的多次包装，那么就成为流的链接。

常用的节点流有：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210404170331.png)

常用的处理流有：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210404170359.png)

我们来看一下节点流的构造方法：

```java
public class NodeStreamVSProcessingStream {

	public static void main(String[] args) {
		try {
			// 节点流 可以直接根据一个目标构造 
			FileInputStream fin = new FileInputStream("D:/temp/1.txt");
			FileOutputStream fout = new FileOutputStream("D:/temp/1.txt");
			ByteArrayInputStream bin = new ByteArrayInputStream("hellow".getBytes());
			FileReader freader = new FileReader("D:/temp/1.txt");
			FileWriter fwriter = new FileWriter("D:/temp/1.txt");
			// 处理流必须依托已经存在的流构造，一般作用是对已有流做一些功能上的增强
			ObjectInputStream oin = new ObjectInputStream(fin);
			ObjectOutputStream oout = new ObjectOutputStream(fout);
			LineNumberReader lin=new LineNumberReader(freader);
			//这里的代码不规范，流打开了没有关闭,记得关闭
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
```

实际上就和前面学习的差不多，因为一般情况下我们都是直接对一个文件节点进行操作，所以一般我们构造的都是节点流对象，当然处理流的使用也很重要。比如：

```java
public static void main(String[] args) {

		try {
            //列表的使用，使用泛型增强代码健壮性
			List<String> lines = readLines("D:\\course\\course\\code_demo\\src\\ch08\\XiaoHe.ini");
            //迭代器简写形式
			for (String line : lines) {
				System.out.println(line);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 从一个文本文件中，一次读取一行，放到list中
	 * 
	 * @param fsrc
	 * @return
	 * @throws IOException
	 */
	public static List<String> readLines(String fsrc) throws IOException {
		try (Reader reader = new FileReader(fsrc); 
				//LineNumberReader 必须在其他流基础上构建
             //这里我们使用的实际上是LineNumberReader
             //但是首先需要有一个节点流
				LineNumberReader lineReader = new LineNumberReader(reader);) {
			String line = "";
			List<String> lines = new ArrayList<String>();
			while (line != null) {
				lines.add(line);
				//每次读取一行
				line = lineReader.readLine();
			}
            //记得关闭输入流
            reader.close();
			return lines;
		}
	}
```

上面就是一个处理流的按行读入的方法，他的功能是按txt文件的行读取数据，每一次只读一行数据，适用读取存储的是列表形式数据的txt文件。我们当然也可以选择还是用传统的方法使用StringBuffer一次性读入所有行的内容，然后再使用split()分割获得每一行的数据，但是要注意此时的切割应该是按照两个字符切割：是回车\r和换行\n，小细节要注意，所以最终应该使用split("[\r,\n]")来实现。因此按行读入还是使用处理流的readline()方法更好。例如：

```java
//这是一个已经封装了按行读入的处理流，直接使用即可
BufferedReader in = new BufferedReader(new FileReader(fileName));
String line;
//一次只读一行
while ((line = in.readLine()) != null){
    //对每一行读入的数据的操作
}
```

#### System的标准输入和输出

我们经常用的System的输入输出方法实际上也是输入输出流的使用，System.out实际上是PrintStream类型，而System.in是InputStream类型，System.err（System.err是标准错误输出,也是输出的一种类型）是PrintStream类型。因此都是字节流。

System.out/System.err的println/print方法中println是将参数输出并换行，而print是将方法参数输出但不换行。print和println方法针对多数数据类型都进行了重写，例如Boolean,char,int,long,float,double以及char[],Object和String等。print(Object)和println(Object)方法中调用了参数的toString()方法，再将生成的字符串输出。

为了使用方便，一般会将标准读入数据的System.in用各种处理流进行封装，比如：

```java
BufferedReader br=new BufferedReader(new InputStreamReader(System.in));
br.readLine();//实现按行读入
```

#### 文件的随机访问RandomAccessFile类

RandomAccessFile，可以实现对文件的随机读写操作，比如：

```java
//实例化一个随机访问对象，mode是可选选项
RandomAccessFile(String name,String mode);
RandomAccessFile(File f,String mode);
```

而常用的访问方式有：

|   方法名和返回类型    |                  说明                   |
| :-------------------: | :-------------------------------------: |
| boolean readBoolean() |       从文件中读取一个 boolean 值       |
|    byte readByte()    |     从文件中读取一个带符号位的字节      |
|    char readChar()    |          从文件中读取一个字符           |
|     int readlnt()     |     从文件中读取一个带符号位的整数      |
|   String readLine()   |         从文件中读取下一行文本          |
|  void seek(long pos)  |   指定从文件起始位置开始的指针偏移量    |
| void writeByte(int v) | 以单字节的形式向文件中写入一个 byte 值  |
| void writeChar(int v) | 以双字节的形式向文件中写入一个 char 值  |
| void skipBytes(int n) | 以当前文件指针位置为起始点，跳过 n 字节 |

#### 命令行参数

我们在启动java应用程序时可以一次性的项应用程序中传递多个参数，这些参数称为命令参数。其格式如下：

```java
java ClassName lis "bily" "Mr.Brown"
```

最终命令行参数会被系统以String数组的方式传递给应用程序中的main方法，由参数args来接收。所以main函数的接收参数类型是：

```java
public static void main(String[] args);
```

因此上面的代码执行完成后就会在main的args[]中存储了这两个字符串名称，我们就可以通过调用args[0]或者args[1]来获取传进来的参数。

#### 正则表达式

正则表达式是文本处理的常用工具，他可以用来匹配符合条件的字符串文本。规则是：

| 字符  |         含义         |                             描述                             |
| :---: | :------------------: | :----------------------------------------------------------: |
|   .   | 代表一个字符的通配符 |                能和回车符之外的任何字符相匹配                |
|  []   |        字符集        | 能和括号内的任何一个字符相匹配。方括号内也可以表示一个范围，用"-"符号将起始和末尾字符区分开来，例如[0-9]匹配的就是任意一个0-9的字符 |
| \[^\] |     排斥性字符集     |                    和集合外的任意字符匹配                    |
|   ^   |       起始位置       |                 定位到一行的起始处并向后匹配                 |
|   $   |       结束位置       |                 定位到一行的结尾处并向前匹配                 |
|  ()   |          组          |                     按照子表达式进行分组                     |
|   ▏   |          或          |                或关系的逻辑，通常和组结合使用                |
|  \\   |         转义         | 匹配反斜线符号之后的字符，所以可以匹配一些特殊符号，例如$和▏ |
|   *   |      零个或多个      |              匹配表达式首项字符的零个或多个副本              |
|   +   |      一个或多个      |              匹配表达式首相字符的一个或多个副本              |
|   ?   |      零个或一个      |              匹配表达式首项字符的一个或零个副本              |
|   n   |         重复         |                 匹配表达式首相字符的n个副本                  |

其中还有几个简写形式：

```
\d表示数字，相当于[0-9]
\D表示非数字，相当于[^0-9]
\s表示空白符，相当于[\t\n\x0B\f\r]
\S表示非空白符，相当于[^\s]
\w表示单词字符，相当于[a-zA-Z_0-9]
\W表示非单词字符，相当于[^\w]
```

```java
public class RegExpDemo {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		findEmail( );
		testTels();
		splitContent();
	}

	public static void testTels( ) {
		testTel("13820477575");
		testTel("123456");
	}
	private static void testTel(String content) {
        //匹配规则是11为的0-9数字
		boolean match=content.matches("[0-9]{11}");
		System.out.println(content +(match?" ":" 不")+"是合法的电话号码");
	}

	public static void findEmail( ) {
		String content = "天外天技术支持：cs@tju.edu.cn  联系我们：1234567890@qq.com 地址：天津市南开区";
        //匹配规则是若干个字符+@+若干个字符+.+若干个字符
		String telReg = "\\w+@\\w+.[\\w+]+";
		Pattern telPattern = Pattern.compile(telReg);

		Matcher m = telPattern.matcher(content);
		while (m.find()) {
			System.out.println(m.group(0));
		}
	}
	public static void splitContent() {
		String content=" 第一回 甄士隐梦幻识通灵 贾雨村风尘怀闺秀 ... 第二回 贾夫人仙逝扬州城 冷子兴演说荣国府 ... 第三回 托内兄如海酬训教 接外孙贾母惜孤女 ....";
        //匹配规则是任意的数组内的1-3个字符的组合形成的章回数
		String contents[] = content.split("第[一,二,三,四,五,六,七,八,九,十,零]{1,3}回 ");
		for(String title:contents) {
			System.out.println(title);
		}
	}
}

```
