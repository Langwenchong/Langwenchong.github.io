---
title: Java学习笔记-第十三讲
comments: false
top: false
date: 2021-04-11 16:20:15
tags: [Java]
categories: 编程语言
---

记录翀翀🧐学习Java面向对象程序设计的核心笔记与思考，努力学习的过程，就像在黑屋子里洗衣服，你不知道洗干净没有，只能一遍一遍尽力去洗，等到了考场上那一刻，灯光亮了，你会发现，只要认真洗过，那件衣服就会光亮如新，愿你我都能够坚持学习。

<!-- more -->

#### Java通信之Socket通信

Socket通信是一种广泛应用的通信方式，他可以通过java实现，这里我们详细学习一下。首先我们要知道Socket编程是一种端到端的通信，他是在客户端和服务端两个端程序中通过socket建立连接来进行实时的数据通信的。我们查看sokcet英文翻译有插头的意思，因此我们可以理解为两个端程序个拥有一个socket插头，他们通过插头将通信数据放到管道上然后实现数据交换，因此socket承担了数据通信，类似于“桥梁”的作用，这里我们以一张图来说明：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210415170729.png)

因此我们不难看出Serever服务端运行着一个连接请求监视器，永远是客户端发起连接请求，然后服务端发现连接请求后相应和Client建立通信管道，然后双方开始进行数据通信，其中socket承担着“入口”和“桥梁”的作用，来传送数据流。如下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210415170934.png)

对于客户端，他的输出流就是服务端的输入流，而服务端的输出流就是客户端的输入流。因此客户端通过OutputStream将要写入服务端的数据传送，然后服务端通过InputStream接受并进行数据的更新。同时客户端通过OutputStream将要返还给客户端的信息进行发送，然后客户端通过InputStream接受到数据进行更新。最终当通信完成以后，两个端程序都要关闭Socket插口从而终止连接。这就是一次Socket通信的全过程。因此Socket通信步骤是：

1. 在客户端和服务端创建Socket和ServerSocket实例
2. 打开连接到Socket的输入/输出流
3. 利用输入/输出流，按照一定的协议对Socket协议进行读写操作
4. 关闭输入/输出流和Socket

{% note info, 

注意步骤三是数据通信的核心，同时完成通信一定要关闭Socket，否则会造成严重的负荷。

%} 

#### Socket通信Socket类

这里需要引用java.net.Socket类来引入下面几个函数：

##### 构造Socket方法

```java
//接受要访问的客户端的host和端口号port
public Socket(String host,int port);
//也可以接受要访问的客户端的ip地址+port实例化创建
public Socket(InetAffress address,int port);
```

##### 从Socket中获得输入输出流

```java
public InputStream getInputStream();
public OutputStream getOutputStream();
```

注意方法的返还类型是输入/输出流，此时的方法都是针对的客户端的Socket方法，我们不难知道getOutputStream实际上是Socket接受来自客户端要向服务端发出的数据流，而getInputStream是Socket从通信管道接受到的要写入客户端的数据流。

##### 关闭

```java
public void Socket();
```

我们用循环分别创建Socket请求`ww.tju.cn`的不同的端口号：

```java
public class SocketScan {

	public SocketScan() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		//远程的地址，可以是IP 地址，也可以是域名
		String address = "www.tju.edu.cn";
		for (int port = 80; port < 10000; port++) {
			Socket socket =null;
			try {
				System.out.println("scan "+address +":" + port);
				socket = new Socket(address, port);	
				//远程主机名
				System.out.println("hostname=" + socket.getInetAddress().getHostName());
				//远程地址
				System.out.println("ip=" + socket.getInetAddress().getHostAddress());				
				System.out.println(address + " listen on port:" + port);
			} catch (IOException e) {
				System.out.println(address + " port=" + port + " connect error:" + e);
			}finally {
				if(socket!=null) {
					try {
						socket.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}
	}

}
```

最终的控制台结果为：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210415173848.png)

我们可以看到最终coonet被拒绝了，即服务端可以拒绝与客户端接入，那么此时服务端由于调用了获取服务端的信息方法并且返还错误因此抛出异常，也自然就不会输出地址了上面的代码是客户端监视检查服务端各个端口状态的代码。

我们还可以从上面的代码示例中获得以下几个方法的功能：

##### 获取服务器端口

