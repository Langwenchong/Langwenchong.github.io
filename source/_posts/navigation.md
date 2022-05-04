---
title: hexo百宝箱搭建攻略
comments: false
top: false
date: 2021-07-16 11:00:43
tags: [百宝箱,hexo]
categories: 
	- [知识分享,魔改攻略]
headimg: https://langwenchong.gitee.io/figure-bed/20210716145137.png

---

hello~今天带来一期百宝箱的制作教程，在日常生活中我们经常需要收藏许多网址书签来提升我们的办公效率，但是书签的放置，整理和分类的工作总是一言难尽，非常麻烦。因此本次我们将通过建立一个hexo小站来单独存储我们的所有收藏网址，也就是今天要介绍的百宝箱😛！

<!-- more -->

### 效果展示

下图是我建立的百宝箱小站，你可以点击这里快速跳转查看demo:

{% link 雨中的百宝箱,https://coolchong.cn/navigation/#, %}

![](https://langwenchong.gitee.io/figure-bed/QQ图片20210716111527.png)

### 百宝箱介绍

{% note quote,  首先我需要说明一下，这个百宝箱的搭建你可以理解为是建立一个新的hexo网站，因此很显然他是基于一个主题搭建的，这个主题就是[hexo-theme-webstack](https://github.com/HCLonely/hexo-theme-webstack/)。但是它区别于我们之前搭建hexo博客，因为他可以不需要再次新建一个github仓库进行部署，我们只需要本地预览生成html即可，如果你没有理解也没有关系，跟着教程一步步来就好了。 %}

我在原主题上进行了部分魔改美化，因此如果你想要使用原主题的配置，请参考

{% link 原主题配置,https://github.com/HCLonely/hexo-theme-webstack/, %}

如果你想要参考我的魔改后的配置请参考:

{% link 我的魔改配置,https://github.com/Langwenchong/navigation, %}

这里介绍一下我都进行了那些方面的修改：

{% checkbox minus yellow checked, 去除Chinese语言选择栏 %}

{% checkbox plus green checked, 明亮模式下新增circleMagic从上到下掉落彩色气泡的特效，使页面更加美观%}

{% checkbox plus green checked, 返回顶部引入哆啦A梦先生 %}

{% checkbox plus green checked, 夜间模式参考cuteen主题的首图壁纸样式，增加了自定义壁纸以及网格特效 %}

{% checkbox plus green checked, 夜间模式的选择框增加白色阴影选中样式%}

{% checkbox red checked, 更改全局的鼠标样式以及滑动条样式 %}

{% checkbox minus yellow checked, 左侧栏去除无用的x与y轴滑动条 %}

### 搭建教程

首先我们需要新建一个根目录navigation文件夹，然后进入这个文件夹进行hexo环境的初始化：

```linux
mkdir navigation
cd navigation
hexo init
```

进行完hexo初始环境的搭建后，我们需要下载hexo-theme-webstack主题，输入如下指令：

```linux
cd themes
git clone https://github.com/HCLonely/hexo-theme-webstack.git
```

下载完成后navigation下的文件应该与下图一致：

![](https://langwenchong.gitee.io/figure-bed/P4O96[}00UI[UFKDVGTTCW2.png)

如果有多余的文件删除即可。我们打开当前中的_config.yml文件滑动至最下方修改一下使用的主题:

![](https://langwenchong.gitee.io/figure-bed/`B]C43H]L{@E7B`[G`A}B@T.png)

然后我们再在这里右键点击`git bash here`打开命令窗输入`hexo cl && hexo g&& heso s`后在端口`localhost://4000`上即可看到本地预览的效果，但是此时我们发现里面的内容还是空的，链接都没有，因为这需要我们自己添加，同时此时的个人信息还不是自己的，关于页面也还没有建立。我们需要参考配置文档进行配置，这里给出配置文档，我们只需要像往常魔改自己的hexo博客那样按照文档在_config.yml中进行配置即可：

{% link 开发者说明文档,https://blog.hclonely.com/posts/3cd4fb34/, %}

### 魔改教程

这里我不详细指导如何配置开发者提供的yml配置方法，都是hexo老手了，yml应该能自己搞定，如果实在看不懂文档，可以对照着我之前上面所发的配置git仓库进行参考，或者留言区询问我。这里主要讲解一下魔改的步骤：

#### 去除Chinese语言选项

这个东西...没啥用，而且总是跳转到空白界面，很烦所以将它去除，我们打开navigation/themes/layout/index.ejs文件将16-27行注释掉即可：

![](https://langwenchong.gitee.io/figure-bed/20210716114155.png)

#### 左侧栏去除无用的x轴和y轴滑动条

实际上这个滑动条是有用的，开发者考虑到我们在创建一个网址专栏时可能会有多个子专栏，因此当子专栏过多时是会用到滑动条的，但是他实在是不美观，因此我将左侧的x与y轴滑动条强制删除了，这样修改的**前提是我们必须保证每一个专栏最多只能有5个子专栏**如下图：

![](https://langwenchong.gitee.io/figure-bed/$3K@$]XM95UH3H9[GUZ[@HX.png)

那么修改的方法也很简单，我们打开navigation/themes/webstack/source/css/hclonely.css在最下面加入如下代码即可：

```css
.ps-scrollbar-y,
.ps-scrollbar-y-rail,
.ps-scrollbar-x {
  display: none!important;
}
```

#### 夜间模式的选择框增加白色阴影选中样式

我们还是在

navigation/themes/webstack/source/css/hclonely.css中加入如下代码：

```css
body.night .box2:hover {
  box-shadow: 0 26px 40px -24px rgb(255, 255, 255);
  -webkit-box-shadow: 0 26px 40px -24px rgba(130, 130, 130, 0.13);
  -moz-box-shadow: 0 26px 40px -24px rgba(0, 36, 100, 0.3);
  -webkit-transition: all 0.3s cubic-bezier(0.25, 0.1, 0.14, 1.43);
  -moz-transition: all 0.3s ease;
  -o-transition: all 0.3s ease;
  transition: all 0.3s ease-out;
  background-color: #232323 !important;
}
```

修改后效果如下图：

![](https://langwenchong.gitee.io/figure-bed/20210716115320.png)

#### 明亮模式下新增circleMagic从上到下掉落彩色气泡的特效

 这里我们还是使用到了CircleMagic.js来实现，在navigation/themes/webstack/layout/index.ejs文件的最下方下入如下代码：

```js
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.6.0/jquery.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/Langwenchong/cdn/js/circleMagic.min.js"></script>
    <script>
      $('.main-content').circleMagic({
      radius: 7,
      density: .06,
      color: 'rgba(255,255,255, .4)',
      color: 'random',
      clearOffset: 1
    });
    </script>
```

但是我们会发现气泡是从下向上漂浮的，并且横向出现了滚动条最要命的是canvas幕布居然在最上层导致链接框无法点击了😱，因此我们需要进一步修改，首先在themes/webstack/source/css/hclonley.css中添加如下代码取消横向滚动条：

```css
.main-content {
  overflow: hidden;
}
```

然后我们还要将.main-content下的泡泡幕布倒转180度从而使得泡泡从上向下落：

```
.main-content canvas {
  transform: rotate(180deg);
  //添加这个z-index属性后鼠标才能点击到链接框
  z-index: -1 !important;
}
```

#### 更改全局的鼠标样式以及滑动条样式 

还是在hclonely.css中加入如下代码：

```css
a,
button,
img,.box2 {
  cursor: url("https://sakurasep.club/usr/plugins/QuietBeautify/assets/img/a2.cur"), pointer !important;
}
::-webkit-scrollbar {
  width: 8px;
  height: 8px
}

body.night::-webkit-scrollbar-track {
  background-color: #1f2d3d !important;
}

body.night::-webkit-scrollbar-thumb {
  background-color: pink;
}

::-webkit-scrollbar-track {
  background-color: rgba(73, 177, 245, .2);
  /* background-color:transparent!important; */
  border-radius: 2em
}

::-webkit-scrollbar-track.night {
  background-color: #1f2d3d !important;
}

::-webkit-scrollbar-thumb {
  background-color: #49b1f5;
  background-image: -webkit-linear-gradient(45deg, rgba(255, 255, 255, .4) 25%, transparent 25%, transparent 50%, rgba(255, 255, 255, .4) 50%, rgba(255, 255, 255, .4) 75%, transparent 75%, transparent);
  border-radius: 2em
}

::-webkit-scrollbar-corner {
  background-color: transparent
}

::-moz-selection {
  color: #fff;
  background-color: #49b1f5
}
```

#### 返回顶部引入哆啦A梦先生

默认返回顶部实在是丑陋无比，所以我花钱引入了哆啦A梦先生来管理返回顶部的功能，同时他也可以吸引顾客的眼球😏。我们需要先打开layout/common/footer.ejs文件，修改以下代码如图：

![](https://langwenchong.gitee.io/figure-bed/67NXYD[P3X38DFVH[62_C4L.png)

然后我们再在hclonely.css中加入如下代码：

```css
.go-up{
  bottom:80px!important;
  transition: .3s;
}
body.night .go-up a{
  background:transparent!important;
}
body.night .go-up a:hover{
  background:transparent!important;
}
.go-up:hover{
  bottom:120px!important;
}
.go-top{
  background:transparent!important;
}
```

#### 夜间模式cuteen主题风的首图壁纸样式

在hclonely.css最下方加入以下代码：

```css
body.night,
body.night #body {
  position: relative;
  /* background-color: #2c2e2f !important; */
  background-image: url('https://langwenchong.gitee.io/figure-bed/044.jpg');
  background-size: cover;
  background-attachment: fixed;
  color: #a9a9a9 !important;
}

body.night .main-content {
  background: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAQAAAAECAYAAACp8Z5+AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAKUlEQVQImU3IMREAIAgAwJfNkQCEsH8cijjpMf6vnXlQaIiJFx+omEBfmqIEZLe2jzcAAAAASUVORK5CYII=);
}

```

### 部署教程

那么大体上我们已经把百宝箱小站开发的差不多了，现在我们需要将它部署到我们的博客网站上啦，这里有两种方法①新建一个github仓库来存储部署并且使用一个二级域名来解析指向即可但是很麻烦②以分站的形式来建立百宝箱子页，这里我参考了黑石大大的博文：

{% link 分站的建立,https://www.heson10.com/volantis/posts/46324.html, %}

我就在以更简单直接的方法介绍一下我们怎样将navigation部署为博客的一个子页，我们首先需要修改navigation文件夹下的_config.yml文件中的如下内容：

![](https://langwenchong.gitee.io/figure-bed/1RU6`[G_3[GS%]N`EV2E{MA.png)

我们需要将url和root改为

```
url: <你的博客域名>/navigation
root: /navigation
```

然后要注意最下方的deploy不需要填写仓库地址或者ip地址，因为我们并不是将它作为另一个新网站重新部署。我们直接在navigation下打开命令窗输入以下指令：

```hexo
hexo cl
hexo g
hexo s//本地预览一下生成的页面是否正常
```

当本地预览没有任何问题后，我们打开navigation下的public文件夹，这个文件夹存储的是生成的html文件，我们将public文件夹下的所有文件复制：

![](https://langwenchong.gitee.io/figure-bed/20210716140845.png)

然后我们打开自己的博客站点文件夹，我这里是`myblog`（名字可能不同），然后在博客站点文件夹下进入source文件夹并创建一个新的文件夹navigation:

![](https://langwenchong.gitee.io/figure-bed/20210716142711.png)

然后进入这个navigation文件夹将刚刚复制的文件拷贝过来即可。然后我们再打开博客站点文件夹下的_config.yml文件，在如下地方加入`- "navigation/**"`。意思是hexo博客渲染生成页面时这个文件夹下的内容跳过渲染显示：

![](https://langwenchong.gitee.io/figure-bed/20210716142110.png)

此时我们运行博客本地预览，重新生成博客页面

```
hexo cl && hexo g
```

输入`hexo s`打开本地博客预览后输入地址`http://localhost:4000/navigation/` 即可看到百宝箱已经加入成功：

![](https://langwenchong.gitee.io/figure-bed/20210716141648.png)

接下来我们只需要为自己的博客顶栏添加一个新的图标链接指向这个子页即可了。最后在博客站点下重新部署即可将导航栏百宝箱部署线上！

那么本次的分享到此就结束啦，如果你有任何疑问不用害羞，尽管在评论区留言即可😃！如果有什么更好的魔改方案，也欢迎分享给本博主！我们下次见~

