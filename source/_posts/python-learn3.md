---
title: python学习笔记--python基础(3)
comments: false
top: false
date: 2022-01-17 14:31:27
tags: [python]
categories: 
	- [个人笔记,Python基础]
---

python基础入门笔记，记录翀翀对Python基础的理解与总结，常言道：一分耕耘，一分收获。”在自己的理想道路上，多动脑筋，不断的思考，不停地学习，四肢能勤，不断地“书读百遍”，就会“其义自现”。愿你我都能坚持学习😁

<!-- more -->

### Python tuple元组详解

元组（tuple)是Python中另一个重要的序列结构，和列表类似，元组也是由一系列按特定顺序排列的元组组成。但是他和list列表又有所区别如下：

- 列表的元素是可以更改的，包括修改元素值，删除和插入元素，所以列表是可变序列；
- 而元组一旦被创建，它的元素就不可更改了，所以元组是不可变序列。

元组可以看成是不可变的列表，**因此他不提供append()，remove()等方法同时也不支持`del tuple[idx]`删除元组的方法**。

```python
>>> tup=(1,2,3)
>>> del tup(0)
  File "<stdin>", line 1
SyntaxError: cannot delete function call
```

通常情况下，元组用于保存无需修改的内容。从形式上看，元组的所有元素都放在一对小括号`()`中，相邻元素之间用逗号`,`分隔，如下所示：

```python
(element1, element2, ... , elementn)
```

其中 element1~elementn 表示元组中的各个元素，个数没有限制，只要是 Python 支持的数据类型就可以。**因此元组中也可以存储若干个类型不同的数据，但是为了提高可读性，一般也存储相同类型的数据**。

```python
("c.biancheng.net", 1, [2,'a'], ("abc",3.0))
```

{%  note info,

要注意元组tuple和列表list是两种不同的数据结构，他们的type类型并不相同！

%}

```python
>>> type( ("c.biancheng.net",1,[2,'a'],("abc",3.0)) )
<class 'tuple'>
```

#### Python创建元组

Python中元组的创建和list类似也有两种创建方法

##### 1）使用()创建

通过()创建元组以后，一般使用`=`将它赋值给某个变量，具体格式为：

```python
tuplename = (element1, element2, ..., elementn)
```

其中，tuplename表示变量名，element1~elementn表示元组存储的元素。如下所示：

```python
num = (7, 14, 21, 28, 35)
course = ("Python教程", "http://coolchong.cn")
abc = ( "Python", 19, [1,2], ('c',2.0) )
```

在Python中，元组通常都是使用一对小括号将所有元素包围起来的，但是小括号不是必须的，只要将各元素用逗号分隔，Python就会将其视为元组，如下也是元组：

```python
course = "Python教程", "http://coolchong.cn"
print(course)
```

运行结果：

```python
('Python教程', 'http://coolchong.cn')
```

**要特别注意，当创建的元组中只有一个字符串类型的元素时，该元素后面必须要加一个逗号`,`**，否则Python解释器会将它视为字符串，如下所示：

```python
>>> a=("https://coolchong.cn/",)
>>> print(type(a))
<class 'tuple'>
>>> b=("https://coolchong.cn/")
>>> print(type(b))
<class 'str'>
```

##### 2)使用tuple()函数创建元组

除了使用`()`创建元组外，Python还提供了一个内置的函数tuple()，可以用来将其他数据类型转换为元组类型。tuple()的语法格式如下：

```python
tuple(data)
```

其中data表示可以转换为元组的数据，包含字符串、元组、range()对象等。

```python
#将字符串转换成元组
tup1 = tuple("hello")
print(tup1)
#将列表转换成元组
list1 = ['Python', 'Java', 'C++', 'JavaScript']
tup2 = tuple(list1)
print(tup2)
#将字典转换成元组
dict1 = {'a':100, 'b':42, 'c':9}
tup3 = tuple(dict1)
print(tup3)
#将区间转换成元组
range1 = range(1, 6)
tup4 = tuple(range1)
print(tup4)
#创建空元组
print(tuple())
```

运行结果：

```python
('h', 'e', 'l', 'l', 'o')
('Python', 'Java', 'C++', 'JavaScript')
('a', 'b', 'c')
(1, 2, 3, 4, 5)
()
```

#### Python访问元组元素

和列表一样，我们也可以使用索引(Index)访问元组的某个元素（得到的是一个元素的值），也可以使用切片访问元组的一组元素(得到的是一个新的子元组)。

```python
#访问单个元素
tuplename[i]
#访问一组元素
tuplename[start : end : step]
```

```python
url = tuple("http://c.biancheng.net/shell/")
#使用索引访问元组中的某个元素
print(url[3])  #使用正数索引
print(url[-4])  #使用负数索引
#使用切片访问元组中的一组元素
print(url[9: 18])  #使用正数切片
print(url[9: 18: 3])  #指定步长
print(url[-6: -1])  #使用负数切片
```

运行结果：

```python
p
e
('b', 'i', 'a', 'n', 'c', 'h', 'e', 'n', 'g')
('b', 'n', 'e')
('s', 'h', 'e', 'l', 'l')
```

#### Python修改元组

前面我们已经介绍过元组是无法修改的，因此我们只能是为变量赋值一个新元素来改变变量的元组值如下所示：

```python
tup = (100, 0.5, -36, 73)
print(tup)
#对元组进行重新赋值
tup = ('Shell脚本',"https://coolchong.cn/")
print(tup)
```

运行结果：

```python
(100, 0.5, -36, 73)
('Shell脚本', 'https://coolchong.cn/')
```

同时我们也可以使用`+`拼接元组生成一个新的元组，但是也不会改变原元组：

```python
tup1 = (100, 0.5, -36, 73)
tup2 = (3+12j, -54.6, 99)
print(tup1+tup2)
print(tup1)
print(tup2)
```

运行结果：

```python
100, 0.5, -36, 73, (3+12j), -54.6, 99)
(100, 0.5, -36, 73)
((3+12j), -54.6, 99)
```

#### Python删除元组

我们并不能删除元组中的某一个元素，但是我们可以删除不再使用的整个元组，如下：

```python
tup = ('Java教程',"http://coolchong.cn/")
print(tup)
del tup
print(tup)
```

运行结果：

