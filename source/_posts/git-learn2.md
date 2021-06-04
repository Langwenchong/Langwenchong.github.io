---
title: git学习日志Part2
comments: false
top: false
date: 2021-01-25 12:09:22
tags: [git,SSH Key,远程仓库]
categories: 教程
---

😃hello~本篇文章记录了翀翀学习[廖神git教程](https://www.liaoxuefeng.com/wiki/896043488029600)时的学习笔记，快来和我一起走进git世界吧！食用本篇博客的同时参照着廖雪峰大大的教程做一遍实验，保证你从此能够熟练使用git，成为一名顶级的CV工程师。

<!-- more -->

### 什么是远程仓库

实际上我们之前所做的工作都是在本地进行的，即只有这台计算机可以看到进行版本库的修改等。然而实际生活中我们经常需要将这个仓库上传到云端，这样我们可以随时在不同的电脑上进行“克隆”获得之前版本的库文件，在这个版本的基础上继续进行工作，或者从本地提交新的版本至远程的仓库来更新版本，这就是github的最大魅力。那么接下来我们就来学习使用github。

首先我们需要github账号，注册一个即可。然后我们需要进行以下几个步骤

#### 检查是否有SSH Key

首先在任意地方打开git终端，输入以下指令检查是否已为此电脑配置了ssh key：

```git
ssh -T git@github.com
```

如果已经配置过sshkey了，那么应该会出现下图的提示：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125130324.png)

那么就说明这个电脑可以通过ssh key免密登录上传本地仓库到远端，否则每次提交都需要输入账号和密码。

#### 创建SSH key

如果很不幸你没有设置ssh key，其实也没啥，如果你觉得每次上传输入一次账号和密码也是可以得，那你可以选择不设置SSH Key，但是如果你想上传本地仓库到远端github时不用输入密码，那么就需要配置SSH key,并且你是用的每一个设备都需要配置一个SSH Key（包括你的虚拟机），这样gitHub就可以通过ssh秘钥知道这台设备是你允许免密登录的设备。以后在上传时你就可以免密上传啦！

> 所以sshkey的作用一句话概括就是可以让你这台计算机免密上传本地仓库到远端，实际上他是通过rsa密钥对实现了你设置过SSH key的计算机和远端加密传输。

创建ssh key实际上很简单，首先我们需要打开git终端，然后输入以下指令：

```
 ssh-keygen -t rsa -C "youremail@example.com"
```

上面的邮箱请输入自己的邮箱，然后一路回车就行了。然后我们就可以到用户目录下找到.ssh目录了（不同的系统路径是不同的，这里我给出win的路径：C:\用户\user(应该是你的设备名字）\.ssh。其它系统的请自己努力查找，大致路径是相同的）。然后这个.ssh路径下应该有三个文件，其中id_rsa就是sshkey的私钥，不能告知他人的，而id_rsa.pub是公钥，可以告诉别人。我们现在要将公钥加入到github上，这样远端就可以通过sshkey公钥找到你的这台设备来验证私钥，如果你的这台计算机可以提供正确的私钥，那么就可以免密登陆了。

所以接下来我们登陆github，打开settings中的ssh栏，如图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125131704.png)

新建ssh Key:

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125131755.png)

然后我们就可以看到新建sshKey的输入框了，这里我们先介绍一下都是什么意思：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125131816.png)

我们想，那么一个git账户ssh key肯定不只是有一个，比如你同事有mac,win两台电脑外加一个ubuntu虚拟机，那么现在这三个设备都要免密登录就需要都设置一个sshkey所以你的这个账号下肯定会有许多个sshKey(当然如果你就是穷，只有一个计算机，那当我没说😝)，但是总的来说每台设备都只对应唯一的一个sshkey，所以title就是用来区分每一个秘钥对应的是你的那台设备，你可千万不要命名为sshkey1,sshkey2...。这样以后你也不好区分这个sshkey对应的是那台电脑，我推荐你将title处填写你的设备名，比如我的是win10联想电脑，那么我就命名为Chong's Win laptop,相对应的mac就是Chong's Mac laptop等等。这样我们就可以区分出sshkey对应的设备了，然后我们将刚刚.ssh文件夹下的id_rsa.pub（一定要注意是公钥)复制到下方key处。然后点击add就完成了一个sshkey的添加，从此你的这台设备可以免密登录上传了。此时你在打开终端输入

```git
ssh -T git@github.com
```

应该就会出现成功的那句话了，见上面检查sshkey截图。

##### 思考：为什么我的SSHkey是灰色的？

你会发现你刚刚创建的SSHKey应该和下图的灰色要是一样，写着NeverUsed，这正常，因为你现在只是创建成功了，还未使用过。当使用过这个SSHKey免密登录后就会变成绿色的并且显示上一次使用的时间。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/屏幕截图 2021-01-25 140933.png)

所以如果你创建完成后一定要使用免密登录的方法，否则你创建SSHkey又是为了什么？当然如果你用了很长时间的git后发现某个🔑一直是灰色的或者很久没用了，请仔细想一想是不是你更换了那个设备导致这个SSHkey不会再用到了，那么就可以删除这个🔑了。

