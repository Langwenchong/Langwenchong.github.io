---
title: git学习日志Part1
comments: false
top: false
date: 2021-01-24 12:57:21
tags: [git,版本回退,git安装]
categories: 教程
---

😃hello~本篇文章记录了翀翀学习[廖神git教程](https://www.liaoxuefeng.com/wiki/896043488029600)时的学习笔记，快来和我一起走进git世界吧！食用本篇博客的同时参照着廖雪峰大大的教程做一遍实验，保证你从此能够熟练使用git，成为一名顶级的CV工程师。

<!-- more -->

### git安装与注册

#### linux安装

我使用的是ubuntu(linux内核)，所以这里我首先给出linux的安装方法，输入以下指令（需要密码）：

```linux
sudo apt-get install git
```

如果是老一点的设备或者输入上条指令报错那么请尝试输入

```linux
sudo apt-get install git-core
```

#### win安装

去[git官网](https://git-scm.com/)下载安装文件然后全部默认安装即可。然后使用git-bash-here来运行，这个就可以完美替代win的cmd窗口了。

#### 本地账户注册

我们需要在本地的仓库中注册一个账户，这样以后的git log中就会以我们的名字和邮箱来记录历史事件了。我们需要在命令行中输入：

```git
git config --global user.name "Your Name"
git config --global user.email "You Email"
```

这里面的--global选项是全局设定参数，输入这个以后所有的本地仓库都默认使用这个账户了。输入完成后可以通过如下指令检查自己是否注册成功：

```git
git config user.name
git config user.email
```

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124130828.png)

这个是我的步骤仅供参考，当然这个不会有泄密风险，他只是一个自报家门的步骤方便用来记录的，后面真正的提交需要相对应的密码验证才可以提交。

### 版本库创建

#### 创建新文件

我们按照廖雪峰老师的教学步骤来进行，你可以参考我的过程截图来确认自己是否正在正确进行。我们先创建gitlearn然后输入git init初始化这个仓库，至此这个本地的库就建好了，实际上就是多了一个.git文件并且一般是隐藏的。我们在做[nemu](https://wenchong.space/tags/nemu/)时也知道.git文件中有一个叫做git log的功能可以实现记录我们的每一次改动从而做到版本回溯实际上就是在.git中实现的。现在我们检验一下.git文件是否存在。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124132504.png)

我们发现果然如廖大大所说，.git是隐藏文件，只有在ls加上-ah才能看到并且同时还有两个文件叫做.和..实际上我们大概也能理解这个是什么，他们是两个隐藏的特殊文件用来表示同级和父级文件的。

> 特别注意：git不能记录word的改动，且win下的文本文档也有相对应的缺陷，最好使用notepad++代替（实际上这个应用还有排版，高亮，替代查找等高效的功能，值得使用）

接下来我们就是要尝试进行几次修改和提交来查看git如何进行记录修改的。

我这里使用的是linux中的vim编辑器来创建txt文件，使用的是命令行创建，如果你和我一样那么可以尝试使用这种方法创建，修改文件，毕竟我们在实际工作中并不是总能使用带有GUI的编辑器，使用命令行也是一项本领值得学习。在Linux中vi "fileName"就是打开一个文件，这种使用的是linux自带的vim编辑器打开文件，如果没有这个文件，那么输入这个指令后就会创建一个以你输入的名称为文件名的临时文件，你可以在这里进行编辑。但是他默认的是只读模式（也叫指令模式，因为此时只能输入文件指令），只有点击Insert键才可以转换为插入（编辑）模式对这个文件进行编辑，当编辑完成后点击Esc就又回到了只读模式，如果你确实想要创建这个新文件，那么你就需要在只读模式下输入:wq，即保存并退出编辑，否则输入:q！即表示不保存强制退出。此时我们保存这个文件：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124133853.png)

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124133915.png)

此时我们输入ls指令检查learngit文件夹发现确实新建了一个readme.txt文件。此时我们还要将这个文件加入到learngit本地仓库中才可以被git追踪这个文件的修改历史。

#### 将文件加入到仓库

当我们没有把readme.txt加入到仓库中时，那么git还不能追踪这个文件即git log不会显示这个文件的修改历史，我们此时输入git log检查历史日志发现他会报错fetal:您的当前分支'master'尚无任何提交。

> master分支是一个仓库默认的分支，所有的提交历史默认在这个分支下进行更新

可能现在我们还无法理解master分支是什么，我们以后在学习，现在知道了当文件提交后才可以被git追踪历史修改，其历史会保存到git日志中。master就是默认的分支（当然，由于git新版本的更新，可能你那里显示的是main，但其实没有什么本质区别）。所以我们需要将readme.txt加入到仓库中去才可以被git追踪，上传到本地仓库指令很简单：

