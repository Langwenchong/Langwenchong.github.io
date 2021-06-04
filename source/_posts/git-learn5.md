---
title: git学习日志Part5
comments: false
top: false
date: 2021-01-29 14:23:46
tags: [git,pullrequest,标签]
categories: 教程
---

😃hello~本篇文章记录了翀翀学习[廖神git教程](https://www.liaoxuefeng.com/wiki/896043488029600)时的学习笔记，快来和我一起走进git世界吧！食用本篇博客的同时参照着廖雪峰大大的教程做一遍实验，保证你从此能够熟练使用git，成为一名顶级的CV工程师。

<!-- more -->

### 标签管理

git还引入了标签的概念，实际上就是对于一个对应着commit ID的版本提交一个简便的称号，这样我们就可以轻松的和他人交流某一个特殊的提交节点了。例如我们将commit ID为6a5819e...打上标签为版本v1.2。这样我们在和别人交流这个提交节点时就不用了说commitID了，而是标签v1.2了。

### 创建标签

我们使用如下命令为当前分支所在节点打上标签：

```
git tag [tagname]
```

但是我们有时候可能需要将所在分支之前的提交节点打上标签，而非当前的最新版本，此时我们不可能是使用版本回退来回到之前的节点的，因为这样会丢失当前最新版本，只需要使用如下指令:

```
git tag [tagname] [commit ID]
```

我们可以使用如下指令查看标签列表：

```
git tag
```

但是一定要注意tag的排列不是按照时间顺序的，而是按照字母排序的，所以从tag顺序中无法知道版本节点的先后。同时我们想要查看某个标签对应的版本详细信息时只需要输入：

```
git show [tagname]
```

这样可比查看冗长的git log要方便了许多。例如：

```gas
$ git show v0.9
commit f52c63349bc3c1593499807e5c8e972b82c8f286 (tag: v0.9)
Author: Michael Liao <askxuefeng@gmail.com>
Date:   Fri May 18 21:56:54 2018 +0800

    add merge

diff --git a/readme.txt b/readme.txt
...
```

同时我们还可以在打标签的时候再次添加说明信息：

```
git tag -a [tagname] -m "message" [commit ID]
```

这样当我们再次使用git show的时候就可以得到两条说明文字，一个是之前git commit时的，一个是git tag时的，例如：

```gas
$ git show v0.1
tag v0.1
Tagger: Michael Liao <askxuefeng@gmail.com>
Date:   Fri May 18 22:48:43 2018 +0800

version 0.1 released

commit 1094adb7b9b3807259d8cb349e7df1d4d6477073 (tag: v0.1)
Author: Michael Liao <askxuefeng@gmail.com>
Date:   Fri May 18 21:06:15 2018 +0800

    append GPL

diff --git a/readme.txt b/readme.txt
...
```

> 注意：当某个节点是合并共享的版本节点，即同时处于master分支和dev分支上，那么无论处于哪个分支的这个节点上，我们都可以查看到这个标签。

### 操作标签

我们肯定有打错标签的时候，那么可以使用如下指令删除标签：

```
git tag -d [tagname]
```

创建的标签都只会存储在本地，不会自动推送到远程分支，所以删除标签可以再本地安全删除，当我们想要将标签推送到远程仓库时，使用git push即可：

```
git push origin [tagname]
```

既可以将本地的某一个标签推送到远程仓库分支，当然你也可以一次性将这条分支上的所有标签全部推送到远程仓库：

```
git push origin --tags
```

但是如果已经推送到远程仓库的标签要删除，那么我们需要先将本地分支上的标签删除：

```
git tag -d [tagname]
```

然后再推送删除操作将远程仓库的同样的标签也删除：

```
git push origin :refs/tags/[tagname]
```

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210129150149.png)

我们可以在github上查看远程仓库的标签是否添加和删除成功。

### 项目参与

由于github上的大部分项目开源存储，所以我们可以参与到这个项目中的开发中，但是我们知道对于别人的远程仓库由于我们没有sshkey绑定是不能够给将我们本地的修改推送到别人的远程仓库中的，那么我们如何才能够参与这个开源项目呢？很简单，我们点击一下某个人的开源仓库项目fork按钮

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210129152652.png)

就可以将这个开源项目添加到了我们自己的远程仓库中（其中star按钮表示点赞）。这样我们就可以在自己的远程仓库中查看到这个项目（显示fork from...)

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210129153311.png)

然后我们克隆自己远程仓库中的这个项目到本地就可以参与开发修改了，这样我们自己新建一个分支然后修改这个项目或者在master分支后面新增修改提交，然后我们将自己的修改提交到我们自己的远程仓库（一定要注意是自己的仓库）。那么如果我们想要将自己的一些修改想法分享给原创作者只需要创建一个pull request，然后选择自己的修改即可，同时我们还需要添加一下修改的标题和一些介绍即可，最后将pull request提交给作者，作者审核通过同意后即可将我们的修改添加到他的远程仓库了。

比如现在我们想要向廖雪峰老师发送一份感谢信的pull request，我们首先需要fork他的仓库，这里我已经完成了。然后我们克隆这个仓库到我们的本地，然后我们根据廖雪峰老师的提示，在相应的日期下新建我们的感谢信，我处于2021一月份，所以在202001中添加一个md：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210129155300.png)

然后我们将这个文件提交并上传到我们的远程仓库

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210129155816.png)

然后我们就可以在自己的远程仓库查看到这个修改了。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210129155922.png)

这样我们的仓库已经有了我们的修改，接下来我们将自己的修改通过pull request发给廖雪峰老师，只需要点击pull request一栏创建一个新的pull request即可：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210129160038.png)

这里提示可以将我们的master分支下的修改提交合并到廖雪峰老师的learngit仓库的master分支，然后我们点击创建：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210129160223.png)

然后我们添加一下标题和一些说明文字就可以提交pull request了。

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210129160302.png)

那么现在我们就可以查看到自己的pull request已经成功提交了，接下来就是等待廖老师的审核啦。

### 结尾语

那么此次我们历时5天的git学习历程就到此结束啦，回想起来，git学习也不是一件多难的事情，凡事都重在持之以恒，敢于尝试吧😜！