```python
('Java教程', 'http://coolchong.cn')
Traceback (most recent call last):
    File "C:\Users\mozhiyan\Desktop\demo.py", line 4, in <module>
        print(tup)
NameError: name 'tup' is not defined
```

Python 自带垃圾回收功能，会自动销毁不用的元组，所以一般不需要通过 del 来手动删除。

### Python中元素和列表的区别

看完前面对元组和列表的介绍以后，我们可以发现两者有很多共同点，但是列表中的元素可以任意修改，就好比是用铅笔在纸上写的字，写错了还可以擦除重写，而元组中的元素无法修改，除非将元组整体替换掉，就好比是用圆珠笔写的字，写了就擦不掉除非换一张纸。

{% note info,

可以将元组tuple理解为一个只读版本的列表list即可

%}

由于两者的存储特性不同，因此存储方式也是不同的：

```python
>>> listdemo = []
>>> listdemo.__sizeof__()
40
>>> tupleDemo = ()
>>> tupleDemo.__sizeof__()
24
```

可以看出虽然列表和元组都是空的，但是元组却比列表少占用了16个字节，这是因为列表是动态的，需要存储指针指向对应的元素（占用8个字节），另外，由于列表是可变的，所以需要额外存储已经分配的长度大小（占用8个字节）。但是对于元组，他由于不可变，长度固定 ，因此存储空间也是固定的，不需要指针和额外的空间因此相较于列表更加轻量级，性能也要略优于列表。

但是既然列表就可以实现元组的功能，我们为什么还要保留使用元组这个数据类型呢？这要从Python的垃圾回收机制讲起，在Python中如果一些变量不再使用，Python就会回收他们所占用的内存，返还给操作系统，以便其他变量或其他应用使用。但是对于一些静态变量，（比如元组），如果他占用的空间不大，那么Python会暂时缓存这些内存，这样的话，下一次再创建同样大小的元组时，Python就可以不用再向操作系统发出请求取寻找内存了，而是直接分配之前缓存的内存空间，大大提升程序的运行速度（大约快了5倍）。因此元组具有不可替代性。同时，**元组还可以在映射（和集合的成员）中当做`键`使用，而列表是不行的。**

### Python dict字典

Python中字典(dict)是一种无序的、可变的序列，他的元组以`键值对(key-value)`的形式存储因此元素在底层并不是挨着存放的。相对地，列表和元组都是有序的序列，他们的元素在底层是挨着存放的。

字典类型是Python中**唯一**的映射类型，”映射“是数学中的术语，简单理解，他指的是元素之间相互对应的关系，即用过一个元素就可以唯一的找到另一个元素如下所示：

