---
title: Scilab文档阅读--2d_plot
comments: false
top: false
date: 2021-04-17 15:58:24
tags: [大创,scilab]
categories: 大创项目
---

EasyDraw绘图云平台是基于scilab源代码，仿照scilab实现根据建模语句建模画图功能的项目，这里记录翀翀😑每天苦逼的阅读scilab介绍文档中Graphics画图板块函数功能后的理解与思考。

<!-- more -->

### LineSpec

LineSpec可以帮助我们快速指定绘图时使用的线条的外观。他是一个可选参数，在绘图命令中直接输入使用即可，其中他有三个可选参数，都是字符串类型：

- LineStyle:线条的样式
- Color：线条的颜色
- Marker type：线条的标记样式

这里我们可以利用上面的三个参数来自定义指定一个绘图线条的样式，其格式就是三个参量的字符串按照任意顺序拼接即可：

```matlab
String(类型): "{LineStyle}-{Color}-{Marker type}"
```

这里我们首先来以一个例子来说明三个参数分别用来决定一个线条的什么样式：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/2145d0e2a76705a7c6b41ead72e681e.png)

如上图是一个图形化界面显示的三角函数的图形，我们使用了两种不同样式的线条进行了显示。

他们的建模语句是：

```matlab
clf();
x = 1:0.5:10; // Init.
// The order of information about color, line style or markers does not matter
// BUT the information must be unambiguous
subplot(311);plot(x,sin(x),'.b-');
subplot(312);plot(x,sin(x),'b.-');
subplot(313);plot(x,sin(x),'b-.');// The point belongs to information about line style (not marker!)
```

我们注意到这三个函数图像的plot()方法调用后面都跟随着一个String字符串，例如`'.b-'`,`b.-`等，这就是定义线条样式的语句，也就是LineSpec。他们定义了线条的样式LineStyle如上图线条的实线或者虚线，Color定义了颜色，这里我是用了`b`参数设置线条颜色为蓝色，同时还有一个Marker type属性设定了线条的标记样式，例如图一使用和图2都使用了点来标记线条，而图三没有使用标记。

#### 注意：线条样式设置的参量顺序可以任意排序

我们发现这里的图一和图二的线条样式是完全一致的，但是两者的LineSpec语句并不相同，分别是`'.b-'`和`'b.-'`。但是两者表示的线条样式是相同的，第一个LineSpec形式是`{Marker type}{Color}{LineStyle}`而第二个顺序是`{Color}{Marker type}{LineStyle}`。

下面我们分别给出LineSpec三个参量的可选项：

#### LineStyle

| 可选项 | 线条样式  |
| :----: | :-------: |
|  `-`   |   实线    |
|  `--`  |   虚线    |
|  `:`   |   点线    |
|  `-.`  | 虚线+点线 |

#### Color

| 可选项 | 线条颜色 |
| :----: | :------: |
|   r    |   红色   |
|   g    |   绿色   |
|   b    |   蓝色   |
|   c    |   青色   |
|   m    |   品红   |
|   y    |   黄色   |
|   k    |   黑色   |
|   w    |   白色   |

{% note info, 

注意颜色不需要全拼单词，直接使用上面的字母表示即可，注意黑色是k

%} 

#### Marker type

|         可选项         |     标记样式     |
| :--------------------: | :--------------: |
|          `+`           |       加号       |
|          `o`           |       圆圈       |
|          `*`           |       星号       |
|          `.`           |      实心点      |
|          `x`           |      十字架      |
|  `'square'` or `'s'`   |      正方形      |
|  `'diamond'` or `'d'`  |       菱形       |
|           ^            |    向上的三角    |
|           v            |    向下的三角    |
|           >            |    向右的三角    |
|           <            |    向左的三角    |
| `'pentagram'` or `'p'` |      五角星      |
|                        | 不填写时为无标记 |

### Matplot

在2d界面中我们用Matplot函数来绘制矩阵的二维图，其格式有下面两种

```c
//矩阵的大小,后面只填写<opt_args>提供的strf,rect和nax参数值
Matplot(a,[strf,rect,nax])
//定义矩阵的大小，后面可以以键值对形式给出opt_args的几个可选选项的任意组合
Matplot(a,<opt_args>)
```

其中有以下几个参数：

- a:定义一个矩阵的大小（n1,n2)

- <opt_args>:opt_args是几个给定的可选参数，他必须按照键值对的规则进行赋值

- strf：strf是一个长度为3的字符串’xyz'，其中x,y,z个代表一个可以设定的属性，当我们传进一个数值字符串时会默认将3个数值赋值给x,y,z三个参量，例如'081'，那么x就是0，y就是8,z就是1。

- rect：当strf中的第二个属性值y是1,3或者5时，那么可以使用这个参数。这个参数是一个大小为4的行向量：
  $$
  rect=[x_{min},y_{min},x_{max},y_{min}]
  $$
  来定义显示图框架的尺寸

- nax：当strf的第三个属性值z为1是可以使用这个参数，这个参数是一个大小为4的行向量：
  $$
  nax=[n_x,N_x,n_y,N_y]
  $$
  其中nx(ny)是定义x(y)轴上的子级数，Nx(Ny)是定义x(y)轴上的级数。

#### <opt_args>提供的可选参数

首先opt_args的可选参数必须使用键值对的形式赋值，如：

```c
key1=value1,key2=value2...//其中key是下面的可选参量
```

##### rect

rect上面简单介绍过，他是确定图形尺寸的。对应着strf的第二个属性值y,但是在<opt_args>中，strf不是必须给出的，因此如果没有给出strf同时也没有给出frameflag属性值，那么strf的y字符默认7。

##### nax

