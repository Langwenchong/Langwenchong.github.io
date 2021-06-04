---
title: git学习日志Part3
comments: false
top: false
date: 2021-01-26 12:23:11
tags: [git,分支,分支冲突]
categories: 教程
---

😃hello~本篇文章记录了翀翀学习[廖神git教程](https://www.liaoxuefeng.com/wiki/896043488029600)时的学习笔记，快来和我一起走进git世界吧！食用本篇博客的同时参照着廖雪峰大大的教程做一遍实验，保证你从此能够熟练使用git，成为一名顶级的CV工程师。

<!-- more -->

### 分支管理

我们先来了解一下分支，其实可以看成许多个平行宇宙，每一个分支就是一个时间线，可以存储不同进度，不同版本的文件。如果你做过我博客中分享的nemu实验，那么你会发现在我的这个[NEMU2020仓库](https://github.com/Langwenchong/NEMU2020)存有4个分支，分别是master,pa1,pa2,pa3，他们分别存储着不同阶段的代码。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126122908.png)

这就是分支分作用，他可以存储不同版本的完整代码，亦或者是和别人协作开发时为了不影响总体进度，将自己的代码上传到某一分支上最后在合并从而实现高效开发。而Mseter或者是最新版的Main就是默认分支，如果想要切换到其他分支上需要我们自己创建并管理分支，而git完美实现了这一点。

### 创建、合并分支

我们知道当我们未创建其他分支时，那么所有版本都会在master分支上，每一次更新都会在master分支上增加一个节点（对应着gitlog多一项记录），所以随着版本的不断更新，master分支会越来越长，并且又因为HEAD指针一直指向的是最新版本，所以默认的情况如下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126125337.png)

也就是说HEAD指针永远指向分支的最新节点，而现在我们可以创建一个新的分支并且将HEAD切换到新分支dev上，如下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126125838.png)

我们完成这个操作只需输入以下指令

```c
git branch //我们先查看一下现在本地仓库中的分支
```

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126125958.png)

现在只有一个分支main并且HEAD指针现在就指向了main(带*代表当前分支)，现在我们创建一个新分支dev并且切换到新分支上

```c
git branch dev //创建新分支dev
git checkout dev // 切换到新分支dev上
```

或者你也可以输入以下指令一键执行两个操作

```c
git checkout -b dev //创建新分支dev并切换
```

此时我们在输入git branch查看分支情况就会发现成功切换到了dev,此时HEAD就是指向了dev分支的最新版本，但其实看上图我们就知道HEAD还是指向的版本3。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126130652.png)

#### 思考：为什么分支切换如此之快？

我们发现创建分支不过是创建了一个新指针dev指向版本3，切换就是将HEAD指向dev而已，学过c我们都知道指针切换是非常迅速的，所以git可以快速创建和切换分支。

现在我们在dev分支上进行版本更新，更新到版本4（比如在txt中加上一句话：Chong is Handsome)。然后我们提交到本地仓库的dev分支，代码如下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126132649.png)

那么此时我们就来到了下图的情况：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126132806.png)

此时我们发现只有dev更新了，也就是说在master分支上最新版本是版本3，而dev分支上最新版本是版本3并且此时HEAD指向的是dev分支，所以现在HEAD指向的也是版本4。我们验证一下发现此时HEAD指向的版本4的readme.txt内容如下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126133033.png)

然后我们切回到master分支，那么在查看此时HEAD指向的master最新版本3的readme.txt发现确实没有新加的那句话：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126133311.png)

那么现在我们尝试合并两个分支，即将dev的版本4加到master上，即变成下图的情况：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126133556.png)

实际上就是将master指针指向了版本4，接下来我们实际操作以下，就是输入以下指令

```
git merge dev //将dev合并到当前分支master
```

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126133807.png)

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126134007.png)

我们可以看到在没有合并之前master分支的gitlog中只记录了版本3的信息，而当合并了dev以后，master分支的gitlog中增加了一条新信息为版本4的提交信息说明master现在也有了版本4即形成了上图的情况，因此此时master分支下的readme.txt应该也是有新加的那句话：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126134054.png)

那么现在dev和master实际上就没有区别了，完全相同了。所以我们现在就可以删除dev分支了，所以输入以下指令删除dev分支：

```c
git branch -d dev // 删除dev分支
```

