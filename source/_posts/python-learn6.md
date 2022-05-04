---
title: python学习笔记--python基础(6)
comments: false
top: false
date: 2022-01-21 15:55:19
tags: [python]
categories: 
	- [个人笔记,Python基础]

---

python基础入门笔记，记录翀翀对Python基础的理解与总结，常言道：一分耕耘，一分收获。”在自己的理想道路上，多动脑筋，不断的思考，不停地学习，四肢能勤，不断地“书读百遍”，就会“其义自现”。愿你我都能坚持学习😁

<!-- more -->

### Python partial偏函数

简单的理解偏函数，他是对原始函数的二次封装，是将现有函数的部分参数预先绑定为指定值，从而得到一个新的函数，这个函数就成为偏函数。相比原函数，偏函数具有较少的可变参数，从而降低了函数调用的难度。

偏函数的定义需要使用关键字`partial`（位于模块functools中）。他的语法格式如下：

```python
偏函数名 = partial(func, *args, **kwargs)
```

我们在学习了函数的各种接收方法以后，很容易就可以理解后两个参数的意思。\*args用来接收所有的位置参数，而**kwargs用来接收所有的关键字参数，如下是一个偏函数的应用例子：

```python
from functools import partial
#定义个原函数
def display(name,age):
    print("name:",name,"age:",age)
#定义偏函数，其封装了 display() 函数，并为 name 参数设置了默认参数
GaryFun = partial(display,name = 'Gary')
#由于 name 参数已经有默
```

运行结果：

```python
name: Gary age: 13
```

**我们要注意，对于第8行代码，必须采用关键字参数的形式给age形参传值，因为如果以无关键字参数的方式，该实参将试图传递给name形参，Python编辑器会报TypeError错误。**

{% note info,

为了方便正确设置默认值，一般情况下我们最好在对偏函数定义设置默认值时使用关键字参数形式，然后调用再使用位置参数的形式。

%}

当然如果你对参数的传递非常熟悉，那么可以使用位置参数传递，如下是一个使用位置参数为偏函数设置参数默认值的例子：

```python
from functools import partial
def mod( n, m ):
  return n % m
#定义偏函数，并设置参数 n 对应的实参值为 100
mod_by_100 = partial( mod, 100 )
print(mod( 100, 7 ))
print(mod_by_100( 7 ))
```

运行结果:

```python
2
2
```

**注意此时mod_by_100相当于只需要再接收一个m参数了，n并不需要在接收了**，因此此时如果像下面这样调用会出错：

```python
>>>print(mod_by_100( 100,7 ))
Traceback (most recent call last):
  File "d:/Pythoncode/Algrithm/test.py", line 8, in <module>
    print(mod_by_100( 100,7 ))
TypeError: mod() takes 2 positional arguments but 3 were given
```

{% note info,

因此我们可以理解为此时mod_by_100是一个新函数，他只需要接收一个参数，然后就会计算出100% n的值，只不过他的具体实现是基于mod实现的。因此它实现了函数的参数截取。

%}

结合上面的例子，我们不难看出实际上偏函数的运行本质上还是调用了原始函数，只不过是对，原始函数进行了封装，将原函数的一些不需要改变的形参设置了默认值，然后对外部用户只暴露剩下的参数。这种通过将任意数量（顺序）的参数，转化为另一个带有剩余参数的函数对象，从而实现了截取函数功能（偏向）的效果。在实际应用中，可以使用一个原函数，然后将其封装多个偏函数，在调用函数时全部调用偏函数，一定程度上可以提高程序的可读性。

### Python函数递归

#### 函数递归

函数递归就是一个函数不断的调用自身的过程，他往往需要一个终止条件以便能够跳出递归继续向下执行代码。但是有时候我们会由于代码逻辑的缺陷问题，导致函数递归缺失终止条件，那么此时程序并不会真的一直向下递归调用执行，而是在递归调用997次以后停止并报错RecursionError。这是因为在Python中，默认的最大递归次数是997次。

```python
count=0
def func():
    global count
    count+=1
    print(count)
    func()
func()
#最大打印出997，最后报错
```

如果我们需要修改默认的最大递归次数，方法如下：