![](https://langwenchong.gitee.io/figure-bed/20220117152326.png)



字典类型的特点就是：

|            主要特征            |                             解释                             |
| :----------------------------: | :----------------------------------------------------------: |
| 通过键而不是通过索引来读取元素 | 字典类型有时也称为关联数组或者散列表（hash）。它是通过键将一系列的值联系起来的，这样就可以通过键从字典中获取指定项，但不能通过索引来获取。 |
|  字典是任意数据类型的无序集合  | 和列表、元组不同，通常会将索引值 0 对应的元素称为第一个元素，而字典中的元素是无序的。 |
| 字典是可变的，并且可以任意嵌套 | 字典可以在原处增长或者缩短（无需生成一个副本），并且它支持任意深度的嵌套，即字典存储的值也可以是列表或其它的字典。 |
|       字典中的键必须唯一       | 字典中，不支持同一个键出现多次，否则只会保留最后一个键值对。 |
|      字典中的键必须不可变      | 字典中每个键值对的键是不可变的，只能使用数字、字符串或者元组，不能使用列表。 |

{% note info,

Python中的字典类型相当于Java或者C++中的Map对象，但是它比Map对象更加灵活，因为字典的键类型可以是任意的，而不像Java或者C++中需要提前声明键的数据类型保证所有的键类型统一。

%}

```python
>>> a = {'one': 1, 'two': 2, 'three': 3}  #a是一个字典类型
>>> type(a)
<class 'dict'>
```

#### Python创建字典

##### 1）使用{}创建字典

由于字典中每一个元素都包含两个部分，分别是键（key）和值（value），因此创建字典时、键和值之间使用冒号`:`分隔，相邻元素之间使用逗号`,`分隔，所有元素放在大括号`{}`中。

```python
dictname = {'key':'value1', 'key2':'value2', ..., 'keyn':valuen}
```

其中 dictname 表示字典变量名，keyn : valuen 表示各个元素的键值对。需要注意的是，同一字典中的各个键必须唯一，不能重复。**当为已有键再次设定值的时候会将之前的值覆盖掉。**

```python
#使用字符串作为key
scores = {'数学': 95, '英语': 92, '语文': 84}
print(scores)
#使用元组和数字作为key
dict1 = {(20, 30): 'great', 30: [1,2,3]}
print(dict1)
#创建空元组
dict2 = {}
print(dict2)
```

运行结果：

```python
{'数学': 95, '英语': 92, '语文': 84}
{(20, 30): 'great', 30: [1, 2, 3]}
{}
```

可以看到，字典的键可以是整数、字符串或者元组，只要符合唯一和不可变的特性就行；字典的值可以是 Python 支持的任意数据类型。

##### 2）通过fromkeys()方法创建字典

在Python中我们还可以使用dict字典类型提供的fromkeys()方法创建带有默认值的字典，具体格式如下：

```python
dictname = dict.fromkeys(list，value=None)
```

其中list参数表示字典中所有键的列表（因此必须各不相同），value参数表示所有值的默认值，如果不写，就会设置为空值None。

```python
knowledge = ['语文', '数学', '英语']
scores = dict.fromkeys(knowledge, 60)
print(scores)
```

运行结果：

```python
{'语文': 60, '英语': 60, '数学': 60}
```

##### 3）通过dict()映射函数创建字典

通过dict()函数创建字典的写法有多种，如下所示几种写法都是等价的创建了同一个字典a

|                           创建格式                           |                           注意事项                           |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
|       a = dict(str1=value1, str2=value2, str3=value3)        | str 表示字符串类型的键，value 表示键对应的值。使用此方式创建字典时，字符串不能带引号。**这种方式创建会导致键都是统一的字符串类型** |
| \#方式1<br/>demo = [('two',2), ('one',1), ('three',3)]<br/>\#方式2<br/>demo = [['two',2], ['one',1], ['three',3]]<br/>\#方式3<br/>demo = (('two',2), ('one',1), ('three',3))<br/>\#方式4<br/>demo = (['two',2], ['one',1], ['three',3])<br/>a = dict(demo) | 向 dict() 函数传入列表或元组，而它们中的元素又各自是包含 2 个元素的列表或元组，其中第一个元素作为键，第二个元素作为值。 |
| eys = ['one', 'two', 'three'] #还可以是字符串或元组<br/>values = [1, 2, 3] #还可以是字符串或元组<br/>a = dict( zip(keys, values) ) | 通过应用 dict() 函数和 zip() 函数，可将前两个列表转换为对应的字典。 |

{% note info,

注意，无论采用以上哪种方式创建字典，字典中各元素的键都只能是字符串、元组或者数字，**不能是列表，因为列表是可变的，不能作为键。** 

%}

```python
>>> a=dict(name="langwenchong",height=190,age=20)
>>> pring(a)
{'name': 'langwenchong', 'height': 190, 'age': 20}
>>> demo=([1,'one'],['two',2])
>>> b=dict(demo)
>>> print(b)
{1: 'one', 'two': 2}
>>> keys=(('name','age'),'height')
>>> values=["langwenchong+20",190]
>>> c=dict(zip(keys,values))
>>> print(c)
{('name', 'age'): 'langwenchong+20', 'height': 190}
```

如果不为dict()函数传入任何参数，那么代表创建一个空的字典，如下：

```python
# 创建空的字典
d = dict()
print(d)
```

运行结果为：

```python
{}
```

#### Python访问字典

列表和元组都是通过下表索引来访问元素的，而字典不同，他可以通过键来访问对应的值。因为字典中的元素都是无序的，每一个元素的位置都是不固定的，因此字典也不能像列表和元组那样，采用切片的方式一次性访问多个元素。

```python
tup = (['two',26], ['one',88], ['three',100], ['four',-59])
dic = dict(tup)
print(dic['one'])  #键存在
print(dic['five'])  #键不存在
```

运行结果：

```python
88
Traceback (most recent call last):
    File "C:\Users\mozhiyan\Desktop\demo.py", line 4, in <module>
        print(dic['five'])  #键不存在
KeyError: 'five'
```

除了上面这种方式访问字典，Python更推荐使用get()方法来获取指定键对应的值，当指定的键不存在时，get()方法不会抛出异常。

```python
dictname.get(key[,default]) 
```

其中，dictname 表示字典变量的名字；key 表示指定的键；default 用于指定要查询的键不存在时，此方法返回的默认值，**如果不手动指定，会返回 None**。

```python
a = dict(two=0.65, one=88, three=100, four=-59)
print( a.get('one') )
print( a.get('five') )
print( a.get('five', '该键不存在') )
```

运行结果：

```python
88
None
该键不存在
```

#### Python删除字典

```python
a = dict(two=0.65, one=88, three=100, four=-59)
print(a)
del a
print(a)
```

运行结果：

```python
{'two': 0.65, 'one': 88, 'three': 100, 'four': -59}
Traceback (most recent call last):
    File "C:\Users\mozhiyan\Desktop\demo.py", line 4, in <module>
        print(a)
NameError: name 'a' is not defined
```

### Python字典基本操作

字典是一个可变序列，因此我们可以添加、修改、删除字典中的键值对，常见的字典操作有以下几种：

- 向现有字典中添加新的键值对。
- 修改现有字典中的键值对。
- 从现有字典中删除指定的键值对。
- 判断现有字典中是否存在指定的键值对。

#### Python字典添加键值对

```python
dictname[key] = value
```

```python
a = {'数学':95}
print(a)
#添加新键值对
a['语文'] = 89
print(a)
#再次添加新键值对
a['英语'] = 90
print(a)
```

运行结果：

```python
{'数学': 95}
{'数学': 95, '语文': 89}
{'数学': 95, '语文': 89, '英语': 90}
```

#### Python字典修改键值对

Python字典中的键的名字是不能被修改的，但是我们可以修改键对应的值。由于字典中各元素的键是唯一的，因此，如果新添加元素的键与已存在的元素的键相同，那么键所对应的值就会被新的值替换掉，以此达到修改元素值的目的：

```python
a = {'数学': 95, '语文': 89, '英语': 90}
print(a)
a['语文'] = 100
print(a)
```

运行结果：

```python
{'数学': 95, '语文': 89, '英语': 90}
{'数学': 95, '语文': 100, '英语': 90}
```

#### Python字典删除键值对

如果要删除字典中的键值对，还是可以使用del语句

```python
# 使用del语句删除键值对
a = {'数学': 95, '语文': 89, '英语': 90}
del a['语文']
del a['数学']
print(a)
```

运行结果：

```python
{'英语': 90}
```

#### 判断字典中是否存在指定键值对

我们只能通过`in`和`noe in`运算符对键进行判断，而无法判断值是否在字典中即只能判断是否为字典的键而不能判断是否为字典的值，如下都是基于键key的判断

```python
a = {'数学': 95, '语文': 89, '英语': 90}
# 判断 a 中是否包含名为'数学'的key
print('数学' in a) # True
# 判断 a 是否包含名为'物理'的key
print('物理' in a) # False
# 这个判断是判断95是否为字典的键
print(95 in a) #False
```

运行结果：

```python
True
True
False
```

##### 思考：怎样判断字典是否包含某个值？

我们可以通过dict.keys()和dict.values()获取所有的键和所有的值，这样我们可以使用in和dict.values()来实现值的查找

```python
>>> d = {'1': 'one', '3': 'three', '2': 'two', '5': 'five', '4': 'four'}
>>> 'one' in d.values()
>>> True
```

##### 思考：能够根据值找到字典中的键？

可以代码实现如下：

```python
>>> d = {'1': 'one', '3': 'three', '2': 'two', '5': 'five', '4': 'four'}
>>> list(d.keys())[list(d.values()).index('one')]   #根据字典值  返回对应的key
>>> '1'
```

{% note info,

根据上面的代码我们可以得出一个结论，即dict的键中的第k个键与值中的第k个值正好可以组成字典中的第k个键值对，即键和值的相对位置是对应的。

%}

### Python dict字典其他方法详解

前面我们学习了fromkeys()和get()，这里再介绍剩余的函数。

#### keys()、values()和items()方法

将这三个放在一起介绍，是因为他们都用来获取字典中特定数据：

- eys() 方法用于返回字典中的所有键（key）；
- values() 方法用于返回字典中所有键对应的值（value）；
- items() 用于返回字典中所有的键值对（key-value）。

```python
scores = {'数学': 95, '语文': 89, '英语': 90}
print(scores.keys())
print(scores.values())
print(scores.items())
```

运行结果：

```python
dict_keys(['数学', '语文', '英语'])
dict_values([95, 89, 90])
dict_items([('数学', 95), ('语文', 89), ('英语', 90)])
```

要注意，**keys()、values()和items()返回值类型分别为dic_keys、dict_values、dict_items而并不是列表list或元组tuple或集合set**。这是因为Python并不希望我们用户能直接操作这几个方法的返回值。

为了能够使用这三个方法返回的数据进行操作，我们有以下几种方案，但是无一例外都是使用的新数据，而并没有操作原字典 数据，即操作并不会影响改变字典

##### 1）使用list()函数，将他们返回的数据转换成列表

```python
a = {'数学': 95, '语文': 89, '英语': 90}
b = list(a.keys())
print(b)a = {'数学': 95, '语文': 89, '英语': 90}
b = list(a.keys())
print(b)
```

运行结果：

```python
['数学', '语文', '英语']
```

##### 2）使用for in 循环遍历他们的返回值

```python
a = {'数学': 95, '语文': 89, '英语': 90}
for k in a.keys():
    print(k,end=' ')
print("\n---------------")
for v in a.values():
    print(v,end=' ')
print("\n---------------")
for k,v in a.items():
    print("key:",k," value:",v)
```

运行结果：

```python
数学 语文 英语
---------------
95 89 90
---------------
key: 数学  value: 95
key: 语文  value: 89
key: 英语  value: 90
```

#### copy()方法

copy()方法返回一个字典的拷贝，也即返回一个具有相同键值对的新字典

```python
a = {'one': 1, 'two': 2, 'three': [1,2,3]}
b = a.copy()
print(b)
```

运行结果：

```python
{'one': 1, 'two': 2, 'three': [1, 2, 3]}
```

但是我们要注意此时copy()方法只是浅拷贝，即只是对最表层的键值对进行了深拷贝，也就是说它会再申请一块内存用来存放`{'one':1,'two':2,'three':[]}`,而对于某些列表类型的值来说，此方法对其做的是浅拷贝，也就是说，b中的[1,2,3]的值不是自己独有的， 而是和a共有指向的统一内存单元。

```python
a = {'one': 1, 'two': 2, 'three': [1,2,3]}
b = a.copy()
#向 a 中添加新键值对，由于b已经提前将 a 所有键值对都深拷贝过来，因此 a 添加新键值对，不会影响 b。
a['four']=100
print(a)
print(b)
#由于 b 和 a 共享[1,2,3]（浅拷贝），因此移除 a 中列表中的元素，也会影响 b。
a['three'].remove(1)
print(a)
print(b)
```

运行结果：

```python
{'one': 1, 'two': 2, 'three': [1, 2, 3], 'four': 100}
{'one': 1, 'two': 2, 'three': [1, 2, 3]}
{'one': 1, 'two': 2, 'three': [2, 3], 'four': 100}
{'one': 1, 'two': 2, 'three': [2, 3]}
```

从运行结果不难看出，对a增加新键值对，b不变；而修改a某键值对中列表内的元素，b也会相应改变。

#### update()方法

update()方法可以使用一个字典所包含的键值对来更新已有的字典。在执行update()方法时，如果被更新的字典已包含对应的键值对，那么value会被覆盖，如果被更新的字典中不包含对应的键值对，那么键值对被添加进去。

```python
a = {'one': 1, 'two': 2, 'three': 3}
a.update({'one':4.5, 'four': 9.3})
print(a)
```

运行结果：

```python
{'one': 4.5, 'two': 2, 'three': 3, 'four': 9.3}
```

从运行结果可以看出，由于被更新的字典已经包含key为"one"的键值对，因此更改时键值对的value被改写，而被更新的字典中不包含key为“four"的键值对，所以更新时会为原字典增加一个新的键值对。

#### pop()和popitem(）方法

pop和popitem()都用来删除字典中的键值对，不同的是，pop()用来删除指定的键值对，而popitem()用来随机删除一个键值对，他们得语法格式如下：

```python
dictname.pop(key)
dictname.popitem()
```

```python
a = {'数学': 95, '语文': 89, '英语': 90, '化学': 83, '生物': 98, '物理': 89}
print(a)
a.pop('化学')
print(a)
a.popitem()
print(a)
```

运行结果：

```python
{'数学': 95, '语文': 89, '英语': 90, '化学': 83, '生物': 98, '物理': 89}
{'数学': 95, '语文': 89, '英语': 90, '生物': 98, '物理': 89}
{'数学': 95, '语文': 89, '英语': 90, '生物': 98}
```

##### 思考：popitem()的底层原理？

其实，说popitem()随机删除字典中的一个键值对是不准确的，虽然字典时一种无序的列表，但是键值对在底层也是有存储顺序的，popitem()总是弹出底层的最后一个key-value，这和列表的pop()方法类似，都实现了数据结构中的“出栈”的操作。

#### setdefault()方法

setdefault()方法用来返回字典中某个key对应的value值，但是他在返回前会进行以下操作：

- 如果该 key 存在，那么直接返回该 key 对应的 value；
- 如果该 key 不存在，那么先为该 key 设置默认的 defaultvalue（可以理解为插入了一个新的键值对，key-defaultvalue），然后再返回该 key 对应的 defaultvalue。

```python
a = {'数学': 95, '语文': 89, '英语': 90}
print(a)
#key不存在，指定默认值
a.setdefault('物理', 94)
print(a)
#key不存在，不指定默认值
a.setdefault('化学')
print(a)
#key存在，指定默认值
a.setdefault('数学', 100)
print(a)
```

运行结果：

```python
{'数学': 95, '语文': 89, '英语': 90}
{'数学': 95, '语文': 89, '英语': 90, '物理': 94}
{'数学': 95, '语文': 89, '英语': 90, '物理': 94, '化学': None}
{'数学': 95, '语文': 89, '英语': 90, '物理': 94, '化学': None}
```

我们发现由于前两次调用setdefault()时传入的键都是在字典中不存在的，因此会在字典中加入这个新的键值对，值就是defaultvalue可以自定义或者默认为None，但是如果穿入的键存在，那么后面的defaultvalue将没有任何作用，直接返还字典key对应的value值。

### Python使用字典格式化字符串

之前我们学习过使用转换说明符来格式化输出字符串，比如：

```python
name="小明"
age = 8
print("%s已经%d岁了！" % (name,age))
```

运行结果：

```python
小明已经8岁了！
```

但是这是变量比较少的情况，如果变量非常多，那么此时我们再使用这种形式格式化字符串就变得异常麻烦，因此我们接下来学习使用字典来格式化字符串：

```python
 字符串模板中使用key
temp = '教程是:%(name)s, 价格是:%(price)010.2f, 出版社是:%(publish)s'
book = {'name':'Python基础教程', 'price': 99, 'publish': 'C语言中文网'}
# 使用字典为字符串模板中的key传入值
print(temp % book)
book = {'name':'C语言小白变怪兽', 'price':159, 'publish': 'C语言中文网'}
# 使用字典为字符串模板中的key传入值
print(temp % book)
```

运行结果：

```python
教程是:Python基础教程, 价格是:0000099.00, 出版社是:C语言中文网
教程是:C语言小白变怪兽, 价格是:0000159.00, 出版社是:C语言中文网
```

{% note info,

要注意对应的键是写在百分号`%`和转换符字母之间的，比如%(price)010.2f表示的是此处输出的字典中price键对应的值价钱应为一个小数，并且最小宽度为10（不足就前面补0），同时保留两位小数。

%}

### Python set集合详解

Python中的集合，与数学中的和概念一致，用来保存不重复的元素，即集合中的元素都是唯一的，互不相同。从形式上看，和字典类似，Python集合会将所有元素放在一对大括号`{}`中，相邻元素使用逗号`,`分开

```python
{element1,element2,...,elementn}
```

集合可以存储无限多个元素。**从内容上看，集合只能存储不可变的数据类型，包括整型、浮点型、字符型、元组。但是无法存储列表、字典、集合这些可变的数据类型，否则Python解释器就会抛出TypeError错误。**比如说：

```python
>>> {{'a':1}}
Traceback (most recent call last):
  File "<pyshell#8>", line 1, in <module>
    {{'a':1}}
TypeError: unhashable type: 'dict'
>>> {[1,2,3]}
Traceback (most recent call last):
  File "<pyshell#9>", line 1, in <module>
    {[1,2,3]}
TypeError: unhashable type: 'list'
>>> {{1,2,3}}
Traceback (most recent call last):
  File "<pyshell#10>", line 1, in <module>
    {{1,2,3}}
TypeError: unhashable type: 'set'
```

要注意集合中的元素是唯一的，**对于重复出现的数据元素，只会保留一份**

```python
>>> {1,2,1,(1,2,3),'c','c'}
{1, 2, 'c', (1, 2, 3)}
```

由于Python中的set集合是无序的，因此每一次输出元素的排列顺序都是不同的。

{% note info,

其实Python中有两种集合类型，一种是set类型的集合，另一种是frozenset类型的集合，他们的唯一区别就是set类型集合可以做添加、删除元素的操作，而frozenset类型集合不行。

%}

#### Python创建set集合

Python提供了2种创建set集合的方法，分别是使用{}创建和使用set()函数将列表、元组等类型数据转换为集合。

##### 1）使用{}创建集合

在Python中，创建set集合可以像列表、元素和字典一样，直接将集合赋值给变量，从而实现创建集合的目的，其语法格式如下：

```python
setname = {element1,element2,...,elementn}
```

其中，setname 表示集合的名称，起名时既要符合 Python 命名规范，也要避免与 Python 内置函数重名。

```python
a = {1,'c',1,(1,2,3),'c'}
print(a)
```

运行结果：

```python
{1, 'c', (1, 2, 3)}
```

##### 2）set()函数创建集合

set()函数为Python的内置函数，其功能是将字符串、列表、元组、range()对象等可迭代对象转换成集合，该函数的语法如下：

```python
setname = set(iteration)
```

其中，iteration 就表示字符串、列表、元组、range 对象等数据。

```python
set1 = set("c.biancheng.net")
set2 = set([1,2,3,4,5])
set3 = set((1,2,3,4,5))
print("set1:",set1)
print("set2:",set2)
print("set3:",set3)
```

运行结果：

```python
set1: {'a', 'g', 'b', 'c', 'n', 'h', '.', 't', 'i', 'e'}
set2: {1, 2, 3, 4, 5}
set3: {1, 2, 3, 4, 5}
```

**注意如果要创建空集合，只能使用set()函数实现，因为直接使用一对{}，Python解释器会将其视为一个空字典。**

#### Python访问set集合元素

由于集合中的元素是无序的，因此无法像列表那样使用下表索引来访问元素，Python中，访问集合元素最常用的方法就是使用循环结构，将集合的数据逐一读取出来。

```python
a = {1,'c',1,(1,2,3),'c'}
for ele in a:
    print(ele,end=' ')
```

运行结果：

```python
1 c (1, 2, 3)
```

#### Python删除set集合

```python
a = {1,'c',1,(1,2,3),'c'}
print(a)
del(a)
print(a)
```

运行结果：

```python
{1, 'c', (1, 2, 3)}
Traceback (most recent call last):
  File "C:\Users\mengma\Desktop\1.py", line 4, in <module>
    print(a)
NameError: name 'a' is not defined
```

### Python set集合基础操作

#### 向set集合中添加元素

我们要注意，使用add()方法向set集合添加元素时，只能是数字，字符串，元组或者布尔类型，不能添加列表、元组或者集合这些可变的数据，否则Python解释器会报TypeError错误。

```python
a = {1,2,3}
a.add((1,2))
print(a)
a.add([1,2])
print(a)
```

运行结果：

```python
{(1, 2), 1, 2, 3}
Traceback (most recent call last):
  File "C:\Users\mengma\Desktop\1.py", line 4, in <module>
    a.add([1,2])
TypeError: unhashable type: 'list'
```

#### 从set集合中删除元素

使用remove()可以删除集合中的元素，但是我们要注意如果被删除的元素不包含在集合中，那么这个方法会抛出KeyError错误，例如：

```python
a = {1,2,3}
a.remove(1)
print(a)
a.remove(1)
print(a)
```

运行结果：

```python
{2, 3}
Traceback (most recent call last):
  File "C:\Users\mengma\Desktop\1.py", line 4, in <module>
    a.remove(1)
KeyError: 1
```

如果使用此方法删除集合中元素，需要注意的是，如果被删除的元素就不包含在集合中，那么此方法就会抛出KeyError异常，例如：

```python
a = {1,2,3}
a.remove(1)
print(a)
a.remove(1)
print(a)
```

运行结果为：

```python
{2, 3}
Traceback (most recent call last):
  File "C:\Users\mengma\Desktop\1.py", line 4, in <module>
    a.remove(1)
KeyError: 1
```

为了避免这种报错，我们可以哈斯用discard()方法，此方法和remove()方法的用法完全相同，唯一的区别就是当删除集合中元素失败时，此方法不会抛出任何错误。

```python
a = {1,2,3}
a.remove(1)
print(a)
a.discard(1)
print(a)
```

运行结果：

```python
{2, 3}
{2, 3}
```

#### Python set集合做交集、并集、差集运算

集合最常用的操作就是交集、并集、差集以及对称差集运算，如下所示：

![](https://langwenchong.gitee.io/figure-bed/20220117203958.png)

我们可以使用如下代码实现不同的集合运算：

| 运算操作 | Python运算符 |               含义                |                       例子                        |
| :------: | :----------: | :-------------------------------: | :-----------------------------------------------: |
|   交集   |      &       |        取两集合公共的元素         |                >>> set1 & set2 {3}                |
|   并集   |      丨      |        取两集合全部的元素         |           >>> set1 丨 set2 {1,2,3,4,5}            |
|   差集   |      -       |  取一个集合中另一集合没有的元素   | >>> set1 - set2 {1,2}<br /> >>> set2 - set1 {4,5} |
| 对称差集 |      ^       | 取集合 A 和 B 中不属于 A&B 的元素 |             >>> set1 ^ set2 {1,2,4,5}             |

####  Python set集合方法大全

这里我们给出C语言编程网的Python中集合函数大全方便查阅：

{% link set集合操作大全, http://c.biancheng.net/view/4402.html %}

### Python frozenset

set是一个可变序列，程序可以改变序列中的元素，而frozenset集合是不可变序列，程序是不能改变不可变序列中的元素的。set结合所支持的add()、remove()、discard()等方法frozenset一概不支持，而set中不改变集合本身的方法frozenset也支持。

我们在以下两种场景下会使用到frozenset，也正是这两个场景确立了frozenset的不可替代性：

- 当集合的元素不需要改变时，我们可以使用 fronzenset 替代 set，这样更加安全。
- 有时候程序要求必须是不可变对象，这个时候也要使用 fronzenset 替代 set。比如，字典（dict）的键（key）就要求是不可变对象。

{% note info,

一定要注意字典的键是不允许发生改变的，因此他不支持list,set这些可变序列数据类型的。

%}

```python
s = {'Python', 'C', 'C++'}
fs = frozenset(['Java', 'Shell'])
s_sub = {'PHP', 'C#'}
#向set集合中添加frozenset
s.add(fs)
print('s =', s)
#向为set集合添加子set集合
s.add(s_sub)
print('s =', s)
```

运行结果：

```python
s = {'Python', frozenset({'Java', 'Shell'}), 'C', 'C++'}
Traceback (most recent call last):
    File "C:\Users\mozhiyan\Desktop\demo.py", line 11, in <module>
        s.add(s_sub)
TypeError: unhashable type: 'set'
```

要注意，**set集合本身的元素要求是不可变的**，因此set的元素是不能为set的，即set集合不支持嵌套的，但是我们可以向set中加入frozenset的，因为他是不可变的集合类型。

### 深入底层了解Python字典和集合

在Python中字典和集合是进行过性能高度优化的数据结构，特别是对于查找、添加和删除操作。我们首先拿列表介绍一下复杂度：

假设现在有一个存储产品信息（产品ID、名称和价格）的列表，现在的需求是，借助某件产品的ID找出其价格，则实现代码如下：

```python
def find_product_price(products, product_id):
    for id, price in products:
        if id == product_id:
            return price
    return None
products = [
    (111, 100),
    (222, 30),
    (333, 150)
]
print('The price of product 222 is {}'.format(find_product_price(products, 222)))
```

运行结果：

```python
The price of product 222 is 30
```

如上查找列表时，如果列表有n个元素，因为查找的过程需要遍历列表，那么最坏的情况时间复杂度是O(n)。即使对列表进行了排序，再使用二分查找算法，也需要`O(logn)`的时间复杂度，更何况列表的排序还需要`O(nlogn)`的时间。

当如果用字典来存储这些数据，那么查找就会非常便捷高效，只需要O(1)的时间复杂度就可以完成，因为可以通过**键的哈希值**，找到对应的值，而不需要对字典做遍历操作，实现代码如下：

```python
products = {
  111: 100,
  222: 30,
  333: 150
}
print('The price of product 222 is {}'.format(products[222]))
```

运行结果为：

```python
The price of product 222 is 30
```

如下是一个简单的列表查找和字典查找的速度对比，我们可以看到仅仅十万的数据量，两者的速度差异就如此之大：

```python
#统计时间需要用到 time 模块中的函数，了解即可
import time
def find_unique_price_using_list(products):
    unique_price_list = []
    for _, price in products: # A
        if price not in unique_price_list: #B
            unique_price_list.append(price)
    return len(unique_price_list)
id = [x for x in range(0, 100000)]
price = [x for x in range(200000, 300000)]
products = list(zip(id, price))
# 计算列表版本的时间
start_using_list = time.perf_counter()
find_unique_price_using_list(products)
end_using_list = time.perf_counter()
print("time elapse using list: {}".format(end_using_list - start_using_list))
#使用集合完成同样的工作
def find_unique_price_using_set(products):
    unique_price_set = set()
    for _, price in products:
        unique_price_set.add(price)
    return len(unique_price_set)
# 计算集合版本的时间
start_using_set = time.perf_counter()
find_unique_price_using_set(products)
end_using_set = time.perf_counter()
print("time elapse using set: {}".format(end_using_set - start_using_set))
```

运行结果：

```python
time elapse using list: 68.78650900000001
time elapse using set: 0.010747099999989018
```

而往往企业的后台数据都有上亿乃至十亿数量级，因此如果使用了不合适的数据结构，很容易造成服务器的崩溃。因此字典和集合O(1)的复杂度可谓是相当快速了，加下来我们就了解一下他们的底层实现原理。

#### 字典和集合的工作原理

字典和集合能如此高效，和他们的数据结构密不可分，不同于其他数据结构，字典和集合内部结构都是一张哈希表：

- 对于字典而言，这张表存储了哈希值（hash）、键和值这 3 个元素。
- 而对集合来说，哈希表内只存储单一的元素。

对于之前版本的Python，他的哈希结构如下：

```python
 | 哈希值 (hash)  键 (key)  值 (value)
. |           ...
0 |    hash0      key0    value0
. |           ...
1 |    hash1      key1    value1
. |           ...
2 |    hash2      key2    value2
. |           ...
```

但是我们发现这种结构的弊端，是随着哈希表的扩张，他会变得越来越稀疏，比如有这样一个字典：

```python
{'name': 'mike', 'dob': '1999-01-01', 'gender': 'male'}
```

那么他会存储为如下结构：

```python
entries = [
['--', '--', '--']
[-230273521, 'dob', '1999-01-01'],
['--', '--', '--'],
['--', '--', '--'],
[1231236123, 'name', 'mike'],
['--', '--', '--'],
[9371539127, 'gender', 'male']
]
```

三个键值对数据却需要哈希表开辟7个空间，显然非常浪费存储空间，为了提高存储空间的利用率，现在的哈希表除了字典本身的结构，会把索引和哈希值、键、值单独分开，也就是采用如下这种结构：

```python
Indices
----------------------------------------------------
None | index | None | None | index | None | index ...
----------------------------------------------------

Entries
--------------------
hash0   key0  value0
---------------------
hash1   key1  value1
---------------------
hash2   key2  value2
---------------------
        ...
---------------------

```

这和数据结构中的索引表建立类似，此时哈希表内键哈希值不同的键值对存储到了相邻的存储单元，而我们使用indices来表示哈希表内的关系，这样就节省了大量的空间。因此此时上面的字典在新哈希表结构下的存储形式为：

```python
indices = [None, 1, None, None, 0, None, 2]
entries = [
[1231236123, 'name', 'mike'],
[-230273521, 'dob', '1999-01-01'],
[9371539127, 'gender', 'male']
]
```

##### 哈希表插入数据

当我们向字典中插入数据时，Python会首先**根据键(key)计算**出对应的哈希值（通过hash(key)函数计算)，而向集合中插入数据时，Python会**根据元素本身计算**对应的哈希值（通过hash(values)函数计算)。

```python
dic = {"name":1}
print(hash("name"))
setDemo = {1}
print(hash(1))
```

运行结果：

```python
8230115042008314683
1
```

得到哈希值（例如hash)之后，再结合字典或集合要存储数据的个数（例如n),就可以得到该元素应该插入到哈希表中的位置（比如,可以用hash%n的方式)

