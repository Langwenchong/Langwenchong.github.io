---
title: ubuntu新手向安装配置与美化一条龙教程
comments: false
top: false
date: 2021-01-22 11:28:47
tags: [ubuntu]
categories: 
	- [教程,ubuntu配置]
headimg: https://gitee.com/Langwenchong/figure-bed/raw/master/20210704155405.png
---

本教程是在我进行了尝试并且成功安装以后总结出来的新手向傻瓜式教程，适用于第一次安装虚拟机的小白参考，基本上安装完以后可以实现虚拟机上所有的基本操作同时也进行了MACOS风格美化保证你从此爱上虚拟机😄！

<!-- more -->

### 📷虚拟机展示

![](https://img.imgdb.cn/item/600a49d93ffa7d37b3f189c2.jpg)

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122114837.png)

第一张图片是美化以后的虚拟机桌面显示，下图是虚拟机的配置，基本上实现了对于一个同学学习使用虚拟机的全配置。其中我这篇教程将帮助你实现以下功能：

1. 安装虚拟机基础配置
2. 中文输入法，VSCODE等必要的软件安装
3. MAC风格桌面美化

### 📀虚拟机安装

#### 基础配置

首先你需要下载两个文件，分别是[VirtualBox](https://www.virtualbox.org/)和[UbuntuDesktop](https://ubuntu.com/#download)(由于是新手向，怕你不知道点那个键，我给你截图画出了需要点击的键咯~)

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122115534.png)

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122115608.png)

可能你安装的时候版本已经更新了，没事安装最新的即可，毕竟有新版本为何不使用呢？如果你实在是想安装老版本那强烈推荐ubuntu18.04版本比较稳定，我这里就是安装的当前最新版本ubuntu20.04，但是没关系，无论过对于那个版本，本教程都适用。你下下来的VirtualBox应该是一个安装程序exe点击启动安装，而ubuntu应该是一个压缩包文件，千万不要解压缩。

安装好VM(后面VirtualBox简称为VM)后打开，应该出现下图界面：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122115950.png)

你那里应该还没有虚拟机，所以接下来就是新建一个虚拟机啦，点击新建然后弹出下图

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122120208.png)

这里我强烈推荐你将名称命名为ubuntu+版本的格式，因为你以后也许会创建许多个不同版本的虚拟机，为了易于区分，这样命名更加友好。至于下方的文件夹你应该默认的是C盘，一定要改成D盘的VirtualBox VMs，应该是没有这个文件夹的你需要自己在D盘新建文件夹命名为这个然后选择这个文件夹存储。至于为什么不存储在C盘，因为以后随着的配置的增加和使用次数的频繁这个文件夹大约会暴增到10G左右放到C盘迟早要炸。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122120617.png)

至于内存开到2G就行了没必要开太大，内存≠磁盘空间。然后就到了关键步骤，为磁盘分配空间：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122120753.png)

选择创建虚拟硬盘，然后选择VDI就行，下一步以后出现物理硬盘的分配方式选择动态分配即可再下一步然后关键步骤：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122120921.png)

这里也是选择D盘存储，最重要的是下面的硬盘空间大小他默认的是开10G，千万不要以为这很大，实际上这个完全不够用，很容易导致未来磁盘空间不足无法开机的报错情况类似于[《ubuntu磁盘空间不足》](https://wenchong.space/2021/01/21/ubuntu-problem1/)，因为一旦分配了硬盘空间后以后就不好扩容了（当然是可以扩容的，但是很复杂），我推荐你一次性开的足够大，大约>=60G比较好，我开的是100G，你自己斟酌。然后我们就完成了基础配置，接下来先别急着启动，打开设置。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122121722.png)

对控制器IDE分配光驱这里应该可以直接选择刚刚下载的iso文件就是那个压缩包。然后在点击ok退出到主界面启动此时第一次启动他会进行虚拟机的安装出现下图的界面：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122121932.png)