```git
git add <filename>
git commit -m "message"
```

git add 文件名是添加到本地仓库，git commit -m "信息"是在git日志中添加我们对于本次版本提交的一些小注释方便我们了解这次版本的修改特点，从而版本回溯时知道该回溯到何处。这里如果按照廖雪峰大大的教程我们要输入以下指令提交：

```git
git add readme.txt
git commit -m "wrote a readme file"
```

这样我们就完成了一次版本库的更新，就是将readme.txt加入到了gitlearn本地仓库中。此时我们在输入git log就可以看到版本库的更新信息了

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124135257.png)

我们发现git日志中增加了一项信息，其中Author就是我们之前注册的信息，下方记录着提交时间以及这次版本库更新的小提示，这样我们就知道了这次提交都有哪些修改信息了。其中git commit时有显示1 file changed,2 insertions表示的是一个文件修改（就是我们新建的readme.txt），后面的2 insertions就是插入了两个语句。

##### 思考：那么当我们需要一次性提交上百甚至上千个文件时怎么办？

你肯定会有这种疑虑：当我们上传成百上千的文件时怎么办，难道git add 一百次？其实不用，此时我们使用以下指令即可一次性进行加入：

```git
git add .
```

##### 思考：此时就可以在github上查看到我这次提交的文件了吗？

千万不要以为这个上传是上传到github上，他仅仅是将文件上传到了本地仓库并且日志记录了本次本地仓库中的变化，还没有上传到github上。

### 文件修改对比

此时我们在本地仓库中添加了一个文件readme.txt，那么以后git将会追踪他的变化。此时我们修改readme.txt文件，然后输入指令

```
git status
```

得到的结果如图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124142543.png)

他会和上一次的提交进行对比并告诉我们两者之间的区别，这样我们就可以了解当前的仓库状态了。上面说到readme.txt被修改了但是还没有保存提交，所以此时我们使用git log查看时并没有记录这次修改。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124142758.png)

但是我们发现此时只是知道了某个文件被修改了，却不知道具体的修改之处，此时我们可以输入git diff查看文件具体哪里出现了修改。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124142916.png)

红色代表删除，绿色代表添加，我们发现Git is aversion control system.被删除替换为了新添加的Git is a distributed version control system.了。并且下方之前的空行我们删除后他也能够追踪。所以git diff（实际上就是difference的简写）就可以对比本次待提交的文件版本和上一次已经提交的文件版本之间的变化。这样我们确认修改无误后就可以将第二次的版本也提交了。步骤同上，你可以尝试：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124143340.png)

我们发现在git add添加以后输入git diff会对比告诉我们要添加到本地仓库的修改文件时readme.txt然后同样输入提示信息后再次输入git status我们可以看出此时readme.txt确实被提交了，此时和版本库中的readme.txt就一样了（请忽视下方的.radme.txt.swo）。此时提交为空，说明被修改过的文件都已经上传到了本地仓库了。此时我们再次输入git lig进行查看：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124143641.png)

我们可以看到新的提交已经上传，并且注释为add distributed，且最新的一次版本提交总是位于log中的最上方。

#### 思考：git status和git diff的区别？

git status指令是告诉我们那些文件被修改了需要等待提交，git diff是告诉我们被修改过的待提交的文件（未add之前的文件）和上一次版本的文件对比哪些具体内容被修改了。下面的廖大大的工作区和暂存区一章就不讲了，因为我们是以能够使用为目的的，会用就行了，那一章理论只是探讨实用性不强就不细学了。

### 版本回退

我们此时再次修改文件readme.txt的内容并且再次上传。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124144357.png)

此时readme.txt内容如下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124144428.png)

而之前的几个版本的内容如下：

```c
//版本1：wrote a readme file
Git is a version control system.
Git is free software.
//版本2：add distributed
Git is a distributed version control system.
Git is free software.
//版本3：append GPL
Git is a distributed version control system.
Git is free software distributed under the GPL.
```

那么现在我们可能想回到之前的版本2，如果按照原先的修改，我们需要手动修改至版本2，但是当内容太多时，手动修改肯定不现实。此时我们就可以使用git版本回退的功能，这离不开git log的记录。我们再次打开git log

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124144811.png)

现在我们具体讨论一下git log的各种信息的用处。首先注释不用说能够提示我们各个版本的修改特点，Author是谁修改的，而注意HEAD->master，HEAD指的是当前版本所在的分支为master且是版本3，而现在我们想要回退到版本2，那么就需要commit后面的一长串数字了，他是是每一次提交版本特有的数字串用来区分各个版本的，而我们回退就需要使用这个数字串。

