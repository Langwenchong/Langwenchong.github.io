---
title: 前后端跨域请求解决策略
comments: false
top: false
date: 2022-01-11 14:33:09
tags: [跨域]
categories: 
	- [知识分享,学习心得] 
headimg: https://langwenchong.gitee.io/figure-bed/20220111161316.png
---

在前后端分离开发的项目中，我们总是会遇到请求跨域的问题，每一次都避免不了开发人员之间的对线，为了缓解同事友谊，翀翀特此提供一篇完美解决前后端跨域请求的攻略😉~

<!-- more -->

### 什么是跨域

我们在进行本地前后端项目的接口对接或者是项目打包部署到线上以后（但是前后端项目部署到了不同的服务器上），那么此时就可能会出现跨域的问题，他总是出现如下的报错：

<img src="https://langwenchong.gitee.io/figure-bed/20220111144458.png" style="zoom:150%;" />

如上所示，控制台警告信息中提示我们这个从本地`http://localhost:8080`发起的向`http://api.cheeseburgerim.space/api/user/login`的请求被跨域限制策略所阻挡了，并且如果想要通过请在请求函数中添加一系列请求头，但是往往我们在添加以后仍然不能解决。

如果想要解决这个跨域问题，我们首先需要了解跨域请求被阻拦的原因：

#### 跨域请求产生的原因

我们首先要了解什么是`跨域`,跨域是因为浏览器的同源策略限制，是浏览器的一种安全机制，服务端之间就不会产生跨域的。所谓`同源`就是指两个页面具有相同的协议，相同的主机和相同的端口，三者之中有一个不同的时候就会产生跨域。如下所示：

|        当前页面url        |          被请求页面url          | 是否跨域 |             产生原因             |
| :-----------------------: | :-----------------------------: | :------: | :------------------------------: |
|   http://www.test.com/    | http://www.test.com/index.html  |    否    | 同源（协议、域名、端口号均相同） |
|   http://www.test.com/    | https://www.test.com/index.html |    是    |      协议不同（http/https)       |
|   http://www.test.com/    |      http://www.baidu.com/      |    是    |     主域名不同（test/baidu）     |
|   http://www/test.com/    |      http://api.test.com/       |    是    |       子域名不同（www/api)       |
| http://www.test.com:8080/ |      http://test.com:7001/      |    是    |      端口号不同（8080/7001)      |

{% note info,

我们可以总结出不产生跨请求域的条件是：①协议必须一致②域名必须完全相同③端口号必须一致

%}

#### 简单请求/非简单请求

然后接下来我们再来了解一下简单请求和非简单请求，在有时候我们会发现请求发出以后在控制的network栏监控处可以发现有些请求明明应该只执行一次，但是实际上他会执行两次，这是因为它属于非简单请求，此时会先发送一个预检验请求如下所示：

![](https://langwenchong.gitee.io/figure-bed/20220111150522.png)

我们在一些传送复杂文件的请求A中就会发现在这个请求发送之前，他会先发送一个如上所示的OPTIONS请求并且通常返还的是200，包括了响应请求的信息即对方服务器关于请求的一些限制信息，然后接下来才会发送这个真正的传输文件的请求A，如果不满足对方的要求就会报错。

##### 简单请求

但是一般情况下我们使用的都是简单请求，他包括：

1. 请求方法为：HEAD、GET、POST中的一种
2. HTTP请求头中字段不超过：Accept、Accept-Language、Content-Language、Last-Event-ID
3. Content-Type字段值为application/x-www-form-urlencoded、multipart/form-data、text/plain中的一种

##### 非简单请求

对于简单请求不会发起预检验请求，而以下的这些就是非简单请求，他在请求真正发起之前会先进行预检验请求可以获取到服务器设置的响应请求信息以及对发起请求的限制：

1. 请求方法为PUT、DELETE
2. 发送JSON格式的ajax请求
3. http中带自定义请求头

##### 简单请求的跨域

对于简单请求，如果浏览器发现是跨域请求，就会自动在请求头中加入Origin字段，代表请求来自哪个域（协议+主机名+端口号），服务器收到请求以后，根据请求头中Origin中字段值来判断是否允许跨域请求通过。如果想要解决跨域问题，只需要在服务器的响应头Access-Control-Allow-Origin字段中设置指定的域名，表示允许这些域名的跨域请求。如果请求头中Origin字段的域名包含在这些域名中，则可以实现跨域请求（当然有时候还需要结合其他字段来判断），否则不通过。

##### 非简单请求的跨域

而对于非简单请求的跨域，会先发送一次“预检”（OPTIONS)请求。预检请求会事先询问服务器，当前域名是否在服务器允许的范围内，以及可以使用那些HTTP动词和信息字段。只有得到肯定答复以后，浏览器才会发出真正的HTTP请求，否则就会报错。

{% note info,

了解完以上的信息以后，我们会发现无论是哪种跨域，实际上解决办法就是两种策略：①代理请求端使其请求源和服务端一致②后端服务器配置请求允许不同源的请求

%}

### 开发环境解决跨域

