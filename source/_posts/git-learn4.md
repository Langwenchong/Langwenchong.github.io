---
title: git学习日志Part4
comments: false
top: false
date: 2021-01-28 15:41:12
tags: [note,git]
categories: 
	- [教程,git学习]
headimg: https://gitee.com/Langwenchong/figure-bed/raw/master/20210704135540.png
---

😃hello~本篇文章记录了翀翀学习[廖神git教程](https://www.liaoxuefeng.com/wiki/896043488029600)时的学习笔记，快来和我一起走进git世界吧！食用本篇博客的同时参照着廖雪峰大大的教程做一遍实验，保证你从此能够熟练使用git，成为一名顶级的CV工程师。

<!-- more -->

### bug分支

我们这里在讨论一种特殊的情况，这个场景一般发生在实际的业务开发工作中，我们假设现在某个项目已经开发出来一个不稳定的版本readme.txt存在于dev分支上，然后我们现在自己的分支myjob上正在开发自己的业务功能板块，实现一个矩阵相乘的c文件maxtrix-mul.c，但是我们现在还处于中途开发阶段，还没有commit。即此时我们的分支情况下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210128161809.png)

此时我们假设现在matrix-mul.c还没有开发完，即如下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210128155833.png)

那么显然此时我们就还没有将matrix-mul开发完不能commit为一个版本（在实际开发中，一般只有开发完一个阶段形成一个版本后才会commit,而不是随心所欲的提交）。但是此时我们已经修改了matrix-mul.c，此时老板告诉我们开发的dev分支上的新版本中readme.txt有Bug需要修改并且要求我们现在就要修改这个bug。此时我们第一想法就是切换到dev分支，然后新建一个Issue分支来解决这个bug，然后再将这个issue上改完bug的分支合并到dev上从而达到修改bug的目的（注意这种创建新分支修改bug再合并到dev分支的策略，我们一般不能够直接修改dev分支上的文件以防破坏了dev分支）。但是此时我们发现当尝试切换到dev分支再创建issue分支时是不行的，会报错：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210128161318.png)

我们发现他报错还没有对已被修改的文件matrix-mul.c进行保存，所以切换分支的行为被终止了。我们分析一下发现确实此时我们编辑了matrix-mul.c文件但是此时还没有commit到一个新节点保存。理论上来说我们未尝不可已先将这个文件的修改提交为一个版本然后注释为"不是一个新版本，而是临时需要改bug切换分支而保存的行为"以此来达到在git日志中记录我们这次上传的提示。但是我们想一想平常工作中肯定需要时常进行修改bug的任务，难道每次都要这样暂存一个版本吗？那这样git日志里绘充斥了许多没有意义的切换分支的信息记录，无疑阻碍工作。所以此时我们需要一个办法来暂存这个已被修改的matrix-mul.c文件同时不会记录到git日志上成为一个节点，然后我们可以切换到dev分支上先解决bug，解决完后在切换回来继续工作直至开发成一个阶段了再提交commit。这时我们需要输入以下指令：

```
git stash
```

这样git会将myjob分支上的我们现在开发到一半的matrix-mul.c存到一个特殊的地方并且不会新增commit,此时我们再查看工作区状态

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210128161346.png)

我们发现此时git认为myjob分支是干净的，即假装认为此时所有被修改的文件都已经存储了(实际上此时myjob分支的被修改的matrix-mul.c只是被暂存到了一个地方)。然后此时我们就可以切换到了dev分支上了。此时我们就到达了如下图的情况

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210128162032.png)

然后我们现在查看一下这个有bug的readme.txt文件，他的内容如下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210128162405.png)

果然有bug,我们现在修改一下readme.txt的bug，修复成无bug的版本：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210128162509.png)

然后在issue上提交这个修改好bug的版本，此时分支情况如下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210128162756.png)

所以新的issue分支现在领先dev一个版本是修复好bug的版本，我们采用Fast forward模式的分支合并将dev分支也移到这个无bug版本：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210128163105.png)

我们发现此时dev分支上的最新版本确实修复了bug:

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210128163144.png)

所以dev分支上的版本已经修改好了bug了，所以我们可以删除issue分支了并切换到myjob分支继续我们的板块开发了。

#### 注意：删除分支时所处分支对命令的影响

一定要注意在上面这种情况下，如果我们处在dev分支上删除issue分支，那么命令就是

```
git branch -d issue
```

即可，但是如果此时我们是先切换到了myjob分支上在删除issue分支时会有一个小报错如下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210128164903.png)

此时我们需要输入如下的指令进行强制删除

```
git branch -D issue
```

效果是一样的，但是为了防止出现这种报错，我们最好是在上游分支即dev分支上删除合并的分支issue分支最好。

那么此时我们就回到了issue分支了，分支分布情况如下：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210128165107.png)

此时我们的myjob分支上的文件还在被暂存处呢，我们输入以下指令：

```
git stash list
```

