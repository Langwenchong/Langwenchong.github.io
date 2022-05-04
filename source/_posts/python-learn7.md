---
title: python学习笔记--python基础(7)
comments: false
top: false
date: 2022-01-23 15:25:01
tags: [python]
categories: 
	- [个人笔记,Python基础]
---

python基础入门笔记，记录翀翀对Python基础的理解与总结，常言道：一分耕耘，一分收获。”在自己的理想道路上，多动脑筋，不断的思考，不停地学习，四肢能勤，不断地“书读百遍”，就会“其义自现”。愿你我都能坚持学习😁

<!-- more -->

### Python字符串拼接

在Python中拼接字符串很简单，可以直接将两个字符串紧挨着写在一起即可：

```python
strname = "str1" "str2"
```

strname 表示拼接以后的字符串变量名，str1 和 str2 是要拼接的字符串内容。使用这种写法，Python 会自动将两个字符串拼接在一起。**要注意拼接并不会改变原先的字符串，仅仅是生成一个新的字符串而已。**

```python
str1 = "Python教程" "http://c.biancheng.net/python/"
print(str1)
str2 = "Java" "Python" "C++" "PHP"
print(str2)
```

运行结果：

```python
Python教程http://c.biancheng.net/python/
JavaPythonC++PHP
```

{% note info,

这种直接罗列紧挨着的字符串拼接仅限于拼接字符串常量，如果需要使用到变量，那么需要使用`+`进行拼接

%}

```python
name = "C++教程"
url = "http://c.biancheng.net/cplus/"
info = name + "的网址是：" + url
print(info)
```

运行结果：

```python
C++教程的网址是：http://c.biancheng.net/cplus/
```

#### Python字符串和数字的拼接

在很多应用场景中，我们都需要将字符串和数字进行拼接，而Python是不允许直接拼接数字和字符串的，所以我们必须先将数字转换成字符串。可以借助str()和repr()函数将数字转换为字符串，他们的使用格式如下：

```python
str(obj)
repr(obj)
```

obj表示要转换的对象，他可以是数字、列表、元组、字典等多种类型的数据。

```python
name = "C语言中文网"
age = 8
course = 30
info = name + "已经" + str(age) + "岁了，共发布了" + repr(course) + "套教程。"
print(info)
```

运行结果：

```python
C语言中文网已经8岁了，共发布了30套教程。
```

##### 思考：str()和repr()的区别？

- str() 用于将数据转换成适合人类阅读的字符串形式。
- repr() 用于将数据转换成适合解释器阅读的字符串形式（Python 表达式的形式），适合在开发和调试阶段使用；如果没有等价的语法，则会发生 SyntaxError 异常。

```python'
s = "http://c.biancheng.net/shell/"
s_str = str(s)
s_repr = repr(s)
print( type(s_str) )
print (s_str)
print( type(s_repr) )
print (s_repr)
```

运行结果:

```python
<class 'str'>
http://c.biancheng.net/shell/
<class 'str'>
'http://c.biancheng.net/shell/'
```

从上面的演示中，我们可以看到，s本身就是一个字符串，但是我们依然使用了str()和repr()来对他进行转换。从运行结果中我们可以看出，str()保留了字符串最原始的样子，而repr()使用引号将字符串包围起来，这就是Python字符串的表达形式。

另外，在Python交互变成环境中，输入一个字符串（变量、加减乘除、逻辑运算等）时，Python会自动使用repr()函数处理该表达式。

### Python截取字符串（字符串切片）

本质上来看，字符串是由多个字符构成的，字符之间是有顺序的，这个顺序就是索引（index)。Python允许通过索引来操作字符串中的单个字符或者多个字符，比如获取指定索引处的字符，返回指定字符的索引值等。

#### 获取单个字符

知道字符名以后，我们可以通过方括号`[]`中使用索引即可访问对应的字符，具体语法格式如下：

```python
strname[index]
```

strname表示字符串名字，index表示索引值。

