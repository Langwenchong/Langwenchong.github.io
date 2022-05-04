---
title: Docker入门笔记(1)
comments: false
top: false
date: 2021-11-20 16:09:29
tags: [docker]
categories: 
	- [知识分享,学习心得]
headimg: https://langwenchong.gitee.io/figure-bed/20211120222554.png
---

记录翀翀入门docker的笔记，如果你也是小白，快来和我一起学习docker吧😉！

<!-- more -->

{% note quote,

从本篇开始，翀翀将开始记录学习docker时的笔记，参考的教程是[《狂神说docker》](https://www.bilibili.com/video/BV1og4y1q7M4?p=1)，这里由衷感谢狂神大大无微不至的讲解！

%}

### Docker的基本组成

![](https://langwenchong.gitee.io/figure-bed/20211120161955.png)

首先我们可以看到他由客户端、本地服务器、远程仓库三个部分完成。其中我们客户端可以输入指令从远程仓库拉取不同的镜像到本地服务器。本地服务器通过Docker守卫进程首先管理镜像，然后镜像可以实例化出许多相互隔离的容器来进行不同的工作。

- 镜像（images)：docekr镜像就好比模板，可以通过这个模板来创建容器服务、比如我们可以通过run tomcat镜像创建两个tomcat容器分别是tomcat01和tomcat02，两个容器相互隔离独立的运行服务。也就是说**一个镜像可以创建多个容器、最终的服务运行或者项目运行是在容器中的**
- 容器（Container)：Docker利用容器技术可以独立运行一个或者一组容器，**通过镜像来创建的**。因此容器可以启动、停止、删除等。
- 仓库（Repository)：仓库就是**存放镜像的地方**，分为私有仓库和公有仓库，默认的是docker  hub(但是也有国内阿里云镜像等)。

{% note info,

我们可以简单的理解为仓库就是类似于github的远程仓库地址，可以pull push。而镜像和容器的关系类似于java中类和实例的关系，镜像来定义工作的原理和运行的功能。容器就是具体的工作实例，因此由同一个镜像创建的容器工作原理是相同的，但是他们之间相互独立工作。

%}

### Docker安装

#### 环境查看

{% note info,

博主使用的是centos8，腾讯云1核2G的服务器，使用xshell远程连接服务器进行学习的

%}

首先查看配置如下

```shell
#系统版本
[root@VM-0-7-centos ~]# cat /etc/os-release
NAME="CentOS Linux"
VERSION="8 (Core)"
ID="centos"
ID_LIKE="rhel fedora"
VERSION_ID="8"
PLATFORM_ID="platform:el8"
PRETTY_NAME="CentOS Linux 8 (Core)"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:centos:centos:8"
HOME_URL="https://www.centos.org/"
BUG_REPORT_URL="https://bugs.centos.org/"

CENTOS_MANTISBT_PROJECT="CentOS-8"
CENTOS_MANTISBT_PROJECT_VERSION="8"
REDHAT_SUPPORT_PRODUCT="centos"
REDHAT_SUPPORT_PRODUCT_VERSION="8"
```

#### 安装步骤