那么此时我们就又只有一个默认分支master了并且HEAD指向了新的版本4。

#### 思考：为什么合并时是Fast-forward?

我们注意到合并分支时显示为Faster-forward,实际上就是快速切换的意思，我们可以大概了解到这种指针指向改变的何兵就是Faster-forward的情况，那么也就是说还有其他情况的分支合并，我们后面再学习，现在只需了这些指令的使用就可以了。一定要注意git merge branch是将branch合并到当前的分支上，并且不是只添加最新版本，而是将所有的历时版本都合并到当前分支。即：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126134859.png)

如果此时dev更新了版本4和版本5，那么合并后master也将拥有版本4和版本5两个版本的历史版本。即merge时当前的分子master会把对方相对于自己超前的版本节点继承。

#### 补充：切换分支的新指令

我们知道checkout是检查的意思，貌似和切换分支的意思没有关系，那怎么能担当切换分支的作用呢？为了更加形象也为了避免指令歧义，我们现在最好用更新的指令来实现切换分支，如下：

```c
git branch dev // 创建dev分支
git switch dev //切换到新分支dev
```

或者一键创建并切换到新分支dev

```c
git switch -c dev //创建并切换到到新分支dev
```

#### 总结

|                           指令名称                           |                  指令功能                  |
| :----------------------------------------------------------: | :----------------------------------------: |
|                          git branch                          |                查看现有分支                |
|                   git branch [branchname]                    |                  新建分支                  |
|    git switch [branchname]<br />git checkout [branchname]    |                切换到新分支                |
| git switch -c [branchname]<br />git checkout -b [branchname] |           一键新建并切换到新分支           |
|                    git merge [branchname]                    | 将[branchname]分支合并到当前HEAD指向的分支 |
|                  git branch -d [branchname]                  |                  删除分支                  |

### 解决分支冲突

我们发现之前的合并是master在版本3停住了，然后dev往后更新了一个版本4，所以dev超前了master分支一个版本，所以合并时master就直接继承了dev的新版本4。但是现在考虑另一种情况master此时如果也有自己的版本4时那么合并时会不会出现问题呢？实际上也不一定必定出现冲突，我们先看一种比较好的情况。

假设此时有一个文件里面写了a，并且此时有两个分支都在这个节点且此时HEAD是在feature分支上如下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126152117.png)

那么此时如果feature往后更新了一个版本为ab，同时master也自己更新了一个版本bc如下图：

<img src="https://gitee.com/Langwenchong/figure-bed/raw/master/20210126152645.png" style="zoom: 80%;" />

那么我们此时要进行合并是把feature合并到master上即同级别合并，我们思考此时会不会出现合并冲突，实际上并不会，因为master分支时在a的前面一行插入了c,而feature分支时在a的后面一行插入了b，此时合并不会出现冲突，而是出现下图的情况：

<img src="https://gitee.com/Langwenchong/figure-bed/raw/master/20210126153057.png"  />

即此时master会增加一个新版本他是来自于自己之前的版本和feature版本的合并体，新的文本会有三行，就是在master的第二个版本的基础上的末尾添加了来自于feature版本的b。这种就是非常良好的合并情况，即没有冲突的地方。你一会感到疑惑为什么此时不会出现冲突，我们以一个形象的例子来比喻，这就好像两个学生用时写一篇作文，小明改开头c，小红改结尾b，作文中间部分a不做修改，那么合并时就没有冲突只需加上小明的开头c和小红的结尾b。并且一定要注意此时feature是不会影响的，绿色线只是表示为...做了贡献的意思。也就是说此时feature自己还是处于版本2没有发生变化可以自己继续进行发展而master分支此时位于版本3也可以继续自己发展。但是如果两个人都同时修改一个地方就不行了。比如下面这种情况就会出现冲突：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126163042.png)

即此时feature是将a这一行改为了ab,而master将a这一行改成了ca，此时就会出现冲突了，此时就相当于两个人同时对文章的主体内容部分进行了修改，我们来实际操作一下这种情况，首先先做到为合并之前的情况，完成这个情况后我们输入下面这个指令以图的形式来展示以下此时的情况是否和上面相一致：

```git
git log --graph --pretty=oneline --abbrev-commit
```

我们先查看master分支：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126155109.png)

此时master确实是两个版本，a->ca，然后我们看一下feature分支：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126155147.png)