```java
public int getPort()//获取服务器端口
```

因此当成功建立联系时，我们可以通过调用socket.getPort()获得正在与之建立联系的客户端socket端口号，他是一个int型，因此端口号的范围是0~65535,当联系建立失败时，无法正常返还抛出异常。

##### 获取客户端端口

```java
public int getLocalPort()//获取客户机端口
```

获取当前客户端正在与服务端建立连接的端口号

##### 获取地址

```java
public InetAddress getInetAddress()
public InetAddress getLocalAdress()
```

#### Socket通信ServerSocket类

##### 构造方法

```java
public ServerSocket(int port)
//支持指定数目的连接
public ServerSocket(int port,int backlog)
```

上面这些方法如果未正常返还都将抛出例外IOException，程序中需要捕获处理。

#### Socket通信实战

之前我们一直在学习理论，但是只有实战体验才能真正理解Socket通信，这里我们运行一下三个不同的Socket通信下Client和Server端程序通信例子。

##### 面向Byte通讯

此时输入和输出流都是字节流，我们这里定义输入端和服务端代码如下：

**客户端**

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210415192117.png)

**服务端**

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210415192202.png)

同时我们看到在客户端代码中定义端口号是config.port，这里我们查看一下config文件中的信息：

```java
public class Config {
	public static int PORT = 5555;
	public static String BYE = "bye";
	public static int MAX_LEN = 100;
}
```

因此当建立连接成功后，会在端口5555进行数据通讯，接下来我们分别开启两个命令创启动两个端程序。我们观察上面的代码，不难看出客户端会向服务端发送10个数0~9，因此当我们先启动服务端以后服务端并不会有任何数据接收，直至客户端启动以后，两个端程序的socket实例都创建成功以后，客户端会先将数据通过OutputStream输出到socket中，然后socket将数据传送到服务端，服务端的serversocket(这里实例名称为server)接收到数据，显示数字。因此两个命令窗的显示情况如下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210415192650.png)

我们注意到服务端会说出和客户端相同的数字，并且我们要注意命令窗的语句打印顺序为：

1. 客户端说出0
2. 服务端说出0
3. 客户端说出1
4. 服务端说出1
5. ...

即两个端程序并不是一次性打印10句话，而是客户端每发送一个数字（说出一句话），服务端接收到数字以后会立刻打印，因此我们可以看出数据流并不是全部到达socket后统一发送，而是socket每次接受一个字节的数据就发送。

##### 面向Char通讯

**客户端**

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210415193022.png)

**服务端**

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210415193049.png)

{% note info, 

注意此时输入/输出流单位发生了变化， 输入和输出的方法也使用了Reader()，因此此时是字符流。

%} 

最终两个端程序的命令窗打印的结果是：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210415193313.png)

###### 思考：客户端和服务端启动的先后？

为了验证服务端只有监视接收到客户端的连接请求后才会打印客户端的数字，我们只启动服务端，发现此时服务端没有任何语句输出，只是等待链接：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210415193450.png)

并且还要注意我们必须先启动服务端保证服务端随时等待客户端的连接，如果我们先启动客户端而未启动服务端，那么客户端会发现连接失败，即未发现连接地址有服务端口，如下我们启动客户端：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210415193622.png)

因此我们知道客户端必须先启动暴露给客户端，这样客户端才能向服务端发送请求，同时服务端随时监视等待客户端的链接请求，一旦发现会立刻相应连接。

###### 思考：真正的Socket通讯是什么样子的？

这里我只是用自己的电脑同时扮演客户端和服务端来模拟Socket通讯，实际生活中一般Client和Server是对应着两个不同地区的两台主机，此时服务器一直处于运行状态，而客户端只要发送请求并且此时服务端可以接入就会立刻建立链接与客户端进行数据通讯。

##### 支持输入、输出和多客户端

我们发现前面的两个实战演示中，服务端总是只为一个客户端服务，但是实际生活中，服务端可能同时要与上千或者上万个服务端进行通讯，因此他应该可以同时与多个客户端程序进行通讯，因此此时我们需要使用多线程来让客户端能够为每一个客户端建立一个serversocket与之进行数据通讯，如下面的代码：

**客户端**

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210415195151.png)

**服务端**

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210415195216.png)