这个界面就是选择安装时的显示语言，实际上选英语也没啥事，当然选中文的话你能够清晰看到安装进度但是实际上也看不懂随便选吧。关键是点击右边的install ubuntu进行安装，然后你就可以去玩几把游戏去了，这个安装大概一般在1小时左右，不用动虚拟机等待他自己安装即可。安装完成后他会要求重新启动虚拟机重启即可，在这里部分电脑可能会出现报错然后重启后再次安装虚拟机的情况，那么就再安装一次这次安装就一定会成功了，如果你启动成功了那么就应该可以进入到桌面啦（貌似，还有一个注册账户的环节，你就直接注册就好了）。

进入到桌面以后，你的应该是一个很丑陋的桌面没关系，我们先来安装一下软件，因为这个需要很长的时间。请点击Ubuntu Sofware进入到应用市场进行安装，当然你也可以选择使用命令行安装，但是应用市场更加简单。进入市场后安装一下几个软件：

- Visuacl Sudio Code(IED，如果你使用的是其他的请自行安装)
- Gparted(磁盘管理软件)
- Fcitx(这个是中文输入法)

其中FCITX请安装以下这个：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122133457.png)

当然如果你没有上面这个那么就打开终端，在桌面中单机鼠标右键，选择open in terminal即可打开终端，然后输入

```linux
sudo apt install fcitx
```

你需要输入密码，输入密码时他是不会显示小圆点的，你就直接输入完成后回车即可,他就会自动下载。

#### 中文显示与中文输入法

接下来我们安装完这几个软件后先将界面改成中文吧，否则太难受了，点击Language Support打开语言支持软件（自带），他需要进行以下更新你直接更新就好了，然后就可以打开这个界面了。