Python允许从字符串的两端使用索引：

- 当以字符串的左端（字符串的开头）为起点时，索引是从 0 开始计数的；字符串的第一个字符的索引为 0，第二个字符的索引为 1，第三个字符串的索引为 2 ……
- 当以字符串的右端（字符串的末尾）为起点时，索引是从 -1 开始计数的；字符串的倒数第一个字符的索引为 -1，倒数第二个字符的索引为 -2，倒数第三个字符的索引为 -3 ……

```python
url = 'http://c.biancheng.net/python/'
#获取索引为10的字符
print(url[10])
#获取索引为 6 的字符
print(url[-6])
```

运行结果：

```python
i
y
```

#### 获取多个字符（字符串切片）

使用`[]`除了可以获取单个字符之外，我们还可以指定一个范围获取多个字符，也就是一个子串或者片段，具体格式如下：

```python
strname[start : end : step]
```

- strname：要截取的字符串；
- start：表示要截取的第一个字符所在的索引（截取时包含该字符）。如果不指定，默认为 0，也就是从字符串的开头截取；
- end：表示要截取的最后一个字符所在的索引（截取时不包含该字符）。如果不指定，默认为字符串的长度；
- step：指的是从 start 索引处的字符开始，每 step 个距离获取一个字符，直至 end 索引出的字符。step 默认值为 1，当省略该值时，最后一个冒号也可以省略。

```python
url = 'http://c.biancheng.net/java/'
#获取从索引5开始，直到末尾的子串
print(url[7: ])
#获取从索引-21开始，直到末尾的子串
print(url[-21: ])
#从开头截取字符串，直到索引22为止
print(url[: 22])
#每隔3个字符取出一个字符
print(url[:: 3])
```

运行结果：

```python
c.biancheng.net/java/
c.biancheng.net/java/
http://c.biancheng.net
hp/bne.ta/
```

### Python len()函数详解

Python中，要想知道一个字符串有多少个字符（获取字符串长度），或者一字符串占用多少个字节，我们可以使用len()方法。

```python
len（string）
```

```python
>>> a='http://c.biancheng.net'
>>> len(a)
22
```

在实际开发中，除了常常获取字符串的长度外，有时候我们还需要获取字符串的字节数。在Python中，不同的字符所占的字节数不同，数字、英文字母、小数点、下划线以及空格各占一个字节，而一个汉字可能占2~4个字节，具体占多少个，取决于采用的编码方式。例如，汉字在GBK/GB2312编码中占用2个字节，而在UTF-8编码中一般占用3个字节。

![](https://langwenchong.gitee.io/figure-bed/20220123162120.png)

我们可以通过使用encode()方法，将字符串进行编码后再获取它的字节数。例如，采用UTF-8编码方式，计算”人生苦短，我用Python“的字节数，可以执行如下代码：

```python
>>> str1 = "人生苦短，我用Python"
>>> len(str1.encode())
27
```

因为汉字加中文标点符号共7个，占21个字节，而英文字母和英文的标点符号占6个字节，一共占用27个字节。同理，如果要获取采用GBK编码的字符串的长度，可以执行如下代码：

```python
>>> str1 = "人生苦短，我用Python"
>>> len(str1.encode('gbk'))
20
```

### Python split()方法切割字符串

Python中，除了提供了一些内置函数获取字符串的相关信息外（例如len()),字符串类型本身也提供了一些方法供我们使用，这些方法都是字符串类型特有的。

split()方法可以实现将一个字符串按照指定的分隔符切分成多个子串，这些子串会被保存到列表中（不包括分隔符），作为方法的返回值。

```python
str.split(sep,maxsplit)
```

此方法中各部分参数的含义分别是：

1. str：表示要进行分割的字符串；
2. sep：用于指定分隔符，可以包含多个字符。此参数默认为 None，表示所有空字符，包括空格、换行符“\n”、制表符“\t”等。
3. maxsplit：可选参数，用于指定分割的次数，最后列表中子串的个数最多为 maxsplit+1。如果不指定或者指定为 -1，则表示分割次数没有限制。