我们可以看出客户端为每一个客户分配了一个server线程，所以ServerThread如下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210415195310.png)

假设此时我们传入了两个客户Client1和Client2并且Client1先与服务端建立连接。这样最终的运行结果如下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210415194742.png)

我们发现在为客户端1进行服务的同时服务端有与客户端2建立了连接，因此此时服务端和多个客户端进行了连接，这更加符合现实生活中的CS通讯模型。

#### 利用Socket模拟浏览器加载页面

如果我们学习过前后端调用的基础知识，我们知道当我们打开一个网站时，我们作为客户端会向服务端发送一个请求，服务端接受到请求以后会响应传送给我们一个页面的前端渲染的代码，浏览器将前端的html代码渲染显示，这也就呈现了我们看到的页面，那么接下来我们来用Socket模拟一下前后端页面的调用。我们来看一下代码：

**客户端**

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210415200215.png)

**服务端**

```java
public class HTTPServer {

	public static void main(String args[]) {
		int port;
		ServerSocket serverSocket;

		try {
			port = Integer.parseInt(args[0]);
		} catch (Exception e) {
			System.out.println("port = 8080 (默认)");
			port = 8080; //默认端口为8080
		}

		try {
			serverSocket = new ServerSocket(port);
			System.out.println("服务器正在监听端口：" + serverSocket.getLocalPort());

			while (true) { //服务器在一个无限循环中不断接收来自客户的TCP连接请求
				try {
					//等待客户的TCP连接请求
					final Socket socket = serverSocket.accept();
					System.out.println("建立了与客户的一个新的TCP连接，该客户的地址为："
							+ socket.getInetAddress() + ":" + socket.getPort());

					service(socket); //响应客户请求
				} catch (Exception e) {
					e.printStackTrace();
				}
			} //#while
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/** 响应客户的HTTP请求 */
	public static void service(Socket socket) throws Exception {

		/*读取HTTP请求信息*/
		InputStream socketIn = socket.getInputStream(); //获得输入流
		Thread.sleep(500); //睡眠500毫秒，等待HTTP请求  
		int size = socketIn.available();
		byte[] requestBuffer = new byte[size];
		socketIn.read(requestBuffer);
		String request = new String(requestBuffer);
		System.out.println(request); //打印HTTP请求数据
		
		String contentType = "text/html";
		//String contentType = "application/zip";
		

		/*创建HTTP响应结果 */
		//HTTP响应的第一行
		//String responseFirstLine = "HTTP/1.1 200 OK\r\n";
		String responseFirstLine = "HTTP/1.1 404 Not Found \r\n";
		//HTTP响应头
		String responseHeader = "Content-Type:" + contentType + "\r\n\r\n";
		//获得读取响应正文数据的输入流

		/*发送HTTP响应结果 */
		OutputStream socketOut = socket.getOutputStream(); //获得输出流
		//发送HTTP响应的第一行
		socketOut.write(responseFirstLine.getBytes());
		//发送HTTP响应的头
		socketOut.write(responseHeader.getBytes());
		//发送HTTP响应的正文
		String content="hellow "+new java.util.Date().toString();
		byte[] buffer = content.getBytes();
		socketOut.write(buffer, 0, buffer.length);

		Thread.sleep(1000); //睡眠1秒，等待客户接收HTTP响应结果        
		socket.close(); //关闭TCP连接  
		//作者：孙卫琴                                     *
 		// 来源：<<Tomcat与Java Web开发技术详解>>           *
 		//技术支持网址：www.javathinker.org  
	}
}
```

然后我们看一下结果，最终客户端等待了2s以后得到了服务端相应的前端代码（很神奇），我这里编码有点问题出现了乱码：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210415200507.png)

#### 总结

本次我们通过三个实战例子学习了Java中常用的Socket通讯，我们最后做几点总结：

- C/S通过socket来将各自的输入/输出流进行交换
- 当C/S类方法调用失败时会抛出异常我们需要捕捉解决
- Socket通讯结束最终要记住关闭输入/输出流,关闭socket通讯
- 一个服务端可以通过多线程服务多个客户端
- 浏览器访问网站并不是直接从服务器获取页面，而是获取前端代码，然后通过浏览器渲染最终呈现出精美的页面
- 一个C/S通讯的成功建立要确保服务器运行+正确的地址+空闲的端口才能实现