可以查看暂存处确实还存储这之前的文件：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210128165323.png)

接下来我们从暂存处取出这个文件版本，这里有两种方式

①输入git stash apply恢复文件但是暂存处还会保存这个文件，所以还需要在输入git stash drop来删除暂存处的文件。

```c
git stash apply //从暂存处取出文件恢复我们的myjob分支
git stash drop  //删除暂存处的文件
```

②或者直接一键取出暂存处的文件同时清空暂存处

```
git stash pop
```

此时我们在查看stash list 发现确实清空了暂存处同时恢复了文件工作区有记录了被修改的但是还没有被保存的文件:

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210128165756.png)

我们现在思考一个问题，dev分支上的bug确实是修复好了，但是我们想一下我们的myjob分支的版本肯定是在之前的dev分支上clone来的基础上进行开发的，所以我们的myjob当前版本肯定也存在和dev分支上的bug,所以我们也需要将myjob分支上同样的bug进行修复，但是此时就不需要再重复创建分支-修改bug-合并等过程了，可以直接使用下面的方法一步修改相同的bug：

我们查看一下dev分支的git log:

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210128170547.png)

我们可以找到之前修复bug的提交commit ID是4857ad1c，然后切换回myjob分支：

输入以下指令：

```
git cherry-pick 4857ad1c
```

即可以将dev分支上修复bug的操作（注意仅仅是修复bug的操作，而不是dev上的文件）复制同步到了myjob分支上，这样myjob分支就修复好了和dev相同的bug了，并且一定要注意此时git会自动生成一次新的提交即git日志上新增加了一次提交历史并且commit信息就是dev修复bug的信息。我们此时查看一下myjob分支上的readme.txt文件：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210128170954.png)

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210128171219.png)

确实修复好了相同的bug。并且此时myjob分支上确实新增加了一个提交"reapai bug"和dev的commit信息相同，但是注意这真的是一个新的提交所以commit ID是不同于dev分支的git日志的commit ID。这样我们就可以继续开发我们的myjob分支了。

#### 思考：有没有另一种修复dev分支的bug?

聪明的你一定想到了另一种修复bug的方法了。即先把myjob上的bug修复了，然后切换到dev分支上，使用git  cherry-pick [commitID]同步myjob上的修复bug操作即可。并且此时dev分支还会自动生成一个新提交即为新版本。但是注意即使是这个方法切换分支时也还是需要输入git stash暂时存储那些被修改但是还没有提交的文件。

### 多人协作

#### 远程仓库

这里我们介绍一下多人协作的指令。首先我们知道当从远程仓库克隆时，git就是把本地的master分支和远程的master分支对应，所以我们克隆下来的都默认克隆master分支。并且要注意远程仓库的默认名称是origin。我们使用指令

```c
git remote //查看远程仓库信息
```

可以查看远程仓库的名字：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210128195611.png)

如果没有更改过一般就是origin，然后我们使用以下指令可以查看远程仓库的地址：

```c
git romote -v //查看远程仓库详细信息
```

我们可以查看到远程仓库的地址：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210128195751.png)

这里会显示两个地址一般是一样的，你可能是https协议的也有可能是我这种git协议的，通过上面我们就可以知道抓取和推送的远程仓库origin的地址。但是要注意如果你没有推送权限，比如你克隆了别人的仓库的git地址，你会发现你没有push的地址。

#### 推送分支

我们现在再来回忆一下推送的指令：

```
git push origin master
```

实际上这条指令的意思是说把本地仓库你现在所处的分支推送到远程仓库oirgin的master分支上。再比如我们要将本地的分支版本推送到dev分支上，那么指令就是：

```
git push origin debv
```

这里我们并不是要将所有的分支都推送到远程仓库，我们规定：

- master分支时主分支，存储的是项目稳定的版本，因此要时刻保证本地远程同步
- dev分支时开发分支，一般存储的是项目不稳定的版本，可能存在Bug，一般团队中所有成员的最终开发分支要合并到这个分支上形成多个版本，所以也要与远程仓库同步
- bug分支，比如issue-1,issue-1001,bug-7等你自己本地命名的新分支用来修复bug，修复后就会删掉的分支就没必要上传到远程仓库了
- feature分支，一般是开发一些未知的功能板块（可能不会应用到实际项目中）时的分支，可上传也可不上传
- chong，yourjob等自己开发时的分支一般不用推送到这个项目的远程分支，你可以推送到自己的git仓库的分支上

#### 抓取分支

在多人写作时，master分支和dev分支无疑经常需要被抓取，比如你要在稳定版本1.0之上开发2.0版本，那么就需要克隆版本1.0作为开发基础版本。现在假设你要克隆这个项目，由于肯定也是开发团队中的一员，所以sshkey肯定已经加到这个团队仓库中了，所以可以直接使用git协议抓取，这样就可以免密上传了。重点是一般可能作为开发人员，你克隆的都是dev分支，然而git默认只会抓取master分支，所以你需要输入如下指令抓取特定分支：