定义x和y的级数（即精度值），对应着strf的第三个属性z，同样的，在<opt_args>中如果没有给出axesflag和strf,那么strf的z字符就默认是1。

##### frameflag

指定绘图的框架是如何进行计算大小的，这个值的可选范围是0-8的一个整数，他和strf的y字符相对应。也就是说如果没有给出strf的3字符形式，但是给出了frameflag=k，那么此时y值就是k。即他相当于单独对y进行赋值从而确定绘图的大小规则。

##### axesflag

指定在绘图周围绘制什么样的坐标轴，这个值的可选范围是0-5的一个整数，对应着strf中的z值，因此它相当于单独对z进行赋值。

##### strf

很明显strf是最重要的参数，他是同时对xyz都进行赋值。其中x,y,z具体都代表如下含义。

###### x

定义字幕图注是否显示、只有两个可选值0和1。

- x=0：不显示字幕图注信息。
- x=1：显示字幕图注信息。

###### y

控制从最小值计算坐标表示范围，实际的范围可以大于做小要求。有0-8八个整数值

|  y   |                             含义                             |
| :--: | :----------------------------------------------------------: |
|  0   |             不进行计算，绘图时直接使用默认的比例             |
|  1   | 用rect行向量的值范围即水平方向坐标范围是[xmin,xmax],竖直方向坐标范围是[ymin,ymax] |
|  2   |               从x和y的最小值或者最大值开始绘制               |
|  3   |         绘图时按照rect行向量提供的x/y的比例进行绘图          |
|  4   |   从x的最小值和y的最小值开始伸长等距的范围，因此是个正方形   |
|  5   |          使用rect行向量中的参数放大扩展显示绘图范围          |
|  6   |                            没看懂                            |
|  7   |         和1很类似，但是以前的图使用新得比例进行绘制          |
|  8   |         和2很类似，但是以前的图使用新的比例进行绘制          |

###### z

控制绘图周围框架上的信息显示，如果使用的是坐标轴，那么可以通过nax的可选参数来定义刻度线的数量，即坐标轴的精度

|  z   |                    含义                    |
| :--: | :----------------------------------------: |
|  0   |       不在边框框架上绘画任何测量刻度       |
|  1   |            在绘图时，y轴在左边             |
|  2   |        绘图被一个没有刻度的方框包围        |
|  3   |          在绘图时，y轴显示在右边           |
|  4   | 坐标轴被画在框架的中心点，同时禁止使用边框 |
|  5   | 坐标轴被画在框架的中心点，同时允许使用边框 |

strf的默认值是‘081’即默认不显示字幕图注，并且从x/y的最小/最大开始绘图同时y轴显示在左侧。

##### 总结

我们可以总结为：strf是一个最全的属性设置项他用来定义一个绘图的各种规则，而y和z也可以单独通过frameflag和axesflag来设值，其中y是决定绘图的坐标范围，而z是设置坐标绘图时坐标轴的位置以及刻度的精度问题。rect是y取1,3,5时可以使用的一个行向量用来存储x,y的最小值和最大值，nax是z取1即绘图要求有刻度时用来存储刻度精度的向量。

#### 代码调用案例

{% note info, 

当矩阵绘图函数调用为Matplot([x y z; h i j; k l m])时，那么默认是以单位长度为1的正方形排列来绘制二维矩阵图，此时每一个`;`代表一行的结束。编号不同的样条会被映射为不同的颜色，这样我们就可以清楚的分辨各个样条的位置。

%} 

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210424110823.png)

上面的绘图代码是：

```matlab
Matplot([1 2 3 4 5 6])
```

首先要注意这种形式的绘图时要将所有的行编号写到一个中括号内，由于这里我们命名了1 2 3 4 5 6六个样条，同时都处于同一行，因此出现了上图的形式，要注意此时就是一个正方形样条，观察刻度值会发现x方向和y方向距离都是单位长度1。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210424111128.png)

此时的绘图代码是

```matlab
Matplot([1 2 3;4 5 6])
```

由于此时3和4之间存在`;`，因此此时的矩阵是两行三列。每一个样条都是一个独一无二的颜色映射的正方形。之所以颜色会不同，就是因为我们为每一个样条正方形赋予了不同的编号。因此当编号相同时，样条的颜色映射会相同，如下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210424111325.png)

此时的绘图代码是

```matlab
Matplot([1 2 3;1 3 2])
```

因此左上角的样条和左下角的样条颜色映射是相同的，而右侧则是对角线样条颜色相同，这就是相同编号会映射相同颜色造成的。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210424112414.png)

绘图代码是

```matlab
Matplot([2,3,6],"083")
```

此时我们使用了前面提到的第一种调用Matplot的格式，我们设置strf为“083”，因此此时z的值修改为了3，因此y轴会移动到右侧。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210424112808.png)

此时绘图代码是

```matlab
Matplot([2,3,6],"135",[1,2,4,6])
```

此时我们还是只绘画一行样条，但是strf被修改为了“135”，因此此时y被修改为3，因此会根据rect行向量给出的x和y的长度比例来绘图，我们此时的rect存储的是[1,2,4,6]，因此xmin=1,ymin=2,xmax=4,ymax=6。因此绘图的比例是3/4。同时坐标范围也变成了rect定义的范围，又因为z被修改为了5，因此此时坐标轴画在了二维矩阵图中心，并且允许有边框。

#### 相关函数

在scilab的源码中可以找到以下有关Matplot()方法的实现函数：

- scilab\modules\graphics\sci_gateway\cpp\sci_matplot.cpp
- scilab\modules\graphics\sci_gateway\cpp\sci_matplot1.cpp
- scilab\module\graphic_objects\includes\MatPlotDecomposer.hxx

两个cpp存储的是两个重载的matplot()函数。