此时feature确实是两个版本，a->ab,然后我们尝试将feature合并到master：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126155307.png)

此时我们发现出现冲突了，我们查看一下readme.txt文件信息：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126161626.png)

我们发现git已经用箭头指出来出现冲突的内容的部分了，所以接下来我们需要将有冲突的地方进行重新手动更正合并。其中<<<<到=\==是HEAD中冲突部分的内容，===到>>>>部分是feature部分的内容。我们删除这些内容将冲突的内容重新更正为hhh再次提交，那么此时就处于了下图的情况。我们可以观察到此时master分支单独出现了一个新版本为hhh，并且此时feature分支还是处于版本2可以继续独立发展，master也是。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126154147.png)

这就是解决冲突的办法。此时在输入以图的形式查看

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126165104.png)

我们发现此时的图和我们上面的图是一样的。

#### 思考：此时如果是二进制或者其他不能直接打开修改合并的冲突文件怎么办？

实际上只有对于txt,md,cpp等可以直接编辑的冲突文件允许手动更正，而对于更多的exe,二进制等冲突文件一般是二选一选择一个版本来替换。

#### 思考：合并到底是如何合并的？

我们这里具体讨论一下合并的具体情况以及合并冲突的由来问题。我们对比两种情况可以总结出合并具有以下特点：

1. 合并时将目标分支的版本合并到当前版本
2. 目标分支自身不会受到任何影响
3. 合并的版本是领先于当前分支的所有版本

我们具体来分析一种很极端的情况，加入在上图合并后的基础上，feature有经过了三次版本的迭代，到达了如下图的情况：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126170406.png)

那么此时如果要将feature合并到master分支，那么合并后的情况会如下图所示：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210126170509.png)

即此时master分支上会增加两个版本分别是feature的版本4和版本5因为他们两个都是领先于master分支的。我们发现此时虽然feature版本4和master的版本3有冲突，但是也没有关系，因为冲突永远是在两个最新版本之间产生的，而版本4此时只是一个历史版本，所以不会有冲突，只要feature合并时的最新版本5和master版本3不冲突即可正常合并。因此此时我们查看master的版本会发现他有5个版本，分别是a,ca,hhh,hhhaaa,hhhh换行abcd。这就是分支合并与冲突解决的相关知识点。

### 分支管理策略

我们之前学习了Fast forwad模式的分支合并，实际上在开发中已经能够完成绝大多数的任务需求了，但是我们现在假设一种实际多人开发一个项目的环境下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210127155416.png)

一般master分支主分支上是存储某个项目的迭代稳定版本，所有人是不允许在这个分支上进行开发的。而dev分支一般是所有开发人员开发时定期合并组成的不稳定的迭代版本。底下的两个代表的是不同的开发人员对于这个项目的不同板块进行开发都各自拥有一个自己的分支。在一段开发时间后，完成了一定的功能开发后，工作人员会将所有分支合并到dev分支形成一个不稳定的待检测的版本，如果有bug会在进行相应的修复，然后稳定后无bug后合并到master分支上形成一个稳定版本。所以我们在每次合并时尤其是dev分支的合并时，我们希望可以记录每一次合并分支的信息，知道这次dev上的版本合并了那些开发人员的分支，这样我们就可以看出不同的项目功能版本的贡献者了。但是很明显Faster forward模式下的合并是不会存储合并分支信息的。所以我们学习一种新的模式开发，实际上就是禁用Fast forward模式的分支合并，这样每次合并都会在Fastforward的基础上在向后移动一个节点产生一个commit来记录我们的合并分支信息如下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210127160447.png)

可千万别和分支合并时解决冲突的图混淆了，看上图合并以后master分支的指针并未指向dev分支的最新版本，而是又往后走了一个节点，产生了一个新的节点形成一个新commit,所以我们需要加上一个分支合并的信息。

指令如下：

```
git merge --no-ff -m "message" [branchname]
```

实际上就是在git merge [branchname]之间加上了一个参数 -m "messsage"来填写分支合并的的信息。观察上面那个多人合作开发的图，很明显当都合并到dev分支上时也是采用的禁用Fast forward模式的分支合并。

### 结尾语

那么本次学习就先到这里了，我们要重点理解和掌握创建、切换分支（尤其是Fast forward模式）和分支合并以及解决合并冲突的方法😃。