### 添加远程仓库

那么我们现在配置完了sshkey了，接下来我们尝试将之前的learngit仓库推送到github上。首先我们需要在github上创建一个远程仓库：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125132810.png)

然后我们就会进入到新建仓库编辑处如下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125132931.png)

这里名字就命名为本地仓库相同的即可，然后选择public即公开仓库，这样别人就可以看到我们的这个仓库，也就可以查看并克隆我们的仓库（所以不要存储敏感信息，比如银行卡密码等），如果是隐私信息请设置为private，然后下方的discription是仓库介绍，一般写2~3句话简单介绍一下即可，以后他会显示在这个地方：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125133220.png)

然后同时我们勾选Add a Readme file，他是进入这个仓库后的详细信息，以后这个readme.md中的内容会显示在仓库下方，你可以写一些介绍文档，版本迭代信息，致谢等等，他最后会显示在这个地方：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125133433.png)

并且以后我们可以通过点击绿色劝处的钢笔直接在github上对这个readme.md进行编辑。例如现在我们创建完learngit后（create respository后),他会默认在reame.md中填写的是我们之前的discription,现在我们修改这个readme:

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125133713.png)

编辑完成后我们看下方：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125133814.png)

这里会有一个commit表，就是类似于git commit，可以写一些这次修改的注释。这里我们然后点击commit changes。我们会发现learngit下的介绍信息被修改了：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125134006.png)

多了一句刚刚我们添加的话，并且上面的红圈处注释了我们commit时修改的注释信息。此时首页的仓库介绍就只有“翀翀学习git的仓库😎”这句话，而仓库具体的介绍即readme的信息就有我们新添加的话。所以我们以后关于仓库的具体介绍信息都可以写到readme文件中。

但是现在我们github上的仓库还是空的，没有和我们本地的learngit仓库关联，所以也就还没有readme.txt文件呢，接下来我们将本地方库提交至github上的远程仓库。这里有两种方法：①将本地仓库与远程仓库关联②克隆这个远程仓库然后本地文件转移

两种方法无好坏都可以，这里我们先教第一种：

#### 方法一：将本地仓库与远程仓库关联

首先我们需要在github上将仓库地址获取，这里点击仓库的绿色code按钮，我们可以看到有5中方法：

1. HTTPS格式的远程仓库地址
2. SSH格式的远程仓库地址
3. Github Cli格式的远程仓库地址
4. 在GitHub Desktop打开（需要额外下载github桌面软件）
5. 以压缩包方式下载

前三种方法比较常见，都是获取地址关联，其中HTTPS格式和SSH格式是我们今后会常用的方法，我们需要分辨以下这两者的区别：

##### 思考:HTTPS和SSH的仓库地址区别？

我们知道HTTPS协议一般安全性很强，所以按照理解，凡事使用https的地址关联的仓库，那么无论你这个设备是否注册过sshkey，push时是都需要输入密码的。而SSH地址就是利用SSH验证私钥，如果你的电脑有SSHkey私钥且验证正确，那么推送时就可以免密啦，当然如果私钥验证不正确那么你是无权免密推送，会报错你无权push。一定要注意ssh只是能够允许你将仓库推送到自己的远程仓库时免密的，否则你是无权将本地仓库推送到别人的远程仓库的。

那么我们之前刚刚设置完SSH，所以尝试使用SSH来免密推送我们的本地仓库到远程仓库github/learngit.git。首先我们复制SSH地址：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125135526.png)

注意SSH地址一定是git@github.com开头的，后面的是你的账号名称/仓库名称.git。并且点击右边的小面板按钮就会复制这个地址，然后我们在本地仓库中打开git终端，即在learngit文件夹中右键鼠标选择git-bash-here(这个是win的方法)：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125135925.png)

如果是linux的，那么就需要cd 这个文件夹，总之最后你打开的终端最末尾处的应该写的是你的仓库名称learngit，然后我们关联这个仓库输入以下指令：

```
git remote add origin git@github.com:Langwenchong/learngit.git
```

一定要注意后面的地址应该是你自己的地址，即Langwenchong处应该是你自己的账号名称，否则你就会推送到我的远程仓库，当然了你是无权推送到我的远程仓库的（因为密码验证无法通过，最终会报错）。

然后关联完成后，我们就可以push将本地仓库的文件推送到远程仓库了：

```c
git push -u origin master //注意如果你是新版本的话可能是main
```

一定要注意请查看github上的默认分枝是master还是main,一般最新版本都是main了，那么代码应该是：

```
git push -u origin main
```

如果顺利的话，你应该不用输入密码就可以直接上传成功了，最后如下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125141139.png)

现在我们查看一下github上的learngit仓库，应该发生了变化增加了readme.txt文件：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125142057.png)

如果你上传成功后发现github上没有变化，请查看是否上传到了master分支上：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125142200.png)

所以我们知道了git push origin "branch"是将本地仓库的最新版本关联到远程仓库的branch分支上，如果你选择的是master，那么就关联到了master分支上，如果是main,那么就关联到了main分支上。