```python
import sys
sys.setrecursionlimit(修改后的值)
```

#### 递归实例

我们以二分法查找列表l中数字num的索引熟悉一下函数的递归

```python
def search(l, num, start=None, end=None):
    start = start if start else 0
    end = end if end else len(l)-1
    mid = (end-start)//2+start
    if l[mid] > num:
        return search(l, num, start, mid-1)
    elif l[mid] < num:
        return search(l, num, mid+1, end)
    elif l[mid] == num:
        return mid

# 默认要寻找的数存在，否则会报错
l = [2, 3, 5, 10, 15, 16, 18, 22, 26, 30, 32, 35, 41,
     42, 43, 55, 56, 66, 67, 69, 72, 76, 82, 83, 88]
print(search(l, 67))
```

{% note info,

我们只需要记住，递归需要一个终止条件同时还要注意最大递归次数即可。

%}

### Python变量作用域

#### Python局部变量

在函数内部定义的变量，他的作用域也仅限于函数内部，出了函数就不能使用了，我们将这样的变量称为`局部变量`。

当函数被执行时，Python会为其分配一块临时的存储空间，所有在函数内部定义的变量，都会存储在这块空间中。而在函数执行完毕后，这块临时存储空间随即会被释放并回收，该空间中存储的变量自然也就无法再被使用。

```python
def demo():
    add = "hello"
    print("函数内部 add =",add)
demo()
print("函数外部 add =",add)
```

运行结果：

```python
函数内部 add = hello
Traceback (most recent call last):
  File "C:\Users\mengma\Desktop\file.py", line 6, in <module>
    print("函数外部 add =",add)
NameError: name 'add' is not defined
```

我们可以看到，如果试图在函数外部访问其内部定义的变量，那么Python解释器会报NameError错误，并且提示我们没有定义要访问的变量，这也证实了当函数执行完毕后，其内部定义的变量会被销毁并回收。

我们还要注意，函数接收的参数也属于局部变量，只能在函数内部使用：

```python
def demo(name,add):
    print("函数内部 name =",name)
    print("函数内部 add =",add)
demo("Python教程","http://c.biancheng.net/python/")
print("函数外部 name =",name)
print("函数外部 add =",add)
```

运行结果：

```python
函数内部 name = Python教程
函数内部 add = http://c.biancheng.net/python/
Traceback (most recent call last):
  File "C:\Users\mengma\Desktop\file.py", line 7, in <module>
    print("函数外部 name =",name)
NameError: name 'name' is not defined
```

我们可以看到name变量和add变量形参只能在函数内部使用，外部也是无法使用的。因为函数执行完成以后会立即销毁存储这些函数相关变量的存储空间。

#### Python全局变量

除了在函数内部定义变量，Python还允许我们在所有函数的我外部定义变量，这样的变量我们成为`全局变量`。和局部变量不同，全局变量的默认作用域是整个程序，即全局变量既可以在各个函数的外部使用，也可以在各函数内部使用。

定义全局变量的方式有以下两种：

##### 一、在函数体外部定义的变量

```python
add = "http://coolchong.cn"
def text():
    print("函数体内访问：",add)
text()
print('函数体外访问：',add)
```

运行结果：

```python
函数体内访问： http://coolchong.cn
函数体外访问： http://coolchong.cn
```

##### 二、 在函数体内定义全局变量

我们可以使用`global`关键字对变量进行修饰，这样这个变量就变成了全局变量，即使此时他是在函数内部定义的：

```python
ef text():
    global add
    add= "http://coolchong.cn/"
    print("函数体内访问：",add)
text()
print('函数体外访问：',add)
```

运行结果：

```python
函数体内访问： http://coolchong.cn/
函数体外访问： http://coolchong.cn/
```

{% note info,

我们要注意使用global关键字修饰变量时，不能直接给变量赋初值，否则会引发语法错误。

%}

#### 获取指定作用域范围中的变量

在一些特定场景中，我们可能需要某个作用域内（全局范围内或者局部范围内）所有的变量，Python中提供了一下3种方式：

##### 1）globals()函数

globals()函数为Python的内置函数，他可以返还一个包含全局范围内所有的变量的字典，该字典中的每个键值对，键为变量名，值为该变量的值。