![](https://img.imgdb.cn/item/600a65443ffa7d37b3031f31.jpg)

这里选择添加语言选择添加汉语同时下方的输入法应该也已经可以选择添加fcitx了。配置完以后。打开个人设置，即点击右上角的小三角就可以选择settings打开设置了。

![](https://img.imgdb.cn/item/600a659f3ffa7d37b3035546.jpg)

打开后选择区域语言（Rgion&Language)选择中文格式和拼音输入源：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/@Q`JULO7DE$962@34%S6ZWG.png)

配置完这些后请重启虚拟机，再次进入以后应该就实现了中文显示和中文输入法了，此时你在观察右上角应该多了一个语言栏选择

![](https://img.imgdb.cn/item/600a669f3ffa7d37b303ceea.jpg)

这里选择中文智能拼音即可，这样中英切换就是shift键了。

#### 窗口大小调整

你的桌面上应该不是全部显示窗口，这里我们将窗口调整一下，仍然是打开设置，选择显示器（display）将分辨率选择为1440×900并且选择keep保存这样窗口看起来就比较舒服了。当然左上角的视图菜单栏中也有全屏模式但是我感觉不太好用。可以选择自动调整窗口大小这样就可以缩小显示了。

#### 浏览器配置

ubuntu默认安装了火狐浏览器，这个就很好用了，不用换成chrome了，更不要在使用360，金山毒霸，QQ浏览器等了，首先是虚拟机上不好安装这些浏览器，同时身为一名程序猿，我们要更加优雅的使用浏览器，当然得选择可以支持插件扩展的浏览器了，所以早日习惯使用火狐和chrome更好，我感觉火狐就挺好的，chorme占用的内存较大并且还得再次安装太麻烦，这里就是用火狐了。打开火狐浏览器，你应该还不能直接使用搜索引擎，因为他默认使用的google搜索，我国国内不支持，请刚换成必（推荐）应或者百度。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122135457.png)

怕你不知道在哪里，点击这个如果是英文的话应该是preference然后选择搜索引擎更换为必应

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122135558.png)

同时顺便将浏览器语言改为中文，这个就自己改吧，有手就行。接下来我们顺便美化一下浏览器，点击左下角的扩展和主题搜索infinity插件，这种插件还有许多你可以自己搜索进行安装。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122135808.png)

然后选择安装这个插件，然后浏览器桌面壁纸就会变得非常的好看了。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122135849.png)

如果不喜欢可以自己更改壁纸，例如这是我美化以后的：

![](https://img.imgdb.cn/item/600a6a1e3ffa7d37b3061d32.jpg)

你可以选择点击右上角的无穷符号进行配置更改使得桌面效果达到你满意的样子。这个插件还有一个非常强的地方，你可以登录QQ，备份数据记录自己的桌面配置，这样以后在其他的安装了inifinity电脑浏览器上，你可以一键同步数据使得浏览器自动更新成你保存的样子。当然还有更多有意思的插件比如油猴、setupvpn、简悦等你可以自己选择下载。

#### 桌面壁纸更换

相比你很不喜欢这个丑陋的桌面壁纸，这里你可以使用刚刚配置好的浏览器进行图片搜索然后下载更换桌面壁纸。只需要在设置中的背景下更换即可。

#### 安装git指令依赖

打开终端输入

```
sudo apt install git
```

即可。

#### 共享粘贴板

你会发现虚拟机和主机之间的粘贴板是不共享的，这在cv时是非常难受的，所以我们接下来完成共享粘贴板很简单，打开VM设置界面。

![](https://img.imgdb.cn/item/600a6bdf3ffa7d37b30839e8.jpg)

将这两个改为双向即可完成共享粘贴板，如果你发现选择完这两个后仍然无法实现共享粘贴板，那么请参考这篇博客 [《共享粘贴版失效解决办法》](https://blog.csdn.net/qq_33215865/article/details/88916461)

#### 共享文件夹

实际上两个系统间的文件也不能共享，之前我们一直使用的方法是邮箱传递，但是这很不优雅，这里可以选择建立一个共享文件夹，网上的办法讲的都很繁复，实际上很简单。首先我们在主机win新建一个文件夹命名为ubuntushare，然后打开VM配置，在共享文件夹中挂载：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/JVB0QUGPOPEDE9Z]EPJ_H3V.png)

路径就是Ubuntushare的文件夹地址，然后名称他会默认使用ubuntushare即可，最后选择自动挂载，不用固定分配。这样配置完成后如果

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122151948.png)

共享文件夹中显示数量为1说明就挂载成功了我们进入虚拟机打开文件夹应该新增了一个栏目就是新增的共享文件夹。

![](https://img.imgdb.cn/item/600a6dfe3ffa7d37b309b1f5.png)

以后如果需要在主机和虚拟机之间传输文件就只需要将文件放到这个文件夹内即可了，这个文件夹中的文件一旦被删除那么两边的文件就都没有了。

然后我们在终端中输入指令df -h，可以查看磁盘的使用情况

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122142006.png)

我们可以看到sda6（可能你的是sda1,2或者5)等这个是磁盘的主文件空间，一定不能让他满了，我们可以看到这个分配的空间大约是我们给磁盘空间分配的50%,那么另外的50%是分配给了系统的，我们一般是无权访问修改的。所以这个就类似于C盘了，我们的文件就放到了这里，所以不能让他满了。如果要满了，可以选择扩容，这里我们介绍一下Gparted（我之前让下载的软件）

![](https://img.imgdb.cn/item/600a6f8a3ffa7d37b30add20.jpg)

这里显示了我们分配的两个分区的使用情况，一般不要进行更改，当需要对其进行扩容时需要用到这个软件，具体的扩容方法请参考这篇博客：[《ubuntu磁盘扩容》](https://blog.csdn.net/weixin_40976261/article/details/88641457)

至此我们已经完成了对于ubuntu虚拟机入门学习的基本功能配置了，虽然他还很丑，但是他已经可以使用了，可能你还需要对VSCODE进行语言环境的配置，这个请参考我的另一篇文章是对C/C++的环境配置：

### 🍎ubuntuMAC风美化

当然你可能想更加优雅的使用ubuntu完成对于苹果人上人的身份转换，那么接下来我们进行的都是一些无病呻吟对于虚拟机使用毫无改善只是更换样式的操作。首先我们需要下载一个软件，这个软件在ubuntu商场无法搜索到，需要打开终端使用命令行安装：

```linux
sudo apt-get install gnome-tweak-tool
```

安装成功以后你应该多了两个软件分别是优化（tweaks)和插件(extensions)。这里我们打开优化，可以看到外观中主题是yaru不好看，所以接下来我们更换成mac的主题。我们需要去这里（使用虚拟机的浏览器打开）：[GnomeLook官网](https://www.pling.com/p/1275087)

这里我直接给的是Mcmojave主题的，这个就挺好看的，省的你自己犯选择焦虑症，然后点击右边的download选择一个你喜欢的主题下载即可，我选择的是暗黑主题(Mcmojave-dark)

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122144459.png)

下载以后我们将其解压缩，这是个两级压缩我们分别输入

```linux
xz -d <filename>.tar.xz
tar xvf <filename>.tar
```

解压完成后是一个Mcmojave文件夹然后将其移动到~/themes文件夹下，这里我们发现是无权直接复制粘贴到那个指定文件夹的，这里使用高权限的方法，输入

```linux
sudo nautilus
```

然后选择复制这个Mcmojave文件夹，将其移动到其他位置/计算机/usr/share/themes中。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122145136.png)

然后我们打开优化(tweaks)将主题换成Mcmojave即可，然后神奇的地方就行，我们就会发现出现了标志性的三色标志。

接下来我们在将icon换成mac版本，这里用到的方法和上面的差不多，我们访问这个网站（还是使用虚拟机的浏览器打开）：[GnomeLookicon](https://www.gnome-look.org/p/1305429/)

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122145637.png)

还是选择下载一个我选择的是01-Mcmojave-circle，然后还是将其解压缩，这次移动到其他位置/计算机/usr/share/icons中，然后再次打开优化将图标改为相应的mac风，自此已经非常像MACl了，然后我们再将dock栏也改成mac风格。如果你是ubuntu18.04那么直接在ubuntu应用市场中的附加组件中选择dash-to-dock组件安装后应用即可。如果你使用的是和我一样的Ubuntu20.04以上，那么应用市场没有附加组件选项，我们选择另一种方法安装。打开虚拟机上的浏览器访问[GNOME插件](https://extensions.gnome.org/extension/307/dash-to-dock/)

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122150246.png)

然后应用这个插件我们浏览器的右上角就出现了小脚印的插件标志点击这个标志

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122150504.png)

搜索dash to dock安装这个插件然后返回桌面发现dock栏变成了mac风格。然后右键dock栏可以进行配置将其调到下方。此时就完成了dock栏的配置，如果有个人需求请自己再修改。然后我们再将桌面上的垃圾桶和个人目录隐藏，打开优化(tweaks)然后选择扩展，点击Desktop icons右边的小齿轮

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210122150820.png)

隐藏垃圾桶和个人文件夹即可。自此我们的虚拟机美化就完成了。

现在我们再回看一下虚拟机整体，空间足够，应用齐全（不要在虚拟机上安装QQ,WECHAT，很麻烦），并且优雅至极，你还有什么理由不爱上使用虚拟机学习呢？还不赶快使用虚拟机做几个实验感受一下优雅的学习氛围：[ubuntu上进行的实验学习](https://wenchong.space/tags/%E5%A4%A7%E4%BD%9C%E4%B8%9A/)。那么你一定很疑惑虚拟机还能干些什么吧？首先学习linux肯定是很好的，毕竟Ubuntu操作系统内核就是linux，其次任何具有破坏性的造作的项目学习都可以在这里学习，例如git本地仓库的学习，漏洞实验等等，如果不小心搞坏了，没有任何负担，删了虚拟机重新配置就是啦😋。

### 🍻结尾语

很开心你能够看完本篇博客，如果能够按照我的讲解成功配置好了虚拟机那更是我的荣幸。完成这次安装，相比你对虚拟机也有了一定的了解，最重要的是学会了直面困难，自己动手解决问题的能力！相信你以后还会用到本篇博客？快快收藏这个宝藏攻略ba~

