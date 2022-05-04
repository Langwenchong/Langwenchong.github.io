---
title: python学习笔记--python基础(5)
comments: false
top: false
date: 2022-01-19 14:06:24
tags: [python]
categories: 
	- [个人笔记,Python基础]
---

python基础入门笔记，记录翀翀对Python基础的理解与总结，常言道：一分耕耘，一分收获。”在自己的理想道路上，多动脑筋，不断的思考，不停地学习，四肢能勤，不断地“书读百遍”，就会“其义自现”。愿你我都能坚持学习😁

<!-- more -->

### Python函数用法详解

函数就是将一个复杂的需要多次调用的步骤进行封装以便后期复用，在Python中除了可以使用内置函数以外，我们还可以自定义函数，将一段有规律的、可重复使用的代码定义成函数，从而达到一次编写、多次调用的目的。

```python
#自定义 len() 函数
def my_len(str):
    length = 0
    for c in str:
       length = length + 1
    return length
#调用自定义的 my_len() 函数
length = my_len("http://c.biancheng.net/python/")
print(length)
#再次调用 my_len() 函数
length = my_len("http://c.biancheng.net/shell/")
print(length)
```

运行结果：

```python
30
29
```

{% note info,

注意，Python中的函数既可以接收多个(>=0)参数，还可以返还多个(>=0)返回值。

%}

#### Python函数的定义

Python中使用`def`关键字实现对一个自定义函数的声明，具体格式如下：

```python
def 函数名(参数列表):
    //实现特定功能的多行代码
    [return [返回值]]
```

其中，用 [] 括起来的为可选择部分，即可以使用，也可以省略。**当不设置返回值时，默认返回None。注意，在创建函数时即使不需要参数，也必须保留一对空的"()"**，否则Python解释器将提示"invalid syntax"错误。同时如果想要定义一个没有任何功能的空函数，可以使用pass语句作为占位符。

另外值得一提的是，函数中的 return 语句可以直接返回一个表达式的值：

```python
def str_max(str1,str2):
    return str1 if str1 > str2 else str2
```

#### Python函数的调用

```python
[返回值] = 函数名([形参值])
```

要注意创建的函数有多少个形参，那么调用时即需要传入多少个值，并且顺序必须和创建函数时一致，即使该函数没有参数，函数名后面的小括号也不能省略。

#### 为函数提供说明文档

我们通过调用Python的help()内置函数或者\_\_doc\_\_属性，就可以查看到某个函数的使用说明文档。无论是Python提供给我们的函数，还是自定义的函数，其说明文档都需要设计该函数的程序猿自己编写。

本质上，函数的说明文档就是一段字符串，只不过作为说明文档。字符串的放置位置是有讲究的，函数的说明文档通常位于函数内部、所有代码的最前面。

```python
#定义一个比较字符串大小的函数
def str_max(str1,str2):
    '''
    比较 2 个字符串的大小
    '''
    str = str1 if str1 > str2 else str2
    return str
help(str_max)
#print(str_max.__doc__)
```

运行结果：

```python
Help on function str_max in module __main__:

str_max(str1, str2)
    比较 2 个字符串的大小
```

### Python函数值传递和引用传递

在Python中，根据实际参数的类型不同，函数传递的方式有两种，分别为值传递和引用传递(地址传递)。

1. 值传递：适用于实参类型为不可变类型（字符串、数字、元组）；
2. 引用（地址）传递：适用于实参类型为可变类型（列表，字典）；

值传递和应用传递的特点是，函数参数进行值传递以后，如果形参的值发生改变，不会影响实参的值。而函数参数继续使用引用传递以后，改变形参的值，实参的值也会一同发生改变。

```python
def demo(obj) :
    obj += obj
    print("形参值为：",obj)
print("-------值传递-----")
a = "C语言中文网"
print("a的值为：",a)
demo(a)
print("实参值为：",a)
print("-----引用传递-----")
a = [1,2,3]
print("a的值为：",a)
demo(a)
print("实参值为：",a)
```

运行结果：