```python
#全局变量
Pyname = "Python教程"
Pyadd = "http://c.biancheng.net/python/"
def text():
    #局部变量
    Shename = "shell教程"
    Sheadd= "http://c.biancheng.net/shell/"
print(globals())
```

运行结果：

```python
{ ...... , 'Pyname': 'Python教程', 'Pyadd': 'http://c.biancheng.net/python/', ......}
```

{% note info,

注意globals()函数返还的字典中，不仅仅包含我们定义的全局变量，还有许多默认包含的变量，他们是Python主程序内置的，我们可以不用理会。

%}

可以看到，通过调用globals()函数我们可以得到一个包含所有全局变量的字典，并且通过字典，我们可以访问指定的全局变量，如果需要，我们还可以修改它的值：

```python
print(globals()['Pyname'])
globals()['Pyname'] = "Python入门教程"
print(Pyname)
```

运行结果：

```python
Python教程
Python入门教程
```

##### 2）locals()函数

locals()函数也是Python内置函数之一，通过调用这个函数，我们可以得到一个包含当前作用域内所有变量的字典。当在函数内部调用locals()函数，会得到包含所有局部变量的字典，而在全局范围内调用locals()函数，其功能就和globals()函数功能完全相同。

```python
#全局变量
Pyname = "Python教程"
Pyadd = "http://c.biancheng.net/python/"
def text():
    #局部变量
    Shename = "shell教程"
    Sheadd= "http://c.biancheng.net/shell/"
    print("函数内部的 locals:")
    print(locals())
text()
print("函数外部的 locals:")
print(locals())
```

运行结果：

```python
函数内部的 locals:
{'Sheadd': 'http://c.biancheng.net/shell/', 'Shename': 'shell教程'}
函数外部的 locals:
{...... , 'Pyname': 'Python教程', 'Pyadd': 'http://c.biancheng.net/python/', ...... }
```

**但是我们要注意，当使用locals()函数获得所有局部变量组成的字典时，可以像globals()函数那样，通过指定键访问对应的变量值，但是我们无法对变量值进行修改**

```python
#全局变量
Pyname = "Python教程"
Pyadd = "http://c.biancheng.net/python/"
def text():
    #局部变量
    Shename = "shell教程"
    Sheadd= "http://c.biancheng.net/shell/"
    print(locals()['Shename'])
    locals()['Shename'] = "shell入门教程"
    print(Shename)
text()
```

运行结果：

```python
shell教程
shell教程
```

##### 3）vars(object)

vars()函数也是Python内置函数之一，其功能是返回一个指定object对象范围内所有变量组成的字典，如果不传入object参数，vars()和globals()的作用完全相同。

```python
 #全局变量
Pyname = "Python教程"
Pyadd = "http://c.biancheng.net/python/"
class Demo:
    name = "Python 教程"
    add = "http://c.biancheng.net/python/"
print("有 object：")
print(vars(Demo))
print("无 object：")
print(vars())
```

运行结果：

```python
有 object：
{...... , 'name': 'Python 教程', 'add': 'http://c.biancheng.net/python/', ......}
无 object：
{...... , 'Pyname': 'Python教程', 'Pyadd': 'http://c.biancheng.net/python/', ...... }
```

### Python在函数内部使用同名的全局变量

首先我们要明确，函数可以直接不接收参数就直接使用全局变量如下所示：

```python
name = 'Charlie'
def test ():
    # 直接访问name全局变量
    print(name) # Charlie
test()
print(name)
```

运行结果：

```python
Charlie
Charlie
```

此时写法是正确的，相当于test()函数直接打印了全局变量name，同时在函数外部主程序内又打印了一遍全局变量name，因此两个输出结果均为Charlie。

同时当函数内部出现了同名的局部变量，那么局部变量会覆盖之前的全局变量的值，即函数默认将同名变量视为局部变量进行使用，因此如下所示

```python
name = 'Charlie'
def test ():
    name="wenchong"
    print(name) # wenchong
test()
print(name)
```

运行结果：

```python
wenchong
Charlie
```

