---
title: volantis主题美化--为侧栏添加好文推荐功能
comments: false
top: false
date: 2021-08-21 22:04:11
tags: [hexo]
categories: 
	- [知识分享,魔改攻略]
headimg: https://langwenchong.gitee.io/figure-bed/20210821225637.png
---

快来食用本篇博文为自己的volantis主题添加一个侧栏好文推荐功能吧😃~

<!-- more -->

{% note quote,

由于题主水平有限，本篇魔改教程的内容实际上很简单，一学就会！如果有更好的修改思路，请您一定要分享给博主哦~

%}

### 效果展示

![](https://langwenchong.gitee.io/figure-bed/20210821221313.png)

### 开发由来

实际上这个内容实现起来很简单，博主并没有能力实现动态的随机推荐文章功能，而仅仅是静态的固定文章推荐功能。开发由来是博主在阅览到其他主题的博客时，发现许多博客都有随机推荐文章的功能，既美观又可以有效的解决侧栏内容过于单调的问题，因此我尝试用自己浅薄的前端技术实现一个类似于[黑石大大](https://www.heson10.com/)所用的cuteen主题的随机文章推荐功能，很幸运，在阅读了源代码后发现可以在不破坏主题源代码的情况下完美实现此功能。

### 魔改步骤

#### 新建recommend.ejs文件

首先我们需要新建一个模板文件，这里我们和主题源代码的思路一致为一个新的样式板块使用一个独立的ejs文件。我们在`themem\volantis\layout\_widget`下新建`recommend.ejs`文件并且加入如下代码：

```ejs
<%- partial('_pre') %>
<section class="widget <%- item.class %> <%- page.widget_style %> <%- page.widget_platform %>">
    <%- partial('header', {item: item}) %>
    <div class='content'>
        <div class="recommend">
            <section class="recommend-erapper">
                <% (item.posts||[]).forEach(function(post){ %>
                <div class="recommend-box">
                    <a href='<%- url_for(post.url) %>'>
                        <img src="<%- url_for(post.img) %>">
                        <div class="background"></div>
                        <p id="post-id"><%- post.title %></p>
                        <p id="post-info"><%- post.info %></p>
                    </a>
                </div>
                <% }) %>
            </section>
        </div>
    </div>
</section>
```

#### 引入模板样式

然后我们再在sidebar.styl文件中的最下方加入如下样式代码：

```css
.recommend  .content{
  padding: 8px 16px;  
}

.recommend  .content .recommend-box a:hover img{
  transform: scale(1.1)
  filter: blur(0px)
}
.recommend  .content .recommend-box a:hover .background{
  opacity :0;  
}
.recommend  .content .recommend-box a:hover #post-id{
  color:#f2b94b
  top:76%;
  font-size:20px;
  line-height:24px;
}
.recommend  .content .recommend-box a:hover #post-info{
  bottom:-30px;  
}
.recommend  .content .recommend-box a{
  color: #fff;
  display:block;
  position:relative;
  width:100%;
  margin-bottom:8px;
  overflow: hidden
  // box-shadow: inset 1px 10px 2px rgba(0,0,0,.4)
}

.recommend  .content .recommend-box a img{
  transition: .6s all
  // filter:  brightness(.5);
  border-radius: 4px;
  filter: blur(1px)
}
.recommend  .content .recommend-box a #post-id {
  top: 60%;
  left: 8px;
  max-width: 80%;
  transform: translateY(-65%);
  text-align: center;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-size: 16px;
  font-weight: 700;
  position: absolute;
  margin: 0;
  transition: .3s all;
}
.recommend  .content .recommend-box a #post-info{
  margin: 0;
  font-size: 8px;
  line-height: 2;
  position: absolute;
  left: 8px;
  /* transform: translateX(-50%); */
  max-height: 48px;
  /* text-align: center; */
  bottom: 15px;
  width: 90%;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  color: #F7F7FA;
  transition:.3s all;
}
.recommend  .content .recommend-box a .background{
  position:absolute;
  bottom:8px;
  left:0px;
  width: 100%;
  height: 80%;
  background: linear-gradient(to bottom, rgba(0,0,0,0), rgba(0,0,0,1));
  transition: .3s all
}
```

#### 配置文件写入数据

最后我们需要在`_config.yml`文件中写入数据来存储我们要推荐的文件，在`_config.yml`文件中的widget_library下添加如下代码：

```yml
 	#---------------------------------------
    # recommend widget
    recommend:
      class: recommend
      sticky: true #下滑到下方固定，强烈推荐
      display: [desktop] #目前只能在pc端显示
      header:
        icon: fad fa-thumbs-up #头部的icon样式
        title: 好文推荐 #头部的标题
      posts: #以下是推荐的文章，请注意格式严格对齐
        - title: #文章标题
          url: #文章绝对链接路径
          img: #文章背景图
          info: #文章简介
        - title: #文章标题
          url: #文章绝对链接路径
           img: #文章背景图
          info:  #文章简介
        - title:  #文章标题
          url: #文章绝对链接路径
          img: #文章背景图
          info: #文章简介
```

我们要注意这里的文章个数可以自行修改，3个或者更多都是可以得，但是为了美观考虑，博主推荐放三个文章效果最佳。同时这里的文章链接和头图链接必须是绝对链接路径，不能是相对路径。

最后我们再在for_page中引入这个模块即可，如我的for_page如下填写：

```yml
for_page: [blogger, webinfo, tagcloud,recommend]
```

{% note info,

一定要注意无论怎样填写，当recommend组件开启`sticky`属性时，请将recommend模块填写到for_page数组的最后面😟！这样才不会出现模块重叠的效果。

%}

#### 进阶方法

实际上这种静态推荐的方法有一定的局限性，即无论是何种页面推荐的文章都是写死固定的，但是动态博客都是动态随机推荐文章的，而这种功能也可以在hexo静态页面博客上实现，黑石大大早已给出了思路，但是博主却并没能实现，如果您参考下方的攻略后能够成功实现还请您分享给博主！

{% link Hexo博客实现随机文章功能,https://www.heson10.com/volantis/posts/31514.html %}

### 后言

经过本次魔改，我们对ejs文件的渲染有了一定的了解，我们在ejs文件中使用如下代码即可轻松实现ejs中的代码模板动态渲染`_config.yml`中的数据：

```ejs
<% (item.posts||[]).forEach(function(post){ %>//获取数组并循环渲染
<a href='<%- url_for(post.url) %>'>//获取链接路径
<img src="<%- url_for(post.img) %>">//获取链接路径
<%- js(theme.plugins.backstretch.js) %>//引入外部js文件
```

这样我们以后就可以轻松的自定义ejs模板来实现对博客的页面魔改啦！那么本次分享到此就结束啦，我们下次见🤗！~