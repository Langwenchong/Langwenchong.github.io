---
title: python学习笔记--python基础(2)
comments: false
top: false
date: 2022-01-16 13:52:21
tags: [python]
categories: 
	- [个人笔记,Python基础]
---

python基础入门笔记，记录翀翀对Python基础的理解与总结，常言道：一分耕耘，一分收获。”在自己的理想道路上，多动脑筋，不断的思考，不停地学习，四肢能勤，不断地“书读百遍”，就会“其义自现”。愿你我都能坚持学习😁

<!-- more -->

### Python序列

所谓序列，就是一块可以存放多个值的连续内存空间，这些值按照一定的顺序排列，可以通过每一个值所在位置的编号（称为索引）访问他们。

在Python中，序列类型包括字符串、列表（也称为数组）、元组、集合与字典（也称为映射），这些序列支持以下几种通用的操作。**但是特殊地是集合和字典不支持索引、切片、相加和相乘操作。**

#### 序列索引

这个很好理解，从左到右索引值从0开始递增，我们使用A[index]的形式就可以获取指定位置的序列元素：

![](https://langwenchong.gitee.io/figure-bed/20220116132820.png)

除此之外，Python还支持索引值是负数，此时索引是从又向左计数，换句话说，从最后一个元素开始计数，从索引值-1开始向左递减，如下所示：

![](https://langwenchong.gitee.io/figure-bed/20220116133048.png)

{% note info,

要注意，使用负值作为序列中各元素的索引值时，是从-1开始，而不是从0开始，因为-0就是0就是开头元素。

%}

```python
str="你好呀大帅哥"
print(str[0],"==",str[-6])
print(str[5],"==",str[-1])
```

运行结果：

```python
你 == 你
哥 == 哥
```

#### 序列切片

切片操作是访问序列中元素的另一种方法啊，他可以访问一定范围内的元素，通过切片操作，可以生成一个新的序列。**一定要注意切片并不是操作原序列，而是生成一个新序列。**

```python
sname[start : end : step]
```

其中，各个参数的含义分别是：

- sname：表示序列的名称；
- start：表示切片的开始索引位置（包括该位置），此参数也可以不指定，会默认为 0，也就是从序列的开头进行切片；
- end：表示切片的结束索引位置（不包括该位置），如果不指定，则默认为序列的长度；
- step：表示在切片过程中，隔几个存储位置（包含当前位置）取一次元素，也就是说，如果 step 的值大于 1，则在进行切片去序列元素时，会“跳跃式”的取元素。如果省略设置 step 的值，则最后一个冒号就可以省略。

{% note info,

要注意切片的范围是左闭右开[start,end），同时step默认是1，想要隔k个元素取一个元素，那么step要设置为step+1

%}

```python
str="你好呀大帅哥"
#取索引区间为[0,2]之间（不包括索引2处的字符）的字符串
print(str[:2])
#隔 1 个字符取一个字符，区间是整个字符串
print(str[::2])
#取整个字符串，此时 [] 中只需一个冒号即可
print(str[:])
```

运行结果：

```python
你好
你呀帅
你好呀大帅哥
```

#### 序列相加

Python中支持两种类型相同的序列使用`+`运算符进行相加操作，他会将两个序列进行连接，但是并不会取出重复的元素，而是仅仅简单的拼接。**同时要注意这里的`类型相同`指的是两侧序列要么都是列表类型，要么都是元组类型，要么都是字符串。**

#### 序列相乘

在Python中，使用数字乘以一个序列会生成新的序列，其内容为原来序列被重复n次的结果。例如：

```python
str="你好呀大帅哥"
print(str*3)
```

运行结果：

```python
'你好呀大帅哥你好呀大帅哥你好呀大帅哥'
```

同时比较特殊的，列表类型在进行乘法运算时，还可以实现初始化指定长度列表的功能。例如如下的代码，将创建一个长度为5的列表，列表中的每一个元素都是None，表示什么都没有。

```python
#列表的创建用 []，后续讲解列表时会详细介绍
list = [None]*5
print(list)
```

运行结果：

```python
[None, None, None, None, None]
```

#### 检查元素是否包含在序列中

在Python中，可以使用`in`关键字检查某元素是否为序列的成员，其语法格式为：

```python
value in sequence
```

其中value表示要检查的元素，sequence表示指定的序列。如下代码所示：

```python
str="coolchong.cn"
print('c' in str)
```

运行结果：

```python
True
```

同时还有一个`not in `关键字，他可以用来检查元素是否不包含在指定的序列中，比如：

```python
str="coolchong.cn"
print('c' not in str)
```

运行结果：

```python
False
```

#### 和序列相关的内置函数

同时Python还提供了一些有关序列的内置函数，其功能如下,**注意这些函数都不会直接操作原序列而是生成一个新的值**：

|    函数     |                             功能                             |
| :---------: | :----------------------------------------------------------: |
|    len()    |         计算序列的长度，即返回序列中包含多少个元素。         |
|    max()    |                    找出序列中的最大元素。                    |
|    min()    |                    找出序列中的最小元素。                    |
|   list()    |                      将序列转换为列表。                      |
|    str()    |                     将序列转换为字符串。                     |
|    sum()    | 计算元素和。注意，对序列使用 sum() 函数时，做加和操作的必须都是数字，不能是字符或字符串，否则该函数将抛出异常，因为解释器无法判定是要做连接操作（+ 运算符可以连接两个序列），还是做加和操作。 |
|  sorted()   |                 对元素进行排序。（类型不变）                 |
| reversed()  | 反向序列中的元素。**（类型会变成reversed，需要再使用list()、或者tuple()转换回去）** |
| enumerate() |        将序列组合为一个索引序列，多用在 for 循环中。         |

##### 思考：enumerate()方法的应用？

```python
enumerate(sequence, [start=0])
```

sequence是一个输入序列，start是下标起始位置，方法返回的是一个枚举对象。

```python
>>> seasons = ['Spring', 'Summer', 'Fall', 'Winter']
>>> list(enumerate(seasons))
[(0, 'Spring'), (1, 'Summer'), (2, 'Fall'), (3, 'Winter')]
>>> list(enumerate(seasons, start=1))       # 下标从 1 开始
[(1, 'Spring'), (2, 'Summer'), (3, 'Fall'), (4, 'Winter')]
```

在遍历一个序列（列表或者元组）时，我们可以如下遍历，这样就同时可以使用索引和元素值了：

```python
>>> seq = ['one', 'two', 'three']
>>> for i, element in enumerate(seq):
...     print i, element
...
0 one
1 two
2 three
```

##### 思考：sorted(list)与list.sort()的区别？

首先两种写法都是正确的，可以对列表进行排序，但是两个方法略有不同。首先就是返还值不同，sorted()是返还一个新的列表并不会操作原序列，而list.sort()则是直接操作原序列进行排序并且返还一个值None

```python
>>> lst=[1,3,2,4]
>>> a=sorted(lst)
>>> print(lst,a,sep='\t')
[1, 3, 2, 4]    [1, 2, 3, 4]
>>> b=lst.sort()
>>> print(lst,b,sep='\t')
[1, 2, 3, 4]    None
```

同时sorted()和list.sort()还都可以通过使用key参数指定排序规则，并且是稳定排序，也就是说对于指定规则不能涵盖的元素，本来谁在前面，排好以后谁还是在前面。如下所示我们对列表重新制定排序规则，通过使用lambd重新定义排序规则为按照元素转换成字符串以后的长度排序：

```python
>>> lst=[1,2,3,13,7,11]
>>> c=sorted(lst,key=lambda x:len(str(x)))
>>> print(lst,c,sep='\t')
[1, 2, 3, 13, 7, 11]    [1, 2, 3, 7, 13, 11]
>>> d=lst.sort(key=lambda x:len(str(x)))
>>> print(lst,d,sep='\t')
[1, 2, 3, 7, 13, 11]    None
>>>
```

{% note info,

实际上sorted()和list.sort()都是在通过key的值比较进行递增排序，默认key=None的但是我们也可以重定义key，一般使用lambda进行重定义（后面会讲到lambda，这里了解即可）

%}

##### 思考：如何实现降序排序？

实际上排序函数语法如下：

```python
sorted(iterable,key=None,reverse=False)
list.sort(iterable,key=None,reverse=False)
```

因此降序我们只需要将reverse设置为True即可啦：

```python
>>> lst=[1,2,3,4,45,6]
>>> e=sorted(lst,reverse=True)
>>> print(lst,e,sep='\t')
[1, 2, 3, 4, 45, 6]     [45, 6, 4, 3, 2, 1]
>>> f=lst.sort(reverse=True)
>>> print(lst,f,sep='\t')
[45, 6, 4, 3, 2, 1]     None
```

### Python列表(list)

在C和Java中我们通常是使用数组Array来存储多个相邻连接的数据，但是在Python中是没有数组的，而是提供了一个更加强大的列表类型，他可以按成数组的所有操作同时还具有一些更加强大的函数。从形似上看，列表就是将所有元素放到一个中括号`[]`中，相邻元素之间使用`,`分隔，如下：

```python
[element1,element2,element3,...,elementn]
```

Python的列表没有个数限制，存储范围为无限大，同时内容可以是任何类型如下所示一个列表可以存储许多不同类型的元素：

```python
["http://coolchong.cn/", 1, [2,3,4] , 3.0]
```

**但是为了提高代码可读性，我们通常默认推荐使用列表存放一些数据类型相同的元素**

#### Python创建列表

在Python中有两种创建列表的方法：

##### 1）使用[]直接创建列表

使用`[]`创建列表，同时使用`=`将列表赋值给一个变量：

```python
um = [1, 2, 3, 4, 5, 6, 7]
name = ["C语言中文网", "coolchong.cn"]
program = ["C语言", "Python", "Java"]
```

创建一个空列表只需要用[]表示即可

```python
emptylist=[]
```

##### 2）使用list()函数创建列表

使用内置函数lis()创建一个列表，使用它可以将其他数据数据类型转换为列表类型：

```python
#将字符串转换成列表
list1 = list("hello")
print(list1)
#将元组转换成列表
tuple1 = ('Python', 'Java', 'C++', 'JavaScript')
list2 = list(tuple1)
print(list2)
#将字典转换成列表
dict1 = {'a':100, 'b':42, 'c':9}
list3 = list(dict1)
print(list3)
#将区间转换成列表
range1 = range(1, 6)
list4 = list(range1)
print(list4)
#创建空列表
print(list())
```

运行结果：

```python
['h', 'e', 'l', 'l', 'o']
['Python', 'Java', 'C++', 'JavaScript']
['a', 'b', 'c']
[1, 2, 3, 4, 5]
[]
```

{% note info,

注意对于字典转换为列表以后，只会存储key键，而映射值会丢失并不能存储到列表中

%}

#### 访问列表元素

列表是Python中序列的一种形式，因此我们可以使用索引来获取元素，同时也可以使用切片访问列表中的一组元素（得到的是一个新的子列表）

```python
url = list("http://c.biancheng.net/shell/")
#使用索引访问列表中的某个元素
print(url[3])  #使用正数索引
print(url[-4])  #使用负数索引
#使用切片访问列表中的一组元素
print(url[9: 18])  #使用正数切片
print(url[9: 18: 3])  #指定步长
print(url[-6: -1])  #使用负数切片
```

运行结果：

```python
p
e
['b', 'i', 'a', 'n', 'c', 'h', 'e', 'n', 'g']
['b', 'n', 'e']
['s', 'h', 'e', 'l', 'l']
```

**一定要注意取元素一定是从左向右取，可以正/负索引搭配使用来划定要切片的范围，但是要保证范围是合法的**

#### Python删除列表

对于不再使用的数据，我们统一使用`del`关键字进行删除，因此如果我们需要手动删除某个列表时使用`del lst`即可，如下：

```python
intlist = [1, 45, 8, 34]
print(intlist)
del intlist
print(intlist)
```

运行结果：

````python
[1, 45, 8, 34]
Traceback (most recent call last):
    File "C:\Users\mozhiyan\Desktop\demo.py", line 4, in <module>
        print(intlist)
NameError: name 'intlist' is not defined
````

##### 思考：我们需要删除每一个不会再使用的变量吗？

不需要，Python有自带的垃圾回收机制，当发现某个数据没有再被引用以后就会自动销毁，即使开发者不手动删除，Python也会自动将其回收。

### Python list列表添加元素

我们直接尝试使用过`+`来拼接列表添加元素，如下所示：

```python
language = ["Python", "C++", "Java"]
birthday = [1991, 1998, 1995]
info = language + birthday
print("language =", language)
print("birthday =", birthday)
print("info =", info)
```

运行结果：

```python
language = ['Python', 'C++', 'Java']
birthday = [1991, 1998, 1995]
info = ['Python', 'C++', 'Java', 1991, 1998, 1995]
```

但是我们会发现此时两个原列表并没有发生变化，拼接操作仅仅是将两个列表拼接生成一个新列表，但是我们如何修改原列表给他添加元素呢？

#### Python append()方法添加元素

append()方法就是用于在列表的末尾追加元素，该方法的语法格式如下：

```python
listname.append(obj)
```

其中listname就是要添加元素的列表，obj表示添加到列表末尾的数据，他可以是单个元素，也可以是列表、元组等。

```python
l = ['Python', 'C++', 'Java']
#追加元素
l.append('PHP')
print(l)
#追加元组，整个元组被当成一个元素
t = ('JavaScript', 'C#', 'Go')
l.append(t)
print(l)
#追加列表，整个列表也被当成一个元素
l.append(['Ruby', 'SQL'])
print(l)
```

运行结果：

```python
['Python', 'C++', 'Java', 'PHP']
['Python', 'C++', 'Java', 'PHP', ('JavaScript', 'C#', 'Go')]
['Python', 'C++', 'Java', 'PHP', ('JavaScript', 'C#', 'Go'), ['Ruby', 'SQL']]
```

我们会发现使用append()方法添加列表或者元组时得到的结果和我们预期略有不同，它仅仅是将列表或者元组整体追加到了后面，但是我们更希望把其内部的元素逐一取出添加到末尾。

#### Python extend()方法添加元素

extend()和append()的不同之处：extend()不会把列表或者元组视为一个整体，而是把它们包括的元素逐个添加到列表末尾。

```python
l = ['Python', 'C++', 'Java']
#追加元素
l.extend('C')
print(l)
#追加元组，元祖被拆分成多个元素
t = ('JavaScript', 'C#', 'Go')
l.extend(t)
print(l)
#追加列表，列表也被拆分成多个元素
l.extend(['Ruby', 'SQL'])
print(l)
```

运行结果：

```python
['Python', 'C++', 'Java', 'C']
['Python', 'C++', 'Java', 'C', 'JavaScript', 'C#', 'Go']
['Python', 'C++', 'Java', 'C', 'JavaScript', 'C#', 'Go', 'Ruby', 'SQL']
```

#### Python insert()方法插入元素

append()和extend()都只能在列表的末尾追加元素，但是如果我们希望在列表中间插入元素，那么次是就会使用到insert()方法，格式如下：

```python
listname.insert(index , obj)
```

其中，index表示指定位置的索引值，insert()会将obj插入到listname列表第index个元素的位置，更好理解的说就是新插入的元素在新标中的索引位置为index。**同时我们要注意insert()也是将要插入的列表或者元组视为一个整体插入到列表中，这一点和append()一样**。

```python
l = ['Python', 'C++', 'Java']
#插入元素
l.insert(1, 'C')
print(l)
#插入元组，整个元祖被当成一个元素
t = ('C#', 'Go')
l.insert(2, t)
print(l)
#插入列表，整个列表被当成一个元素
l.insert(3, ['Ruby', 'SQL'])
print(l)
#插入字符串，整个字符串被当成一个元素
l.insert(0, "http://coolchong.cn")
print(l)
```

运行结果：

```python
['Python', 'C', 'C++', 'Java']
['Python', 'C', ('C#', 'Go'), 'C++', 'Java']
['Python', 'C', ('C#', 'Go'), ['Ruby', 'SQL'], 'C++', 'Java']
['coolchong.cn', 'Python', 'C', ('C#', 'Go'), ['Ruby', 'SQL'], 'C++', 'Java']
```

### Python list列表删除元素

在Python列表中想要删除元素主要有以下三种场景：

- 根据目标元素所在位置的索引进行删除，可以使用 del 关键字或者 pop() 方法；
- 根据元素本身的值进行删除，可使用列表（list类型）提供的 remove() 方法；
- 将列表中所有元素全部删除，可使用列表（list类型）提供的 clear() 方法。

#### del:根据索引值删除元素

del是Python中的关键字，专门用来执行数据删除操作，他不仅可以删除列表整体，也可以删除列表中指定位置的元素。格式为：

```python
#删除一个指定元素
del listname[index]
#删除[star,end)范围的元素
del listname[start : end]
```

```python
lang = ["Python", "C++", "Java", "PHP", "Ruby", "MATLAB"]
#使用正数索引
del lang[2]
print(lang)
#使用负数索引
del lang[-2]
print(lang)
lang = ["Python", "C++", "Java", "PHP", "Ruby", "MATLAB"]
del lang[1: 4]
print(lang)
lang.extend(["SQL", "C#", "Go"])
del lang[-5: -2]
print(lang)
```

运行结果：

```python
['Python', 'C++', 'PHP', 'Ruby', 'MATLAB']
['Python', 'C++', 'PHP', 'MATLAB']
['Python', 'Ruby', 'MATLAB']
['Python', 'C#', 'Go']
```

{%  note info,

要注意del listname[start,end]此时表示的就是删除原列表！

%}

##### 思考：什么时候切片是新列表?什么时候是引用原列表？

这个地方非常容易混淆，我们要注意：**可以使用切片来截取列表中的任何部分，得到一个新列表，也可以通过切片来修改和删除列表中部分元素，甚至可以通过切片操作为列表对象增加元素。**

**只有在删除和`=`赋值的时候切片表示原引用列表**，其他情况下都是一个新列表对象，如下所示：

```python
>>> lst=[1,2,3]
#此时不是赋值，因此是为新列表添加元素，原列表不会发生变化
>>> lst[:].append(4)
>>> print(lst)
[1, 2, 3]
#此时是赋值修改，因此是原列表发生变化
>>> lst[:]=[1,2,3,4]
>>> print(lst)
[1, 2, 3, 4]
#删除操作直接删除原列表部分元素
>>> del lst[2:]
>>> print(lst)
[1, 2]
```

#### Pop():根据索引值删除元素

使用`listname.pop(index)`可以删除指定索引出的元素，如果不指定index那么默认删除的是列表的最后一个元素类似于数据结构中的出栈操作，此种方法不支持范围删除。

```python
nums = [40, 36, 89, 2, 36, 100, 7]
nums.pop(3)
print(nums)
nums.pop()
print(nums)
```

运行结果：

```python
[40, 36, 89, 36, 100, 7]
[40, 36, 89, 36, 100]
```

**要注意虽然Python中列表由pop()表示删除元素，但是插入元素可不是push()而是append()**

#### remove():根据元素值进行删除

除了使用del和pop()删除指定索引值的元素，我们还可以使用remove()来删除指定元素值，但是**要注意他每一次只会删除第一个值匹配的元素，并且必须保证要删除的元素存在，否则会报异常**

```python
nums = [40, 36, 89, 2, 36, 100, 7]
#第一次删除36
nums.remove(36)
print(nums)
#第二次删除36
nums.remove(36)
print(nums)
#删除78
nums.remove(78)
print(nums)
```

运行结果：

```python
[40, 89, 2, 36, 100, 7]
[40, 89, 2, 100, 7]
Traceback (most recent call last):
    File "C:\Users\mozhiyan\Desktop\demo.py", line 9, in <module>
        nums.remove(78)
ValueError: list.remove(x): x not in list
```

#### clear():删除所有元素

Python可以使用clear()删除列表的所有元素，即清空列表但是此时列表自身还是存在的只是变成了一个空列表：

```python
url = list("http://c.biancheng.net/python/")
url.clear()
print(url)
```

运行结果：

```python
[]
```

#### 思考：搜索并逐一删除元素的写法？

假设现在有一个场景，是当列表中存在元素为1时，那我们就要将这个元素删除，此时你会怎么写？我猜测你的第一想法一定是：

```python
lst=[1,1,1,2,1,1,1]
for i in range(len(lst)):
    if(lst[i]==1):
        del lst[i]
```

我们会发现报错了，此时他报的错是列表访问越界：

```python
Traceback (most recent call last):
  File "d:/Pythoncode/Algrithm/test.py", line 9, in <module>
    if(lst[i]==1):
IndexError: list index out of range
```

这是为什么呢？原因是列表在删除过程中会逐渐变短，而i使用是在原列表长度的范围内进行递增，因此只要删除了一个或者多个元素，那么后面就一定会出现越界。我们以一个例子为例体会一下这个过程：

```python
lst=[1,2,2,3,1,1,4]
for i in range(len(lst)):
    print(i,lst[i],sep="|")
    del lst[i]
```

假设现在我们要遍历一个列表，每次都打印此次访问到的元素索引值和元素值，然后再删除这个元素，那么我们最终得到的结果如下：

```python
PS D:\Pythoncode> & D:/Python/anaconda3/python.exe d:/Pythoncode/Algrithm/test.py       
0|1
1|2
2|1
3|4
Traceback (most recent call last):
  File "d:/Pythoncode/Algrithm/test.py", line 3, in <module>
    print(i,lst[i],sep="|")
IndexError: list index out of range
```

![](https://langwenchong.gitee.io/figure-bed/20220116155225.png)

这个过程如上所示，因此我们发现这种方法删除元素是不可行的，为了解决这个问题，我们只需要让i倒着遍历列表并删除即可了：

```python
lst=[1,2,2,3,1,1,4]
#i的范围为[len(lst)-1,-1)，每一次i都减一
for i in range(len(lst)-1,-1,-1):
    print(i,lst[i],sep="|")
    del lst[i]
```

运行结果：

```python
PS D:\Pythoncode> & D:/Python/anaconda3/python.exe d:/Pythoncode/Algrithm/test.py
6|4
5|1
4|1
3|3
2|2
1|2
0|1
```

我们可以使用remove()方法来实现类似的删除元素值的功能，他的写法如下：

```python
lst=[1,2,2,3,1,1,4]
#思考：这里为什么是lst的全范围切片？
for el in lst[:]:
    if(el==1):
        lst.remove(el)
print(lst)
```

运行结果：

```python
[2, 2, 3, 4]
```

**这里我们要注意必须是遍历全范围切片**，原因很简单和上面类似，如果我们直接在lst中遍历并删除也会造成数组越界的问题，为了解决这个问题，我们使用的策略是遍历一个lst的全范围切片子列表（可以看成是复制了一个列表），在里面寻找是否还有要删除的元素，如果有就调用一次lst.remove()删除，这样我们就保证了每一次调用lst.remove()时保证了一定还有可以删除的元素。同时由于遍历查找和删除的是两个不同的列表，因此就不会造成访问越界了，毕竟el遍历的切片子列表一直就没有变化。

### Python list列表修改元素

#### 修改单个元素

```python
nums = [40, 36, 89, 2, 36, 100, 7]
nums[2] = -26  #使用正数索引
nums[-3] = -66.2  #使用负数索引
print(nums)
```

运行结果：

```python
[40, 36, -26, 2, -66.2, 100, 7]
```

#### 修改一组元素

Python 支持通过切片语法给一组元素赋值。在进行这种操作时，如果不指定步长（step 参数），Python 就不要求新赋值的元素个数与原来的元素个数相同；这意味，该操作既可以为列表添加元素，也可以为列表删除元素。

```python
nums = [40, 36, 89, 2, 36, 100, 7]
#修改第 1~4 个元素的值（不包括第4个元素）
nums[1: 4] = [45.25, -77, -52.5]
print(nums)
```

运行结果：

```python
[40, 45.25, -77, -52.5, 36, 100, 7]
```

**如果对空切片（slice）赋值，就相当于插入一组新的元素：**

```python
nums = [40, 36, 89, 2, 36, 100, 7]
#在4个位置插入元素
nums[4: 4] = [-77, -52.5, 999]
print(nums)
```

运行结果：

```python
[40, 36, 89, 2, -77, -52.5, 999, 36, 100, 7]
```

**但是我们要注意使用切片语法赋值时，Python 不支持单个值**（必须是一个列表才行），例如下面的写法就是错误的：

```python
nums[4: 4] = -77
File "d:/Pythoncode/Algrithm/test.py", line 3, in <module>
    nums[4: 4] = -77
TypeError: can only assign an iterable
```

只需要修改为

```python
nums[4: 4] = [-77]
```

**但是如果使用字符串赋值，Python会自动把字符串转换成序列**，其中的每个字符都是一个元素：

```python
nums = [40, 36, 89, 2, 36, 100, 7]
#在4个位置插入元素
nums[4: 4] = "xyz"
print(nums)
```

运行结果：

```python
[40, 36, 89, 2, 'x', 'y', 'z', 36, 100, 7]
```

### Python list列表查找元素

#### index()方法

```python
istname.index(obj, start, end)
```

listname表示列表名称，obj表示要查找的元素，start表示查找起始位置，end表示结束位置。index方法用来查找某个元素在[start,end)列表中首次出现的位置。

- start 和 end 可以都不写，此时会检索整个列表；
- 如果只写 start 不写 end，那么表示检索从 start 到末尾的元素；
- 如果 start 和 end 都写，那么表示检索 start 和 end 之间的元素。

```python
nums = [40, 36, 89, 2, 36, 100, 7, -20.5, -999]
#检索列表中的所有元素
print( nums.index(2) )
#检索3~7之间的元素
print( nums.index(100, 3, 7) )
#检索4之后的元素
print( nums.index(7, 4) )
#检索一个不存在的元素
print( nums.index(55) )
```

运行结果：

```python
3
5
6
Traceback (most recent call last):
    File "C:\Users\mozhiyan\Desktop\demo.py", line 9, in <module>
        print( nums.index(55) )
ValueError: 55 is not in list
```

**要注意当要查找的元素不存在时，则会导致ValueError错误，因此在使用index()之前最好使用count()方法判断一下**

#### count()方法

```python
listname.count(obj)
```

其中listname是列表名称，obj是要统计的元素。count()方法用来统计某个元素在列表中出现的次数，我们可以使用这个方法来判断哪一个列表是否包含某个元素。如果count()返还0则说明列表中不存在这个元素。

```python
nums = [40, 36, 89, 2, 36, 100, 7, -20.5, 36]
#统计元素出现的次数
print("36出现了%d次" % nums.count(36))
#判断一个元素是否存在
if nums.count(100):
    print("列表中存在100这个元素")
else:
    print("列表中不存在100这个元素")
```

运行结果：

```python
36出现了3次
列表中存在100这个元素
```

### Python range()快速初始化数字列表

range()语法格式和切片很像，也有三个参数：

```python
range(start, stop[, step])
```

start是起始位置，stop是结束位置，step是步长，同时也是左闭右开[start,stop)，且当只填写一个数字时默认从0开始，但是我们要注意range()生成的元素组成的并不是列表list类型：

```python
print(type(range(5)))
<class 'range'>
```

因此如果我们想要视同range()快速初始化列表需要在最外侧转换成list类型，同时我们使用step步长可以初始化一些特殊列表：

比如1~10内的偶数组成的列表：

```python
even_numbers = list(range(2,11,2))
print(even_numbers)
```

运行结果：

```python
[2, 4, 6, 8, 10]
```

#### 思考：还有没有其他高级写法？

列表推导(List Comprehension) 是一种数学家用来实现众所周知标记集合的Python方式。它由方括号组成，包含一个表达式，后跟一个for子句，后面跟一个可选的if子句。

表达式可以是我们想要放入列表中的任何类型的对象；由于我们用零初始化列表，因此我们的表达式将只为0。

```python
arr = [0 for i in range(1000)]
```

当然也可以用等价的写法：

```python
arr=[0]*1000
```

使用列表推导也可以写1-10以内的偶数组成的列表：

```python
even_numbers = [i for i in range(2,11,2)]
```

### Python 使用list模拟栈和队列

#### list模拟栈

栈stack的特点就是后进先出，因此我们必须保证pop()时弹出的是最后进来的元素，因此只需要插入元素使用append()即可模拟：

```python
 #定义一个空 list 当做栈
stack = []
stack.append(1)
stack.append(2)
stack.append("hello")
print(stack)
print("取一个元素：",stack.pop())
print("取一个元素：",stack.pop())
print("取一个元素：",stack.pop())
```

运行结果：

```python
[1, 2, 'hello']
取一个元素： hello
取一个元素： 2
取一个元素： 1
```

#### list模拟队列

队列queue特点是先进先出，因此我们必须保证pop()时弹出的是最先进来的元素，因此只需要保证插入元素使用insert(0,obj)即可模拟：

```python
 #定义一个空列表，当做队列
queue = []
#向列表中插入元素
queue.insert(0,1)
queue.insert(0,2)
queue.insert(0,"hello")
print(queue)
print("取一个元素：",queue.pop())
print("取一个元素：",queue.pop())
print("取一个元素：",queue.pop())
```

运行结果：

```python 
['hello', 2, 1]
取一个元素： 1
取一个元素： 2
取一个元素： hello
```

