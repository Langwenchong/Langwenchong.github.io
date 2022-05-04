---
title: hexo主题美化--底部添加标签
comments: false
top: false
date: 2021-03-03 15:42:02
tags: [hexo]
categories: 
	- [知识分享,魔改攻略]
headimg: https://langwenchong.gitee.io/figure-bed/20210704132715.png
---

hello~，快来食用本篇博客与翀翀😛一起为自己的博客底部添加上漂漂亮亮的标签🔖吧，相信你一定会喜欢哒

<!-- more -->

### 成果预览

![](https://langwenchong.gitee.io/figure-bed/20210303155842.png)

### 操作步骤

{% note info, 

首先要声明，我这里的步骤都是以Next主题v8.0+进行的，如果你的版本过低或者使用的是其他博客主题请对比参考，可能直接按照此步骤无法达到理想效果~

%} 

说来也简单，我们首先复制一下代码

```html
{%- if theme.footer.badge %}
<style>
  .github-badge {
      display:inline-block;
      border-radius:4px;
      text-shadow:none;
      font-size:13px;
      color:#fff;
      line-height:15px;
      margin-bottom:5px;
  }
  .github-badge a{
      display: inline-block;
      margin: 0 1px 5px;
      border:none!important;
  }
  .github-badge .badge-subject {
      display:inline-block;
      background-color:#4D4D4D;
      padding:4px 4px 4px 6px;
      border-top-left-radius:4px;
      border-bottom-left-radius:4px;
  }
  .github-badge .badge-value {
      display:inline-block;
      padding:4px 6px 4px 4px;
      border-top-right-radius:4px;
      border-bottom-right-radius:4px;
  }
  .github-badge .bg-brightgreen {
      background-color:#4DC820 !important;
  }
  .github-badge .bg-orange {
      background-color:#FFA500 !important;
  }
  .github-badge .bg-yellow {
      background-color:#D8B024 !important;
  }
  .github-badge .bg-blueviolet {
      background-color:#8833D7 !important;
  }
  .github-badge .bg-pink {
      background-color:#F26BAE !important;
  }
  .github-badge .bg-red {
      background-color:#e05d44 !important;
  }
  .github-badge .bg-blue {
      background-color:#007EC6 !important;
  }
  .github-badge .bg-lightgrey {
      background-color:#9F9F9F !important;
  }
  .github-badge .bg-grey, .github-badge .bg-gray {
      background-color:#555 !important;
  }
  .github-badge .bg-lightgrey, .github-badge .bg-lightgray {
      background-color:#9f9f9f !important;
  }
</style>
<div class="github-badge">
  <a style="color: #fff"  href="https://hexo.io/" target="_blank" title="由 Hexo 强力驱动">
    <span class="badge-subject">Powered</span><span class="badge-value bg-blue">Hexo</span>
  </a>
  <a style="color: #fff" href="https://cloud.tencent.com/" target="_blank" title="静态网页托管于 腾讯云" >
    <span class="badge-subject">Hosted</span><span class="badge-value bg-brightgreen">TencentCloud</span>
  </a>
  <a style="color: #fff" href="https://fontawesome.com/icons" target="_blank" title="本站所有icon图标来自于 fontawesome" >
    <span class="badge-subject">Decorated</span><span class="badge-value bg-orange">Fontawesome</span></a>
  <a style="color: #fff" href="https://github.com/next-theme/hexo-theme-next" target="_blank" title="站点使用 Nextv8.0 Muse 主题" >
    <span class="badge-subject">Theme</span><span class="badge-value bg-blue">Nextv8.0 Muse</span>
  </a>
  <a style="color: #fff" href="http://creativecommons.org/licenses/by-nc-sa/4.0/" target="_blank" title="本站点采用知识共享署名-非商业性使用-相同方式共享 4.0 国际许可协议进行许可">
    <span class="badge-subject"><i class="fa fa-copyright"></i></span><span class="badge-value bg-lightgrey">BY-NC-SA 4.0</span>
  </a>
</div>
{%- endif %}
```

然后打开next主题文件yml，在footer中加入一个新的参数开关，如下：

![](https://langwenchong.gitee.io/figure-bed/20210303160229.png)

如果你是其他的主题也不要担心，我们回去查看一下代码，分析一下为何要加入badge。在代码的最上层有一个If判断句，他是根据这个参数的真值来判断下方的代码是否要插入的。由于我这里设置的参数是badge，所以上面的代码判断句才写成：

![](https://langwenchong.gitee.io/figure-bed/20210303160421.png)

theme表示的是你的主题，footer是位置，badge是开关参数名称，如果你想在A处添加一个名字叫badge的参数开关，那么你就应该写成

```
{%- if theme.A.badge %}
```

总之无论哪种主题都可以，但是必须先写上theme参数，后面是你自己添加的。然后我们了解了yml具体的运行机制以后，接下来就是要将代码粘贴到布局代码中了。如果你和我的主题与版本一致，那么请在themes/next/layout/_partials/footer.swig中的如下位置添加

![](https://langwenchong.gitee.io/figure-bed/20210303160911.png)

注意前面的theme.footer.powered就可以注释掉了，因为和我们添加的标签功能重叠了。这里由于使用的是swig文件，他就是一个渲染成html之前的初始化文件，因此渲染后就会成为html。如果你的主题下布局文件使用的是njk或者其他的文件也可以尝试，但是大体思路是一样的，添加完成后再Hexo三剑客步骤以后，就完成了。

如果你想更改标签的内容，请在

![](https://langwenchong.gitee.io/figure-bed/20210303161221.png)

图中四个画圈的位置都进行更改，其中href是跳转链接，title是鼠标悬浮后显示的信息。