```c
git clone -b [branchname] [git-addr] // 抓取远程仓库的某一个特定分支
```

##### 思考：如果两个人都同时推送一个特定分支会怎样？

我们举一个例子，假如有一个dev分支上的项目版本是1.0，然后你克隆了这个仓库的dev分支到了你的本地开发分支myjon上，那么你开发了一个新版本你将其命名为版本2.0。此时你想将这个新版本推送到dev分支上，但是在你推送之前，已经由另一个开发伙伴也用1.0开发了一小部分功能命名为1.1上传到了dev分支上了，那么此时你就会出现报错：

```gas
To github.com:michaelliao/learngit.git
 ! [rejected]        dev -> dev (non-fast-forward)
error: failed to push some refs to 'git@github.com:michaelliao/learngit.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

一般如上面这样，我们分析一下为什么会报错，此时分支情况如下图：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210128202959.png)

此时就是这种情况，你会发现在我们推送2.0版本之前小明已经将1.1推送到了远程仓库dev分支上，那么此时如果我们要将我们的2.0版本推送到远程仓库的2.0分支时git就会出现报错，原因是此时远程仓库已经是1.0->1.1了，而要推送的是1.0->2.0，那么就产生了歧义，2.0版本到底是推送到1.0和1.1版本之间还是1.1版本之后？所以我们需要先同步一下远程分支。

因为我们之前clone过远程仓库了，所以我们这条分支已经和远程仓库的dev分支有了联系，所以此时不需要删除仓库重新克隆远程仓库来更新分支，而只需要输入如下指令更新：

```c
git pull //同步远程仓库分支到本地仓库分支
```

那么就会变成如下图所示情况：

![](https://gitee.com/Langwenchong/figure-bed/raw/master/20210128203520.png)

那么此时我们的本地分支已经同步更新了，此时在git push到远程仓库就可以上传我们的2.0版本了。当然在git pull时由于版本不同可能会产生冲突即版本1.1和版本2.0之间有冲突（毕竟你们两个人个能同时对同一个文件进行了修改），那么我们就需要手动解决一下即可。所以在本地仓库的分支必须领先远程仓库的分支才可以推送。

##### 注意：如果本地仓库分支和远程仓库分支没有建立关联会报错

此时要注意只有clone后我们的这条分支myjob才会和远程仓库的dev分支建立了关联，这样git pull 时git才会知道是将dev分支要同步更新到myjob分支上，但是如果此时你使用的是另一个自己新建的本地分支feature，那么git pull时由于feature和dev分枝没有建立关联，git pill时会报错（因为git不知道feature分支要同步远程仓库的那一条分支）：

```
no tracking information
```

所以此时我们需要手动关联一下本地分支，我们输入

```c
git branch --set-upstream-to <branch-nameA> origin/<branch-nameB>
//将本地仓库的分支A和远程仓库的B分支建立关联
```

这样我们再git pull时则可以将远程仓库的B分支更新同步到本地仓库的A分支了。

这里还有一小节是变基，不太好看懂，学有余力不妨看一看：[《Rebase》](https://www.liaoxuefeng.com/wiki/896043488029600/1216289527823648)

### 总结

|                           指令名字                           |                           指令功能                           |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
|                          git stash                           |  将现在分支上的工作区中已被修改但是还没有上传的文件暂存起来  |
|                       git stash apply                        |            将暂存区的文件恢复，但是不会清空暂存区            |
|                        git stash drop                        |                          清空暂存区                          |
|                        git stash pop                         |               将暂存取文件恢复的同时清空暂存区               |
|                        git stash list                        |                          查看暂存区                          |
|                  git branch -d [branchname]                  |                           删除分支                           |
|                  git branch -D [branchname]                  |                         强制删除分支                         |
|                 git cherry-pick [commit ID]                  | 同步某一次操作同时自动新生成一次提交，提交的注释和pick的注释相同 |
|                          git remote                          |               查看远程仓库（显示远程仓库名字）               |
|                        git remote -v                         |          查看远程仓库的具体信息（显示远程仓库地址）          |
|           git clone -b [branchname] [origin_addr]            | 克隆远程仓库的某一个特定分支到当前分支同时建立两个分支的关联 |
|                           git pull                           |           更新同步远程仓库的分支到当前已关联的分支           |
| git branch --set-upstream-to [branch-nameA] origin/[branch-nameB] |          将本地仓库的分支A和远程仓库的B分支建立关联          |

多人协作模式：

1. git clone从远程仓库克隆之前的稳定版本后在本地分支上开发
2. 首先试图push推送自己的分支
3. 如果推送失败，git pull更新本地分支
4. 如果合并有冲突，先手动解决冲突并本地提交
5. 如果没有冲突或者冲突已解决再次尝试push即可
6. 如果git pull时报错无关联，那么需要先将本地分支和远程仓库的远程分支相关联