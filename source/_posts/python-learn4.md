---
title: python学习笔记--python基础(4)
comments: false
top: false
date: 2022-01-18 14:19:40
tags: [python]
categories: 
	- [个人笔记,Python基础]
---

python基础入门笔记，记录翀翀对Python基础的理解与总结，常言道：一分耕耘，一分收获。”在自己的理想道路上，多动脑筋，不断的思考，不停地学习，四肢能勤，不断地“书读百遍”，就会“其义自现”。愿你我都能坚持学习😁

<!-- more -->

### Python if else条件语句详解

```python
height = float(input("输入身高（米）："))
weight = float(input("输入体重（千克）："))
bmi = weight / (height * height)  #计算BMI指数
if bmi<18.5:
    print("BMI指数为："+str(bmi))
    print("体重过轻")
elif bmi>=18.5 and bmi<24.9:
    print("BMI指数为："+str(bmi))
    print("正常范围，注意保持")
elif bmi>=24.9 and bmi<29.9:
    print("BMI指数为："+str(bmi))
    print("体重过重")
else:
    print("BMI指数为："+str(bmi))
    print("肥胖")
```

运行结果：

```python
输入身高（米）：1.7↙
输入体重（千克）：70↙
BMI指数为：24.221453287197235
正常范围，注意保持
```

要注意Python的判断条件语句后面要加上冒号`:`，同时他是通过缩进来识别代码块的，不支持大括号包裹，具有相同缩进量的若干行代码属于同一个代码块，因此我们要注意Python中的代码缩进量。

{% note info,

要注意Python中的else if可以使用更简洁的elif来代替书写。

%}

#### 如何判断表达式是否成立

在Python中if和elif后面的“表达式”的形式是很自由的，只要表达式有一个结果，不管这个结果是什么类型，Python都能判断他是“真”还是“假”。布尔类型有两个值分别是True和False，Python会把True当做真，False当做假。**但是对于数字，Python会把0和0.0当做假，其他值都当做真。而对于对象或者序列，当他们为空或者None时，Python会把他们当做假，其他情况当做真，比如下面的表达式都是不成立(假)的**：

```python
""  #空字符串
[ ]  #空列表
( )  #空元组
{ }  #空字典
None  #空值
```

```python
b = False
if b:
    print('b是True')
else:
    print('b是False')
n = 0
if n:
    print('n不是零值')
else:
    print('n是零值')
s = ""
if s:
    print('s不是空字符串')
else:
    print('s是空字符串')
l = []
if l:
    print('l不是空列表')
else:
    print('l是空列表')
d = {}
if d:
    print('d不是空字典')
else:
    print('d是空字典')
    
#不规定时默认函数返还None
def func():
    print("函数被调用")
if func():
    print('func()返回值不是空')
else:
    print('func()返回值为空')
```

运行结果：

```python
b是False
n是零值
s是空字符串
l是空列表
d是空字典
函数被调用
func()返回值为空
```

{% note info,

对于没有return语句的函数，返回值即为空，也即None

%}

### Python pass语句及其作用

在实际开发中，有时候我们先搭建起程序的整体逻辑框架，但是暂时不去实现某些细节，而是在这些地方加一些注释，方便以后添加代码，如下所示：

```python
age = int( input("请输入你的年龄：") )
if age < 12 :
    print("婴幼儿")
elif age >= 12 and age < 18:
    print("青少年")
elif age >= 18 and age < 30:
    print("成年人")
elif age >= 30 and age < 50:
    #TODO: 成年人
else:
    print("老年人")
```

当年龄大于等于30并且小于50时，我们没有使用print()语句，而是使用了一个注释，希望以后再处理成年人的情况，当Python执行到这个elif分支时，会跳过注释，什么都不执行。但是Python系统了一个更加专业的做法，就是空语句pass,`pass`是Pytohn中的关键字，用来让解释器跳过此处，什么都不做。

就像上面的情况，有时候程序需要占用一个位置，后者放一条语句，但是又不希望这条语句做任何事情，此时就可以通过pass语句来实现，使用pass语句比使用注释更加优雅。