这里有两种方法回退，首先就是HEAD表示当前版本，HEAD\^表示的是上一个版本，HEAD^\^就是上上个版本，在后面可以使用HEAD\^3,HEAD^100等表示回退，例如现在我们要从版本3回退到版本2，可以使用如下指令：

```c
git reset --hard HEAD^
//或者如下(请以自己的commit为准)
git reset  --hard commitID
```

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124145540.png)

此时我们确实回退到了版本2，commit回到了e9ec3的版本2，如果你不信可以查看一下readme.txt文件的内容。

但是我们需要注意此时的回退真的是回退到了版本2的地方，连同git log也回到了版本2，所以此时git log中就只有版本2之前的内容了，就好像从来没有出现过版本3一样。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124145736.png)

这样子可是不太妙，如果此时我们后悔了，想在回到版本3，但是Head^只能表示以前的，而版本3的commit又不见了。此时如果你没有关闭中断或者切换中断，你可以选择往上找找到之前的版本3的commit从而实现回退至版本3，但是你总是会关闭中断的，那么此时就不能获得版本3的commit了。例如此时关闭这个中断重新打开，发现任何有关版本3的信息都没有了，此时我们需要获得版本3的commit就需要输入

```
git reflog
```

来获得git中每一条指令的信息，从而间接获得版本3的commit

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124150351.png)

我们可以看到reflog中有指出版本3的信息，可以根据后面的commit提示知道版本3的commit ID是d915b22（请以自己的ID为准），所以此时我们就可以回退之版本3了。此时在打开git log就回到了版本3时的git log了，所以此时git log中应为:

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124150706.png)

那么本次我们就完成了版本3->版本2->版本3的穿越过程了。

#### 思考：为什么版本回退会如此之快？

实际上git中的HEAD就是一个指针，每一次的版本提交都会存储，我们的版本回退只是切换指针而已，所以切换速度很快。

### 删除本地仓库中的文件

我们知道git add是将文件加入到本地仓库，这样git就可以追踪他了，但是假设你现在删除了这个文件，那么git会察觉到你删除了某个文件而这个文件现在在被追踪，那么你就需要告诉他将版本库中的这个文件删除，即使用

```c
git rm fileName
git commit -m "message"
```

假设现在我们删除了raedme.txt。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124152436.png)

那么我们发现此时git察觉到了删除操作并且git staus也告诉了我们删除了readme.txt，现在我们想要将这个文件也在本地仓库中删除从此git不在追踪他认为其从来没有存在过。我们输入

```c
git rm raedme.txt
//当然实际上此时使用 git add readme.txt和rm是一个效果，所以都使用add也可以
git commit -m "remove readme.txt"
```

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124152722.png)

当然此时git也会把这次提交看成一个版本库，所以在git log中也会记录这次修改：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124152809.png)

提示：当git log太长无法一页显示时，按↑和↓可以查看更多信息，并且按q退出日志。因为他也会将这次删除看成一次版本所以，我们也可以使用版本回退恢复这个被删除的文件，即

```
git reset --hard HEAD^
```

我们就又回到了版本3：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124153040.png)

当然我们此时的git log中就没有版本4删除文件的提交信息了，就好像版本4不存在过一样：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210124153201.png)

我们发现一旦在本地仓库中删除了这个文件，那么想要恢复这个文件就只能使用版本回退恢复了。还有一种情况是，你不小心将git追踪的文件删除了，但是本地仓库中还没有删除这个文件，那么就可以使用

```
git checkout -- fileName
```

来恢复文件，但是实际上我们也可以使用回收站恢复来复原这个误删的文件。

### git指令速览

|                       指令名称                        |                           指令功能                           |
| :---------------------------------------------------: | :----------------------------------------------------------: |
|           git add  fileName<br />git add .            |     将修改过的待提交的文件加入到版本库（实际上是暂存区）     |
|                git commit -m "message"                | 将暂存区的文件提交至版本库（此时gitlog中会增加一个commit历史）并且添加提交提示 |
| git reset --hard HEAD^<br />git reset --hard commitID |                   版本回退至特定的commit处                   |
|                        git log                        |                         查看git日志                          |
|                      git reflog                       |                      查看git每一条指令                       |

### 结尾语

一定要记住我所讲的是最简单的git操作指令，许多复杂情况并未讨论，但是也足以应用git实现我们日常的需求了，在这里我们要记住add和commit永远要一起连接着输入（实际上并不用，但是为了避免复杂的bug产生，我们这里add后必须commit）。重点是掌握版本回退就足矣。那么希望你能有所收获😉~