---
title: Docker入门笔记(2)
comments: false
top: false
date: 2021-11-22 13:52:01
tags: [docker]
categories: 
	- [知识分享,学习心得]
headimg: https://langwenchong.gitee.io/figure-bed/20211128205510.png
---

记录翀翀入门docker的笔记，如果你也是小白，快来和我一起学习docker吧😉！

<!-- more -->

{% note quote,

从本篇开始，翀翀将开始记录学习docker时的笔记，参考的教程是[《狂神说docker》](https://www.bilibili.com/video/BV1og4y1q7M4?p=1)，这里由衷感谢狂神大大无微不至的讲解！

%}

### 可视化管理工具——portainer

```shell
#首先我们需要下载portainer镜像
[root@VM-0-7-centos ~]# docker pull portainer/portainer
Using default tag: latest
latest: Pulling from portainer/portainer
94cfa856b2b1: Pull complete 
49d59ee0881a: Pull complete 
a2300fd28637: Pull complete 
Digest: sha256:fb45b43738646048a0a0cc74fcee2865b69efde857e710126084ee5de9be0f3f
Status: Downloaded newer image for portainer/portainer:latest
docker.io/portainer/portainer:latest
[root@VM-0-7-centos ~]# docker images
REPOSITORY            TAG       IMAGE ID       CREATED        SIZE
nginx                 latest    ea335eea17ab   3 days ago     141MB
centos                latest    5d0da3dc9764   2 months ago   231MB
portainer/portainer   latest    580c0e4e98b0   8 months ago   79.1MB
#创建一个容器运行服务，这里我暴露到了外网的9000端口
[root@VM-0-7-centos ~]# docker run -d -p 9000:9000 --restart=always -v /var/run/docker.sock:/var/run/docker.sock --name prtainer01  portainer/portainer
```

然后我们就可以在`http://ip:9000`上看到portainer可视化面板了如下图所示，首先我们需要创建账号然后就可以登录了

![](https://langwenchong.gitee.io/figure-bed/20211121140602.png)

然后我们选择本地local选项即可，因为一般我们都是单机测试使用的

![](https://langwenchong.gitee.io/figure-bed/20211121140723.png)

然后我们就进入到了管理面板，映入眼前的有我们非常熟悉的镜像、容器等展示，我们可以在这里使用UI进行容器、镜像的管理，比如查看日志、进入容器的终端界面、删除创建、运行停止等等。

![image-20211121141053931](C:\Users\86159\AppData\Roaming\Typora\typora-user-images\image-20211121141053931.png)

### Docker镜像讲解

#### 镜像是什么

镜像是一种轻量级、可执行的独立软件包，用来打包软件运行环境和基于运行换开发的软件，它包含运行某个软件所需的所有内容，包括代码、运行时、库、环境变量和配置文件。所有应用，直接打包成docker镜像，就可以直接跑起来。那么我们如何获取到打包好的镜像呢？我们可以通过如下几种途径获取：

1. 从远程仓库下载
2. 朋友拷贝给你
3. 自己制作一个镜像DockerFile

#### Dokcer镜像加载原理

##### 联合文件系统

联合文件系统（[UnionFS](https://en.wikipedia.org/wiki/UnionFS)）是一种分层、轻量级并且高性能的文件系统，它支持对文件系统的修改作为一次提交来一层层的叠加，同时可以将不同目录挂载到同一个虚拟文件系统下(unite several directories into a single virtual filesystem)。

联合文件系统是 Docker 镜像的基础。镜像可以通过分层来进行继承，基于基础镜像（没有父镜像），可以制作各种具体的应用镜像。

另外，不同 Docker 容器就可以共享一些基础的文件系统层，同时再加上自己独有的改动层，大大提高了存储的效率。

##### Docker镜像加载原理

docker的镜像实际上是由一层一层的文件系统组成，这种层级的文件系统就是UnionFS。

bootfs(boot file system)：docker镜像的最底层是bootfs，主要包含bootloader（加载器）和kernel（内核)。bootloader主要是引导加载kernel，linux刚启动时会加载bootfs文件系统。这一层与典型的linux/Unix系统一样，包含bootloader和kernel。当boot加载完成后，整个内核就在内存中了，此时内存的使用权已由bootfs转交给了内核，此时系统也会卸载bootfs(减少资源浪费)。这里的加载，可以理解为，我们windows电脑开机时候，从黑屏到进入操作系统的过程。

rootfs(root file system)：在bootfs之上，包含的就是典型linux系统中的`/dev、/proc、/bin、/etc`等标准目录和文件。rootfs就是各种不同的操作系统发行版，比如Ubuntu、Centos等等。

![](https://langwenchong.gitee.io/figure-bed/20211121142822.png)

图中以一个debian系统为例，从左到右，分为3个过程:

1. 首先下载一个debian系统
2. 让安装了emacs，这是后可以看到在图1基础上加了一层image
3. 然后又安装了Apache,这时候就是在之前的基础上又加了一层image

这正验证了之前的那句话，**docker的镜像实际上是由层一层的文件系统组成的**。对于不同的的linux发行版本，bootfs基本是一致的，rootfs会有差别，**所以不同的发行版可以共用bootfs**。

平时我们安装虚拟机的CentOS都是好几个G，但是为什么Docker这里安装CentOS才200M呢？

```shell
[root@VM-0-7-centos ~]# docker images centos
REPOSITORY   TAG       IMAGE ID       CREATED        SIZE
centos       latest    5d0da3dc9764   2 months ago   231MB
```

这就是因为首先docker安装会优先安装最精简版的OS,同时对于一个精简的OS，rootfs可以非常小，只需要包含最基本的命令、工具和程序库即可。而更底层的bootfs并不需要镜像来携带安装，他可以使用主机的内核，因此没有了最浪费时间的引导加载过程，启动速度也就快了，同时大小也轻巧了许多。

#### 镜像分层理解

知道了镜像的加载原理，不妨再回头看下镜像分层的原理。之前提过，镜像下载的时候是分层下载的，有些层如果已经存在了，就无需再次下载。比如我下载一个redis的镜像。

![](https://langwenchong.gitee.io/figure-bed/20211121144215.png)

这种方式最大的好处就在于资源共享。比如有多个镜像都从相同的BASE镜像构建来的，那么宿主机只需要在磁盘上保留1分BASE镜像，同时内存中
也只需要加载一份BASE镜像，这样所有的容器都可以使用。另外，镜像的每一层都是可以共享的。我们可以通过`docker image inspect`来查看镜像的分层，比如我们现在查看刚才下在的redis镜像

```shell
docker image inspect redis:latest
```

![](https://langwenchong.gitee.io/figure-bed/20211121144412.png)

上面就是redis镜像的所有分层文件，因此所有的docker镜像都起始于一个基础镜像层，当进行修改或者增加新的内容时，就会在当前镜像之层上创建新的镜像层，如下图

![](https://langwenchong.gitee.io/figure-bed/20211122210158.png)

假如现在我们要制作一个镜像，这个镜像基于Ubuntu linux 16.04，那么这个也就是镜像的第一层，然后我们还要继续安装python包，那么就会在第一层之上创建第二个镜像层即python层，继续打补丁的话，就会在第二层python镜像层的基础上创建第三个层。

{%note info,

我们一定要注意镜像和镜像层的区别，在添加额外的镜像层时，镜像始终保持是当前所有镜像层的组合。

%}

![](https://langwenchong.gitee.io/figure-bed/20211122210209.png)

如上图所示这里有2个镜像层，第一个镜像层包含了3个文件，而镜像则是包含了两个镜像层的6个文件。**同时当需要对某个层文件进行更新操作时，并不是替换，而是使用更高一层的文件去覆盖旧文件。**如下图所示，如果现在我们需要更新第二个镜像层文件5，那么此时生成镜像中的文件会覆盖底层镜像中对应的文件，使得文件里更新版本为一个新镜像层添加到镜像中。

![](https://langwenchong.gitee.io/figure-bed/20211121145527.png)

此时这个镜像实际上有7个文件，但是我们从镜像外的角度来看，会认为他有6个文件，这是因为文件7覆盖而不是更换的文件5。即我们从外部的视角有点类似于搭盒子以后的俯视图，即如下图所示

![](https://langwenchong.gitee.io/figure-bed/20211121145823.png)

我们从外部看这个三层镜像层组成的镜像会认为没有文件5，但是实际上此时文件5并没有消失，他还存在于第二个镜像层，只是被更高层次的同功能的位置文件7覆盖了而已。

因此我们在下载一个镜像时并不是一次性下载完成的，而是逐层逐层的下载，当发现他需要的某些层已经在下方存在过了，那么他就无需再下载这个镜像层了。

{%note info,

同时我们还要记住docker的一个特点，即docker镜像都是只读的，当容器启动时，一个新的可写层被加载到镜像的顶部，这一层就是我们通常说的容器层，容器层之下的叫做镜像层。

%}

这样当我们这个我们修改过的容器为一个新的镜像时，实际上就是在原基础镜像的基础上又新添加了我们的操作层，但是别人下载我们的这个镜像时如果他之前已经安装了基础镜像层，那么根据分层的理论他就只需要下载我们的操作层即可了，效率大大提升！如下图

![](https://langwenchong.gitee.io/figure-bed/20211121151407.png)

#### commit镜像

```shell
docker commit 提交容器为一个新的副本

#命令和git原理类似
docker commit -m="提交的描述信息" -a="作者" 容器id 目标镜像名:[tag]
```

我们以tomcat测试为例，首先我们下载tomcat镜像，让创建并运行容器，但是会发现`webapps`下没有任何东西，这是因为他默认安装的是最精简的阉割版，我们需要把webapps.dist下的所有内容copy到webapps下。

```shell
[root@VM-0-7-centos ~]# docker run -it -p 8080:8080 tomcat
[root@VM-0-7-centos ~]# docker exec -it 866a0027304a /bin/bash
root@866a0027304a:/usr/local/tomcat# cp -r  webapps.dist/* webapps/
```

现在我们已经部署tomcat成功了，可以输入`http://ip:8090` 查看界面了：

![](https://langwenchong.gitee.io/figure-bed/20211121155805.png)

然后刚刚我们已经修改了在tomcat容器上进行了文件移动的操作了，那么我们现在就可以commit提交我们刚刚的修改了

```shell
#我们提交后命名为tomcatwenchong 1.0版本
[root@VM-0-7-centos ~]# docker commit -a="wenchong" -m="add webapps app" 866a0027304a tomcatwenchon:1.0
sha256:dfe08bc422460ad9dddf275c5f45f387fd4f2c6596991eb51da5a4df36975b6f
```

![](https://langwenchong.gitee.io/figure-bed/20211121161248.png)

然后我们就得到了我们自己的一个镜像，我们会发现它比tomcat要大一点点，这是因为我们在tomcat镜像的基础上加上了一个新的操作层。这也间接体现了镜像分层的原理。我们可以多次commit获得多个版本，和git commit类似。

### 容器数据卷

我们回顾一下之前的mysql容器有没有什么弊端。我们发现这个数据都是存储在mysql容器内部的，那么只要我们不小心删除了容器就会造成数据的永久丢失，这显然是很危险的，因此我们需要保证数据持久化存储在本地，即docker内部产生的数据可以同步到本地，这样删除容器后本地还会保留有数据，这就是`容器数据卷`的作用。

![](https://langwenchong.gitee.io/figure-bed/20211121184817.png)

{% note info,

使用容器卷技术不仅仅可以实现容器和外部主机的数据共享，同时多个容器之间可以通过挂载相同的主机路径实现容器间的数据共享。

%}

### 使用数据卷

#### 使用-v命令挂载

```shell
docker run -it -v 主机目录:容器目录

#如下我们将centos容器内部的home挂载到主机的/home/ceshi

[root@VM-0-7-centos home]# docker run -it -v /home/ceshi:/home centos /bin/bash
[root@c384462e385f /]# cd /home
[root@c384462e385f home]# ls
[root@c384462e385f home]# [root@VM-0-7-centos home]# 
[root@VM-0-7-centos home]# ls
ceshi  compile  demo  hexo  wenchong
[root@VM-0-7-centos home]# docker inspect c384462e385f
```

![](https://langwenchong.gitee.io/figure-bed/20211121190447.png)

接下来我们写一点东西测试一下是否真正实现了数据共享

![](https://langwenchong.gitee.io/figure-bed/20211121190857.png)

发现通过数据卷挂载以后确实实现了类似`共享文件夹`的功能。这样我们就可以保证容器的数据持久化存储了。并且当主机下修改这个目录，容器也会自动同步（即使容器没有运行）。如下图

![](https://langwenchong.gitee.io/figure-bed/20211121191510.png)

此时我们修改test.java后再查看容器内的内容

![](https://langwenchong.gitee.io/figure-bed/20211121191844.png)

并且此时如果我们删除容器，test.java也并不会丢失，还会存储在主机的`/home/ceshi`下，如下图所示

![](https://langwenchong.gitee.io/figure-bed/20211121192240.png)

{% note info,

要注意虽然删除容器后，主机的文件还会存在。但是如果删除了容器内的这个文件夹，那么主机上也会同步删除所有的数据文件。

%}

#### 实战：数据卷挂载安装mysql

这个实战非常常用，因为我们经常需要容器运行mysql进行数据管理，但是数据又需要本地存储，因此会用到卷技术。这里我们实战演练一下

```shell
#首先我们获取镜像，这里下载mysql:5.7
[root@VM-0-7-centos home]# docker pull mysql:5.7

#然后我们需要创建容器
#但是我们知道mysql需要创建账户，这里会用到如下命令
#（你可以在docker hub mysql手册中找到这个命令）

-d 后台运行
-p 端口映射
-v 数据卷挂载
-e 环境配置，这里配置了mysql的账户密码
--name 容器命名
[root@VM-0-7-centos home]$ docker run -d -p 3310:3306 -v /home/mysql/conf:/etc/mysql/conf.d -v /home/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 --name mysql01 mysql:5.7
```

自此我们就启动了一个mysql容器，并且注册了账号，密码为123456，同时容器向外暴露的端口是3310，那么接下来我们启动navicat工具尝试连接这个数据，填写完账号，密码和地址后我们会发现成功连接了这个容器内的数据库

![](https://langwenchong.gitee.io/figure-bed/20211121201210.png)

并且此时卷挂载成功，我们在主机`/home/mysql`下可以查看到data和conf文件夹

```shell
[root@VM-0-7-centos home]# ls
compile  demo  hexo  mysql  wenchong
[root@VM-0-7-centos home]# cd mysql
[root@VM-0-7-centos mysql]# ls
conf  data
```

接下来我们尝试navicat中操作为数据库建一个表test，然后我们进入数据存储目录data下发现确实容器这里确实同步了一个数据库test如下图

![](https://langwenchong.gitee.io/figure-bed/20211121201645.png)

这样我们就实现了在本地创建数据库后，容器内自动同步，实现了mysql数据的持久化本地存储，即使这时候删除容器也不会波及到数据。同时当我们再修改配置时，无需在连接服务器进入容器去修改配置了，而是可以直接在本地修改配置，远程服务器的容器将会自动同步这个配置，这样修改配置更加高效了😍。

#### 具名挂载和匿名挂载

之前我们使用-v挂载时总是声明了主机路径和容器路径，即如下图所示

```shell
docker run -d -P --name nginx01 -v /主机路径:/容器路径 nginx
```

这样我们就实现了把nginx01容器的一个路径挂载到主机的一个路径下，但是有时候我们并不想主动声明要挂载的主机路径，那么此时我们可以如下书写

```shell
docker run -d -P --name nginx02 -v /容器路径 nginx
```

![](https://langwenchong.gitee.io/figure-bed/20211121203747.png)

```shell
docker volume ls  查看所有卷
#这种就是匿名挂载，我们在-v时只写了容器内路径，不写主机路径
```

但是此时他挂载到了哪里呢？实际上未直接声明要挂在主句路径的卷都会默认放到docker下，这里我们为了方便验证，再学习一下具名挂载，具名挂载实际上也没有声明主句路径，但是他为这个新建的卷起了一个名字方便一会我们取寻找到他，格式如下

```shell
docker run -d -P --name nginx03 -v 卷名:/容器路径 nginx
```

![](https://langwenchong.gitee.io/figure-bed/20211121204448.png)

```shell
#然后我们查看juming-nginx这个卷默认存储的位置
docker volume inspect juming-nginx  查找juming-nginx卷的默认挂载地址
```

![](https://langwenchong.gitee.io/figure-bed/20211121204658.png)

{%note info,

具名和匿名卷都是没有指定挂载路径的，但是他们会默认挂载到` /var/lib/docker/volumes/xxxxx/_data,`下

%}

然后我们进入这个路径查看一下这个匿名卷是否真的取出了我们需要的conf.d以便后面和主机进行文件同步。

![](https://langwenchong.gitee.io/figure-bed/20211121205113.png)

我们通过具名挂载可以方便的找到我们的卷，后面我们就可以动态的挂载这个卷了，因此大多数情况下我们使用的都是具名挂载。

```shell 
#总结-v的写法
-v /容器内路径 #匿名挂载
-v 卷名:容器内路径 #具名挂载
-v /宿主机路径:/容器内路径 #指定路径挂载

#同时我们还可以为容器内设置权限
#当卷容器路径后面加上:ro那么这个文件就只能宿主机修改了，容器只能读此文件了
#当卷容器路径后面加上:rw那么容器可以读或者写这个共享文件(默认不写也是这个权限)
docker run -d -P --name nginx03 juming-nginx:/etc/nginx:ro nginx
docker run -d -P --name nginx03 juming-nginx:/etc/nginx:rw nginx
```

### DockerFile

dockerfile就是构建docker镜像的文件，因此是一个命令参数脚本。他的构建步骤如下

1. 编写一个dockerfile文件
2. docker build构建为一个镜像
3. docker run运行镜像
4. docker push发布镜像到远程镜像仓库平台（Docker hub 或者阿里云)

实际上官方的镜像也是用dickerfile构建的，比如docker hub上的centos镜像，我们点击他的标签就会跳转到对应的github仓库里面就是dockerfile文件。

![](https://langwenchong.gitee.io/figure-bed/20211122171422.png)

比如这里我们点击最新版本的latest标签，我们会发现他跳转到了如下的dockerfile界面，首先他使用指令`from scratch`提供最基础的镜像层，然后添加了centos最纯净版本，然后又添加了额外的指令集扩充并打上了标签，最终使用`bin/bash`完成运行。

![](https://langwenchong.gitee.io/figure-bed/20211122171622.png)

很多官方镜像都是基础包，很多功能都没有，我们通常都会搭建自己的镜像。只有自己制作的才是最适合自己的开发环境。因此我们可以构建自己的dockerfile来创建自己的docker镜像。

{% note info,

dockerfile类似于一个自动化执行指令不断创建commit镜像提交并最终打包发布的一个脚本，可以用来构建一个docker镜像。

%}

### DockerFile构建过程

#### 基础知识

1. 每一个保留关键字（指令）都必须是大写字母组成
2. 指令是从上到下顺序执行的
3. `#`表示注释
4. 每一个指令运行后会创建提交生成一个新的创建层

![](https://langwenchong.gitee.io/figure-bed/20211122172002.png)

dockerfile是面向开发，我们以后发布项目，就需要做镜像为我们的项目提供相对应的运行环境，此时我们就需要编写dockerfile文件，这个文件十分简单。项目交付由以前的`jar包`、`war包`等代码项目提交逐渐演化为了`docker镜像`代码项目+环境集成一体的阶段。因此Docker镜像逐渐成为企业交付的标准，必须要掌握。

##### 思考：DockerFile和Docker images的区别？

正如上文所述，dockerfile是docker images的构建文件，dockerfile定义了创建一个镜像的一切步骤，只要按照dockerfile中的指令执行即可构建生成一个我们最终所需要的docker镜像。而镜像就是最终我们需要发布和运行的产品，他直接包含了要运行的项目以及其需要的运行环境，因此保证了项目打包文件即拆即用，大大简化了运维部署的流程。

##### 思考：docker commit提交也可以完成自定义镜像构建，为什么还需要dockerfile?

我们回顾一下之前的docker commit是我们手动修改了一个容器，在上面进行了一系列的操作然后commit提交打包成一个新的镜像。但是当面临需要添加许多新的依赖，并且添加环境配置，端口暴露等复杂需求时，使用commit就略显麻烦和鸡肋了，因此我们需要一个自动化构建镜像的脚本文件，这就是dockerfile存在的价值。

#### DockerFile的指令

```shell
FROM 		#引入基础镜像 centos ubuntu等都是基础镜像，一些从这里开始构建
MAINTAINER 	#镜像是谁写的，姓名+邮箱
RUN			#镜像构建的时候需要运行的命令
ADD			#在基础镜像基础上添加其他功能
WORKDIR		#镜像的工作目录
VOLUME		#卷要挂载的目录位置
EXPOSE		#指定暴露端口（如果定义了，那么run创建容器时就无需在-p指定暴露端口）
RUN 		#需要运行的指令
CMD			#指定容器启动时要运行的命令（只有最终一个会生效，且可被替代）
ENTRYPOINT	#指定容器启动时要运行的命令（可以追加命令）
ONBUILD		#当构建一个被继承的DockerFile就会运行ONBUILD指令
COPY		#类似于ADD，将指定的文件拷贝到镜像中
ENV			#构建时设置环境便令
```

![](https://langwenchong.gitee.io/figure-bed/20211122173918.png)

#### 实战测试

![](https://langwenchong.gitee.io/figure-bed/20211122174033.png)

假设我们要自己创建一个centos镜像，我们在`/home`路径下创建`/home/dockerfile`用来存储我们创建的dockerfile文件。因为官方的centos镜像是最精简版的，许多我们平时需要的命令比如`vim`,`ll`等都是没有的，因此我们想基于官方的centos镜像基础上再添加一些指令。

![](https://langwenchong.gitee.io/figure-bed/20211122174859.png)

这里我们在centos基础上添加`vim`，`ifconfig`等指令，同时希望在启动运行后能够输入语句提示我们镜像已经构建

![](https://langwenchong.gitee.io/figure-bed/20211122175506.png)

编写完成后保存退出，然后我们运行这个dockerfile尝试构建我们自己的docker镜像如下图

![](https://langwenchong.gitee.io/figure-bed/20211122180107.png)

```shell
#运行dockerfile构建docker镜像
docker build -f dockerfile文件路径 -t 镜像名:[tag]
#然后会依次执行我们的指令，最终得到如下输出及说明运行构建镜像成功
Successfully built c5f9b92260c5
Successfully tagged mycentos:0.1
```

然后我们进行这个镜像的测试，创建一个对应的容器并查看刚刚我们添加的指令集是否安装成功

![exit](https://langwenchong.gitee.io/figure-bed/20211122181308.png)

{% note info,

要注意，ENV类似于map只是存储了不同的配置变量的具体值，而具体的首次进入路径设置是由WORKDIR完成的。

%}

同时我们还可以使用如下命令轻松查看这个自定义的镜像是如何一步一步构建完成的

```shell
docker history 镜像id
```

![](https://langwenchong.gitee.io/figure-bed/20211122181916.png)

#### CMD和ENTRYPOINT

```shell
CMD			#指定容器启动时要运行的命令（只有最终一个会生效，且可被替代）
ENTRYPOINT	#指定容器启动时要运行的命令（只有最终一个会生效，可以追加命令）
```

刚刚我们也运行了CMD指令，那么他和ENTRYPOINT具体是干什么的？又有什么区别呢？

##### CMD测试

我们再创建一个新的dockerfile命名为dockerfile-cmd-test，并且在里面添加`CMD`指令

```SHELL
FROM centos
CMD ["ls","-a"] #启动容器后面添加 ls -a打印全部内容
```

然后现在我们运行这个dockerfile文件生成一个新的镜像，并创建容器启动它，我们可以看到如下结果

```shell
[root@VM-0-7-centos dockerfile]# docker build -f dockerfile-cmd-test -t cmdtest .
Sending build context to Docker daemon  3.072kB
Step 1/2 : FROM centos
 ---> 5d0da3dc9764
Step 2/2 : CMD ["ls","-a"]
 ---> Running in d14c7e0b26d5
Removing intermediate container d14c7e0b26d5
 ---> 48fe3fde9750
Successfully built 48fe3fde9750
Successfully tagged cmdtest:latest
[root@VM-0-7-centos dockerfile]# docker run 48fe3fde9750

```

![](https://langwenchong.gitee.io/figure-bed/20211122203111.png)

因此CMD指令是容器创建成功并启动后会执行的指令。但是此时如果我们在启动时再追加一个`-l`参数使得启动后打印的操作变为`ls -al`，但是此时会发现报错了：

```shell
[root@VM-0-7-centos dockerfile]# docker run 48fe3fde9750 -l
docker: Error response from daemon: OCI runtime create failed: container_linux.go:380: starting container process caused: exec: "-l": executable file not found in $PATH: unknown.
```

这是因为此时`-l`参数并不是追加到了`ls -a`后面，而是直接替换了`ls -a`，因此此时相当于创建容器并启动容器后要运行的指令变成了`-l`，很显然容器并不知道这是个什么指令，因此报错了。因此如果我们在`CMD`的情况下向最后运行`ls -al`指令，需要全部替换，即创建并启动容器的指令应该是

```shell
docker run 48fe3fde9750 ls -al
```

##### ENTRYPOINT测试

这个指令就是解决了上面的弊端，他是允许直接为要运行的指令追加参数的。比如此时我们再创建一个dockerfile文件命名为dockerfile-cmd-entrypoint。然后在里面添加如下内容

```shell
FROM centos
ENTRYPOINT ["ls","-a"]   #这里使用了ENTRYPOINT代替之前的CMD                 
```

然后也是运行dockerfile创建镜像，然后创建并启动容器，正常情况下不加新的指令参数也是会正常执行`ls -a `指令的，和CMD没有什么区别。但是如果此时我们再后面追加一个`-l`，那么此时指令并不会被替换为`-l`而是追加这个参数变成了`ls -al`，因此此时可以正确执行命令得到如下结果

![](https://langwenchong.gitee.io/figure-bed/20211122204643.png)

DockerFile中许多命令都十分类似，我们需要了解他们的区别，CMD和ENTRYPOINT只是其中一组，我们要通过对比测试学习区分两个指令的不同点。

### 实战：Tomcat镜像构建

这次我们不再是基于已有的tomcat容器或者镜像进行操作构建一个tomcat新镜像了，而是完完全全使用压缩包原文件，引入并使用脚本自动化构建环境创建一个tomcat镜像。因此首先我们需要一个tomcat源文件压缩包，然后由于tomcat基于java运行，因此我们还需要一个jdk压缩包。这里我们可以前往[jdk官网](https://www.oracle.com/java/technologies/downloads/#java8)下和[tomcat官网](https://tomcat.apache.org/download-80.cgi)下载需要的tar.gz压缩包文件。这里博主宝宝贴心的提供我实操用的压缩包文件😁,密码是wssb

{% link 实验资源 , https://pan.baidu.com/s/1a6nOATjckhAOTAlVcrQSew %}

下载完成以后我们使用xftp上传到服务器上，这里我上传到了`/home/dockerfile/tomcat/`路径下,在编写之前我们需要先写一个声明文件为`readme.txt`，在tomcat下创建即可然后我们现在就开始编写dockerfile文件。此时tomcat文件夹文件如下

![](https://langwenchong.gitee.io/figure-bed/20211125202857.png)

我们要注意按照官方的规范写法，我们需要将容器构建文件命名为`Dockerfile`。这样我们之后运行dockerfile取构建镜像时服务器会自动寻找这个Dockerfile文件，前面不再需要添加`-f`选项了。接下来我们开始编写Dockerfile文件

```shell
#引入基本镜像
FROM centos
#创作者信息
MAINTAINER wenchong<1422257646@qq.com>

#把之前的说明文档readme.txt放到容器的/usr/local/下
COPY readme.txt /usr/local/readme.txt

#注意这里使用ADD而不是COPY是因为ADD可以解压缩
#同样解压缩后将文件夹放到容器的/usr/local/下
ADD jdk-8u311-linux-x64.tar.gz /usr/local/
ADD apache-tomcat-9.0.55.tar.gz /usr/local/

#安装vim指令集
RUN yum -y install vim

#pwd后账号的基础工作路径
ENV MYPATH /usr/local
WORKDIR $MYPATH

#这里是核心，他自动的使用之前添加的tomcat和jdk依赖文件
#自动搭建环境，这里就是使用脚本指令设置环境变量
#注意不同的版本略有区别，需要根据实际情况设置
ENV JAVA_HOME /usr/local/jdk1.8.0_311
#分号用来区分路径1和路径2
ENV CLASS_PATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV CATALINA_HOME /usr/local/apache-tomcat-9.0.55
ENV CATALINA_BASH /usr/local/apache-tomcat-9.0.55
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/lib:$CATALINA_HOME/bin

#希望tomcat运行后在容器内部的8080端口暴露
EXPOSE 8080

#最后每一次打开都会打印日志
#也是为了让他有一个前端进程，从而保证不会让容器自动关闭
CMD /usr/local/apache-tomcat-9.0.55/bin/startup.sh && tail -F /usr/local/apache-tomcat-9.0.55/logs/catalina.out
```

然后我们就完成了Dockerfile的编写，接下来我们就运行这个dockerfile来创建我们自己的diytomcat镜像，命令如下

```shell
#一定不要忘记最后面有一个.
#同时由于我们命名为了Dockerfile因此这里不需要-f选中dockerfile文件了
[root@VM-0-7-centos tomcat]# docker build -t diytomcat .
```

然后他就会逐行 指令去执行，最后我们得到如下图则说明镜像创建完成：

![](https://langwenchong.gitee.io/figure-bed/20211125205519.png)

接下来我们运行这个镜像来创建并启动一个diytomcat容器，指令如下

```shell
#有点长，我们依次解释
#首先-d 容器后台运行，由于我们设置了启动后打印日志的前端进程因此容器不会自动关闭
# --name 设置容器名称为diytomcat01
#然后-p 将容器内部8080端口映射暴露到宿主机的9090端口，这样我们可以在外部访问
#然后两个-v分别是挂载路径映射
[root@VM-0-7-centos tomcat]# docker run -d -p 9090:8080 --name diytomcat01 -v /home/dockerfile/tomcat/test:/usr/local/apache-tomcat-9.0.55/webapps/test -v /home/dockerfile/tomcat/tomcatlogs/:/usr/local/apache-tomcat-9.0.55/logs diytomcat
```

我们创建并启动成功以后，发现他确实没有自动关闭，同时我们进入这个容器输入`pwd`后发现默认的工作目录确实是`/usr/local`，同时输入`ls -ll`发现我们需要的tomcat和jdk的文件夹都存在，说明配置成功了

![](https://langwenchong.gitee.io/figure-bed/20211125210640.png)

然后我们再去访问`https://云服务器ip:9090`查看能否访问到tomcat入口页面，结果成功！

![](https://langwenchong.gitee.io/figure-bed/20211125210854.png)

那么接下来我们可以尝试发布项目了，由于我们做了卷挂载，因此我们可以直接在本地将项目放置到`/home/dockerfile/tomcat/test`文件夹下既可以自动同步到容器内tomcat的test目录下自动发布，也就意味着现在我们通过了卷挂载实现了本地项目编写完成后后远程容器内的tomcat自动部署项目😎!

![](https://langwenchong.gitee.io/figure-bed/20211125213045.png)我们进入本地的test路径创建一个WEB-INF目录，然后里面编写一个web.xml文件内容如下

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://java.sun.com/xml/ns/j2ee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee
         http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd"
         version="2.4">
 
</web-app>
```

![](https://langwenchong.gitee.io/figure-bed/20211125212155.png)然后我们再返回到test文件夹下编写一个入口页面，这里我们使用index.jsp文件实现，内容如下

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Hello World</title>
</head>
<body>
Hello World!<br/>
<%
	System.out.println("Hello Wenchong");
%>
</body>
</html>
```

编写完成，此时我们的本地test目录下新添加了一个入口页面indexjsp,由于使用了卷挂载，容器内的tomcat也会自动同步这个文件，因此此时我们输入`http:云服务器ip:90980/test`就可以立即看到这个页面自动部署成功了，如下图

![](https://langwenchong.gitee.io/figure-bed/20211125213638.png)

这就是使用卷挂载实现的项目自动部署，我们的nginx的nginx.conf配置文件也可以和本地的同步，这样每次我们都无需再去容器内部修改配置文件了，大大简化了修改流程。同时我们还可以通过查看本地的`tomcatlogs`时刻看到容器中tomcat的日志如下图

![ ](https://langwenchong.gitee.io/figure-bed/20211125214046.png)

每次有人访问和这个服务，我们tomcat都会在日志中打印信息，但是我们无需到容器内不去查看日志，而是通过卷挂载后只需通过本地的tomcatlogs下的catalina.out就可以实时查看日志。