```python
age = int( input("请输入你的年龄：") )
if age < 12 :
    print("婴幼儿")
elif age >= 12 and age < 18:
    print("青少年")
elif age >= 18 and age < 30:
    print("成年人")
elif age >= 30 and age < 50:
    pass
else:
    print("老年人")
```

运行结果：

```python
请输入你的年龄：40↙
```

从运行结果可以看出，程序虽然执行到第10行代码，但是并没有进行什么操作、

### Python assert断言函数及其用法

assert语句又称为断言语句，可以看成是功能缩小版的if语句，他用来判断某个表达式的值，如果值为真，则程序可以继续往下执行，反之如果值为假，那么Python解释器就会报AssertionError错误，程序退出执行。

```python
mathmark = int(input())
#断言数学考试分数是否位于正常范围内
assert 0 <= mathmark <= 100
#只有当 mathmark 位于 [0,100]范围内，程序才会继续执行
print("数学考试分数为：",mathmark)
```

如果输入的分数为90那么程序可以正常执行：

```python
90
数学考试分数为： 90
```

但是如果输入的值为159此时表达式为假，程序就会报错：

```python
159
Traceback (most recent call last):
  File "C:\Users\mengma\Desktop\file.py", line 3, in <module>
    assert 0 <= mathmark <= 100
AssertionError
```

你可能会疑惑，命名assert会令程序崩溃，为什么还要使用它呢？这是因为，预期让程序在晚些时候崩溃，不如再错误条件出现时，就直接让程序崩溃，这样有利于我们对程序排错，提高程序的健壮性。

因此assert语句通常用于检查用户的输入是否符合规定，还经常用作程序初期测试和调试过程中的辅助工具。

### Python while循环语句

```python
my_char="http://c.biancheng.net/python/"
i = 0;
while i<len(my_char):
    print(my_char[i],end="")
    i = i + 1
```

运行结果：

```python
http://c.biancheng.net/python/
```

只需要保证while在有限次循环以后能够退出就行，同时循环体内部的代码缩进要相同。

### Python for循环及用法详解

```python
for 迭代变量 in 字符串|列表|元组|字典|集合：
    代码块
for 索引值,元素 in 枚举:
    代码块
```

```python
my_dic = {'python教程':"http://c.biancheng.net/python/",\
          'shell教程':"http://c.biancheng.net/shell/",\
          'java教程':"http://c.biancheng.net/java/"}
for ele in my_dic:
    print('ele =', ele)
```

运行结果：

```python
ele = python教程
ele = shell教程
ele = java教程
```

要注意对于字典的遍历，默认取出来的是键，因此如果想要获取相应的值还需要使用get()方法。

### Python循环结构else用法

在Pytohn中，无论是while循环还是for循环，其实都可以紧跟一个else代码块，他们的作用是当循环条件为False跳出循环时，程序会最先执行else代码块中的代码。

```python
add = "http://c.biancheng.net/python/"
i = 0
while i < len(add):
    print(add[i],end="")
    i = i + 1
#原本位于 else 代码块中的代码
print("\n执行 else 代码块")
```

运行结果:

```python
http://c.biancheng.net/python/
执行 else 代码块
```

```python
add = "http://c.biancheng.net/python/"
for i in  add:
    print(i,end="")
else:
    print("\n执行 else 代码块")
```

运行结果：

```python
http://c.biancheng.net/python/
执行 else 代码块
```

我们发现一个问题，就是上面的代码完全不可不添加else也可以实现相同的效果，那也就是说else语句没有用处吗？并不是的，else代码块经常和break结合使用实现一些特殊用处。

### Python嵌套循环实现冒泡排序

冒泡排序是数据结构中的经典算法，他的时间复杂度为O(n^2)，就是两个循环的简单嵌套，因此接下来我们尝试使用Python来实现这个冒泡排序。

冒泡排序算法的实现思想遵循以下几步：