```python
-------值传递-----
a的值为： C语言中文网
形参值为： C语言中文网C语言中文网
实参值为： C语言中文网
-----引用传递-----
a的值为： [1, 2, 3]
形参值为： [1, 2, 3, 1, 2, 3]
实参值为： [1, 2, 3, 1, 2, 3]
```

### Python底层了解函数参数传递机制

#### Python函数参数的值传递机制

```python
def swap(a , b) :
    # 下面代码实现a、b变量的值交换
    a, b = b, a
    print("swap函数里，a的值是", \
        a, "；b的值是", b)
a = 6
b = 9
swap(a , b)
print("交换结束后，变量a的值是", \
    a , "；变量b的值是", b)
```

运行结果：

```python
swap函数里，a的值是 9 ；b的值是 6
交换结束后，变量a的值是 6 ；变量b的值是 9
```

如上所示，在swap()函数中，a和b的值分别是9,6，交换结果后，变量a和b的值依然是6和9，从这个运行结果可以看出，程序中实际定义的变量a和b，并不是swap()函数中的a和b。因为swap()函数中的a和b只是主程序变量a和b的复制品，如下图所示：

上面程序开始定义了 a、b 两个局部变量，这两个变量在内存中的存储示意图如图 1 所示。

![](https://langwenchong.gitee.io/figure-bed/20220119144126.png)

当程序执行swap()函数时，系统进入swap()函数，并且将主程序的a、b变量作为参数传入swap()函数，但是传入swap()函数的只是a、b的副本，而不是a、b本身。进入swap()函数以后，系统中产生了4个变量，这4个变量在内存中的存储示意图如图2所示：

![](https://langwenchong.gitee.io/figure-bed/20220119144317.png)

当在主程序中调用swap()函数时，系统分别为主程序和swap()函数分配两块栈区，用于保存他们的局部变量。将主程序中的a、b变量作为参数值传入swap()函数，实际上是在swap()函数栈区中重新生成了两个变量a、b，并且将主程序栈区中a、b变量的值分别赋值给swap()函数栈区中的a、b参数（就是对swap()函数中的a、b两个变量进行初始化）。此时，系统存在两个a变量、两个b变量，只是存在与不同的栈区中而已。

程序在swap()函数中交换a、b两个变量的值，实际上是对图2中灰色区域中的a、b变量进行交换。交换结束以后，输出swap()函数中a、b变量的值，可以看到a的值为9，b的值为6,此时在内存中的存储示意图如图3所示：

![](https://langwenchong.gitee.io/figure-bed/20220119144738.png)

对比图3和图1，可以看到两个示意图中主程序栈区中a、b的值并未有任何变化，程序改变的仅仅是swap()函数栈区中a、b的值。这既是值传递的实质，当程序开始执行函数时，系统对形参进行初始化，就是把实参变量的值赋给函数的形参变量，在函数中操作的并不是实际上的实参变量。

#### Python函数参数的引用传递

如果实际参数的数据类型是可变对象（列表、字典），则函数参数的传递方式将采用引用传递方式，需要注意的是，**引用传递方式的底层实现，采用的依然是值传递的方式**。

```python
def swap(dw):
    # 下面代码实现dw的a、b两个元素的值交换
    dw['a'], dw['b'] = dw['b'], dw['a']
    print("swap函数里，a元素的值是",\
        dw['a'], "；b元素的值是", dw['b'])
dw = {'a': 6, 'b': 9}
swap(dw)
print("交换结束后，a元素的值是",\
    dw['a'], "；b元素的值是", dw['b'])
```

运行结果：

```python
swap函数里，a元素的值是 9 ；b元素的值是 6
交换结束后，a元素的值是 9 ；b元素的值是 6
```

如上所示，在swap()函数中，dw字典的a,b两个元素的值被交换成功，不仅如此，当swap()函数执行结束后，主程序中dw字典的a、b两个元素的值被交换了，这很容易造成一种错觉，即在调用swap()函数时，传入swap()函数的就是dw字典本身，而不是它的复制品。但这是一种错觉，下面我们还是结合示意图来说明程序的执行过程。

程序开始创建了一个字典对象，并且定义了一个dw引用变量（其实就是一个指针），指向字典变量，这意味着此时内存中有两个东西，对象本身和指向该对象的引用变量。此时系统内存中的存储示意图如下所示：

![](https://langwenchong.gitee.io/figure-bed/20220119145406.png)

接下来当主程序开始调用swap()函数时，dw变量作为参数传入swap()函数，这里依然采用值传递方式，把主程序中dw变量的值赋给swap()函数的dw形参，从而完成swap()函数的dw参数的初始化。值的指出的是，主程序中的dw是一个引用变量（也就是一个指针），他保存了字典对象的地址值，当把dw的值赋给swap()函数的dw参数后，就是让swap()函数也保存这个地址值，即也会引用到同一个字典对象，图5显示了dw字典传入swap()函数后的存储示意图。

![](https://langwenchong.gitee.io/figure-bed/20220119145658.png)

从图5来看，这种参数传递方式是不折不扣的值传递方式，系统一样复制了dw的副本到swap()函数，但由于dw只是一个引用变量，因此系统复制的是dw变量，并未复制字典本身。

当程序在swap()函数中操作dw参数时，由于dw只是一个引用变量，故实际操作的还是字典对象。此时，不管是操作主函数中的dw变量，还是操作swap()函数里的dw参数，其实操作的都是他们共同引用的字典对象，他们引用的是同一个字典对象。因此，当在swap()函数中交换dw参数所引用字典对象的a,b两个元素的值后，可以看到在主程序中dw变量所引用字典对象的a、b两个元素的值也被交换了。

为了更好地证明主程序中的dw和swap()函数中的dw是两个变量，在swap()函数的最后一行增加如下代码：

```python
#把dw 直接赋值为None，让它不再指向任何对象
dw = None
```

运行上面代码，结果是swap()函数中的dw变量不再指向任何对象，程序其他地方没有任何变化。主程序调用swap()函数后，再次访问dw变量的两个元素，依然可以输出9、6。可见，主程序的dw变量并没有受到任何影响。实际上，当在sawp()函数中增加`dw=None`代码后，在内存中的存储示意图如下所示：

![](https://langwenchong.gitee.io/figure-bed/20220119150411.png)

我们可以看出，把swap()函数中的dw赋值为None后，在swap()函数中失去了对字典对象的引用，不可再访问该字典对象，但是主程序中的dw变量不受任何影响，依然可以使用该字典对象，所以依然输出字典对象的a、b元素的值。

我们通过上面的学习，可以得到如下两个结论：

1. 不管什么类型的参数，在 Python 函数中对参数直接使用“=”符号赋值是没用的，直接使用“=”符号赋值并不能改变参数。
2. 如果需要让函数修改某些数据，则可以通过把这些数据包装成列表、字典等可变对象，然后把列表、字典等可变对象作为参数传入函数，在函数中通过列表、字典的方法修改它们，这样才能改变这些数据。

### Python位置参数

#### 实参和形参数量必须一致

位置参数，有时也被称为必备参数，指的是必须按照正确的顺序将实际参数传到函数中，换句话说，调用参数时传入实际参数的数量和位置必须和定义函数时保持一致。

在调用函数，指定的实际参数的数量，必须和形式参数的数量一致（传多传少都不行）。否则Python解释器会抛出TypeError异常，并提示缺少必要的位置参数。

```python
def girth(width , height):
    return 2 * (width + height)
#调用函数时，必须传递 2 个参数，否则会引发错误
print(girth(3))
```

运行结果：

```python
Traceback (most recent call last):
  File "C:\Users\mengma\Desktop\1.py", line 4, in <module>
    print(girth(3))
TypeError: girth() missing 1 required positional argument: 'height'
```

```python
def girth(width , height):
    return 2 * (width + height)
#调用函数时，必须传递 2 个参数，否则会引发错误
print(girth(3,2,4))
```

运行结果：

```python
Traceback (most recent call last):
  File "C:\Users\mengma\Desktop\1.py", line 4, in <module>
    print(girth(3,2,4))
TypeError: girth() takes 2 positional arguments but 3 were given
```

#### 实参和形参位置必须一致

在调用函数时，传入实际参数的位置必须和形式参数的位置一一对应，否则就会产生以下2中结果：

##### 抛出 TypeError 异常

当实际参数类型和形式参数类型不一致，并且在函数种，这两种类型之间不能正常转换，此时就会抛出 TypeError 异常。

```python
def area(height,width):
    return height*width/2
print(area("hhhh",3))
```

运行结果：

```python
Traceback (most recent call last):
  File "C:\Users\mengma\Desktop\1.py", line 3, in <module>
    print(area("hhh",3))
  File "C:\Users\mengma\Desktop\1.py", line 2, in area
    return height*width/2
TypeError: unsupported operand type(s) for /: 'str' and 'int'
```

以上显示的异常信息，就是因为字符串类型和整形数值做除法运算。

##### 产生的结果和预期不符

调用函数时，如果指定的实际参数和形式参数的位置不一致，但是他们的数据类型相同，那么程序并不会抛出异常，只不过导致运行结果和预期不符。

例如，设计一个求梯形面积的函数，并利用此函数求上底为 4cm，下底为 3cm，高为 5cm 的梯形的面积。但如果交互高和下低参数的传入位置，计算结果将导致错误：

```python
def area(upper_base,lower_bottom,height):
    return (upper_base+lower_bottom)*height/2
print("正确结果为：",area(4,3,5))
print("错误结果为：",area(4,5,3))
```

运行结果：

```python
正确结果为： 17.5
错误结果为： 13.5
```

### Python函数关键字参数及用法

之前我们学习的一直是位置参数，即实参和形参位置要一一对应，顺序不能出现错误。但是当参数过多时，使用位置参数就较为复杂，因此我们可以使用关键字参数。`关键字参数`是指使用形式参数的名字来确定输入的参数值，通过此方式来指定函数实参时，不再需要与形参的位置完全一致，只需要将参数名写正确即可。

```python
def dis_str(str1,str2):
    print("str1:",str1)
    print("str2:",str2)
#位置参数
dis_str("http://c.biancheng.net/python/","http://c.biancheng.net/shell/")
#关键字参数
dis_str("http://c.biancheng.net/python/",str2="http://c.biancheng.net/shell/")
dis_str(str2="http://c.biancheng.net/python/",str1="http://c.biancheng.net/shell/")
```

运行结果：

```python
str1: http://c.biancheng.net/python/
str2: http://c.biancheng.net/shell/
str1: http://c.biancheng.net/python/
str2: http://c.biancheng.net/shell/
str1: http://c.biancheng.net/shell/
str2: http://c.biancheng.net/python/
```

我们发现函数在传参时，可以单独使用位置参数，也可以单独使用关键字参数传参，甚至还可以混用传参的参数方法。

{% note info,

但是一定要注意，混用两者时，所有关键字参数必须位于所有的位置参数之后。

%}

如下的写法就是错误的

```python
# 位置参数必须放在关键字参数之前，下面代码错误
dis_str(str1="http://c.biancheng.net/python/","http://c.biancheng.net/shell/")
```

Python解释器会报如下错误：

```python
SyntaxError: positional argument follows keyword argument
```

### Python函数默认参数设置

我们可以为Python中的函数设置默认值，这样的话，即使调用函数时没有给拥有默认值的形参传递参数，该参数可以直接使用定义函数时设置的默认值。

```python
def 函数名(...，形参名，形参名=默认值)：
    代码块
```

{% note info,

要注意，在使用此格式定义函数时，指定有默认值的形式参数必须在所有没有默认参数的后面，否则会产生语法错误。**同时要注意默认参数必须指向不变对象。**

%}

如下写法就是错误的：

```python
#语法错误
def dis_str(str1="http://c.biancheng.net/python/",str2,str3):
    pass
```

显然，str1 设有默认值，而 str2 和 str3 没有默认值，因此 str1 必须位于 str2 和 str3 之后。

接下来我们看一个正确使用函数默认值的例子：

```python
#str1没有默认参数，str2有默认参数
def dis_str(str1,str2 = "http://c.biancheng.net/python/"):
    print("str1:",str1)
    print("str2:",str2)
dis_str("http://c.biancheng.net/shell/")
dis_str("http://c.biancheng.net/java/","http://c.biancheng.net/golang/")
```

运行结果：

```python
str1: http://c.biancheng.net/shell/
str2: http://c.biancheng.net/python/
str1: http://c.biancheng.net/java/
str2: http://c.biancheng.net/golang/
```

上面程序中，dis_str() 函数有 2 个参数，其中第 2 个设有默认参数。这意味着，在调用 dis_str() 函数时，我们可以仅传入 1 个参数，此时该参数会传给 str1 参数，而 str2 会使用默认的参数，如程序中第 6 行代码所示。当然在调用 dis_str() 函数时，也可以给所有的参数传值（如第 7 行代码所示），这时即便 str2 有默认值，它也会优先使用传递给它的新值。

同时，结合关键字参数，以下 3 种调用 dis_str() 函数的方式也是可以的：

```python
dis_str(str1 = "http://c.biancheng.net/shell/")
dis_str("http://c.biancheng.net/java/",str2 = "http://c.biancheng.net/golang/")
dis_str(str1 = "http://c.biancheng.net/java/",str2 = "http://c.biancheng.net/golang/")
```

你可能会疑惑，对于自己自定义的函数，我们可以轻易知道那个参数有默认值，但是如果使用Python提供的内置函数，又或者其他第三方提供的函数，我们怎么知道那些参数有默认值呢？

在Python中，我们可以使用`函数名.__defaults__`查看函数的默认参数的当前值，其返回值是一个元组，以本节中的 dis_str() 函数为例，在其基础上，执行如下代码：

```python
print(dis_str.__defaults__)
```

程序执行结果为

```python
('http://c.biancheng.net/python/',)
```

### Python函数传入任意个参数(进阶)

#### *args接收任意个位置参数

`*args`是可变参数，args接收的是一个元组tuple,可变参数允许传入0个或者任意个参数，这些可变参数在函数调用时被组装为一个元组，如下所示：

```python
def calc(*numbers):
    sum = 0
    for n in numbers:
        sum = sum + n * n
    return sum

```

例如我们要传入0个或者多个不可变参数

```python
calc（）可传入0到多个参数值
>>> calc(1, 2)
5
>>> calc()
0
```

但是如果此时我们要传递一个列表中的所有元素或者元组中的所有元组又该怎么写呢？我们可以如下书写：

```python
>>> nums = [1, 2, 3]
>>> calc(nums[0], nums[1], nums[2])
14
```

但是如果列表或者元组的元素过多时，操作就会过于繁琐，此时Python允许我们在list或者tuple前面加一个`*`号，把list或者tuple传入：

```python
>>> nums = [1, 2, 3]
>>> calc(*nums)
14
```

#### **kw接收任意个关键字参数

`**kw`是关键字参数，kw接收的是一个字典，关键字参数允许你传入0个或者任意个含参数名的参数，这些关键字参数会在函数内部自动组装成一个字典。

```python
def person(name, age, **kw):
    print('name:', name, 'age:', age, 'other:', kw)
```

假设现在我们传入任意个关键字参数

```python
>>> person('Michael', 30)
name: Michael age: 30 other: {}
>>> person('Bob', 35, city='Beijing')
name: Bob age: 35 other: {'city': 'Beijing'}
>>> person('Adam', 45, gender='M', job='Engineer')
name: Adam age: 45 other: {'gender': 'M', 'job': 'Engineer'}
```

但是如果此时需要传递许多个关键字参数，操作也会很繁琐，因此Python允许我们传递一个字典，只需要在字典dict前加上`**`符号，如下所示：

```python
>>> dict={'gender': 'M', 'job': 'Engineer'}
>>> person('Adam', 45, **dict)
name Adam age 45 other {'gender': 'M', 'job': 'Engineer'}
```

{% note info,

我们要注意由于\*args和\*\*kw都是可以吸收任意个参数，因此一般置于后面，同时根据关键字参数总是要位于位置参数后面，如果同时有*args和\*\*kw存在，**kw要置于后面。

%}

#### 命名关键字参数

我们还可以进一步限制传入的关键字参数的名字，并且一旦声明了命名关键字参数，那么就必须出现否则会报错。

如下所示，如果我们使用**kw来接收任意个关键字参数，那么传入的参数名字可以是任意的，我们可以在函数内部对kw进行校验寻找我们要求出现的关键字参数，但是这样的话仍然会造成传入了许多不需要的关键字参数如下所示：

```python
def person(name, age, **kw):
    if 'city' in kw:
        # 有city参数
        pass
    if 'job' in kw:
        # 有job参数
        pass
    print('name:', name, 'age:', age, 'other:', kw)
但是调用者仍可以传入不受限制的关键字参数：

# addr,zipcode完全不需要，但是也传进来了
>>> person('Jack', 24, city='Beijing', addr='Chaoyang', zipcode=123456)
name: Jack age: 24 other: {'city': 'Beijing', 'addr': 'Chaoyang', 'zipcode': 123456}
```

我们发现上面的代码中我们只是需要两个关键字参数即`city`和`job`，但是此时使用kw却接收了许多没用的关键字参数。那么我们如何实现只接收指定的关键字参数呢？这时就要使用命名关键字参数，他的写法如下：

```python
def person(name, age, *, city, job):
    print(name, age, city, job)
```

此时我们指定接收4个参数，name和age都是位置参数，而特殊分隔符`*`表示后面的所有参数都是指定命名关键字参数（**注意此时city和job不再是位置参数了**）。那么我们在为person函数传递参数时就必须传递两个关键字参数`city`和`job`了。此时指定了两个必须传进的指定名称的关键字参数，多了或者少了都不行

```python
>>>person('Jack', 24, city='chengdu', job='auditor')
Jack 24 chengdu auditor
# 少job报错
>>>person('Jack', 24, city='chengdu')
Traceback (most recent call last):
  File "d:/Pythoncode/Algrithm/test.py", line 4, in <module>
    person('Jack', 24, city='chengdu')
TypeError: person() missing 1 required keyword-only argument: 'job'
# 多sex也报错
>>>person('Jack', 24, city='chengdu', job='auditor',sex="male")
Traceback (most recent call last):
  File "d:/Pythoncode/Algrithm/test.py", line 4, in <module>
    person('Jack', 24, city='chengdu', job='auditor',sex="male")
TypeError: person() got an unexpected keyword argument 'sex'
# 使用位置参数来传递city和job肯定也是不行的
>>>person('Jack', 24, 'chengdu','auditor')
Traceback (most recent call last):
  File "d:/Pythoncode/Algrithm/test.py", line 4, in <module>
    person('Jack', 24, 'chengdu','auditor')
TypeError: person() takes 2 positional arguments but 4 were given
```

{% note info,

命名关键字参数可以简单地理解为必须使用关键字参数的形式传进来的键名必须一致的参数。

%}

但是如果我们已经为命名关键字参数设置了默认值，那么此时可以选择不传：

```python
def person(name, age, *, city='chengdu', job):
    print(name, age, city, job)
由于命名关键字参数city具有默认值，调用时，可不传入city参数：

>>> person('Jack', 24, job='tester')
Jack 24 chengdu tester
```

##### 思考：下面这样的写法错在了哪里？

```python
def person(name, age, **kw, *，city, job):
    print(name, age,kw, city, job)
```

我们发现此时**kw这个可以接收任意个关键字参数的形参写在了city和job这两个命名关键字参数前面，那么很显然无论我们传入多少个关键字参数都会被kw吸收，甚至是`city`换入`job`命名关键字参数也会被kw吸收，因此形参city和job永远不可能被赋值，因此上面的写法错误，我们可以如下改写即为正确：

```python
def person(name, age, *, city, job, **kw,):
    print(name, age, city, job, kw)
>>>person('Jack', 24, city="beijing", job="auditor", sex='male', addr='big house')
Jack 24 beijing auditor {'sex': 'male', 'addr': 'big house'}
```

**也就是说\*\*kw永远不能写到命名关键字形参前面**

##### 思考：如果可变位置参数*args写在关键字命名参数前面会怎样？

虽然\*\*kw不能写到命名关键字参数前面，但是\*args是可以写到前面的，并且此时命名关键字参数前面就无需在加上特殊分隔符`*`了，如下所示：

```python
def person(name, age, *args, city, job, **kw,):
    print(name, age,args, city, job, kw)
>>>person('Jack', 24,"a cool boy","500",city="beijing", job="auditor", sex='male', addr='big house')
Jack 24 ('a cool boy', '500') beijing auditor {'sex': 'male', 'addr': 'big house'}
```

此时person函数先通过位置参数的方法获取了`name`和`age`变量，然后又通过args获取了2个位置参数，紧接着就是两个命名关键字参数`city`和`job`，然后最后面又使用了kw接收剩余的关键字参数`sex`和`addr`。**因此总体上来看，函数接收参数的顺序总是先接收所有的位置参数，然后再接收所有的关键字参数。**

##### 思考：为什么\*args在命名关键字前面时就无需再使用*特殊分隔符号了？

原因很简单，之前我们之所要在命名关键字参数前加上特殊分隔符`*`是为了区分位置参数和命名关键字参数，但是当我们使用了\*args那么所有的位置参数都已经吸收了，后面紧跟着的形参很明显一定是关键字参数了，因此此时我们就无需再使用`*`进行区分了。

##### 思考：下面这样的写法错在了哪里？

```python
def person(*, city, job,name, age, *args, **kw,):
    print(name, age,args, city, job, kw)
```

我们发现此时city和name命名关键字反而写到了位置关键字的前面，很明显违背了`所有关键字参数要位于所有位置参数后面`的原则，那么为什么此时命名关键字参数不能写到前面呢？原因很简单，此时`name`和`age`语义就不明确了，我们无法区分他们到底是位置参数还是命名关键字参数了。

{% note info,

因此一定要记住再复杂的函数传参也一定要保证所有的位置参数在所有关键字参数的前面，顺序可以总结为：

```python
def func(位置参数，默认参数，*args，命名关键字参数，默认参数，**kw)
```

%}

例如如下就是一些包含了所有传参形式的例子，如果你可以理解那么恭喜你进阶成功！

```python
def person(name, age=18, *args, city="chengdu", job, **kw,):
    print(name, age,args, city, job, kw)

>>>person('Jack', 24,"a cool boy","500", job="auditor", sex="male")
Jack 24 ('a cool boy', '500') chengdu auditor {'sex': 'male'}
>>>person('Jack', 24,*("a cool boy","500"), job="auditor", **{"sex":"male"})
Jack 24 ('a cool boy', '500') chengdu auditor {'sex': 'male'}
```

### Python None(空值)

在Python中，有一个特殊的常量None(N必须大写)。他和False,0,[],(),{},""等都不同，None有自己的数据类型，我们可以在IDLE中使用type()函数查看它的类型：

```python
>>> type(None)
<class 'NoneType'>
```

可以看到，它属于NoneType类型，None是NoneType数据类型的唯一值（其他变成语言可能将这个值称为null,nll或者undifined）。也就是说None表示为初始化赋值的一个状态。对于任何函数，如果没有return返回值，或者return关键字后面不带任何值，那么Python默认函数都返回None，比如print()函数

```python
>>> spam = print('Hello!')
Hello!
>>> None == spam
True
```

### Python函数返回多个值

实际上Python就是只能反会有一个值，只不过我们可以使用列表，元组，字典甚至对象将多个返回值进行封装，然后一次性返回封装结果即可实现返回多个值的效果。

#### 使用对象返回

```python
class Test:
    def __init__(self):
        self.str = "hello world!"
        self.x = 20  

# 返回一个对象
def fun():
    return Test()

t = fun() 
print(t.str)
print(t.x)
```

运行结果：

```python
hello world!
20
```

#### 使用列表返回

```python
# 返回一个列表
def fun():
    str = "hello"
    x = 20  
    return [str, x];  

 
list = fun() 
print(list)
```

运行结果：

```python
['hello', 20]
```

#### 使用元组返回

```python
# 返回一个元组
def fun():
    str = "你好！"
    x   = 2022
    return str, x;

str, x = fun() # Assign returned tuple
print(str)
print(x)
```

运行结果：

```python
你好！
2022
```

#### 使用字典返回

```python
# 返回一个字典
def fun():
    d = dict(); 
    d['name'] = "欧阳克"
    d['age']   = 25
    return d

d = fun() 
print(d)
```

运行结果：

```python
{'name': '欧阳克', 'age': 25}
```