在开发环境中我们可以向后端大大为我们配置跨域允许，这样我们前端就无需在配置任何东西了，但是俗话说的好：“自己动手，丰衣足食”，我们才不要作一个看后端开发脸色的前端攻城狮🤣，因此我们可以在开发环境中在前端自己解决跨域问题：

{% note info,

要注意，如果你在开发时使用POSTman进行接口的调试工作，那么请注意POSTman是默认永远不会产生跨域的，因此如果你的请求在POSTman中请求成功了并不一定就不会产生跨域而被浏览器所拦截。

%}

#### 策略一：chrome插件代理

在前端配置解决跨域的策略无非就是使用代理，让我们的请求在被封装以后能够以同源的身份被后台服务器所能允许接收，此时我们可以使用代码进行配置，但是如果你是小白的话，完全可以试一试这种使用插件代理的方法：

这里给出插件的百度网盘地址

{% link 提取码：wssb, https://pan.baidu.com/s/1koaZyGBNhKp6uZOVlTP5iQ %}
下载完成以后，在chrome中打开扩展程序选择开发者模式将这个插件进行安装：

![](https://langwenchong.gitee.io/figure-bed/20220111153354.png)

安装完成以后将会这个插件开启并置顶，那么我们就可以使用这个插件进行代理了：

![](https://langwenchong.gitee.io/figure-bed/20220111153607.png)

#### 策略二：vue中proxyTable代理

如果你前端使用的是vue框架，那么可以试试这种方法，即使用vue提供的ProxyTable进行代理从而实现同源请求，假设现在我们要请求的是一个登录接口：`https://api.coolchong.cn/api/user/login`,同时其他的请求接口也类似比如注册是`https://api.coolchong.cn/api/user/register`等等，而我们本地开发时热加载预览的地址是`http://localhost:8080`, 此时为了解决跨域，我们需要将我们的源也代理成`https://coolchong.cn`，此时我们就可以使用proxyTable，如果你的vue也是2.x版本那么可以直接在`/config/index.js`中找到如下代码，如果是vue3.x那么也可以在类似的路径中找到：

![](https://langwenchong.gitee.io/figure-bed/20220111154211.png)

```js
 // Paths
    assetsSubDirectory: 'static',
    assetsPublicPath: '/',
    proxyTable: {
      '/apis': {
        target: 'https://api.coolchong.cn', // 你要代理的域名和端口号，要加上http
        changeOrigin: true, // 跨域
        pathRewrite: {
          '^/apis': '' // 这里用‘/apis’代替target里面的地址，组件中调用接口时直接用api代替 比如我要调用'http://xxx.com:8080/api/NEWS/getNews.json?page=1&pageSize=10'，直接写‘/api/NEWS/getNews.json?page=1&pageSize=10’即可
        }
      }
    },
```

{% note info,

一定要注意修改的是dev即开发环境下的proxyTable，不要改错了。同时当修改了配置以后需要重启这个项目才能加载新的配置。 

%}

配置完成以后，如果此时我们再在本地请求这个接口时，使用`/apis/user/login`代替`https://api.coolchong.cn/api/user/login`,用`/api/user/register`代替`htts://api.coolchong.cn/api/user/register`即可。如下我用axios来演示一下写法：

![](https://langwenchong.gitee.io/figure-bed/20220111154707.png)

自此我们就完成了开发环境下前端解决跨域问题的配置。

### 部署线上解决跨域

但是我们会发现上面这种方法只适用于本地开发调试环境时使用，一个项目真正打包完成部署上去还是会面临跨域，因此接下来我们讲一讲后台的配置来解决项目打包部署线上的跨域问题解决策略。此时我们还是以上面的例子作为讲解。

我们知道实际上前端最终要进行请求的接口还是`https://api.coolchong.cn/api/user/login`，因此我们在完成开发以后部署前先将axios的默认地址baseURL更改回：

![](https://langwenchong.gitee.io/figure-bed/20220111155211.png)

同时在项目打包前将代理proxyTable注释掉：

![](https://langwenchong.gitee.io/figure-bed/20220111155251.png)

那么很显然此时项目的所有请求都会处于跨域状态，但是不用担心，此时我们是在后端解决跨域，因此前端可以直接打包部署了，具体流程参考本篇博客：

{% link vue项目部署, https://blog.coolchong.cn/2021/10/18/nginx-web/ %}

接下来我们进行后端的配置，此时的跨域解决策略就是后端允许任何不同源的请求进行响应，操作很简单，我们只需要为项目添加一个`/configuration/WebMvcConfig.java`配置类，代码如下：

![](https://langwenchong.gitee.io/figure-bed/20220111155749.png)

```java
package com.example.deliverysystem.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @Author Lang wenchong
 * @Date 2021/12/25 21:55
 * @Version 1.0
 */


@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowCredentials(true)
                .allowedOriginPatterns("*")
                .allowedMethods("GET", "POST", "PUT", "DELETE")
                .allowedHeaders("*")
                .exposedHeaders("origin");

    }
}

```

这样我们再将后端代码打包成jar包部署到服务器即可，此时前后端部署的主机不同也不会产生跨域请求了，解决了线上部署环境下的跨域问题。