1. 比较相邻的元素，如果第一个比第二个大，就交换它们两个。
2. 从最开始的第一对到结尾的最后一对，对每一对相邻元素做步骤 1 所描述的比较工作，并将最大的元素放在后面。这样，当从最开始的第一对到结尾的最后一对都执行完后，整个序列中的最后一个元素便是最大的数。
3. 将循环缩短，除去最后一个数（因为最后一个已经是最大的了），再重复步骤 2 的操作，得到倒数第二大的数。
4. 持续做步骤 3 的操作，每次将循环缩短一位，并得到本次循环中的最大数。直到循环个数缩短为 1，即没有任何一对数字需要比较，此时便得到了一个从小到大排序的序列。

例如，使用 for 循环实现用冒泡排序算法对 [5,8,4,1] 进行排序：

```python
data = [5,8,4,1]
#实现冒泡排序
for i in range(len(data)-1):
    for j in range(len(data)-i-1):
        if(data[j]>data[j+1]):
            data[j],data[j+1] = data[j+1],data[j]
print("排序后：",data)
```

运行结果：

```python
排序后： [1, 4, 5, 8]
```

可以看到，实现冒泡排序使用了 2 层循环，其中外层循环负责冒泡排序进行的次数，而内层循环负责将列表中相邻的两个元素进行比较，并调整顺序，即将较小的放在前面，较大的放在后面。

### Python break用法详解

在while和for循环中，只要循环条件满足，程序就会一直执行循环体，不停地转圈。但是在某些场景下，我们可能希望程序在循环结束前就能强制退出循环，此时我们就需要使用Python提供的两种强制离开的办法了：

1. 使用 continue 语句，可以跳过执行本次循环体中剩余的代码，转而执行下一次的循环。
2. 只用 break 语句，可以完全终止当前循环。

在上一节我们学习到for可以配备一个else语句，那么在这种情况下，如果使用break语句跳出循环，就不会执行else包含的代码，如下所示：

```python
add = "http://c.biancheng.net/python/,http://c.biancheng.net/shell/"
for i in add:
    if i == ',' :
        #终止循环
        break
    print(i,end="")
else:
    print("执行 else 语句中的代码")
print("\n执行循环体外的代码")
```

从输出结果可以看出，使用 break 跳出当前循环体之后，该循环后的 else 代码块也不会被执行。但是，如果将 else 代码块中的代码直接放在循环体的后面，则该部分代码将会被执行。

### Python推导式初始化序列

#### 列表推导式

```python
[表达式 for item in 可迭代对象]
[表达式 for item in 可迭代对象 if 条件判断]
```

之前我们实际上已经简单的学习了使用推导式进行序列的初始化，比如：

```python
y = [x for x in range(1, 5)]
print(y)
```

运行结果：

```python
[1, 2, 3, 4]
```

进一步，我们可以在for**后面添加一个if条件语句**进行元素的筛选，比如：

```python
y = [x for x in range(1, 50) if x % 5 == 0]
print(y)
```

运行结果：

```python
[5, 10, 15, 20, 25, 30, 35, 40, 45]
```

如山所示，我们使用if条件句和for循环推导式初始化了一个50以内所有5的倍数组成的列表。

我们甚至可以使用多个for初始化一个元素为元组的列表如下所示：

```python
y = [(row, col) for row in range(1, 7) if row % 2 != 0 for col in range(1, 7) if col % 2 == 0]
print(y)
```

运行结果：

```python
[(1, 2), (1, 4), (1, 6), (3, 2), (3, 4), (3, 6), (5, 2), (5, 4), (5, 6)]
```

#### 字典推导式

```python
{key表达式: value表达式 for item in 可迭代对象}
```

比如我们统计一个字符串中各字符出现的次数：

```python
text = 'you could not see my tears cause I am in the water'
char_count = {c: text.count(c) for c in text}
print(char_count)
```

运行结果：

```pytohn
{'y': 2, 'o': 3, 'u': 3, ' ': 11, 'c': 2, 'l': 1, 'd': 1, 'n': 2, 't': 4, 's': 3, 'e': 6, 'm': 2, 'a': 4, 'r': 2, 'I': 1, 'i': 1, 'h': 1, 'w': 1}
```

#### 集合推导式

```python
{表达式 for item in 可迭代对象}
{表达式 for item in 可迭代对象 if 条件判断}
```

```python
y = {x for x in range(1, 50) if x % 5 == 0}
print(y)
```

运行结果：