如果哈希表中此位置是空的，那么此元素可以直接插入其中，反之如果此位置已经被其他元素占用，那么Python会比较这两个元素的哈希值和键是否相等：

- 如果相等，则表明该元素已经存在，再比较他们的值，不相等就进行更新；
- 如果不相等，这种情况称为哈希冲突（即两个元素的键不同，但求得的哈希值相同）。这种情况下，Python 会使用开放定址法、再哈希法等继续寻找哈希表中空余的位置，直到找到位置。

##### 哈希表查找数据

在哈希表中查找数据，和插入操作类似，Python 会根据哈希值，找到该元素应该存储到哈希表中的位置，然后和该位置的元素比较其哈希值和键（集合直接比较元素值）：

- 如果相等，则证明找到；
- 反之，则证明当初存储该元素时，遇到了哈希冲突，需要继续使用当初解决哈希冲突的方法进行查找，直到找到该元素或者找到空位为止。

{% note info,

这里的空位，表示哈希表没有存储目标元素

%}

##### 哈希表删除元素

对于删除操作，**Python会暂时对这个位置的元素赋予一个特殊的值，等到重新调整哈希表的大小时，再将其删除。**

需要注意的是，哈希冲突的发生往往会降低字典和集合操作的速度。因此，为了保证其高效性，字典和集合内的哈希表，通常会保证其至少留有 1/3 的剩余空间。随着元素的不停插入，当剩余空间小于 1/3 时，Python 会重新获取更大的内存空间，扩充哈希表，与此同时，表内所有的元素位置都会被重新排放。

