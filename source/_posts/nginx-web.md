---
title: 浅谈vue项目部署到nginx
comments: false
top: false
date: 2021-10-18 18:32:42
tags: [nginx]
categories: 
	- [知识分享,学习心得]
headimg: https://langwenchong.gitee.io/figure-bed/20211018222848.png
---
针对小白的快速前端vue项目打包部署教程，包含二级域名解析配置以及https认证等，还不赶快进来看看👀？

<!-- more -->

### 前言

由于我最近写了一个基于vue实现的代码缺陷自动检测的前端项目，又恰巧买了一个腾讯云服务器，因此想借此机会尝试部署到nginx上，但是博客已经占用了 `wenchong.space`域名，因此想尝试部署到二级域名上，但是查阅了csdn上众多 `水文`后，发现大部分内容实在是晦涩难懂、一言难尽😅。幸好chongchong最终耗时一晚成功部署到了服务器上，为了防止以后忘记，也为了让电脑前的你能够少走点弯路，因此诞生了这篇博文。如果你对我的代码缺陷检测项目感兴趣，请点击下方链接查看哦~

{% link  代码缺陷自动监测,https://compile.coolchong.cn/#/CodeEditor, %}

### 准备工作

在部署之前，我们需要进行一些准备工作，您可以参考我下方给出的清单:

{% checkbox  green checked, 拥有一个待部署的vue项目 %}

{% checkbox  green checked, 拥有一个云服务器，最好是centOS6以上%}

{% checkbox  green checked, 服务器上已经安装了nginx %}

{% checkbox green checked, 拥有一个域名 %}

{% checkbox  green checked, 拥有xshell和xftp软件%}

可能你还没有xshell和xftp软件，不用担心，你无需去冒着风险下载破解版本，NETSARANG公司已经提供了个人免费版本，你只需要点击下方链接简单填写姓名和邮件即可下载：

{% link xshell和xftp下载,https://www.netsarang.com/zh/free-for-home-school/, %}

![](https://langwenchong.gitee.io/figure-bed/20211018185733.png)

### vue项目打包

准备工作完成后我们首先要将待部署的vue项目进行打包，因为在我们开发时使用的是vue文件，方便进行热加载随时动态更新我们的修改，但是在部署到服务器后我们只需要放置静态的html资源即可，因此我们首先要进行vue的打包，打包步骤很简单，照着下面操作即可。

#### 1.修改资源路径

我们首先打开 `config/index.js`文件，然后在build环境下加入 `assetsPublicPath:'./`如下图：

![](https://langwenchong.gitee.io/figure-bed/20211018190331.png)

然后为了保证静态的资源(包括图片，elementui组件的icon图标等）正常加载显示，我们需要打开 `build/utils.js`文件，然后在 `fallback`下加入 `publicPath:'../../'`如下图：

![](https://langwenchong.gitee.io/figure-bed/20211018190624.png)

#### 2.关闭跨域代理

在开发时，我们为了解决前后端跨域问题，修改 `proxyTable`,但是部署到服务器后项目统一放置在一个文件件内，是无需在配置跨域代理，因此我们将 `config/index.js`文件的 `proxyTable`处的 `'/api'`后面的代码注释掉：

![](https://langwenchong.gitee.io/figure-bed/20211018204655.png)

#### 3.项目打包

新建终端，输入 `npm run biuld`打包项目，项目会生成一个index.html文件和一个用来存储静态依赖的static文件夹，统一放置在dist文件夹下如下图：

![](https://langwenchong.gitee.io/figure-bed/20211018205119.png)

自此我们就已经完成了vue项目的打包了，然后我们打开这个index.html查看能否正常显示页面，当不是一篇空白正常显示时即说明打包完成了。同时如果你是用了elementui组件库的话，请检查icon图标是否也能够正常显示。

### vue项目部署到nginx

接下来我们就需要通过xshell和xftp远程连接我们的服务器了，然后将打包好的dist文件夹放到特定的位置再修改一下nginx.conf文件的配置重启服务即可了。请参考下面步骤进行：

#### 1.xshell连接远程服务器

首先如果你是第一次使用xshell的话需要新建一个会话，即记录一下这个会话连接的是你的那个服务器，如下图是配置界面：

①首先我们需要填写我们要连接的服务器的相关信息

![](https://langwenchong.gitee.io/figure-bed/20211018205823.png)

②然后我们点击用户身份验证，需要填写用来登录服务器的身份验证的账号和密码，这个根据你当时配置的账号名和密码填写即可：

![](https://langwenchong.gitee.io/figure-bed/20211018210017.png)

③连接服务器

然后我们保存配置双击这个会话即会连接服务器，当成功连接以后会话界面左上角会呈现绿色，并且终端处于等待输入指令的状态：

![](https://langwenchong.gitee.io/figure-bed/20211018210732.png)

#### 2.xftp连接远程服务器

①首先配置也和xshell类似我们先新建一个会话，然后和xshell一样填写相关的配置信息：

![](https://langwenchong.gitee.io/figure-bed/20211018211152.png)

②保存配置后双击连接服务器，如果成功后可以得到下图图示，左侧是当前本地电脑的文件目录，右侧是远程服务器的文件目录：

![](https://langwenchong.gitee.io/figure-bed/20211018211426.png)

#### 3.将dist文件夹放置到远程服务器

我们会发现这个服务器里有许多文件夹，那么dist文件夹放到哪里比较好呢？我推荐你和我一样，将所有我们上传的项目统一放到 `/home`路径下，如下图我的博客，还有前端项目都放到了这里：

![](https://langwenchong.gitee.io/figure-bed/20211018211643.png)

为了方便区分多个文件夹，我们可以将dist更改名称易于区别，例如我这里的代码缺陷自动检测项目就是将dist文件夹更名为了compile文件夹。上传的文件的操作很简单，拖拽上传即可：

![](https://langwenchong.gitee.io/figure-bed/20211018211837.png)

#### 4.配置nginx二级域名解析

我们现在已经将项目文件夹放到了服务器上了，但是现在还不能通过域名解析访问到这个项目，因此接下来我们需要修改nginx配置。如果你还没有nginx也不用担心，上网百度一下安装即可，就是几行指令就轻松安装了。由于我已经使用了 `wenchong.space`作为了博客的解析域名，因此这里我将演示如何部署到二级域名 `compile.wenchong.sapce`下，当然一级域名部署也类似。

①去dns解析平台新建二级域名，首先我们需要创建一个新的二级域名以便后面分配给这个项目，我用的是腾讯云，这里以腾讯云演示，登录腾讯云dns平台后进行域名解析管理，然后新建解析一定要保证是A类型，然后主机记录就是二级域名名称，线路类型默认就行，重点是记录值一定要填写服务器的公网ip如下图：

![](https://langwenchong.gitee.io/figure-bed/20211018212807.png)

②保存这个新添加的解析并且开启解析，然后我们去配置 `nginx.conf`，在xftp中按照 `/etc/nginx/`找到nginx.conf文件，然后右键以记事本形式打开，我们填写如下代码到最下方：

```conf
server {
		#监听端口号,一般就用80,别标新立异
        listen      80;
        #要分配的域名
        server_name compile.wenchong.space; 

		#默认是根路径/
        location / { 
        	#指向的项目文件夹就是我们刚刚传的dist文件夹的位置
            root    /home/compile;
            #入口文件，肯定是index.html啦
            index   index.html;
        }
    }
```

然后保存退出，自此我们就完成了nginx的配置。

③重启nginx服务，由于我们修改了nginx的配置，因此我们要重启服务，打开xshell，输入以下指令首先进入到nginx

```
cd /etc/nginx
```

④然后我们输入如下指令检查nginx配置是否语法正确

```
nginx -t
```

如果没有语法错误则会出现如下信息

```
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```

⑤然后我们输入如下指令重启nginx服务

```
systemctl restart nginx.service
```

当没有任何响应时及说明重启成功，然后我们输入刚刚填写的二级域名 `compile.wenchong.space`会发现已经成功部署可以正常解析了：

![](https://langwenchong.gitee.io/figure-bed/20211018214020.png)但是我们会发现有一点小问题，即上方提示此页面不安全，这是因为使用的是http而非https，当我们输入https开头时会发现无法正常加载，这是因此我们还没有为这个新的二级域名配置ssl证书，因此无法使用https。

#### 5.为二级域名配置https(选做)

如果我们要追求完美，那么还需要再配置一下https的证书。操作很简单如下：

①前往腾讯云申请证书，腾讯云可以为我们提供一年免费的ssl的证书，首先我们进入官网首先然后在云产品中选择ssl证书到达如下界面：

![](https://langwenchong.gitee.io/figure-bed/20211018214354.png)

然后我们点击左侧 `我的证书`一栏既可以看到当前我们已经拥有的证书，这里选择申请免费证书使用默认的亚洲诚信即可：

![](https://langwenchong.gitee.io/figure-bed/20211018214705.png)

![](https://langwenchong.gitee.io/figure-bed/20211018214836.png)

然后我们下一步后会获得一个txt记录类型记录需要添加到域名解析处，直接按照腾讯云推荐自动添加即可，添加完成后我们就会得到一条新的域名解析记录如下图：

![](https://langwenchong.gitee.io/figure-bed/20211018215313.png)

然后我们继续下一步等待5分钟后一般就审核通过了，然后会跳转到一个提供下载zip压缩包的页面，我们需要下载这个压缩包，里面有我们需要配置到nginx、tomcat或者Apache的内容，我们解压缩后只需要使用里面nginx文件夹下的内容，里面会有两个东西，一个是crt证书，另一个是key文件，我们使用拖拽的方法将两个文件放置到xftp连接的远程服务器文件目录中的 `/etc/ssl`下如下图：

![](https://langwenchong.gitee.io/figure-bed/20211018215834.png)

②然后我们需要再配置一下 `nginx.conf`文件，之前我们http使用的是80端口监听，而https一般是443，我们在 `nginx.conf`最下面再写一个新的server代码如下：

```
server {
		#https使用443监听
        listen      443 ssl;
        #注意填写自己的二级域名
        server_name compile.wenchong.space;

		#下面两行的xxxx出改为自己的域名，值和server_name一样即可
         ssl_certificate /etc/ssl/1_xxxxx.crt;
        ssl_certificate_key /etc/ssl/2_xxxxx.key;
        ssl_session_cache shared:SSL:1m;
        ssl_session_timeout  10m;
        ssl_ciphers PROFILE=SYSTEM;
        ssl_prefer_server_ciphers on;
        location / {
        	#注意指向dist路径该改为自己的
            root    /home/compile;
            index   index.html;
        }
     }
```

③然后我们在输入如下指令重新启动nginx服务

```
#检查nginx配置是否正确
nginx -t
#重启nginx服务
systemctl restart nginx.service
```

④重启成功后，我们在搜索引擎搜索栏中输入https开头的二级域名就可以安全解析到之前的项目了，并且此时浏览器会提示此页面安全了！

![](https://langwenchong.gitee.io/figure-bed/20211018220319.png)

### 反思与总结

在经过这次配置后总算是对服务器相关的nginx服务有了一定的了解了。这里给出我的一些理解，实际上server就是服务的意思，因此当我们需要使用nginx配置不同域名、不同端口时都需要重新新建一个server，server_name是匹配的域名，一般是可以匹配到的并且优先匹配优先使用这个server进行服务，但是当我们在nginx.conf中未找到dns中添加的域名记录时，那么会默认使用第一个或者是标记为默认的server进行解析。这也是为什么我的博客在nginx中没有添加 `www.wenchong.space`的server也可以正确解析到博客的原因，因此我server_name为 `wenchong.space`的server标记为了默认服务，因此当输入 `www.wenchong.space`时dns解析发现有这条记录却并没未在nginx中找到对应匹配的服务就会抛给默认server进行服务因此解析到了 `wenchong.sapce`即博客地址了。同时这次我使用的是二级域名指向不同项目的方法来部署的，但是不同的项目实际上有三种不同的方法进行部署，这里我只使用了最常用的方法，另外两种可以参考这篇文章

{% link nginx部署多个项目,https://www.cnblogs.com/zhaoxxnbsp/p/12691398.html, %}

同时本篇博客的理解参考了如下文章，特此鸣谢：

{% link nginx心得,https://www.cnblogs.com/zhaoxxnbsp/p/12691398.html, %}

最后我想说，虽然第一次配置的过程异常痛苦，但是相比于日日夜夜进行crud操作，我认为大学生多勇于尝试探索新事物更加有意义！祝愿你我都能够坚守乐于学习的初衷，早日成为传说中的大牛！