这里我们只有第一次关联时使用这个指令：

```
git remote add origin git@github.com:Langwenchong/learngit.git
git push -u origin master
```

上面的第一句指令是关联仓库，一个远程仓库只能和一个本地仓库关联，而第二句就是将最新的版本上传到github上的哪一个分支上，其中-u参数是不仅把本地master分枝内容推送到远程仓库的目标分支master上，同时还会把本地的master分支和远程的master分支关联起来，在以后的推送或者拉取时就可以简化命令了。

即以后我们在push或者pull时不用加上-u直接

```
git push origin master
git pull origin master
```

就可以完成将本地仓库的最新分支版本上传远端或者从远端获取某个分支的版本了。

##### 注意：第一次使用sshkey进行clone或者push时的报错

当我们刚刚弄完sshkey还从未使用过，这次是第一次使用时那么可能会出现如下询问：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125143031.png)

这个是正常的，他需要你确认GitHub的Key的指纹信息是否真的来自GitHub的服务器，输入yes后回车即可。自此我们就学会了将本地仓库关联到远程仓库并且上传文件了。这种方法比较好，建议牢记，当然你也可以学习方法二：

#### 方法二：克隆这个远程仓库然后本地文件转移

这里我们的方法优点不同，但最终的效果是一样的。其实只是思路相反了，这里我们是先将远程仓库克隆下来为本地仓库，这样他就自动完成了两个仓库的关联，然后我们将readme.txt文件移动到这个新的本地仓库在提交，然后以后我们就在这个新的本地仓库进行文件的修改了。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125143753.png)

我们还是先复制SSH地址这样可以免密上传，但是接下来我们是在桌面上打开终端克隆这个仓库从而创建一个与远程仓库已经关联了的本地仓库。所以我先克隆这个远程仓库到本地

```
git clone git@github.com:Langwenchong/learngit.git
```

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125144014.png)

然后我们就可以发现主目录下多了一个本地文件夹仓库就是learngit，我们在这里创建readme.txt文件。然后编辑完成这个readme.txt一定要注意接下来的步骤有略微差异：

我们思考现在这个本地仓库中新建了一个readme.txt文件，但是还未加入到本地仓库中，所以需要先

```
git add .
git commit -m "create a readme.txt"
```

然后我们在上传

```
git push -u origin main 
```

这样也完成了免密本地上传

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125144250.png)

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125144513.png)

#### 思考：两种上传方式的区别？

我想你现在肯定是看的云里雾里了，确实这里不太好理解尤其对于github小白来说，你现在可以思考这些，随便学一种方法会用即可，反正最终学习的目的就是实用。当然如果你要想弄清楚两种方法需要熟练实用上传的方法再次反复温习就可以很容易辨析两种方法的区别了，这里我总结了以下两种方法的区别：

##### 角度一：指令输入方面

方法一的提交步骤

|             指令              |                             功能                             |
| :---------------------------: | :----------------------------------------------------------: |
| git remote add origin仓库地址 |                  将本地的仓库与远程仓库关联                  |
|    git push -u origin main    | 将这个本地分支提交到远程仓库的main(git commit信息就是git log中最新的注释信息)分支并完成关联 |

方法二的提交步骤

|           指令           |                             功能                             |
| :----------------------: | :----------------------------------------------------------: |
|    git clone 仓库地址    | 将远程仓库克隆到本地即自动生成了一个与远程仓库关联(包括分支)的本地仓库 |
|        git add .         |                   将文件提交到新的本地仓库                   |
| git commit -m "message"  |                          提交的注释                          |
| git push (-u) oigin main |                  -u加不加都行，远程提交完成                  |

##### 角度二：关联方式

方法一是将本地仓库关联到远程仓库从而实现了文件上传，所以需要将本地的分支和远程仓库的分支关联，同时上传的是最新的版本和注释信息，但是之前的版本即gitlog也会上传到远程仓库，所以一次提交后远程仓库的分支可能就已经存储了许多版本了。而方法二是先将新建的远程仓库克隆到本地从而实现创建了一个已经和远程仓库分支关联的新的空本地仓库，修改文件add和commit后加入到本地仓库在上传提交，即第一次提交就是只提交一次版本节点。两种方法都可以在SSHKey的帮助下免密提交。

### 克隆远程仓库

实际上方法二就是在克隆仓库的基础上完成的，即克隆就是获得一个仓库的地址，然后

```
git clone 仓库地址
```

就可以将自己（当然别人的远程仓库也可以）克隆到自己的本地设备上。当然如果是克隆的别人的远程仓库的文件，那么你修改后是不能将修改文件提交到别人的远程仓库的，只能上传到自己的远程仓库。那么这个仓库就会显示为你在别人的仓库基础上修改后上传到了自己的远程仓库即你们两个都是这个仓库的贡献者，这也就就是我们常在github上看到的多人贡献过的仓库，如下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210125150628.png)

### 结尾语

那么本次我们就学习到这里，我们要重点掌握SSHkey的创建和两种方式的提交（尤其是免密）的方法。希望你能有所收获😁~