此时test()函数内部声明了一个name局部变量并且将值设置为了wenchong，因此此时输出结果如下所示，即在test()函数内部局部变量name覆盖掉了全局变量name。但是我们假如将`name="wenchong"`放到`print(name)`下方会怎样？

```python
name = 'Charlie'
def test ():
    print(name) 
    name="wenchong"
test()
print(name)
```

运行结果：

```python
UnboundLocalError : local variable ‘name’ referenced before assignment
```

我们发现此时报错了！原因是此时test()会将namne视为局部变量，那么很显然`print(name)`代码打印的是局部变量的值，但是此时局部变量name还未进行赋值，因此报错了。

实际上此时上面的代码本意是打印全局变量name的值，然后再声明一个全局变量name并且赋值为字符串wenchong,那么此时怎么实现呢？很显然我们并不能直接在函数内部将name声明为`global`全局变量类型，因为这样会导致函数执行结束以后全局变量name也发生了改变导致输出的结果为

```python
Charlie
wenchong
```

但是实际上我们希望输出的结果为

```python
Charlie
Charlie
```

即在test()函数内部定义了局部变量name赋值为wenchong，同时两次打印使用的都是全局变量name，那么此时我们就会用到之前我们学习的`globals()`函数了，代码改为：

```python
name = 'Charlie'
def test ():
    print(globals()['name']) # Charlie
    #也可以写为 print(globals.getr('name'))
    name="wenchong"
test()
print(name) #Charlie
```

为了验证此时函数内部的name确实为局部变量，我们可以使用如下代码测试：

```python
name = 'Charlie'
def test ():
    print(globals().get('name')) # wenchong
    name="wenchong"
    print(name)
test()
print(name)
```

运行结果：

```python
Charlie
wenchong
Charlie
```

### Python局部函数详解

通过前面的学习我们已经知道Python支持局部变量了，那么Python是否支持局部函数呢？即Python函数内部可以在定义函数吗？答案是可以得。Python支持在函数内部定义函数，此类函数就被成为局部函数。

```python
#全局函数
def outdef ():
    #局部函数
    def indef():
        print("hello world")
    #调用局部函数
    indef()
#调用全局函数
outdef()
```

运行结果：

```python
hello world
```

和全局函数返回其局部变量从而扩大这个变量的作用域一样，通过将局部函数函数作为函数的返回值，也可以扩大局部函数的使用范围，比如：

```python
#全局函数
def outdef ():
    #局部函数
    def indef():
        print("调用局部函数")
    #调用局部函数
    return indef
#调用全局函数
new_indef = outdef()
调用全局函数中的局部函数
new_indef()
```

运行结果：

```python
调用局部函数
```

此时这个局部函数作用域就扩大了，他可以脱离父函数作用而在全局内使用。因此我们可以总结出以下规律：

1. 如果所在函数并没有返还局部函数，那么这个局部函数的可用范围仅限于所在函数内部
2. 反之，如果所在函数将局部函数作为返回值，那么局部函数的作用域就会扩大，既可以在函数内部使用，也可以在所在函数的作用域中使用。

同时我们要注意一个问题，**局部函数内部是一个新的作用域，因此如果局部函数中定义了和所在函数中变量同名的变量，也会发生遮蔽问题。**

```python
#全局函数
def outdef ():
    name = "所在函数中定义的 name 变量"
    #局部函数
    def indef():
        print(name)
        name = "局部函数中定义的 name 变量"
    indef()
#调用全局函数
outdef()
```

此时indef()函数内是一个新的作用域，并且此时在内部又定义了一个新的局部变量name，因此此时很明显会报错，Python解释器会报如下错误：

```python
UnboundLocalError: local variable 'name' referenced before assignment
```

那么为了解决这个问题，我们应该怎么样修改代码呢？ 很明显此时无论是使用`global`关键字还是内置函数`globals()`、`locals()`都无法解决错误。此时我们需要使用Python提供的关键字`nonlocal`，顾名思义不是局部变量，那么此时他就会取消遮蔽效果获取到局部函数所在父函数作用域的变量`name`的值：

```python
#全局函数
def outdef ():
    name = "所在函数中定义的 name 变量"
    #局部函数
    def indef():
        nonlocal name
        print(name)
        #修改name变量的值
        name = "局部函数中定义的 name 变量"
    indef()
#调用全局函数
outdef()
```