虽然哈希冲突和哈希表大小的调整，都会导致速度减缓，但是这种情况发生的次数极少。所以，平均情况下，仍能保证插入、查找和删除的时间复杂度为 `O(1)`。

### Python深拷贝和浅拷贝详解

#### Python浅拷贝

常见的浅拷贝方法，是使用数据类型本身的构造器，比如下面两个例子：

```python
list1 = [1, 2, 3]
list2 = list(list1)
print(list2)
print("list1==list2 ?",list1==list2)
print("list1 is list2 ?",list1 is list2)
set1= set([1, 2, 3])
set2 = set(set1)
print(set2)
print("set1==set2 ?",set1==set2)
print("set1 is set2 ?",set1 is set2)
```

运行结果：

```python
[1, 2, 3]
list1==list2 ? True
list1 is list2 ? False
{1, 2, 3}
set1==set2 ? True
set1 is set2 ? False
```

在上面程序中，list2就是list1的浅拷贝，同理set2是set1的浅拷贝。当然，对于**可变的序列**，还可以通过切片操作符`:`来完成浅拷贝，例如：

```python
list1 = [1, 2, 3]
list2 = list1[:]
print(list2)
print("list1 == list2 ?",list1 == list2)
print("list1 is list2 ?",list1 is list2)
```