首先我们打开[帮助文档](https://docs.docker.com/engine/install/centos/)查看具体的安装步骤

##### 1.卸载旧的版本

```shell
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
```

##### 2.需要的依赖安装包

```shell
sudo yum install -y yum-utils
```

##### 3.设置镜像仓库

注意这里官方文档给的镜像仓库地址是外网的，我们改为阿里云国内镜像

```shell
sudo yum-config-manager \
    --add-repo \
    http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
```

##### 4.安装docker相关函数

```shell
sudo yum install docker-ce docker-ce-cli containerd.io
```

##### 5.安装完成启动docker

```shell
sudo systemctl start docker
```

启动成功以后我们可以运行`docker version` 查看相关的docker信息

```shell
[root@VM-0-7-centos ~]# docker version
Client: Docker Engine - Community
 Version:           20.10.10
 API version:       1.41
 Go version:        go1.16.9
 Git commit:        b485636
 Built:             Mon Oct 25 07:42:56 2021
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.10
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.16.9
  Git commit:       e2f740d
  Built:            Mon Oct 25 07:41:17 2021
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.4.11
  GitCommit:        5b46e404f6b9f661a205e28d59c982d3634148f8
 runc:
  Version:          1.0.2
  GitCommit:        v1.0.2-0-g52b36a2
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0

```

##### 6.运行Hello World

```shell
sudo docker run hello-world
```

![](https://langwenchong.gitee.io/figure-bed/20211120164937.png)

出现上图说明运行成功了，实际上上面图就是一个完整的docker镜像搜索->docker拉取镜像->docker运行镜像创建容器->docker容器启动运行的全流程。

我们可以通过如下指令查看从远程仓库拉取到的镜像

```shell
docker images
```

![](https://langwenchong.gitee.io/figure-bed/20211120165330.png)

### Docker讲解

我们回顾一下刚刚的hello-world镜像获取，创建容器，运行容器的全流程，可以总结为下图

![](https://langwenchong.gitee.io/figure-bed/20211120170046.png)

{%note info,

要注意命令docker run name是尝试创建一个新的容器name，如果没有这个镜像会去远程仓库寻找，否则在本地直接使用name镜像**创建一个新的容器**，因此name是镜像名字，默认如果没有给容器命名会自动创建一个名字，或者我们可以使用容器id。

%}

#### 思考：docker到底是什么？怎么运行的？

![](https://langwenchong.gitee.io/figure-bed/20211120170714.png)

Docker是一个C/S结构的系统，Docker的守卫进程运行在主机上，通过socket从客户端访问。DockerServer接收到Docker-Client的指令以后就会执行这个命令。

上图很清晰的描述了docker运行的底层原理。首先最外面的框架就是一个大的Linux服务器即我们的云服务器，而客户端就是不同的账户，比如现在我们正在使用一个账户输入指令，那么这就是一个客户端，但是我们并不是直接操作docker容器的，而是统一将命令交付到守卫进程，守卫进程来根据执行具体的操作不同的容器，因此从docker的视角来看，他和守卫进程通信，而不能直接被我们所操纵，我们只是通过守卫间接的操纵。

同时里面存在许多个相互隔离的容器，他们独立的运行，比如上图中左侧是一个centos容器，右侧是一个mysql容器，但是我们要知道每一个容器都是一个小的`完整系统`，即他们自己都有一套完整的指令、端口等。比如centos容器正在运行，他自己内部端口是8080，mysql容器也在运行并且使用的端口是3306，两者互不干扰，**此时mysql容器也可以运行在8080端口也并不会干扰到centos容器，这是因为两个容器都是独立的系统，有自己的一套完整的构件**。而我们外部也可以使用8080端口，他和两个容器的端口也是互不干扰的，但是此时我们并不能直接通过服务器的8080或者3306端口查看到两个容器的运行，因为我们并不能直接访问操控容器，后面我们会学到可以使用-p(port)指令来设置容器的端口向外暴露，这样我们就可以访问了😋。

#### Docker和虚拟机的区别？为什么Docker更轻量级、运行更快？

![](https://langwenchong.gitee.io/figure-bed/20211120171907.png)

看上图我们可以很明显的看出原因，Docker有更少的抽象层。对于一个虚拟机，他需要现在宿主机上虚拟一套完整的硬件映射系统，然后再在这层虚拟的硬件上搭建一个完整的虚拟操作系统内核Guest OS，然后才能安装真正的项目运行需要的依赖环境。而Docker容器并没有自己的虚拟硬件和操作系统内核，他是直接在宿主机上抽象一层Docker引擎，然后容器直接使用宿主机的硬件和操作系统内核，因此更轻量级、同时运行也更快。一个虚拟机大约是1-2G，而一个docekr容器仅仅10-20M就可以完成和虚拟机一样的工作。因此新建一个容器的时候，docker不需要像虚拟机一样加载一个操作系统内核，无需引导加载，因此启动只需要几秒相较于虚拟机几分钟的启动要快上许多，

![](https://langwenchong.gitee.io/figure-bed/20211120172623.png)

{%note info,

一定要注意Docker容器没有自己的虚拟硬件和操作系统内核，他们使用的都是宿主机的，而虚拟机需要先使用宿主机虚拟自己的硬件和操作系统内核Guest OS。

%}

### Docker的常用命令

#### 帮助命令

```shell
docker version #查看docker版本信息
docker info #详细展示docekr当前的具体信息
docker 命令 --help #针对某一命令各种参数的功能
```

{%link docker帮助文档 , https://docs.docker.com/reference/ %}

#### 镜像命令

##### docker images查看所有本地主机上的镜像

```shell
[root@VM-0-7-centos ~]# docker images
REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
hello-world   latest    feb5d9fea6a5   8 weeks ago    13.3kB
centos        latest    5d0da3dc9764   2 months ago   231MB

#解释
REPOSITORY	#镜像仓库源
TAG 		#版本标签
IMAGE ID 	#唯一区分标识符
CREATED 	#创建时间
SIZE 		#代销

#可选项
-a, --all		#列出所有的镜像
-q, --quiet     #只显示镜像的ID
-aq				#显示所有镜像的ID
```

##### docker search搜索镜像

首先我们可以直接在docker hub上进行搜索也是可以得，但是我们也可以在终端中快速搜索并进行筛选。

```shell
[root@VM-0-7-centos ~]# docker search mysql
NAME                              DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
mysql                             MySQL is a widely used, open-source relation…   11707     [OK]       
mariadb                           MariaDB Server is a high performing open sou…   4458

#可选项
--filter=STARTS=3000    #通过star过滤大于3000的镜像仓库
```

##### docker pull下载镜像

```shell
#docker pull image默认下载最新版
[root@VM-0-7-centos ~]# docker pull mysql
Using default tag: latest #默认下载最新版
latest: Pulling from library/mysql
a10c77af2613: Pull complete  #分层下载，docker image的核心，联合文件系统
b76a7eb51ffd: Pull complete 
258223f927e4: Pull complete 
2d2c75386df9: Pull complete 
63e92e4046c9: Pull complete 
f5845c731544: Pull complete 
bd0401123a9b: Pull complete 
3ef07ec35f1a: Pull complete 
c93a31315089: Pull complete 
3349ed800d44: Pull complete 
6d01857ca4c1: Pull complete 
4cc13890eda8: Pull complete 
Digest: sha256:aeecae58035f3868bf4f00e5fc623630d8b438db9d05f4d8c6538deb14d4c31b
Status: Downloaded newer image for mysql:latest
docker.io/library/mysql:latest #真实地址


#也可以使用docker pull image:[tag]下载指定版本
#如现在下载mysql5.7版本
[root@VM-0-7-centos ~]# docker pull mysql:5.7
5.7: Pulling from library/mysql
a10c77af2613: Already exists #docker联合文件核心亮点，有的就不需重复下载了
b76a7eb51ffd: Already exists #直接共用相同的文件
258223f927e4: Already exists 
2d2c75386df9: Already exists 
63e92e4046c9: Already exists 
f5845c731544: Already exists 
bd0401123a9b: Already exists 
2724b2da64fd: Pull complete 
d10a7e9e325c: Pull complete #5.7版本特有的
1c5fd9c3683d: Pull complete 
2e35f83a12e9: Pull complete 
Digest: sha256:7a3a7b7a29e6fbff433c339fc52245435fa2c308586481f2f92ab1df239d6a29
Status: Downloaded newer image for mysql:5.7
docker.io/library/mysql:5.7 #真实地址

#实际上之前的docker pull mysql等同于docker pull mysql:latest也是有标签的

#当前有两个版本，但是两者之间部分文件是相同共用的
[root@VM-0-7-centos ~]# docker images
REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
mysql         5.7       8b43c6af2ad0   3 days ago     448MB
mysql         latest    b05128b000dd   3 days ago     516MB

```

##### docker rmi删除镜像

```shell
docker rmi 镜像id 删除指定镜像
docker rmi 镜像id1 镜像id2 ...删除多个镜像
```

![](https://langwenchong.gitee.io/figure-bed/20211120204856.png)

```shell
#强制删除所有的镜像
#-f表示强制，后面的$()是计算式使用了查询所有id的docker指令
docker rmi -f $(docker images -aq) 
```

![](https://langwenchong.gitee.io/figure-bed/20211120205145.png)

#### 容器命令

{% note info,

只有有了镜像，才能创建容器，我们这里下载一个centos镜像来测试学习容器的命令

%}

##### 新建容器并启动

```shell
docker run [可选参数] image

#参数说明
--name="Name" 	容器名字 tomcat01 tomcat02用来区分容器
-d 				后台方式运行
-it 			交互方式运行
-p 				指定容器端口(用来主机映射80:8080)
	-p ip:主机端口:容器端口
	-p 主机端口:容器端口 (常用，用来端口映射)
	-p 容器端口
	容器端口
-P				随机指定端口

#测试启动并进入容器
#首先现在在容器外部我们的@后面是vm-0-0-centos
#然后我们run创建一个容器(未设置名字，没关系可以使用id号)
#-it是交互方式进入
#/bin/bash是对容器内部操作时使用指令集，一般都是bash
[root@VM-0-7-centos /]# docker run -it centos /bin/bash
#进入容器内部，@后面跟的是容器id
#这个容器就是一个linux系统，所以ls会得到和外部服务器一样的文件结构
[root@6ee0cf9db211 /]# ls
bin  dev  etc  home  lib  lib64  lost+found  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var

docker exit 退出容器到主机
#输入exit退出容器到主机，并且由于这个容器没有运行任务，因此会默认自动关闭不再运行
[root@6ee0cf9db211 /]# exit
exit
#外部即云服务器也是linux文件结构
[root@VM-0-7-centos /]# ls
bin  boot  data  dev  etc  home  lib  lib64  lost+found  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
```

![](https://langwenchong.gitee.io/figure-bed/20211120210812.png)

##### 查看容器

```shell
docker ps 查看所有当前正在运行的容器
[root@VM-0-7-centos /]# docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
#由于exit后没有运行任务，刚刚的centos容器已经关闭因此查看不到

docker ps -a 查看所有存在的容器(关闭的也可以查看到)
[root@VM-0-7-centos /]# docker ps -a
CONTAINER ID   IMAGE     COMMAND       CREATED         STATUS                     PORTS     NAMES
6ee0cf9db211   centos    "/bin/bash"   8 minutes ago   Exited (0) 6 minutes ago             romantic_lehmann
#发现创建容器时若没有赋名字会随机生成一个

docker -a -n=1 显示最近运行的1个容器
docker ps -q 只显示容器的id
docker ps -aq 显示当前所有容器的id
```

##### 退出容器

```shell
exit #退出容器且如果没有运行任务自动关闭
ctrl+p+q #退出容器且不关闭后台运行(即使没有运行任务)
```

![](https://langwenchong.gitee.io/figure-bed/20211120211849.png)

##### 删除容器

```shell
docker rm 容器id 删除指定容器
docker rm 容器id1 容器id2 删除多个容器
docker rm -f $(docker ps -aq) 强制删除所有容器 
```

{% note info,

之所以要加`-f`参数是因为正在运行的容器不能删除，因此需要强制删除或者停止后再删除

%}

##### 启动和停止容器

```shell
docker start 容器id 		启动指定容器
docker restart 容器id		重启指定容器
docker stop 容器id		停止指定当前运行的容器
docker kill 容器id		强制停止指定当前运行的容器
```

#### 其他常用指令

##### 创建并后台启动容器

之前我们学习的是创建容器并直接进入容器，但是我们能不能启动容器后让他直接后台运行，而我们不进入容器呢？我们知道`-d`是后台运行的参数，那么想当然如下指令就是创建并后台启动容器的指令

```shell
docker run -it image /bin/bash #之前的创建并进入容器
docker run -d image #创建并后台启动容器
```

![](https://langwenchong.gitee.io/figure-bed/20211120212904.png)

但是我们发现了一个问题，他并没有维持后台运行待机的状态，这是因为他没有前台进程，也就是说容器他虽然能后台待机，但是没有接收操控他指令的前台，即他不能和操纵者通信，因此自杀了。类似的还有nginx,假设我们启动了一个nginx容器，但是他没有前台呈现页面的任务，即意味着他什么任务也没有，那么也会和centos类似自杀关闭容器减少资源的浪费。并且此时即使我们再输入`docker start`也无济于事他并不会成功启动，因为他刚启动后又会因为无前台进程自动关闭。我们可以使用如下并不好的策略创建并后台启动容器

```shell
docker run -dit image /bin/bash
#此时我们添加了-d属性，并且给他分配了前台进程，因此不会自动关闭了
```

{%note info,

因此一般我们创建容器时都是首次要进入这个容器并分配任务的，然后再exit或者ctrl+p+q退出容器，此时由于已分配了任务容器不会再自动关闭。如果创建后进入并未分配任务我们为了让他维持运行，需要ctrl+p+q退出。

%}

##### 查看日志

```shel
docker logs -tf 容器id         查看当前容器的全部日志
docker logs -tf --tail num 容器id		查看当前容器的最新num条日志(实时刷新)
```

我们要注意要查看一个容器的日志，**首先这个容器必须正在运行，同时他确实运行过任务才能产生日志**，由于日志会很多，一般我们需要加上`--tail num`来限制显示的日志行数。

##### 查看容器中进程的信息

```shell
docker top 容器id     	查看当前容器内部的进程信息
```

**同样的，他也需要保证当前查看的容器正在运行。**

##### 查看容器的详细信息

```shell
docker inspect 容器id		
```

![](https://langwenchong.gitee.io/figure-bed/20211120215437.png)

##### 进入当前正在运行的容器

通常我们的容器都是后台运行任务的，但是有时候我们需要进入这个容器修改一些配置，我们可以使用如下指令

```shell
docker exec -it 容器id /bin/bash 	进入容器并进入一个新的指令终端
docker attach		进入容器并使用之前的指令终端
```

我们注意两者是有区别的，假设现在正在运行的容器正在不断的占用之前的终端打印信息，那么此时如果我们使用`docker attach`会导致我们无法输入命令，因为当前容器的任务正在使用这个终端打印信息。为了以防这种尴尬的情况出现，我们最好使用前者指令创建一个新终端进入容器。

##### 从容器内拷贝文件到主机上

```shell
docker cp 容器id:容器内路径 目的主机路径
```

![](https://langwenchong.gitee.io/figure-bed/20211120220639.png)

我们要注意docker cp是用来将容器内部的文件拷贝到主机上的，并且不受容器是否正在运行的影响。而主机文件到容器一般不使用此命令，而是通过挂载卷完成。同时使用-v卷的技术可以实现文件系统的自动同步，类似于共享文件夹的功能😁。

#### 常用命令总结

![](https://langwenchong.gitee.io/figure-bed/20211120220939.png)

上图给出了docker相关的大部分命令，我们刚刚只是学习了最常用的镜像和容器相关的指令，实际上还有许多和git相类似的指令，我们会在后面学习到。docker的命令非常多，我们需要经常使用和复习才能记住哦！

### 作业练习

我们这里使用之前学习到的指令尝试完成nginx部署。首先我们需要下载nginx镜像

```shell
[root@VM-0-7-centos ~]# docker pull nginx
Using default tag: latest
latest: Pulling from library/nginx
eff15d958d66: Pull complete 
1e5351450a59: Pull complete 
2df63e6ce2be: Pull complete 
9171c7ae368c: Pull complete 
020f975acd28: Pull complete 
266f639b35ad: Pull complete 
Digest: sha256:097c3a0913d7e3a5b01b6c685a60c03632fc7a2b50bc8e35bcaa3691d788226e
Status: Downloaded newer image for nginx:latest
docker.io/library/nginx:latest
[root@VM-0-7-centos ~]# docker images
REPOSITORY   TAG       IMAGE ID       CREATED        SIZE
nginx        latest    ea335eea17ab   3 days ago     141MB

```

然后我们创建一个nginx容器并命名为nginx01，如下操作进行后台运行和端口配置

![](https://langwenchong.gitee.io/figure-bed/20211121110328.png)

此时我们输入`http://云服务ip:3344`即可看到成功部署后的nginx服务页面(前提是服务器的防火墙已打开)：

![](https://langwenchong.gitee.io/figure-bed/20211121110711.png)

并且此时我们进入nginx容器发现其内部也存在一个配置完整的nginx文件夹，我们可以在这里的nginx.conf配置相关的转发。

```shell
[root@VM-0-7-centos ~]# docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                                   NAMES
429fc0ba5ede   nginx     "/docker-entrypoint.…"   3 minutes ago   Up 3 minutes   0.0.0.0:3344->80/tcp, :::3344->80/tcp   nginx01
[root@VM-0-7-centos ~]# docker exec -it nginx01 /bin/bash
root@429fc0ba5ede:/# whereis nginx
nginx: /usr/sbin/nginx /usr/lib/nginx /etc/nginx /usr/share/nginx
root@429fc0ba5ede:/# cd /etc/nginx
root@429fc0ba5ede:/etc/nginx# ls
conf.d	fastcgi_params	mime.types  modules  nginx.conf  scgi_params  uwsgi_params
```

这样使用容器配置nginx的好处时，当我们需要动态使用nginx切换部署的项目时，无需再频繁的去修改nginx.conf文件了，而只需要将不同的项目都部署到一个nginx容器内，当需要切换时只需要动态的启动或者关闭对应的nginx容器即可了。