运行结果：

```python
所在函数中定义的 name 变量
```

### Python函数高级使用方法

前面我们已经学习函数的基础用法，接下来我们再学习一些高级用法。首先Python允许直接将函数赋值给变量，这样做的效果是，程序也可以用其他变量来调用函数，更加灵活。

```python
def my_def ():
    print("正在执行 my_def 函数")
#将函数赋值给其他变量   
other = my_def
#间接调用 my_def() 函数
other()
```

运行结果：

```python
正在执行 my_def 函数
```

不仅如此，Python还支持将函数以参数的形式传入其他函数，例如：

```python
def add (a,b):
    return a+b
def multi(a,b):
    return a*b
def my_def(a,b,dis):
    return dis(a,b)
   
#求 2 个数的和
print(my_def(3,4,add))
#求 2 个数的乘积
print(my_def(3,4,multi))
```

运行结果：

```python
7
12
```

我们可以看到上面的代码中my_def接收的第三个参数是一个函数，然后将前两个接收的参数传给第三个函数参数去执行，因此函数可以作为参数传递。

### Python闭包函数

闭包，又称为闭包函数或闭合函数，其实和前面我们学习的嵌套函数类似，不同之处在于，闭包中外部函数返回的不是一个具体的值，而是一个函数。一般情况下， 返回的函数会赋值给一个变量，这个变量可以在后面被继续执行调用。

例如，现在我们要实现一个计算数的n次幂的函数，那么用闭包可以如下实现：

```python
#闭包函数，其中 exponent 称为自由变量
def nth_power(exponent):
    def exponent_of(base):
        return base ** exponent
    return exponent_of # 返回值是 exponent_of 函数
square = nth_power(2) # 计算一个数的平方
cube = nth_power(3) # 计算一个数的立方
print(square(2))  # 计算 2 的平方
print(cube(2)) # 计算 2 的立方
```

运行结果：

```python
4
8
```

在上面的程序中，外部函数nth_power()的返回值是函数exponent__of()，而不是一个具体的数值。这个返还的exponent_of函数还需要接收一个base变量，nth_power()只是将exponent_of内部的exponent变量进行了赋值。

