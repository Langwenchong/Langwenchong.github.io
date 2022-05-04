---
title: hexo主题美化--友链编写
comments: false
top: false
date: 2020-12-07 14:36:59
tags: [友链,hexo]
categories: 
	- [知识分享,魔改攻略]
headimg: https://langwenchong.gitee.io/figure-bed/20210704164955.png
---

还在为没有优雅简介的友链页面而苦恼吗？还在为Next主题的反人类侧栏友链而心烦吗？还在为无法找到对移动设备友好的友链页面而心累吗？不妨来试试这个吧😀~

<!-- more -->

### 前言

> 曾经的我与你一样，想拥有一个与众不同的友链页面，他能够实现跳转好友的博客地址的功能同时，最好还能够尽量美观优雅，在经历多日的实地考察，我发现网上并没有理想的友链页面，因此我用了2天的时间总算是编写出了符合自我目标的友链页面，特有如下几个特点：

- 功能齐全（包括官方链接跳转，知己博客跳转）
- 操作简便，只需在_config.yml文件编写即可动态添加or删减友链项
- 美观优雅，可以实时预览知己博客的页面
- 移动适配友好
- 但是同时也附带缺点：不能添加过多的友链从而导致页面过于冗长失去了美化的意义

### 预览效果

本博客使用的及是这个友链页面，点击知己栏目，或者以下链接进行查看：[友链](http://wenchong.space/links/)

### 布置教程

#### 新建页面

首先我们先要新建友链页面，进入自己的博客文件夹根目录下(就是你经常输入hexo s的地方)，输入以下指令

```
hexo new page links
```

然后查看path/source/下是否生成了links文件夹，如果生成了，进入并打开index.md，并在设置栏里加入type属性如下：

![](https://pic.imgdb.cn/item/5fcdd21a3ffa7d37b3abbe89.jpg)

这里只需要注意第二行是否与我这里写的一致即可，请仔细检查第二行是否与我完全一致，这里的title你那里应该是links，删掉即可，这样友链就不会出现令人尴尬的大写标题了😊。

#### 新建swig模块

这里进入path/themes/next/layout/（如果不是next主题或者Next主题不是v8.0+可能略有出入，实在不会请先看下方反思)，新建一个新的文件夹从来储存swig模块，我们模仿其他swig的形式，现在这里新建一个文件夹为_links,然后进入文件夹新建links.swig，最终结果如下：

next/layout:

![](https://pic.imgdb.cn/item/5fcdd5043ffa7d37b3ae52be.jpg)

next/layout/_links:

![](https://pic.imgdb.cn/item/5fcdd52f3ffa7d37b3ae802f.jpg)

然后进入swig文件，选择vscode打开或者其他ide都行，复制下列代码粘贴至此swig文件

```css

{% block content %}
  {######################}
  {### LINKS BLOCK ###}
  {######################}
  <style>
        #links {
            display:flex;
            flex-direction:column;
        }
        #links .container{
            margin: 40px 0;
            display: flex;
            position: relative;
            align-items: center;
            width:100%;
            height:400px;
            overflow:hidden;
            cursor:pointer;
        }
        #links .card {
            cursor:pointer;
            position: absolute;
            width: 300px;
            height: 300px;
            background:#fff;
            box-shadow: 0 15px 35px rgba(0, 0, 0, .2);
            border-radius: 15px;
            display: flex;
            left:50%;
            transform:translateX(-50%);
            justify-content: center;
            align-items: center;
            backdrop-filter: blur(10px);
            transition:.5s;
            z-index:2;
        }
        #links .container:hover .card{
            background:rgb(22, 22, 35,.9);
            height:400px;
            left:0px;
            transform:translateX(0px);
        }
        #links .container .card-hidden{
            box-shadow: 0 15px 35px rgba(0, 0, 0, .2);
            position:absolute;
            width:450px;
            height:400px;
            left:100px;
            top:0px;
            border-radius: 15px;
            opacity:0;
            transition:.5s;
            transition-delay:.6s;
            overflow:hidden;
            z-index:1;
        }
        #links .container .card-hidden img{
            height:100%;
            object-fit:cover;
            border-radius: 15px;
        }
        #links .container:hover .card-hidden{
            opacity:1;
            left:300px;
        }
        #links .card .content {
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            opacity: .5;
            transition: .5s;
            padding:0px;
        }
        #links .container:hover .card .content {
            opacity: 1;
            transform:translateY(-20px);
        }
        #links .card .content .imgBx {
            position: relative;
            width: 150px;
            height: 150px;
            border-radius: 50%;
            overflow: hidden;
            border: 10px solid rgba(0, 0, 0, .25);
        }
        #links .card .content .imgBx img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition:.5s
        }
        #links .container:hover .content .imgBx img{
            transform:rotate(360deg);
        }
        #links .card .content .contentBx h3 {
            font-family: 'Poppins', sans-serif;
            margin:0px;
            padding:0px;
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 2px;
            font-weight: 500;
            font-size: 18px;
            text-align: center;
            margin: 20px 0 10px;
            line-height: 1.1em;
            color:#333;
            transition:.5s;
        }
        #links .container:hover .content .contentBx h3 {
            color:#fff;
        }
        #links .card .content .contentBx  span {
            font-family: 'Poppins', sans-serif;
            font-size: 12px;
            font-weight: 300;
            text-transform: initial;
            color:#333;
        }
        #links .container:hover .content .contentBx h3,#links .container:hover .content .contentBx span{
            color:#fff;
        }
        #links .card .sci {
            position: absolute;
            bottom: 50px;
            display: flex;
            padding:0px;
            margin:0px;
        }

        #links .card .sci li {
            margin:0px;
            padding:0px;
            list-style: none;
            margin: 0 10px;
            transform: translateY(40px);
            transition: .5s;
            opacity: 0;
            transition-delay: calc(0.1s * var(--i));
        }
        #links .container:hover .sci li {
            transform: translateY(0px);
            opacity: 1;
        }
        #links .card .sci li a {
            color: #fff;
            font-size: 24px;
            margin:0px;
            padding:0px;
            transition:.5s;
            text-decoration:none;
        }
        .lb a{
            border:0px!important;
        }
         h2{
            transition:.5s;
            cursor:pointer;
        }
         h2:hover{
            transform:translate(-15px,-9px);
        }
        .lb {
            margin:0 auto;
            width:90%;
            height: 200px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .lb a {
            display: block;
            position : relative;
            width: 100px;
            height: 100px;
            display: flex;
            justify-content: center;
            align-items : center;
            text-decoration: none!important;
        }
        .lb .icon {
            margin-right:20px;
            margin-left:20px;
            box-sizing:border-box;
            position: absolute;
            width: 80px;
            height: 80px;
            color: var(--color);
            display: flex;
            justify-content: center;
            align-items: center;
            transition : all .3s;
        }
        .lb a:hover .icon {
            transform: rotate(-30deg) skew(20deg);
        }

        .lb .icon::after {
            position: absolute;
            content  : '';
            box-sizing  : border-box;
            width : 80px;
            height  : 80px;
            border-radius: 10px;
            border: 2px solid var(--color);
        }
        .lb a:hover .icon::after {
            box-shadow: -1px 1px 3px var(--color);
        }
        .lb .icon i {
            font-size: 48px;
        }
        .lb .icon span {
            display : block;
            position : absolute;
            box-sizing : border-box;
            width : 80px;
            height : 80px;
            border-radius: 10px;
            border : 2px solid var(--color);
            transform : translateX(calc(var(--i) * -8px)) translateY(calc(var(--i) * 8px));
            opacity : 0;
            box-shadow : -1px 1px 3px var(--color);
            transition  : all 0.3s;
        }

        .lb a:hover .icon span {
            opacity: calc((4 - var(--i)) * 0.25);
        }
        .lb .text {
            position: absolute;
            bottom : 30px;
            font-size: 24px;
            color : var(--color);
            opacity : 0;
            transition: all 0.3s;
        }
        .lb a:hover .text {
            opacity: 1;
            bottom : -60px;
        }
    </style>
        <link href="https://cdn.bootcdn.net/ajax/libs/font-awesome/5.15.1/css/all.css" rel="stylesheet">
        <h2>「感谢你的出现，助我勇敢前行.」</h2>
        <div class="lb">
        <a href="https://github.com/" style="--color:#555">
            <div class="icon">
                <span style="--i:1"></span>
                <span style="--i:2"></span>
                <span style="--i:3"></span>
                <i class="fab fa-github"></i>
            </div>
            <div class="text">Github</div>
        </a>
        <a href="https://cloud.tencent.com/" style="--color:#FDCB6E">
            <div class="icon">
                <span style="--i:1"></span>
                <span style="--i:2"></span>
                <span style="--i:3"></span>
                <i class="fas fa-cloud"></i>
            </div>
            <div class="text">腾讯云</div>
        </a>
        <a href="https://www.superbed.cn/" style="--color:#FD79A8;">
            <div class="icon">
                <span style="--i:1"></span>
                <span style="--i:2"></span>
                <span style="--i:3"></span>
                <i class="far fa-image"></i>
            </div>
            <div class="text">聚合图床</div>
        </a>
        <a href="https://hexo.io/zh-cn/index.html" style="--color:#0984E3">
            <div class="icon">
                <span style="--i:1"></span>
                <span style="--i:2"></span>
                <span style="--i:3"></span>
                <i class="fab fa-hackerrank"></i>
            </div>
            <div class="text">Hexo</div>
        </a>
        <a href="https://nodejs.org/en/" style="--color:#00B894">
            <div class="icon">
                <span style="--i:1"></span>
                <span style="--i:2"></span>
                <span style="--i:3"></span>
                <i class="fab fa-node"></i>
            </div>
            <div class="text">Node.js</div>
        </a>
        <a href="http://www.fontawesome.com.cn/" style="--color:#E056FD">
            <div class="icon">
                <span style="--i:1"></span>
                <span style="--i:2"></span>
                <span style="--i:3"></span>
                <i class="fab fa-font-awesome-alt"></i>
            </div>
            <div class="text">FontAwesome</div>
        </a>
    </div>
        <h2>「我们各奔东西，然后，更高处见.」</h2>
        <div id="links">
        
        {% for link in theme.friendlinks %}
        <div class="container">
            <div class="card-hidden">
                <img src="{{link.background}}" alt="background"/>
            </div>
            <div class="card">
                <div class="content">
                    <div class="imgBx">
                        <img src="{{link.avatar}}" alt="{{link.name}}">
                    </div>
                    <div class="contentBx">
                        <h3>{{link.name}}
                            <br />
                            <span>-{{link.info}}-</span>
                        </h3>
                    </div>
                </div>
                <ul class="sci">
                    <li style="--i:1">
                        <a href="{{link.site}}">
                            <i class="fas fa-blog"></i>
                        </a>
                    </li>
                    <li style="--i:2">
                        <a href="{{link.warehouse}}">
                            <i class="fab fa-github"></i>
                        </a>
                    </li>
                    <li style="--i:3">
                        <a href="{{link.qq}}">
                            <i class="fab fa-qq"></i>
                        </a>
                    </li>
                </ul>
            </div>
            </div>
        {% endfor %}
        <div class="message">
            <b>申请要求</b>
            <ol>
                <li>内容持续更新且可以稳定访问</li>
                <li>网页整洁无繁杂广告推广</li>
            </ol>
            <b>友链声明</b>
            <ol>
                <li>本站会主动保存您的 HTTPS 形式的头像图片链接</li>
                <li>本站会定期清理无法访问的友链，如果更换了链接信息请至评论区留言，谢谢合作！</li>
                <li>本站会定期查看双方是否互为友链，如果取消本站友链，本站也会将您的友链移除</li>
            </ol>
            <b>申请方式</b>
            <p>先将本站的友链添加到您的友链，相关信息如下<br/>
               然后按照以下格式在本站留言区留言或者私信博主，待博主为您添上友链
            </p>
            <ul>
                <li>名称：Chong's Blog</li>
                <li>头像链接：http://wenchong.space/images/author.jpeg</li>
                <li>主页链接：http://www.wenchong.space/ </li>
                <li>主页链接：http://www.wenchong.space/ </li>
                <li>主页介绍：回过头来看，那些让你寝食难安的事，大多败给了想象，加油干，没那么难 </li>
                <li>git仓库：https://wwww.github.com/Langwenchong</li>
                <li>QQ：1422257646</li>
            </ul>
        </div>

        </div>
  
  {##########################}
  {### END LINKS BLOCK ###}
  {##########################}
{% endblock %}
```

保存并退出

#### 引入links.swig

进入path/themes/next/layout/，打开page.swig（如果没有请在附近文件夹查找，略有出入属于正常现象）

我们先在这里（大约13行附近）

![](https://pic.imgdb.cn/item/5fcdd67b3ffa7d37b3afec89.jpg)

添加红框所包围代码，这里直接复制粘贴即可

```SAS
  {%- elif page.type === 'links' and not page.title %}
    {{- __('title.links') + page_title_suffix }}
```

然后在这里（大约62行附近）

![](https://pic.imgdb.cn/item/5fcdd7363ffa7d37b3b08b7f.jpg)

添加红框所包围代码，这里直接复制粘贴即可

```SAS
        {% elif page.type === 'links' %}
          {% include '_links/links.swig' %}
```

保存并退出。

#### 添加友链选项

打开主题配置文件\_config.yml(path/themes/next/\_config.yml)，拉到最下方末尾处，添加如下代码：

```yml
- name: Chong's Blog #友链名称
  avatar: http://wenchong.space/images/author.jpeg #友链头像
  site: http://www.wenchong.space/ #友链地址
  info: 回过头来看，那些让你寝食难安的事，大多败给了想象，加油干，没那么难 #友链说明
  warehouse: https://wwww.github.com/Langwenchong #git个人主页
  qq: http://wpa.qq.com/msgrd?v=3&uin=1422257646&site=qq&menu=yes
  background: https://pic.imgdb.cn/item/5fcdd8a93ffa7d37b3b1b0c9.jpg #博客页面预览
```

既然都用博主大大的友链页面啦，交个朋友加上我的友链不过分吧，嘿嘿😆（当然加上我的友链了记得在评论区或私信我加上你的友链，祝我们友谊长存🍻）。

上面的几个选项分别是博客站名，博主头像链接，博客介绍，博主git个人主页，向博主发起QQ临时对话和友人页面预览，推荐所有选项全部加上（如果你是小萌新的话），一定不要删除那个小横线啊喂~

#### 布置跳转按钮

还是这个_config.yml下寻找nemu，加入下面这个选项：

![](https://pic.imgdb.cn/item/5fcdda203ffa7d37b3b30d72.jpg)

保存退出。综上，你已经完成了web端友链部署啦，输入以下指令

```gas
hexo clean
```

```gas
hexo g
```

```gas
hexo s
```

即可本地查看友链页面效果啦，记住一定要严格按照上面的指令启动服务，因为swig重新渲染是需要重新生成的，切不可偷懒。

### 【进阶】移动适配+魔改

#### 移动适配

如果web端成功了的话，你会发现随着窗口缩小页面发生了分布混乱的现象，因为我们还没有进行移动适配，这里我们需要进行移动适配，说来也简单，我们只需打开path/themes/souce/css/_schemes/Muse/layout.styl（注意，如果你使用的不是Muse样式的next主题，请选择自己的相对应的主题，如Gemini等，如果很不幸你使用的不是Next主题，那么最暴力的写法就是直接打开path/souce/css/main.styl进行编写），在末尾处粘贴下以代码：

```css
#links .container .card{
  +mobile(){
    box-shadow: none!important;
    background:rgb(22, 22, 35,.9)!important;
    height:400px!important;
  }
}

#links .container .content .contentBx h3, #links .container .content .contentBx span{
  +mobile(){
    color:#fff!important;
  }      
}
#links .container .sci li {
  +mobile(){
    transform: translateY(0px)!important;
    opacity: 1!important;
  }
}
#links .container .card .content {
  +mobile(){
    opacity: 1!important;
    transform:translateY(-20px)!important;
  }
}
#links .container:hover .card{
  +mobile(){
    left:50%!important;
    transform: translateX(-50%)!important;
  }
}
#links .container:hover .card img{
  +mobile(){
    transform: rotate(0deg)!important;
  }  
}
#links .container .card-hidden{
  +mobile(){
    display:none;
  }
}
.lb{
  +mobile(){
    justify-content: none;
    flex-wrap: wrap;
    height:auto!important;
  }
}
.lb a{
  margin-bottom: 45px!important;
}
```

保存退出，在重新三部曲指令查看应该就可以实现移动适配啦（手机端可能官方链接处略有偏移的小bug,暂时未能解决，请期待再次更新吧）。

#### 魔改

如果你仔细观察你会发现官方链接处是写死的，没错，我就是懒，所以这里并没有写成下方动态增加删减的形式，如果你觉的你不想感谢上述的官方地址，那么完全可以自己更改，更改规则如下：.lb元素块报过来所有的a链接块，每一个a链接块如下：

![](https://pic.imgdb.cn/item/5fcddd5e3ffa7d37b3b57598.jpg)

这里的--color:#FDCB6E是颜色啦，你可以更改为自己喜欢的颜色，注意是修改--color:后面的颜色值代码，i标签是图标了，你也可以更改，这里我使用的是fontawesome上的图标，更改图标只需更改class属性即可，你可以去fontawesome.com上寻找自己心仪的图标（但貌似是得科学上网，否则上不去，祝你成功！）

如果你是就不想感谢官方链接（相信我，你是我见过最冷写无情的人哈哈哈哈），那么就直接在links.swig中将.lb{display:flex}设置为none即可，或者删除这段html也可以（如果你有前端基础的话，否则不要轻易尝试）

\#links .container包裹的是知己博客的每一个小卡片，.lb包裹的是官方感谢链接，我在这里将他们宽度都设置为了100%，所以宽度会动态改变，如果你觉得不美观完全可以自行修改，但是改不回来了自己负责。

### 反思

这是第一次自己编写hexo页面，纯100%手写属实难搞，但是感觉对于拥有一定前端基础的小伙伴来说是一次锻炼自己的技术，了解hexo静态渲染的好机会，虽然过程艰辛，但是收获颇多，这里仅写下我的思考，如有错误，请谅解：我们发现实际上hexo就是根据_config.yml的data来进行页面类型和组件功能是否开启等判断然后进行渲染页面，并且每一个page对应着一个type属性，page.swig则是根据这个type属性进行不同的swig模块引入来渲染页面，swig就是有点像vue里的组件化的意思，他只是为不同的子页面提供一个大纲，一个渲染的规则，然后不同的页面根据不同的swig规则呈现不同的页面，当然这里的每个swig的css样式最终貌似都会被写入一个总的style文件里，这个style文件就是main.style，我们可以通过下图来确定：

![](https://pic.imgdb.cn/item/5fcde0933ffa7d37b3b7ea52.jpg)

他们最终都被写入了main.css文件，所以我们知道所有主体部分的css代码最会都会写入到main.css中去，所以我在上文中推荐不是next主题的小伙伴将移动适配的代码最终写入到main.styl文件中去，然后为了避免出现优先级冲突问题，我们将自己的移动适配的css代码全部加上了!important来提升优先级。至于动态渲染，也与vue思路类似，从theme.friendlinks获取一个大的数据集，然后用for循环来进行渲染，参数全部都是用双大括号包裹，组件化程度叹为观止，可能这就是nextv8.0+取得的最大的进步，当然带来的麻烦也是必不可少的（寻找bug可是够费劲，毕竟代码利用率提高，代码分散性强，动一处而牵全身😵），那么本次发分享就告于段落啦，希望你有所收获！）