{% note info,

在split()方法中，如果不指定sep参数，那么也不能指定maxsplit参数。

%}

**要注意，当未指定sep参数时，split(）方法默认采用空字符进行分割，但是当字符串中有连续的空格或其他空字符时，都会被视为一个分割符归字符串进行分割**

```python
>>> str = "C语言中文网   >>>   c.biancheng.net"  #包含 3 个连续的空格
>>> list6 = str.split()
>>> list6
['C语言中文网', '>>>', 'c.biancheng.net']
```

### Python join()方法合并字符串

join()方法就是split()方法的逆方法，用来将列表（或者元组）中包含的多个字符串连接成一个字符串。

使用join()方法合并字符串时，他会将列表（或者元组）中多个字符串采用固定的分隔符连接在一起。例如，字符串"c.biancheng.net"就可以看做是通过分隔符“.”将['c','biancheng','net'] 列表合并为一个字符串的结果。

```python
newstr = str.join(iterable)
```

此方法中各参数的含义如下：

1. newstr：表示合并后生成的新字符串；
2. str：用于指定合并时的分隔符；
3. iterable：做合并操作的源字符串数据，允许以列表、元组等形式提供。

```python
>>> dir = '','usr','bin','env'
>>> type(dir)
<class 'tuple'>
>>> '/'.join(dir)
'/usr/bin/env'
```

### Python count()方法统计字符串出现的次数

count()方法用于检索指定字符串在另一字符串中出现的次数，如果检索的字符串不存在，则返回0，否则返回出现的次数。

```python
str.count(sub[,start[,end]])
```

此方法中，各参数的具体含义如下：

1. str：表示原字符串；
2. sub：表示要检索的字符串；
3. start：指定检索的起始位置，也就是从什么位置开始检测。如果不指定，默认从头开始检索；
4. end：指定检索的终止位置，如果不指定，则表示一直检索到结尾。

```python
>>> str = "c.biancheng.net"
>>> str.count('.',2,-3)
1
>>> str.count('.',2,-4)
0
```

**要注意搜索范围是[start,end)即末尾是开区间。**

### Python find()方法检测字符串中是否包含某子串

find()方法用于检索字符串中是否包含目标字符串，如果包含，则返回第一次出现该字符串的索引，反之则返回-1。

```python
str.find(sub[,start[,end]])
```

此格式中各参数的含义如下：

1. str：表示原字符串；
2. sub：表示要检索的目标字符串；
3. start：表示开始检索的起始位置。如果不指定，则默认从头开始检索；
4. end：表示结束检索的结束位置。如果不指定，则默认一直检索到结尾。

```python
>>> str = "c.biancheng.net"
>>> str.find('.',2,-4)
-1
```

同时Python还提供了rfind()方法，他可以从字符串右边开始检索，因此返回的是最靠近右侧的首次出现的字符串

```python
>>> str = "c.biancheng.net"
>>> str.rfind('.')
11
```

### Python index()方法检测字符串中是否包含某子串

和find()方法类似，index()方法也可以用来检索是否包含指定的字符串，不同之处在于，当指定的字符串不存在时，idnex()方法会抛出异常。

```python
str.index(sub[,start[,end]])
```

此格式中各参数的含义分别是：

1. str：表示原字符串；
2. sub：表示要检索的子字符串；
3. start：表示检索开始的起始位置，如果不指定，默认从头开始检索；
4. end：表示检索的结束位置，如果不指定，默认一直检索到结尾。

```python
>>> str = "c.biancheng.net"
>>> str.index('.')
1
>>> str = "c.biancheng.net"
>>> str.index('z')
Traceback (most recent call last):
  File "<pyshell#49>", line 1, in <module>
    str.index('z')
ValueError: substring not found
```

类似的，Python也提供了rindex()方法，从右边开始检索：

```python
>>> str = "c.biancheng.net"
>>> str.rindex('.')
11
```

### Python字符串对齐方法

Python str还提供了3种可以用来进行文本对齐的方法，分别是ljust()、rjust()和center()方法。

#### Python ljust()方法

ljust()方法的功能是向指定字符串的右侧填充指定字符，从而达到左对齐文本的目的。

```python
S.ljust(width[, fillchar])
```

其中各个参数的含义如下：

- S：表示要进行填充的字符串；
- width：表示包括 S 本身长度在内，字符串要占的总长度；
- fillchar：作为可选参数，用来指定填充字符串时所用的字符，默认情况使用空格。

```python
S = 'http://c.biancheng.net/python/'
addr = 'http://c.biancheng.net'
print(S.ljust(35,'-'))
print(addr.ljust(35,'-'))
```

运行结果：

```python
http://c.biancheng.net/python/-----
http://c.biancheng.net-------------
```

#### Python rjust()方法

rjust()和ljust()方法类似，唯一的不同之处在于，rjust()方法是向字符串的左侧填充指定字符串，从而达到右对齐文本的目的。

```python
S.rjust(width[, fillchar])
```

```python
S = 'http://c.biancheng.net/python/'
addr = 'http://c.biancheng.net'
print(S.rjust(35,'-'))
print(addr.rjust(35,'-'))
```

运行结果：

```python
-----http://c.biancheng.net/python/
-------------http://c.biancheng.net
```

#### Python center()方法

```python
S.center(width[, fillchar])
```

```python
S = 'http://c.biancheng.net/python/'
addr = 'http://c.biancheng.net'
print(S.center(35,'-'))
print(addr.center(35,'-'))
```

运行结果：

```python
---http://c.biancheng.net/python/--
-------http://c.biancheng.net------
```

### Python startswith()和endswith()方法

#### startswith()方法

startswith()方法用来检索字符串是否以指定字符串开头，如果是返回True,反之返回False。

```python
str.startswith(sub[,start[,end]])
```

此格式中各个参数的具体含义如下：

1. str：表示原字符串；
2. sub：要检索的子串；
3. start：指定检索开始的起始位置索引，如果不指定，则默认从头开始检索；
4. end：指定检索的结束位置索引，如果不指定，则默认一直检索在结束。

```python
>>> str = "c.biancheng.net"
>>> str.startswith("b",2)
True
```

#### endswith()方法

endswith() 方法用于检索字符串是否以指定字符串结尾，如果是则返回 True；反之则返回 False。该方法的语法格式如下：

```python
str.endswith(sub[,start[,end]])
```

```python
>>> str = "c.biancheng.net"
>>> str.endswith("net")
True
```

### Python字符串大小写转换

#### Python title()方法

titile()方法用于将字符串中的每一个单词的首字母转为大写，其他字母全部转为小写，转换完成后，此方法会返回转换得到的字符串。如果字符串中没有需要被转换的字符，那么字符串将会被原封不动的返回

```python
str.title()
```

```python
>>> str = "c.biancheng.net"
>>> str.title()
'C.Biancheng.Net'
>>> str = "I LIKE C"
>>> str.title()
'I Like C'
```

#### Python lower()方法

用于将字符串中的所有大写字母转换为小写字母，转换完成以后，该方法会返回新得到的字符串。如果字符串中原本就都是小写字母，那么这个方法返回原字符串。

```python
str.lower()
```

```python
>>> str = "I LIKE C"
>>> str.lower()
'i like c'
```

#### Python upper()方法

upper()方法和lower()方法功能相反，他用来将字符串中的所有小写字母转换为大写字母。

```python
str.upper()
```

```python
>>> str = "i like C"
>>> str.upper()
'I LIKE C'
```

{ % note info,

要注意，以上三个方法都仅限于将转换后的新字符串返回，而不会修改原字符串。

%}

### Python去除字符串中空格

用户输入数据时，很有可能无疑中输入了多余的空格，或者在一些场景中，字符串前后不允许出现空格或者特殊字符，此时就需要去除字符串中的空格或者特殊字符了。

这里的特殊字符，指的是制表符`\t`，回车符`\r`,换行符`\n`等。

在Python中，字符串变量提供了3种方法来删除字符串中多于的空格或者特殊字符，他们分别是：

1. strip()：删除字符串前后（左右两侧）的空格或特殊字符。
2. lstrip()：删除字符串前面（左边）的空格或特殊字符。
3. rstrip()：删除字符串后面（右边）的空格或特殊字符。

我们要注意Python中字符串类型是不可变的，因此这三个方法仅仅是返回字符串前面或后面空白被删除以后的副本，并不会改变原字符串本身。

#### Python strip()方法

```python
str.strip([chars])
```

其中，str 表示原字符串，[chars] 用来指定要删除的字符，可以同时指定多个，如果不手动指定，则默认会删除空格以及制表符、回车符、换行符等特殊字符。

```python
>>> str = "  c.biancheng.net \t\n\r"
>>> str.strip()
'c.biancheng.net'
>>> str.strip(" ,\r")
'c.biancheng.net \t\n'
>>> str
'  c.biancheng.net \t\n\r'
```

#### Python lstrip()方法

```python
>>> str = "  c.biancheng.net \t\n\r"
>>> str.lstrip()
'c.biancheng.net \t\n\r'
```

#### Python rstrip()方法

```python
>>> str = "  c.biancheng.net \t\n\r"
>>> str.rstrip()
'  c.biancheng.net'
```

### Python format()格式化输出方法

之前我们学习了使用%操作符来对各种类型的数据进行格式化输出，这是早期Python提供的方法。自从Python2.6版本之后，字符串类型提供了format()方法对字符串进行格式化。

```python
str.format(args)
```

此方法中，str 用于指定字符串的显示样式；args 用于指定要进行格式转换的项，如果有多项，之间有逗号进行分割。

学习 format() 方法的难点，在于搞清楚 str 显示样式的书写格式。在创建显示样式模板时，需要使用`{}`和`：`来指定占位符，其完整的语法格式为：

```python
{ [index][ : [ [fill] align] [sign] [#] [width] [.precision] [type] ] }
```

注意，格式中用 [] 括起来的参数都是可选参数，即可以使用，也可以不使用。各个参数的含义如下：

- index：指定：后边设置的格式要作用到 args 中第几个数据，数据的索引值从 0 开始。如果省略此选项，则会根据 args 中数据的先后顺序自动分配。
- fill：指定空白处填充的字符。注意，当填充字符为逗号(,)且作用于整数或浮点数时，该整数（或浮点数）会以逗号分隔的形式输出，例如（1000000会输出 1,000,000）。
- align：指定数据的对齐方式，具体的对齐方式如下表所示

| align参数 |                             含义                             |
| :-------: | :----------------------------------------------------------: |
|     <     |                         数据左对齐。                         |
|     >     |                         数据右对齐。                         |
|     =     | 数据右对齐，同时将符号放置在填充内容的最左侧，该选项只对数字类型有效。 |
|     ^     |          数据居中，此选项需和 width 参数一起使用。           |

- sign：指定有五符号数，此参数的值以及对应的含义如下表所示

| sign参数 |                             含义                             |
| :------: | :----------------------------------------------------------: |
|    +     |                 正数前加正号，负数前加负号。                 |
|    -     |                正数前不加正号，负数前加负号。                |
|   空格   |                 正数前加空格，负数前加负号。                 |
|    #     | 对于二进制数、八进制数和十六进制数，使用此参数，各进制数前会分别显示 0b、0o、0x前缀；反之则不显示前缀。 |

- width：指定输出数据时所占的宽度。
- .precision：指定保留的小数位数。
- type：指定输出数据的具体类型，如下表所示

| type类型值 |                         含义                          |
| :--------: | :---------------------------------------------------: |
|     s      |                 对字符串类型格式化。                  |
|     d      |                     十进制整数。                      |
|     c      |      将十进制整数自动转换成对应的 Unicode 字符。      |
|  e 或者 E  |          转换成科学计数法后，再格式化输出。           |
|   g 或 G   |          自动在 e 和 f（或 E 和 F）中切换。           |
|     b      |    将十进制数自动转换成二进制表示，再格式化输出。     |
|     o      |    将十进制数自动转换成八进制表示，再格式化输出。     |
|  x 或者 X  |   将十进制数自动转换成十六进制表示，再格式化输出。    |
|  f 或者 F  | 转换为浮点数（默认小数点后保留 6 位），再格式化输出。 |
|     %      |         显示百分比（默认显示小数点后 6 位）。         |

```python
#以货币形式显示
print("货币形式：{:,d}".format(1000000))
#科学计数法表示
print("科学计数法：{:E}".format(1200.12))
#以十六进制表示
print("100的十六进制：{:#x}".format(100))
#输出百分比形式
print("0.01的百分比表示：{:.0%}".format(0.01))
```

运行结果：

```python
货币形式：1,000,000
科学计数法：1.200120E+03
100的十六进制：0x64
0.01的百分比表示：1%
```

### Python字符串编码转换

我们知道，最早的字符串编码是ASCII编码，它仅仅对10个数字、26个大小写英文字母以及一些特殊字符进行了编码。ASCII码最多只能表示256个字符，每一个字符只需要占用一个字节。但是伴随着信息技术的发展，各国的文字都需要进行编码，于是相继出现了GBK,GB2312,UTF-8编码等。其中GBK和GB2312是我国制定的中文编码标准，规定英文字符占用1个字节，中文字符占2个字节。而UTF-8是国际通过的编码格式，它包含了全世界所有国家需要用到的字符，其规定是英文字符占1个字节，中文字符占3个字节。

{% note info,

Python3.x默认采用UTF-8编码格式，有效的解决了中文乱码的问题。

%}

我们之前学习过在Python中有两种字符串类型，分别是str和bytes类型，其中str用来表示Unicode字符，bytes用来表示二进制数据。str类型和bytes类型之间就需要使用encode()和decode()方法进行转换。

#### Python encode()方法

encode()方法为字符串类型str提供的方法，用于将str转换为bytes类型，这个过程也称为编码。

```python
str.encode([encoding="utf-8"][,errors="strict"])
```

注意，格式中用 [] 括起来的参数为可选参数，也就是说，在使用此方法时，可以使用 [] 中的参数，也可以不使用。

|        参数        | 含义                                                         |
| :----------------: | :----------------------------------------------------------- |
|        str         | 表示要进行转换的字符串。                                     |
| encoding = "utf-8" | 指定进行编码时采用的字符编码，该选项默认采用 utf-8 编码。例如，如果想使用简体中文，可以设置 gb2312。  当方法中只使用这一个参数时，可以省略前边的“encoding=”，直接写编码格式，例如 str.encode("UTF-8")。 |
| errors = "strict"  | 指定错误处理方式，其可选择值可以是：<br />strict：遇到非法字符就抛出异常。<br />ignore：忽略非法字符。<br />replace：用“？”替换非法字符。<br />xmlcharrefreplace：使用 xml 的字符引用。<br />该参数的默认值为 strict。 |

**注意，使用 encode() 方法对原字符串进行编码，不会直接修改原字符串，如果想修改原字符串，需要重新赋值。**

```python
>>> str = "C语言中文网"
>>> str.encode()
b'C\xe8\xaf\xad\xe8\xa8\x80\xe4\xb8\xad\xe6\x96\x87\xe7\xbd\x91'
>>> str = "C语言中文网"
>>> str.encode('GBK')
b'C\xd3\xef\xd1\xd4\xd6\xd0\xce\xc4\xcd\xf8'
```

#### Python decode()方法

和encode()方法相反，decode()方法用于将bytes类型的二进制数据转换为str类型，这个过程又称为阶解码。

```python
bytes.decode([encoding="utf-8"][,errors="strict"])
```

|       参数        | 含义                                                         |
| :---------------: | ------------------------------------------------------------ |
|       bytes       | 表示要进行转换的二进制数据。                                 |
| encoding="utf-8"  | 指定解码时采用的字符编码，默认采用 utf-8 格式。当方法中只使用这一个参数时，可以省略“encoding=”，直接写编码方式即可。  注意，对 bytes 类型数据解码，要选择和当初编码时一样的格式。 |
| errors = "strict" | 指定错误处理方式，其可选择值可以是：strict：遇到非法字符就抛出异常。ignore：忽略非法字符。replace：用“？”替换非法字符。xmlcharrefreplace：使用 xml 的字符引用。该参数的默认值为 strict。 |

```python
>>> str = "C语言中文网"
>>> bytes=str.encode()
>>> bytes.decode()
'C语言中文网'
```

注意，如果编码时采用的不是默认的 UTF-8 编码，则解码时要选择和编码时一样的格式，否则会抛出异常，例如：

```python
>>> str = "C语言中文网"
>>> bytes = str.encode("GBK")
>>> bytes.decode()  #默认使用 UTF-8 编码，会抛出以下异常
Traceback (most recent call last):
  File "<pyshell#10>", line 1, in <module>
    bytes.decode()
UnicodeDecodeError: 'utf-8' codec can't decode byte 0xd3 in position 1: invalid continuation byte
>>> bytes.decode("GBK")
'C语言中文网'
```

### Python dir()和help()帮助函数

前面我们仅仅是学习了Python字符串中提供的常用的方法，但是这远远不是他的全部方法。我们还可以通过dir()或者help()方法查看更多方法。

Python dir()函数用来列出某个类或者某个模块中的全部内容，包括变量、方法、函数和类等。他的用法：

```python
dir(obj)
```

obj 表示要查看的对象。obj 可以不写，此时 dir() 会列出当前范围内的变量、方法和定义的类型。

Python help() 函数用来查看某个函数或者模块的帮助文档，它的用法为：

```python
help(obj)
```

obj表示要查看的对象，obj可以不写，此时help()会进入帮助子程序。

假设现在我们要使用dir()查看str类型支持的所有方法：

``` python
>>> dir(str)
['__add__', '__class__', '__contains__', '__delattr__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__getitem__', '__getnewargs__', '__gt__', '__hash__', '__init__', '__init_subclass__', '__iter__', '__le__', '__len__', '__lt__', '__mod__', '__mul__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__rmod__', '__rmul__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', 'capitalize', 'casefold', 'center', 'count', 'encode', 'endswith', 'expandtabs', 'find', 'format', 'format_map', 'index', 'isalnum', 'isalpha', 'isascii', 'isdecimal', 'isdigit', 'isidentifier', 'islower', 'isnumeric', 'isprintable', 'isspace', 'istitle', 'isupper', 'join', 'ljust', 'lower', 'lstrip', 'maketrans', 'partition', 'replace', 'rfind', 'rindex', 'rjust', 'rpartition', 'rsplit', 'rstrip', 'split', 'splitlines', 'startswith', 'strip', 'swapcase', 'title', 'translate', 'upper', 'zfill']
```

我们已经找到了它支持的所有方法，接下来我们可以通过help()方法去详细了解每一个方法的具体功能。如下所示我们使用help()方法查看str中lower()方法的用法：

```python
>>> help(str.lower)
Help on method_descriptor:

lower(self, /)
    Return a copy of the string converted to lowercase.
```

{% note info,

注意，使用 help() 查看某个函数的用法时，函数名后边不能带括号，例如将上面的命令写作`help(str.lower())`就是错误的。

%}