运行结果：

```python
[1, 2, 3]
list1 == list2 ? True
list1 is list2 ? False
```

除此之外，Python 还提供了对应的函数 copy.copy() 函数，适用于任何数据类型。其用法如下：

```python
import copy
list1 = [1, 2, 3]
list2 = copy.copy(list1)
print(list2)
print("list1 == list2 ?",list1 == list2)
print("list1 is list2 ?",list1 is list2)
```

运行结果：

```python
[1, 2, 3]
list1 == list2 ? True
list1 is list2 ? False
```

不过要注意的是，对于元组，使用tuple()或者切片操作符`:`不会创建一个浅拷贝，相反他会创建一个指向相同元组的引用：

```python
tuple1 = (1, 2, 3)
tuple2 = tuple(tuple1)
print(tuple2)
print("tuple1 == tuple2 ?",tuple1 == tuple2)
print("tuple1 is tuple2 ?",tuple1 is tuple2)
```

运行结果：

```python
1, 2, 3)
tuple1 == tuple2 ? True
tuple1 is tuple2 ? True
```

此程序中，元组 (1, 2, 3) 只被创建一次，t1 和 t2 同时指向这个元组。

##### 思考：什么时候构造器和切片返还的是引用？什么时候是新数据？

{% note info,

这里有一个规律，就是凡是**可变数据类型**，那么构造器或者切片返还的就是一个新的**浅拷贝数据**；凡是**不可变数据类型**，那么构造器或者切片返还的就是一个指**向原内存单元的引用**

%}

