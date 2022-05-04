---
title: git🍻神技--个人主页速览
comments: false
top: false
date: 2021-01-23 12:43:45
tags: [git]
categories: 
	- [知识分享,魔改攻略]
headimg: https://langwenchong.gitee.io/figure-bed/20210704154504.png
---

本篇文章~~一点也不水~~内容详实，非常值阅读，可以说掌握了这个技能，能够让你的git主页颜值爆表😂，还不点进来看一看？

<!-- more -->

我们知道git主页一般是这个亚子：

![](https://langwenchong.gitee.io/figure-bed/20210123124858.png)

不够炫酷（虽然下方的提交面板i了i了），但是，他不够好看😝，一眼望去，没有一个可以直接清晰了解大大总提交数，仓库数以及issue，star等指标，不能够快速掌握这位大大的git使用等级。

所以我推荐你对github个人主页进行以下修改，很简单，如下：

那么我们先看一下效果图😎： [翀的github](https://github.com/Langwenchong)

![](https://langwenchong.gitee.io/figure-bed/20210123125157.png)

操作步骤，很简单，你只需要在github上创建一个仓库，建议你以自己的名字创建,重点是在下面要选择add a Readme.file，然后创建仓库即可。

![](https://langwenchong.gitee.io/figure-bed/20210123142017.png)

不需要克隆到本地，直接打开这个仓库，然后点击这个按钮进行编辑

![](https://langwenchong.gitee.io/figure-bed/20210123142159.png)

将下面的代码复制到自己的markdown中：

```
### Hi there ,Get to know me quickly!😎  

<a href="https://github.com/anuraghazra/github-readme-stats">
  <img align="center"  src="https://github-readme-stats.vercel.app/api?username=Langwenchong&count_private=true&show_icons=true&theme=gotham&show_owner=true" />
</a>
<a href="https://github.com/anuraghazra/github-readme-stats">
  <img align="center"  src="https://github-readme-stats.vercel.app/api/top-langs/?username=Langwenchong&theme=gotham&layout=compact" />
</a>
```

注意要将上面的username=Langwenchong改成你自己的名字，即username="yourname"。这个是我自己的配置，你可以看到我选择了gotham主题，他是一个赛博朋克风格和git的暗黑模式很搭，如果你不喜欢想更换主题或者自己配置为自己满意的主题，请参考这位大大的git的教程[stats的教程](https://github.com/anuraghazra/github-readme-stats) ，再次向这位大大的伟大项目致敬👏！