**因此，在执行完`square=nth_power(2)`和`cube=nth_power(3)`后，外部函数nth_power()的参数exponent会和内部函数exponent_of一起赋值给square和cube，这样在之后调用square(2）和cube(2)时，程序就能顺利的输出结果，而不会报错exponent变量没有定义**

但是你可能会疑惑我们为什么非要使用闭包来实现上面的功能呢？完全可以下面这种简单的形式：

```python
def nth_power_rewrite(base, exponent):
    return base ** exponent
```

上面的程序确实也可以实现相同的功能，不过使用闭包，可以让程序变得更加简洁易读。设想一下，比如我们现在需要计算很多个数的平方，那么闭包函数的写法明显更好：

```python
# 不使用闭包
res1 = nth_power_rewrite(base1, 2)
res2 = nth_power_rewrite(base2, 2)
res3 = nth_power_rewrite(base3, 2)
# 使用闭包
square = nth_power(2)
res1 = square(base1)
res2 = square(base2)
res3 = square(base3)
```

采用闭包的第二个形式，表达更为简单，每次调用函数时，我们都可以少输入一个参数。

#### 思考：闭包还有什么优势？

如果仅仅是减少输入参数，貌似闭包优点大材小用了，毕竟闭包很难构思，难道优势仅仅是降低操作的难度吗？当然不是，闭包的优点和缩减嵌套函数的优点类似，我们知道每一个函数开头都需要做一些额外工作，那么当多次调用该函数时，每次都需要重复初始化工作，但是如果我们将这些额外工作统一放置到外部函数中，用闭包返还内部函数，就可以减少多次调用导致的不必要的开销，提高程序的运行效率。

#### Python闭包的\_\_closure\_\_属性

闭包函数比普通的函数多了一个\_\_closure\_\_属性，这个属性记录着自由变量的地址。当闭包被调用时，系统就会根据该地址找到对应的自由变量，完成整体的函数调用。

以nth_power()为例，当其被调用时，可以通过\_\_closure\_\_属性获取自由变量（也就是程序中的exponent参数）存储的地址，例如：

```python
def nth_power(exponent):
    def exponent_of(base):
        return base ** exponent
    return exponent_of
square = nth_power(2)
#查看 __closure__ 的值
print(square.__closure__)
```

运行结果：

```python
(<cell at 0x0000014454DFA948: int object at 0x00000000513CC6D0>,)
```

可以看到，显示的内容是一个int整数类型，这就是square中自由变量exponent的初始值，还可以看到，\_\_closure\_\_属性的类型是一个元组，这表明闭包可以支持多个自由变量的形式。

### Python lambda表达式(匿名函数）

对于一个简单的函数，Python还提供了另外一种方法，即lambda表达式。lambda表达式，又称为匿名函数，常用来表示内部仅包含一行表达式的函数。如果一个函数的函数体仅有一行表达式，那么这个函数就可以使用lambda表达式来代替。

lambda表达式的语法格式如下：

```python
name = lambda [list] : 表达式
```

其中，定义lambda表达式时，必须使用lambda关键字，[list]作为可选参数，等同于定义函数时指定的参数列表或者元组用来接收参数，name为表达式的名称。

如果将lambda表达式转换为普通函数的形式就如下方所示：

```python
def name(list):
    return 表达式
name(list)
```

接下来我们尝试使用一个lambda表达式解决求两个数之和的问题：

```python
add = lambda x,y:x+y
print(add(3,4))
```

运行结果：

```python
7
```

使用lambda表达式的优势有：

1. 对于单行函数，使用lambda表达式可以省去定义函数的过程，让代码更加简洁
2. 对于不需要多次复用的函数，使用lambda表达式可以在用完之后立即释放，提高程序执行的性能

### Python eval()和exec()函数

eval()和exec()函数都属于Python内置函数，两个函数的功能是类似的，都可以执行一个字符串形式的Python代码（代码以字符串的形式提供），相当于一个Python的解释器。而这不同之处在于，eval()执行完要返回结果，而exec()执行完不返回结果。

#### eval()和exec()的用法

eval()函数的语法格式如下：

```python
eval(source, globals=None, locals=None, /)
```

而exec()函数的语法格式如下：

```python
exec(source, globals=None, locals=None, /)
```

两者除了函数名不同，其他都相同，各个参数的具体含义为：

- expression：这个参数是一个字符串，代表要执行的语句。该语句受后面两个字典类型参数globals和locals的限制，只有在globals字典和locals字典作用域内的变量和函数才能被执行。
- globals：这个参数管控的是一个全局的命名空间，即expression可以使用全局命名空间中的函数。如果只是提供了globals参数，而没有提供自定义的 \_\_builtins\_\_，则系统会将当前环境中的\_\_builtins\_\_复制到自己提供的globals中，然后才会进行计算。如果连globals这个参数都没有被提供，那么使用Python的全局命名空间。
- locals：这个参数管控的是一个局部命名空间，和globals类似，当它和globals中有重复或冲突时，以locals为准。如果locals没有被提供，那么默认为globals。

{% note info,

注意，\_\_builtins\_\_ 是 Python 的内建模块，平时使用的 int、str、abs 都在这个模块中。通过 print(dic[\_\_builtins\_\_]) 语句可以查看 \_\_builtins\_\_ 所对应的 value。

%}

```python
dic={} #定义一个字
dic['b'] = 3 #在 dic 中加一条元素，key 为 b
print (dic.keys()) #先将 dic 的 key 打印出来，有一个元素 b
exec("a = 4", dic) #在 exec 执行的语句后面跟一个作用域 dic
#全局域字典dic很明显会增加一个新的全局变量a
print(dic.keys()) #exec 后，dic 的 key 多了一个
```

运行结果：

```python
dict_keys(['b'])
dict_keys(['b', '__builtins__', 'a'])
```

上面的代码是在作用域 dic 下执行了一句 a = 4 的代码。可以看出，exec() 之前 dic 中的 key 只有一个 b。执行完 exec() 之后，系统在 dic 中生成了两个新的 key，分别是 a 和\_\_builtins\_\_。其中，a 为执行语句生成的变量，系统将其放到指定的作用域字典里；\_\_builtins\_\_是系统加入的内置 key。

我们再看一个例子：

```python
a=10
b=20
c=30
g={'a':6, 'b':8} #定义一个字典
t={'b':100, 'c':10} #定义一个字典
print(eval('a+b+c', g, t)) #定义一个字典 116
```

运行结果：

```python
116
```

为什么结果为116呢？首先我们设置了eval()函数的全局域为`{'a':6, 'b':8}`，然后又设置了局部域为`{'b':100, 'c':10}`。但是根据之前的讲解，当globals和locals有冲突时，会产生局部域遮蔽全局域冲突变量的情况，因此此时实际上`a+b+c`执行的时候，a用全局域中的6，b和c都是使用局部域中的100和10，因此最终结果为116。

 我们会发现eval函数中执行代码时变量的值与eval所处的域中变量值并不同，这是因为我们重新为其传入了globals和locals，假设此时我们不设置globals如下所示，那么此时eval()的globals将会继承当前的全局域，因此a为10，代码执行结果为120

```python
a=10
b=20
c=30
g={'a':6, 'b':8} #定义一个字典
t={'b':100, 'c':10} #定义一个字典
print(eval('a+b+c', None, t)) #定义一个字典 120
```

以此类推，假设此时我们globals和locals都不设置，那么运行结果将是60

```python
a=10
b=20
c=30
g={'a':6, 'b':8} #定义一个字典
t={'b':100, 'c':10} #定义一个字典
print(eval('a+b+c')) #定义一个字典 60
```

#### exec()和eval()的区别

前面我们讲过，eval()执行完结果会返还，而exec()执行完并不会返还结果，举个例子：

```python
a = 1
exec("a = 2") #相当于直接执行 a=2
print(a)
a = exec("2+3") #相当于直接执行 2+3，但是并没有返回值，a 应为 None
print(a)
a = eval('2+3') #执行 2+3，并把结果返回给 a
print(a)
```

运行结果：

```python
2
None
5
```

**当我们为eval()里放置一个没有结果返回的语句时，Python解释器将会报SyntaxError错误**

```python
>>>a= eval("a = 2")
Traceback (most recent call last):
  File "d:/Pythoncode/Algrithm/test.py", line 1, in <module>
    a= eval("a = 2")
  File "<string>", line 1
    a = 2
      ^
SyntaxError: invalid syntax
```

#### eval()和exec()函数的应用场景

在使用Python开发服务端程序时，两个函数应用的非常广泛，例如客户端向服务端发送一段字符串代码，服务端无需关心具体的内容，直接通过 eval() 或 exec() 来执行，这样的设计会使服务端与客户端的耦合度更低，系统更易扩展。

另外，如果以后接触 [TensorFlow](http://c.biancheng.net/tensorflow/) 框架，就会发现该框架中的静态图就是类似这个原理实现的：

- TensorFlow 中先将张量定义在一个静态图里，这就相当将键值对添加到字典里一样；
- TensorFlow 中通过 session 和张量的 eval() 函数来进行具体值的运算，就当于使用 eval() 函数进行具体值的运算一样。


需要注意的是，在使用 eval() 或是 exec() 来处理请求代码时，函数 eval() 和 exec() 常常会被黑客利用，成为可以执行系统级命令的入口点，进而来攻击网站。解决方法是：通过设置其命名空间里的可执行函数，来限制 eval() 和 exec() 的执行范围。

### Python函数式编程

所谓函数式编程，就是指代码中每一块都是不可变的，都由纯函数的形式组成。这里的纯函数，是指函数本身相互独立、互相影响，对于相同的输入，总会有相同的输出。

{% note info,

函数式编程的一大特点，就是允许把函数本身作为参数传入另一个函数，还允许返回一个函数。

%}

假设现在我们想让列表中的元素值都变为原来的两倍，可以使用如下函数实现：

```python
def multiply_2(list):
    for index in range(0, len(list)):
        list[index] *= 2
    return list
```

要注意，这段代码并不是一个纯函数的形式，因为列表中的元素的值都被改变了，如果多次调用multiply_2()函数，那么每次得到的结果都是不一样的。

而如果想让multiply_2()成为一个纯函数的形式，就得重新创建一个新的列表并返回，也就是写成下面这种形式：

```python
def multiply_2_pure(list):
    new_list = []
    for item in list:
        new_list.append(item * 2)
    return new_list
```

对比上面两种写法，我们可以发现第一种写法中是直接修改了输入列表的元素，而第二种写法是返回了一个新的列表，新的列表存储了操作后的结果元素，并未修改原列表。**第二种写法无论传入多少次list，返回的结果都是一样的。**函数式编程的优点，就是其纯函数和不可变的特性使程序更加健壮，易于调试和测试，但是缺点是限制多，难写。

纯粹的函数式编程语言（比如Scala)，其编写的函数中是没有变量的，因此可以保证，只要输入是确定的，输出就是确定的。而允许使用变量的程序设计语言，由于函数内部的变量状态不确定，因此同样的输入，可能也会得到不同的输出。

Python允许使用变量，所以他并不是一门纯函数式编程语言。Python仅对函数式编程提供了部分支持，主要包括map()，filter()和reduce()这3个函数。他们通常都和lambda匿名函数一起使用。

#### Python map()函数

```python
map(function, iterable)
```

其中，fucntion参数表示要传入一个函数，其可以是内置函数、自定义函数或者lambda匿名函数，iterable表示一个或者多个可迭代对象，可以是列表、字符串等。

map()函数的功能是对每一个可迭代对象中的每个元素，都调用指定的函数，并且返回一个map()对象。**由于返回的是一个map()对象，因此不能直接输出，可以通过for循环或者list()函数来显示。**

我们还是实现对列表中的每一个元素都乘2的功能：

```python
listDemo = [1, 2, 3, 4, 5]
new_list = map(lambda x: x * 2, listDemo)
print(list(new_list))
```

运行结果：

```python
[2， 4， 6， 8， 10]
```

并且map()支持传入多个可迭代对象作为参数

```python
listDemo1 = [1, 2, 3, 4, 5]
listDemo2 = [3, 4, 5, 6, 7]
new_list = map(lambda x,y: x + y, listDemo1,listDemo2)
print(list(new_list))
```

运行结果：

```python
[4, 6, 8, 10, 12]
```

由于map()函数是直接使用C语言写的，运行时不需要通过Python解释器间接调用，并且内部做了诸多优化，所以相比其他方法，此方法的运行效率更高。

#### Python filter()函数

```python
filter(function, iterable)
```

此格式中，fucntion参数要传入一个函数，iterable表示一个可迭代对象。

filter()函数的功能是对iterable中的每一个元素，都使用function函数判断，并返回True或者False，最后将True的元素组成一个新的可遍历的集合。即`元素筛选`。

```python
listDemo = [1, 2, 3, 4, 5]
new_list = filter(lambda x: x % 2 == 0, listDemo)
print(list(new_list))
```

运行结果：

```python
[2, 4]
```

#### Python reduce()函数

reduce() 函数通常用来对一个集合做一些累积操作，其基本语法格式为：

```python
reduce(function, iterable)
```

function参数必须是一个包含两个参数的函数，iterable表示可迭代对象。

{% note info,

注意，由于 reduce() 函数在 Python 3.x 中已经被移除，放入了 functools 模块，因此在使用该函数之前，需先导入 functools 模块。

%}

假设我们要计算某个列表所有元素的乘积

```python
import functools
listDemo = [1, 2, 3, 4, 5]
product = functools.reduce(lambda x, y: x * y, listDemo)
print(product)
```

运行结果:

```python
120
```

#### 总结

通常来说，当对集合中的元素进行一系列操作时，如果操作非常简单，比如累加、累积这种，那么优先考虑使用map()，filter()，reduce()等实现，另外，在数据量非常多的情况下（比如机器学习的应用），一般更倾向于使用函数式编程的表示，因为效率更高。

当然，在数据量不多的情况下，使用for循环等方式也是可以的，不过，如果要对集合中的元素做一些比较复杂的操作，考虑到代码的可读性，通常会使用for循环。