以下是验证，我们发现对于string还是frozenset最终返还的都是引用，而dict就是一个新的拷贝数据

```python
>>> s1="hello"
>>> s2=s1[:]
>>> print(s2 is s1)
True
# frozenset不能切片，因此使用构造器
>>> fs1=frozenset([1,2,3])
>>> fs2=frozenset(fs1)
>>> print(fs2 is fs1)
True
# 字典不能切片，因此也使用构造器
>>> d1={'name':'langwenchong','age':20}
>>> d2=dict(d1)
>>> print(d2 is d1)
```

##### 思考：那么怎样才能让到d2和d1指向同一地址呢？

很简单使用赋值即可，毕竟d1本身就是一个指向内存单元的指针：

```python
>>> d2=d1
>>> print(d2 is d1)
True
```

看到这里，也许你可能对浅拷贝有了初步的认识。浅拷贝，指的是重新分配一块内存，创建一个新的对象，但里面的元素是原对象中各个子对象的引用。

对数据采用浅拷贝的方式时，如果原对象中的元素不可变，那倒无所谓；但如果元素可变，浅拷贝通常会出现一些问题，例如：

```python
list1 = [[1, 2], (30, 40)]
list2 = list(list1)
list1.append(100)
print("list1:",list1)
print("list2:",list2)
list1[0].append(3)
print("list1:",list1)
print("list2:",list2)
list1[1] += (50, 60)
print("list1:",list1)
print("list2:",list2)
```

