---
title: 浅谈《SpringBoot》数据请求响应
comments: false
top: false
date: 2021-08-30 09:49:30
tags: [java,springboot,数据请求]
categories: 
	- [知识分享,学习心得]
headimg: https://langwenchong.gitee.io/figure-bed/20210830125109.png
---

SpringBoot入门笔记，本篇记录翀翀对数据请求响应的方法：RequestMapping,GetMapping和PostMapping的总结。

<!-- more -->

### 快速创建项目

这里我们使用`Spring Initializer`来快速创建一个项目，在选择应用场景依赖时我们选择如下三个即可：

![](https://langwenchong.gitee.io/figure-bed/20210830095406.png)

由于我们的JDK版本是1.8因此需要将java编译配置更改为java 8,然后选择`Spring Web`、`JDBC API`和`MysqlDriver`(后两项依赖是我们通过jdbc方式连接和操作数据库时需要用到的，方便下一篇文章《SpringBoot》操作数据库的演示）:

![](https://langwenchong.gitee.io/figure-bed/20210830095623.png)

创建完成后我们就完成了一个SpringBoot的项目创建，其文件结构如下图：

![](https://langwenchong.gitee.io/figure-bed/20210830095723.png)

然后我们在`demo`下创建一个新的文件`controller\sqlController`，我们将在这里编写持久化服务函数方法来进行数据请求的相应。

{% note info,

我们一定要注意DemoApplication是起始函数，他将在同级和下一级的文件中进行方法的运行，因此我们的Controller层的方法必须建立在与DemoApplication同级包下，因此controller在demo包下。

%}

然后我们在设置一下端口，由于前端vue项目的运行也是在8080端口上，为了避免端口冲突，我一般将SpringBoot项目的端口设置为8888，我们在`main/sources`下可以看见已经创建了一个`application.properties`文件了，他是用来存储项目配置的。但是我更青睐于使用格式更加优雅的`application.yml`进行配置，因此我们在`main/source`下创建yml文件，并且添上端口号：

```yml
server:
	port:8888
```

自此我们的项目就快速创建成功了。然后我们进行一个简单的测试，我们打开`sqlController`文件并编写以下函数：

```java
 @GetMapping("/hello")
    public String hellosql() {
        return "hello sql!";
    }
```

然后我们运行项目后打开网址`http://localhost:8888/hello`当页面中可以显示`hello sql`及说明项目配置成功：

![](https://langwenchong.gitee.io/figure-bed/20210830100834.png)

### GetMapping响应请求

在SpringBoot中我们常用的一种响应请求的方法就是使用@GetMapping注解标记的方法。他有以下两种写法，但是无论哪种写法最终参数都会在路径url中显示：

#### @PathVarialble

我们在`sqlController.java`中编写以下函数：

```java
 @GetMapping("/query/{name}")
    public  String PrintName(@PathVariable("name") String name){
        return "Good morning!"+name+"~";
    }
```

假设我们现在要通过上面的这个方法上传参数name为chongchong，那么最终的url为`http:localhost:8888/query/chongchong`即我们直接在`/query/`的后面加上我们要写的参数即可，如下图是最终的测试结果：

![](https://langwenchong.gitee.io/figure-bed/20210830101641.png)

上面的测试软件是PostMan,可以点击这里下载：

{% link PostMan下载, https://www.postman.com/downloads/ %}

我们要注意一下几点事项：

1. 当使用@GetMapping注解时，请一定要将请求头的方法使用Get请求而不是Post请求，否则会返还错误码405表示方法不正确
2. 注解下方的函数名字没有特殊要求我们可以自己命名例如我这里命名为了PrintName
3. url中`/{var}`表示的是要填写的参数，而前面的`query`来标记此时调用该方法
4. 参数中前必须使用@PathVariable来获取路径中填写的参数，其中注解后方括号内部的`name`必须与路径上的参数同名，但是后面的`String name`可以修改为其他参数名来方便方法内部使用，比如我们可以修改为` public  String PrintName(@PathVariable("name") String n){`此时内部的参数需要使用n来表示

{% note info,

@PathVariable最大的特点就是每一个参数直接使用`/var/`的方式填写即可。并且要注意每次我们修改了controller的代码都需要重新运行SpringBoot项目！

%}

#### @RequestParam

使用这个注解的方法更加普遍，他支持不同形式的参数包括map,List，对象形式等。他的最大特点是请求路径url后面的参数使用`?var=value`的形式表示。

##### 获取基本类型参数

我们使用@RequestParam的方法再重写一下上面的相应方法：

```java
 @GetMapping("/query")
        public String PrintName(@RequestParam("name") String n){
            return"Good morning!"+n+"~";
        }
```

因此此时我们的请求url是`http://localhost:8888/query?name=chongchong`，测试结果如下图：

![](https://langwenchong.gitee.io/figure-bed/20210830103315.png)

**并且@RequestParam还可以使用defaultValue填写默认的参数值**，此时如果后面我们并没有添加参数那么他将会使用默认值替代，如下：

```java
@GetMapping("/query")
        public String PrintName(@RequestParam(value = "name",defaultValue = "chongchong") String n){
            return"Good morning!"+n+"~";
        }
```

此时我输入`http://localhost:8888/query`并没有添加参数值chongchong,但是他仍然会返还上面的那句话：

![](https://langwenchong.gitee.io/figure-bed/20210830103801.png)

**同时@RequestParam还提供了`required=false`来设置参数为非必输项**，如下：

```java
 @GetMapping("/query")
    public String PrintName(@RequestParam(value = "firstName", required = false) String fn,
                            @RequestParam(value = "lastName", required = true) String ln
    ) {
        //填写姓氏就加上，否则只输出名
        return fn == null ? "Good morning!" + ln + "~" : "Good morning!" + fn + ln + "~";
    }
```

我们现在只加上lastName参数为wenchong,FirstName不写，那么测试结果如下图：

![](https://langwenchong.gitee.io/figure-bed/20210830104410.png)

我们发现此时fistName不是必输项因此后台仍然给出了相应。但是我们要注意非必输项为填写时那么将被设置为空即null值，如下图我们打印出firstName的值：

![](https://langwenchong.gitee.io/figure-bed/20210830104639.png)

{% note info,

为了避免出现此类现象，我们可以使用defaulValue来为其设置默认值

%}

##### 使用map来接收参数

我们还可以使用mao来接收一组参数，但是这个方法并没有简化输入url，我们在url中还是要输入所有的参数，只是在接收相应方法中我们不需要再枚举形参了，如下：

```java
@GetMapping("/query")
    public String PrintName(@RequestParam Map<String,Object> args) {
        //map接收了参数，用get声明参数名字
        return "Good morning!" + args.get("firstName") + args.get("lastName") + "~";
    }
```

此时我们输入的url还是`http://localhost:8888/query/?firstName=Lang&lastName=wenchong`,并没有变短，但是此时方法中的参数声明就要简化了许多，当涉及到多个参数时使用此方法效果极佳。此时我们的测试结果如下图：

![](https://langwenchong.gitee.io/figure-bed/20210830105325.png)

###### 思考：Map泛型为什么是String-Object类型？

我们要注意参数的形式是key-value键值对，其中前面部分是形参名称必定是字符串的，但是后面传递的值可能是int,long,String等类型，因此我们需要使用一个更大的父类形式Object来统一表示。

同样的我们还可以使用List或者Array进行接收但是不常用，因为写法很不友好并且接收的是同类型参数，这里仅给出测试代码：

```java
 //使用数组接收
 @GetMapping("/query")
    public String PrintName(@RequestParam("name") String[] args) {
        //参数顺序、数组大小都要给定
        return "Good morning!" + args[0] + args[1] + "~";
    }
//使用List接收
@GetMapping("/query")
    public String PrintName(@RequestParam("name") List<Object> args) {
        //参数顺序、List大小都要给定
        return "Good morning!" + args.get(0) + args.get(1) + "~";
    }
```

##### 使用对象来接收参数

这个方法也常用，他通常用来处理某些具有特殊特殊身份的参数集合使用，如下是一个案例，我们假设要设定chongchong去新华书店购买图书，书名叫做《SpringBoot入门到入土》并且标价20元，此时如果我们要按照基本类型参数一个一个传递，很显然非常的复杂，并且关系不明确，此时我们可以事先定义两个具有特殊关系的对象来分别接收如下：

首先我们需要在`demo`下新建一个包`sqlObject`然后分别在下面建立两个实体类，分别是User和Book：

```java
//sqlObject.User.java
public class User {
    private String username;

    private String location;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
}
```

```java
//sqlObject.Book.java
public class Book {
    private String bookname;
    private Integer price;

    public String getBookname() {
        return bookname;
    }

    public void setBookname(String bookname) {
        this.bookname = bookname;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }
}
```

然后我们再在sqlController中加入以下相应方法：

```java
@GetMapping("/buy")
    public String BuyBook(User user, Book book){
        return user.getUsername()+" go to "+user.getLocation()+" to buy a book called "+ book.getBookname()+" for ￥ "+book.getPrice();
    }
```

测试结果如图：

![](https://langwenchong.gitee.io/figure-bed/20210830112411.png)

{% note info,

注意我们在填写参数时必须按照先填写完obj1的所有成员参数再填写obj2所有成员参数的顺序填写，因此SptingBoot不会去自动识别那个参数属于哪一个类，同时为了避免某个成员参数二次赋值，需要保证两个不用类的参数名称不同。如上图User使用的是username,Book使用的是bookname，当他们同时使用name时那么传参时就会出现name二次赋值的现象。

%}

###### BUG问题：二次赋值现象？

如下图就是一个二次赋值的现象，假设此时我们要求User必须使用name指定人名，Book也必须使用name指定书名，那么我们的对象定义就改为：

```java
//sqlObject.User.java
public class User {
    private String name;


    private String location;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
}
```

```java
//sqlObject.Book.java
public class Book {
    private String name;
    private Integer price;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }
}

```

controller层响应方法如下：

```java
@GetMapping("/buy")
    public String BuyBook(User user, Book book){
        return user.getName()+" go to "+user.getLocation()+" to buy a book called "+ book.getName()+" for ￥ "+book.getPrice();
    }
```

此时我们进行测试，最终结果如下了二次赋值的现象：

![](https://langwenchong.gitee.io/figure-bed/20210830114644.png)

###### 思考：有没有什么更好的方法解决上面的不同类对象同名成员属性参数的区分？

我们虽然可以使用不同的参数来避免二次赋值，但是当面临多个类时很显然上面的方法并不合适，比如有多个类他们都会有同名属性比如id,name等，那么难道每次我们都要绞尽脑汁给他们改成不同的名字吗？没有必要，我们可以使用`@InitBinder`指定前缀绑定来解决问题。

##### @InitBinder应用

我们使用@InitBinder注解来解决User和Book添加了相同的属性name的赋值问题，此时我们在controller层加入以下响应请求方法：

```java
 @InitBinder("u")
    private void initBinderU(WebDataBinder binder){
        //要求用@InitBinder("u")绑定的对象属性参数加上前缀u.
        binder.setFieldDefaultPrefix("u.");
    }
    @InitBinder("b")
    private void initBinderB(WebDataBinder binder){
        //要求用@InitBinder("b")绑定的对象属性参数加上前缀b.
        binder.setFieldDefaultPrefix("b.");
    }
    @GetMapping("/buy")
    public String BuyBook(@ModelAttribute("u") User user,@ModelAttribute("b") Book book){
        return user.getName()+" go to "+user.getLocation()+" to buy a book called "+ book.getName()+" for ￥ "+book.getPrice();
    }
```

此时我们在输入参数时就要求需要加上前缀了，这就有点类似于sql语句中的前缀，如下图是测试图：

![](https://langwenchong.gitee.io/figure-bed/20210830114207.png)

这样我们通过添加前缀的方式就完美解决了不同类相同属性参数的传值问题。

#### @PathVariable和@RequestParam混用

实际上我们甚至可以混用两种注解，如下：

```java
@GetMapping("/hello/{id}")
    public String hellosql(@PathVariable("id") Integer id,@RequestParam("name") String name) {
        return "hello！ "+id+"号："+name;
    }
```

![](https://langwenchong.gitee.io/figure-bed/20210830124347.png)

### PostMapping响应请求

在学习完GetMapping后我们已经可以完成少量参数时的数据请求了，但是我们发现此时有几个弊端：

1. url中暴露隐私信息
2. 当涉及多个参数时，即使使用对象作为参数写起来也非常的复杂

我们发现之所以出现如上的问题是因为我们总是在基于基础类型变量进行传值，即使是使用了对象也仅仅是在controller层进行了参数接收的简化，但是在传值时还是在一个属性一个属性的传递，因此会出现多参数时url复杂并且暴露隐私信息的问题。那么我们通过PostMapping就可以解决上面的问题，他的特点是将所有的变量封装在一个对象中，然后将对象传递，也就是说对象好像一个盒子，里面盛放了许多信息，这样我们在传递时就不用在url中逐一枚举所有变量了，而是直接上传对象了。

#### 基本接收方法

我们以下图为了讲解一下最简单的PostMapping实现，我们在controller层加入以下函数：

```java
@PostMapping("/query")
    public String PringtName(@RequestParam("name") String name) {
        return "Good afternoon!" + name + "~";
    }
```

然后在postman中进行测试，我们需要注意因为此时我们不是在传递基础变量参数了，而是在传递一个对象，因此我们需要在`body/for-data`进行中填写键值对：

![](https://langwenchong.gitee.io/figure-bed/20210830115821.png)

这就类似于我们传递了一个`{name:"chongchong"}`对象，并且要注意方法使用post形式，此时我们就可以正确得到相应了，并且我们观察此时的url并未携带我们的name信息，隐私信息得到了保障。

{% note info

同样的，postMapping也有defaultValue和required=false设置默认项和非必输项等属性，请自行尝试。

%}

#### 使用Map传递

PostMapping和GetMapping仅仅是在url形式和传输的数据形式上有所区别，最终实现的效果是一致的，因此PostMapping也有用Map传递参数的方法，只是要注意在测试时我们需要在`body/form-data`中进行信息填写：

```java
 @PostMapping("/query")
    public String PrintName(@RequestParam Map<String,Object> args) {
        //map接收了参数，用get声明参数名字
        return "Good afternoon!" + args.get("firstName") + args.get("lastName") + "~";
    }
```

![](https://langwenchong.gitee.io/figure-bed/20210830120559.png)

同理，PostMapping中也有使用数组，List传递参数的方法。

#### 使用Json数据传输

这是PostMapping中最大的特点，他可以使用json数据形式来传递数据，这样我们只需在前端中创建多个键值对对象就可以直接交付到后端完成多对象的传值，我们只需要在对象参数前面加上@RequestBody即可，如下图我们还是来实现买书：

首先我们定义BuyBook类：

```java
public class BuyBook {
    private String username;
    private String location;
    private String bookname;
    private String price;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getBookname() {
        return bookname;
    }

    public void setBookname(String bookname) {
        this.bookname = bookname;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }
}

```

然后在Controller层加入如下相应函数：

```java
 @PostMapping("/buy")
	//只能是一个接收类
    public String BuyBook(@RequestBody BuyBook bb) {
        return bb.getUsername() + " go to " + bb.getLocation() + " to buy a book called " + bb.getBookname() + " for ￥ " + bb.getPrice();
    }
```

这样我们在测试时使用postman并且改为`body/raw/json`格式加入键值对即可：

![](https://langwenchong.gitee.io/figure-bed/20210830122801.png)

这样我们就轻松完成了买书的各种参数的传递。

### RequestMapping

实际上我们前面所学到的GetMapping，PostMapping都是RequestMapping的子类，因此我们可以统一使用RequestMapping来代替前两者。其对应关系为：

|                      @RequestMapping                      | @GetMapping&@PostMapping  |
| :-------------------------------------------------------: | :-----------------------: |
| @RequestMapping(path = "path", method=RequestMethod.GET)  | @GetMapping(path="path")  |
| @RequestMapping(path = "path", method=RequestMethod.POST) | @PostMapping(path="path") |