```python
{35, 5, 40, 10, 45, 15, 20, 25, 30}
```

#### 生成器推导式（生成元组）

```python
(表达式 for item in 可迭代对象)
(表达式 for item in 可迭代对象 if 条件判断)
```

**这样会返还一个生成器对象，一个生成器只能使用一次。**

```python
y = (x for x in range(1, 50) if x % 5 == 0)
print(y)
```

```python
<generator object <genexpr> at 0x0000025228C64518>
```

接下来我们遍历这个y

```python
>>> y = (x for x in range(1, 50) if x % 5 == 0)
>>> for i in y: print(i)
...
5
10
15
20
25
30
35
40
45
>>> for i in y: print(i)
...
>>>
```

我们发现第二次遍历时y的元素不见了。因此一定要注意这种表达式初始化的生成器对象（元组）只能使用一次。

### Python zip函数

zip()函数时Python内置函数之一，他可以将多个序列(列表、元组、字典、集合、字符串以及range()区间构成的列表)“压缩”成一个zip对象，所谓压缩，就是将这些列表中对应位置的元素重新组合，生成一个新的元组。

```python
zip(iterable, ...)
```

其中 iterable,... 表示多个列表、元组、字典、集合、字符串，甚至还可以为 range() 区间。

```python
my_list = [11,12,13]
my_tuple = (21,22,23)
print([x for x in zip(my_list,my_tuple)])
my_dic = {31:2,32:4,33:5}
my_set = {41,42,43,44}
print([x for x in zip(my_dic)])
my_pychar = "python"
my_shechar = "shell"
print([x for x in zip(my_pychar,my_shechar)])
```

运行结果：

```python
[(11, 21), (12, 22), (13, 23)]
[(31,), (32,), (33,)]
[('p', 's'), ('y', 'h'), ('t', 'e'), ('h', 'l'), ('o', 'l')]
```

注意在使用zip()函数“压缩”多个序列时，他会分别读取各序列中第1个元素，第2个元素、...、第n个元素，各自组成一个新的元组。**特别注意，当多个序列中元素个数不一致时，会以最短的序列为准进行压缩。**

另外，对于 zip() 函数返回的 zip 对象，既可以像上面程序那样，通过遍历提取其存储的元组，也可以向下面程序这样，通过调用 list() 函数将 zip() 对象强制转换成列表：

```python
my_list = [11,12,13]
my_tuple = (21,22,23)
print(list(zip(my_list,my_tuple)))
```

运行结果：

```python
[(11, 21), (12, 22), (13, 23)]
```

### Python reversed()函数及用法

reversed()函数时Python内置函数之一，其功能是对于给定的序列（包括列表、元组、字符串以及range(n)区间)，该函数可以返回一个逆序序列的迭代器（**注意是一个新的迭代器类型，没有len())方法，如果必要需要使用list()，tuple()等函数进行转换**)用于遍历该逆序序列。

```python
reversed(seq)
```

其中，seq 可以是列表，元素，字符串以及 range() 生成的区间列表。

```python
#将列表进行逆序
print([x for x in reversed([1,2,3,4,5])])
#将元组进行逆序
print([x for x in reversed((1,2,3,4,5))])
#将字符串进行逆序
print([x for x in reversed("abcdefg")])
#将 range() 生成的区间列表进行逆序
print([x for x in reversed(range(10))])
```

运行结果：

```python
[5, 4, 3, 2, 1]
[5, 4, 3, 2, 1]
['g', 'f', 'e', 'd', 'c', 'b', 'a']
[9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
```

同样的我们也可以使用list()函数将reversed()函数逆序返还的迭代器直接转换成列表进行打印：

```python
#将列表进行逆序
print(list(reversed([1,2,3,4,5])))
```

运行结果：

```python
[5, 4, 3, 2, 1]
```

再次强调，使用 reversed() 函数进行逆序操作，并不会修改原来序列中元素的顺序，例如：

```python
a = [1,2,3,4,5]
#将列表进行逆序
print(list(reversed(a)))
print("a=",a)
```

运行结果：

```python
[5, 4, 3, 2, 1]
a= [1, 2, 3, 4, 5]
```