运行结果为：

```python
list1: [[1, 2], (30, 40), 100]
list2: [[1, 2], (30, 40)]
list1: [[1, 2, 3], (30, 40), 100]
list2: [[1, 2, 3], (30, 40)]
list1: [[1, 2, 3], (30, 40, 50, 60), 100]
list2: [[1, 2, 3], (30, 40)]
```

再来看，list1[0].append(3) 表示对 list1 中的第一个列表新增元素 3。因为 list2 是 list1 的浅拷贝，list2 中的第一个元素和 list1 中的第一个元素，共同指向同一个列表，因此 list2 中的第一个列表也会相对应的新增元素 3。

最后是 list1[1] += (50, 60)，因为元组是不可变的，这里表示对 list1 中的第二个元组拼接，然后重新创建了一个新元组作为 list1 中的第二个元素，而 list2 中没有引用新元组，因此 list2 并不受影响。

通过这个例子，你可以很清楚地看到使用浅拷贝可能带来的副作用。如果想避免这种副作用，完整地拷贝一个对象，就需要使用深拷贝。所谓深拷贝，是指重新分配一块内存，创建一个新的对象，并且将原对象中的元素，以递归的方式，通过创建新的子对象拷贝到新对象中。因此，新对象和原对象没有任何关联。

#### Python深拷贝

Python 中以 copy.deepcopy() 来实现对象的深度拷贝。比如上述例子写成下面的形式，就是深度拷贝：

```python
import copy
list1 = [[1, 2], (30, 40)]
list2 = copy.deepcopy(list1)
list1.append(100)
print("list1:",list1)
print("list2:",list2)
list1[0].append(3)
print("list1:",list1)
print("list2:",list2)
list1[1] += (50, 60)
print("list1:",list1)
print("list2:",list2)
```

运行结果：

```pytohn
list1: [[1, 2], (30, 40), 100]
list2: [[1, 2], (30, 40)]
list1: [[1, 2, 3], (30, 40), 100]
list2: [[1, 2], (30, 40)]
list1: [[1, 2, 3], (30, 40, 50, 60), 100]
list2: [[1, 2], (30, 40)]
```

不过，深度拷贝也不是完美的，往往也会带来一系列问题。如果被拷贝对象中存在指向自身的引用，那么程序很容易陷入无限循环，例如：

```python
import copy
list1 = [1]
list1.append(list1)
print(list1)
list2 = copy.deepcopy(list1)
print(list2)
```

运行结果为：

```python
[1, [...]]
[1, [...]]
```

此例子中，列表 x 中有指向自身的引用，因此 x 是一个无限嵌套的列表。但是当深度拷贝 x 到 y 后，程序并没有出现栈溢出的现象。这是为什么呢？

其实，这是因为深度拷贝函数 deepcopy 中会维护一个字典，记录已经拷贝的对象与其 ID。拷贝过程中，如果字典里已经存储了将要拷贝的对象，则会从字典直接返回。通过查看 deepcopy 函数实现的源码就会明白：

```python
def deepcopy(x, memo=None, _nil=[]):
    """Deep copy operation on arbitrary Python objects.
       
    See the module's __doc__ string for more info.
    """
   
    if memo is None:
        memo = {}
    d = id(x) # 查询被拷贝对象 x 的 id
    y = memo.get(d, _nil) # 查询字典里是否已经存储了该对象
    if y is not _nil:
        return y # 如果字典里已经存储了将要拷贝的对象，则直接返回
        ...
```

