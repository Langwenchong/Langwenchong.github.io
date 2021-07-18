---
layout: friends
title: 
bottom_meta: false
sidebar: []
cover: true
---



<p class="p center logo large thanks" style="margin-top:60px">官方技术支持 <sup>特别鸣谢</sup></p>
<div class="lb">
                    <a href="https://github.com/" style="--color:#555">
                        <div class="icon">
                            <span style="--i:1"></span>
                            <span style="--i:2"></span>
                            <span style="--i:3"></span>
                            <i class="fab fa-github"></i>
                        </div>
                        <div class="text">Github</div>
                    </a>
                    <a href="https://cloud.tencent.com/" style="--color:#FDCB6E">
                        <div class="icon">
                            <span style="--i:1"></span>
                            <span style="--i:2"></span>
                            <span style="--i:3"></span>
                            <i class="fas fa-cloud"></i>
                        </div>
                        <div class="text">腾讯云</div>
                    </a>
                    <a href="https://www.superbed.cn/" style="--color:#0984E3">
                        <div class="icon">
                            <span style="--i:1"></span>
                            <span style="--i:2"></span>
                            <span style="--i:3"></span>
                            <i class="far fa-image"></i>
                        </div>
                        <div class="text">聚合图床</div>
                    </a>
                    <a href="https://hexo.io/zh-cn/index.html" style="--color:#FD79A8">
                        <div class="icon">
                            <span style="--i:1"></span>
                            <span style="--i:2"></span>
                            <span style="--i:3"></span>
                            <i class="fab fa-hackerrank"></i>
                        </div>
                        <div class="text">Hexo</div>
                    </a>
                    <a href="https://nodejs.org/en/" style="--color:#00B894">
                        <div class="icon">
                            <span style="--i:1"></span>
                            <span style="--i:2"></span>
                            <span style="--i:3"></span>
                            <i class="fab fa-node"></i>
                        </div>
                        <div class="text">Node.js</div>
                    </a>
                    <a href="https://fontawesome.com/icons" style="--color:#E056FD">
                        <div class="icon">
                            <span style="--i:1"></span>
                            <span style="--i:2"></span>
                            <span style="--i:3"></span>
                            <i class="fab fa-font-awesome-alt"></i>
                        </div>
                        <div class="text">FontAwesome</div>
                    </a>
                </div>


{% p center logo large, 友人帐 %}
{% p center small, 人生在世，有个朋友是一种福气。 %}

<!-- more -->

 {% issues sites | api=https://api.github.com/repos/Langwenchong/blogFriends/issues?sort=updated&state=open&page=1&per_page=100&labels=active | group=group:技术大佬,铁憨憨,小笨蛋 %}



{% tabs tab-id %}

<!-- tab 📜友链申请流程 -->
{% timenode 第一步：先将本站链接添加至贵站 %}

> * 名称：雨中的博客
> * 链接：https://wenchong.space
> * 头像：https://gitee.com/Langwenchong/figure-bed/raw/master/author.jpeg
> * 网站截图：https://pic.imgdb.cn/item/609a06bed1a9ae528ff429cc.jpg
> * 描述：频繁记录，只因生活和你太值得❤
{% endtimenode %}
{% timenode 第二步：前往Github，新建[Issues](https://github.com/Langwenchong/blogFriends/issues)（👈点我）按照格式填写并提交 %}

```json
​```json

{
    "title": "博客站名",
    "avatar": "站主头像外链",
    "screenshot": "博客截图外链",
    "url": "博客站点链接",
    "description": "形容自己的博客",
    "group": "可以选'技术大佬'或者'铁憨憨'"
}
​```
```
为提高图片加载速度，建议优化头像和截图：
1. 打开 [压缩图](https://www.yasuotu.com/) 上传自己的截图，将图片大小压缩到 1Mb以下。
2. 将压缩后的图片上传到自己搭建的图床、[去不图床](https://7bu.top/) 等，并使用此图片链接作为截图。
{% endtimenode %}
{% timenode 第三步：下方评论区留言，等待博主审核 %}
> * 评论区记得填写QQ邮箱，博主会收到微信及邮件通知，待审核通过后刷新本页面即可显示
> {% endtimenode %}

<!-- endtab -->

<!-- tab 📙友链申请须知 -->
{% checkbox checked blue, 请确保您的博客站点能够正常访问，禁止死链 %}
{% checkbox checked cyan, 原则上只接收博客类网站友链，资源站、视频站等一切非博客类网站不予交换 %}
{% checkbox checked red, 页面保证无繁杂广告推广 %}

{% checkbox checked yellow,  如果是自己创建的 [Issues](https://github.com/Langwenchong/blogFriends/issues) ，可以自己修改。 %}

{% checkbox checked orange, 如果是博主创建的，请自己重新创建一份，然后让博主删掉旧的。 %}

{% checkbox checked , 如果你实在是不会使用github issues添加友链并且又非常渴望和站主添加好友，那么请直接在下方评论区留下链接信息，站主会慷慨地为你添加的！但是你将被划分到`小笨蛋`区域哦~。 %}

<!-- endtab -->

{% endtabs %}

