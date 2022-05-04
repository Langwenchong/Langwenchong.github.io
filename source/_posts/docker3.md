---
title: Docker入门笔记(3)
comments: false
top: false
date: 2021-11-27 21:44:57
tags: [docker]
categories: 
	- [知识分享,学习心得]
headimg: https://langwenchong.gitee.io/figure-bed/20211128205545.png
---

记录翀翀入门docker的笔记，如果你也是小白，快来和我一起学习docker吧😉！

<!-- more -->

{% note quote,

从本篇开始，翀翀将开始记录学习docker时的笔记，参考的教程是[《狂神说docker》](https://www.bilibili.com/video/BV1og4y1q7M4?p=1)，这里由衷感谢狂神大大无微不至的讲解！

%}

### 发布镜像到Dockerhub等远程仓库

首先我们需要一个DockerHub账户，这样我们就可以在服务器发布我们的镜像到远程仓库了。首先我们查看一下在服务器上登录我们DockerHub账户

```shell
Log in to a Docker registry.
If no server is specified, the default is defined by the daemon.

Options:
	#密码
  -p, --password string   Password
      --password-stdin    Take the password from stdin
     #账号
  -u, --username string   Username
  
#这里我们登录自己的账号
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: langwenchong
Password: 
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store
#登录成功
Login Succeeded
```

然后我们尝试发布这个镜像，但是在发布之前我们需要先创建一个标签如下图所示

![](https://langwenchong.gitee.io/figure-bed/20211126153217.png)

我们使用`docker push`指令进行发布，如下图所示，但是由于DockerHub在外网，因此我们可能会上传失败或者上传非常慢，请耐心等待，后面我们还会学习如何发布到阿里云镜像仓库。

![](https://langwenchong.gitee.io/figure-bed/20211126153404.png)

### 发布镜像到阿里云镜像远程仓库

我们已经体会到了上传DockerHub有多慢了，因此我们这里学习如何发布到阿里云镜像仓库。首先我们登录阿里云然后搜索寻找`容器镜像服务`，然后创建一个个人实例用来学习即可如下图

![](https://langwenchong.gitee.io/figure-bed/20211126154006.png)

然后我们进入个人镜像实例，这里我们可以创建命名空间，但是要注意一个账号只能创建三个命名空间，但是一个命名空间可以存储许多的镜像仓库，因此个人使用完全足够，如下图：

![](https://langwenchong.gitee.io/figure-bed/20211126154311.png)

然后我们再创建一个镜像仓库（就类似于github的远程仓库），一会我们就提交到这个远程仓库中，如下图

![](https://langwenchong.gitee.io/figure-bed/20211126154430.png)

然后选择本地仓库创建即可，然后我们就得到了一个远程仓库的地址

![](https://langwenchong.gitee.io/figure-bed/20211126154525.png)

接下来我们按照上面的步骤上传即可，首先我们DockerHub的账号，然后登陆阿里云的账号

![](https://langwenchong.gitee.io/figure-bed/20211126155205.png)

然后我们按照步骤还需要进行仓库的pull,使用`docker tag`创建提交版本等， 这里由于我们是首次提交就不需要拉取了

```shell
#从Registry中拉取镜像
docker pull registry.cn-hangzhou.aliyuncs.com/langwenchong/tomcat-test:[镜像版本号]
#创建提交版本
docker tag [ImageId] registry.cn-hangzhou.aliyuncs.com/langwenchong/tomcat-test:[镜像版本号]
#然后push
docker push registry.cn-hangzhou.aliyuncs.com/langwenchong/tomcat-test:[镜像版本号]
```

{% note info,

一定要注意这里的创建版本，提交必须按照阿里云的要求完成，否则会被拒绝push😯！前面的`hangzhou.aliyuncs.com`是不能省略的！

%}

比如我们这里将镜像版本号设置为1.0并提交，那么指令应该如下图这样操作：

![](https://langwenchong.gitee.io/figure-bed/20211126161845.png)

理论上来说应该挺快的，一会就能提交完成然而我最终还是提交失败了...如果你提交成功了，应该可以看到阿里云的镜像仓库已经更新了

![](https://langwenchong.gitee.io/figure-bed/20211126162111.png)

以后如果我们需要别人使用我们的镜像，只需要docker pull 镜像名称即可了。

### Docker所有流程小结

![](https://langwenchong.gitee.io/figure-bed/20211126162346.png)

自此我们已经学会了docker的全部基本操作，上图是所有流程的过程图。我们看到上图还有`save`和`load`指令，这两个指令实际上也很好理解，我们除了可以让伙伴直接从远程仓库拉取我们推送的镜像以外，也可以使用save指令将我们创建的镜像打包成压缩包，然后发送给伙伴，他再使用`load`指令解压即可得到我们创建的镜像。如果你已经能看懂上面的图了，那么恭喜你已经入门Docker成功😁！但是我们可以再深入学习进阶Docker知识，偏向集群的运维。

### Docker网络

#### 理解Docker0

首先我们清空之前创建的所有镜像和容器，然后输入`ip addr`查看网络信息

![](https://langwenchong.gitee.io/figure-bed/20211126164053.png)

我们可以看到三个网络，分别是三个docker环境。我们思考一个问题：假设现在主机内部有两个容器，其中一个是tomcat容器负责页面的访问，另一个容器时mysql容器用来存储数据，那么我们tomcat容器的项目如何去连接mysql容器获取数据？

![](https://langwenchong.gitee.io/figure-bed/20211126171200.png)

##### 思考：这样连接会不会与容器之间独立的原则相悖？

答案是不会，因为此时两个容器结构上还是独立运行的，两者配置的更改不会影响到对方，只是两个容器之间有功能上的连接，这种连接是允许的。

这里就会涉及到docker网络的知识。接下来我们就以这个为案例进行docker网络的学习，首先我们创建一个tomcat容器，然后启动并且在后面追加`ip addr`查看这个容器的内网信息如下图所示，由于我下载的这个最新版tomcat是精简版没有`ip addr`指令，因此我们选择进入这个容器然后输入如下指令先安装指令集

``` shell
apt update && apt install -y iproute2
```

![](https://langwenchong.gitee.io/figure-bed/20211126165752.png)

安装完成后我们再输入`ip addr`查看这个容器的内网信息：

![](https://langwenchong.gitee.io/figure-bed/20211126170213.png)

{% note info,

如果你已经学过计算及网络了，可以回忆一下这个地址后面的`/8`、`/16`代表什么？实际上他是子网掩码，通过前面的ip地址加上子网掩码我们就可以得知子网的划分。

%}

上面的第二个网络是每一个容器都有的，他是docker为其分配的一个地址用来宿主机访问连接的，我们在创建这个容器时使用的是`-P`随机的端口暴露，但是我们可以通过这个docker为其分配的地址仍然可以ping通这个容器，如下图

![](https://langwenchong.gitee.io/figure-bed/20211126170510.png)

现在我们发现主机是可以通过docker为这个容器分配的地址ping到这个容器的，想一想也很合理，既然容器在宿主机上运行，很显然宿主机应该能够ping到这个容器内部。我们前面学习过两个容器之间很难直接建立连接，那么我们此时就可以借用主机可以ping通任何一个容器的特点，让两个容器通过主机来间接连接。实际上我们学习过计网后应该可以知道实际上docke为这些容器分配的就是一个主机的内网ip，因此这些容器处于同一个主机内网下。

我们每启动一个docker容器，docker就会为docker容器分配一个ip,我们只要安装了docker，就会有一个网卡docker0,他使用桥接模式工作，使用的技术是veth-pair技术。此时每添加一个容器，主机的docker0网络就会添加一条网卡即docker容器的veth地址如下图我们对比一下：

{% gallery::::one %}

![创建容器前主机docker0网络](https://langwenchong.gitee.io/figure-bed/20211126164053.png)

![创建容器主机后docker0网络](https://langwenchong.gitee.io/figure-bed/20211126172319.png)
![tomcat容器内网信息](https://langwenchong.gitee.io/figure-bed/20211126172439.png)

{% endgallery %}

这就是主机可以ping同创建的容器的原因，由此类推，如果现在再创建一个tomcat02容器，那么主机docker0网络下会再新增一个记录值网卡：

{% gallery::::one %}

![创建tomcat02后主机网络](https://langwenchong.gitee.io/figure-bed/20211126174906.png)

![第二个容器内网信息](https://langwenchong.gitee.io/figure-bed/20211126174800.png)

{% endgallery %}

##### 思考：veth-pair到底是啥？怎么运行的？

我们仔细观察发现当创建一个容器后，这个容器获得了88，而宿主机就是89，他们永远生成的都是一对连接的数值即网卡，这就是linux的veth-pair技术，他是专门用来连接各种虚拟网络设备的技术类似于“桥梁”，如下图我们很容易就能理解主机是如何通过veth-pair技术提供的网卡实现和容器通信的

![](https://langwenchong.gitee.io/figure-bed/20211126174954.png)

{% note info,

OpenStac、Docker容器之间的连接、OVS的连接等都是使用veth-pair技术实现的

%}

##### 思考：此时tomcat01能否直接和tomcat02ping通？

此时tomcat01是可以ping通tomcat02的，原因就是两个容器可以通过主机间接实现连接，此时他们位于同一个内网网段了（此时主机是172.18.0.1,tomcat01是172.18.0.2，tomcat02是172.18.0.3），因此可以互相连接了。实际上就是基于vrth-pair实现的。

![](https://langwenchong.gitee.io/figure-bed/20211126175738.png)

即此时两个容器之间可以间接连通了：

![](https://langwenchong.gitee.io/figure-bed/20211126180048.png)

{% note info,

我们要注意首先是通过veth-pair实现了主机和所有的容器连通，然后容器之间又通过和主机的veth-pair通信技术和其他容器处于了同一个网段因此间接也连通了！

%}

也就是说刚刚我们实现的tomcat01连接tomcat02通信实际上通信的路径应该如下：

![](https://langwenchong.gitee.io/figure-bed/20211126180619.png)

我们可以查看到主机的docker0下存储了所有的相关的网卡，因此主机模块优点类似于网络层的路由器他维护了一个路由转发表用来转发信息，因此其他容器间的通信会经过主机。

同时我们要注意，docker0是虚拟的，使用linux桥接直接和物理设备的ip直连映射，即NAT直连。如下图：

![](https://langwenchong.gitee.io/figure-bed/20211128145822.png)

{% note info,

由于docker0的地址都是虚拟ip，因此容器间的通信速度，主机的转发速度非常快。

%}

##### 思考：docker0可用的ip数量有多少？

所有的容器在不指定网络下，都是docker0路由，docker会给我们的容器分配一个默认的可用ip，那么可用的ip数量大概有多少呢？我们查看一下docker0的子网ip是xxx.xxx.xxx.xxx/16，那么也就意味着子网段码占后16位ip，因此是255*255-2≈65535个可分配容器的ip(减去的两个是回环地址0.0.0.0和用来表示子网掩码的255.255.255.255)。

并且当我们删除容器时，docker0网卡会自动回收，假设现在我们将tomcat01容器删除，再查看主机docker0下的网卡信息，会发现之前的88-89网卡被回收了。

![](https://langwenchong.gitee.io/figure-bed/20211128150344.png)

#### 容器互联--link

我们回顾一下之前两个容器之间的通信，他们是基于清楚对方ip的情况下才能通过主机转发连通的，但是我们知道ip是很容易变化的，即使是docker0分配，当一个容器崩溃重启后他的ip会被收回可能再次被分配的ip也和之前的不一样了，那么之前和他有联系的容器现在在和他通信难道还需要手动的一个个去更新ip?很显然不现实，因此我们希望可以通过知道对方的容器服名就可以自动连接，而不再是基于ip。这时我们就会用到`--link`。

![](https://langwenchong.gitee.io/figure-bed/20211128151709.png)

首先我们尝试不用`--link`能够让tomcat02ping到tomcat01，就直接使用容器名tomcat01。

{%note info,

容器默认不配备ping指令，请先输入如下指令为容器安装

```shell
apt-get update && apt install iputils-ping && apt install net-tools
```

%}

![](https://langwenchong.gitee.io/figure-bed/20211128155111.png)

此时我们在创建一个容器时加上`--link 要连接的容器`既可以实现他的单向连通，比如此时我们创建一个tomcat03容器命令如下

``` shell
docker run -d -P --name tomcat03 --link tomcat02 tomcat
```

此时我们创建的容器tomcat03就可以使用容器名来连通tomcat02了（别忘了先安装ping指令），证明图如下

![](https://langwenchong.gitee.io/figure-bed/20211128155405.png)

##### 思考：此时tomcat02能否使用`ping tomcat03 `连接到tomcat03容器？

答案是不能，我们之前说到了--link仅仅是单向连同，因此此时tomcat02并不能使用`ping tomcat03`连接到tomcat03:

![](https://langwenchong.gitee.io/figure-bed/20211128155636.png)

我们探究一下tomcat03为什么可以知道tomcat02的ip，实际上他是使用`--link`为自己的本地host中添加了一条规则记录值记录着tomcat02的ip，因此我们输入`ping tomcat02`时他可以从自己的本地host中获知tomcat02的ip，实际上这个场景优点类似于域名和ip的关系。如下图是探究时的一些发现：

**一：docker network指令的使用以及docker0信息**

```shell
[root@VM-0-7-centos ~]# docker network --help

Usage:  docker network COMMAND

Manage networks
#下面是docker network后面可以追加的参数
Commands:
  #连接一个容器加入网络
  connect     Connect a container to a network
  #创建网络
  create      Create a network
  #容器断开指定网络
  disconnect  Disconnect a container from a network
  #查看某一个网络的详细信息
  inspect     Display detailed information on one or more networks
  #获取网络信息
  ls          List networks
  #删除所有没有被使用的网络
  prune       Remove all unused networks
  #删除指定网络
  rm          Remove one or more networks

Run 'docker network COMMAND --help' for more information on a command.
```

因此这里我们使用`docker network ls`查看一下全局的网络配置如下图

```shell
[root@VM-0-7-centos ~]# docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
#这里的第一个bridge实际上就是使用桥接的docker0网络我们进一步查看
010db73bc452   bridge    bridge    local
7bb6e8a7bdb9   host      host      local
b57d61a5e430   none      null      local
```

这里我们使用`docker network inspect 010db73bc452`进一步查看docker0网络的信息

![](https://langwenchong.gitee.io/figure-bed/20211128161409.png)

**二：容器内部信息**

这里我们是将tomcat03使用了`--link`单向连接了tomcat02，因此此时我们就来查看docker03的信息，这里输入`docker inspect docker03的id`查看他的详细信息：

![](https://langwenchong.gitee.io/figure-bed/20211128161717.png)

除了发现环境配置以外，我们还可以看到他的被分配的docker0ip地址以及默认网关确实就是主机的docker0因此他会经过主机的转发

![](https://langwenchong.gitee.io/figure-bed/20211128161934.png)

**三：查看tomcat03的本地host记录值**

我们知道hosts是一种很早的计网产物，他类似于一个设备的网络备忘录，记录了常用的连接设备要解析的ip地址，因此他再访问这个设备时可以自动根据设备名从host查看到对应的ip。由于使用了`--link tomcat02`，现在tomcat03确实可以根据tomcat02就自动ping通，因此他肯定是知道tomcat02的ip，那么理论上这个对应关系应该就存储到了tomcat03的本地hosts:

```shell
#打印docker03的hosts
[root@VM-0-7-centos ~]# docker exec -it tomcat03 /bin/bash
root@ad49f9ff52b2:/usr/local/tomcat# cat /etc/hosts
#localhost对应回环地址127.0.0.1
127.0.0.1	localhost
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
ff00::0	ip6-mcastprefix
ff02::1	ip6-allnodes
ff02::2	ip6-allrouters
#注意这里确实记录了tomcat02的ip
172.18.0.3	tomcat02 560768d4bf97
172.18.0.4	ad49f9ff52b2

```

正式由于tomcat03的hosts记录了tomcat02的ip映射，因此tomcat03可以通过`ping tomcat02`就可以ping通，因为他会从hotsts获取到tomcat02的ip。

那么现在我们怎么才能让tomcat02也能够通过`ping tomcat03`甚至`ping tomcat01`等等就可以实现连通呢？答案很简单了，逐一去修改各容器的hosts后重启就可以了，但是很显然这种操作太麻烦了，即使使用了卷挂载技术共享hosts也很麻烦。因此`--link`现在并不常用了，甚至docker0都不太常用， 因为他是一个官网的网络，默认不支持`容器名连接访问`等功能，因此接下来我们会学习自定义网络。

#### 自定义网络

我们输入`docker netwoek ls`查看一下当前已有的网络：

```shell
[root@VM-0-7-centos ~]# docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
#注意name为beidge默认就是docker0
010db73bc452   bridge    bridge    local
7bb6e8a7bdb9   host      host      local
b57d61a5e430   none      null      local
```

会发现有如下几种网络模式（driver)：

1. bridge：桥接模式（默认的网络模式，一会我们创建的自定义网络也是这种类型）
2. none：不配置网络
3. host：和宿主机共享网络
4. container：容器网络连通（用得少，局限性大）

接下来我们就来实际操作一下自定义网络，我们在创建自定义网络进行测试之前，先将之前用来演示的tomcat01,tomcat02,tomcat03容器删除。

![](https://langwenchong.gitee.io/figure-bed/20211128164409.png)

然后我们来创建一个网络，首先我们看一下``docker network create`的可选参数

```shell
      valid_lft forever preferred_lft forever
[root@VM-0-7-centos ~]# docker network create --help

Usage:  docker network create [OPTIONS] NETWORK

Create a network

Options:
      --attachable           Enable manual container attachment
      --aux-address map      Auxiliary IPv4 or IPv6 addresses used by Network driver (default map[])
      --config-from string   The network from which to copy the configuration
      --config-only          Create a configuration only network
      #核心参数：配置网络模式
  -d, --driver string        Driver to manage the Network (default "bridge")
  	  #核心参数：配置子网网关
      --gateway strings      IPv4 or IPv6 Gateway for the master subnet
      --ingress              Create swarm routing-mesh network
      --internal             Restrict external access to the network
      --ip-range strings     Allocate container ip from a sub-range
      --ipam-driver string   IP Address Management Driver (default "default")
      --ipam-opt map         Set IPAM driver specific options (default map[])
      --ipv6                 Enable IPv6 networking
      --label list           Set metadata on a network
  -o, --opt map              Set driver specific options (default map[])
      --scope string         Control the network's scope
      #核心参数：配置子网并且格式为xx.xx.xx.xx/xx，决定了一个子网个数以及子网下可分配ip数
      --subnet strings       Subnet in CIDR format that represents a network segment
```

我们创建一个子网命名为`mynet`并且子网掩码长度是16，这样他就可以支持65535个可分配ip,同时子网段是192.168那么命令如下

```shell
#创建网络，并且mynet的默认网关是192.168.0.1
#--drive 设置网络模式为bridge，实际上默认就是bridge
#--subnet 设置子网段为192.168，后面随意变化，因此有255个子网并且每一个子网有255个可分配ip
#--gateway 设置默认网关，一般就是子网下的第一个可分配ip
[root@VM-0-7-centos ~]# docker network create --driver bridge --subnet 192.168.0.0/16 --gateway 192.168.0.1 mynet
c9bf25797ca395d914d6807e3536e148a464777831b9cc4897d166a88e565f2d
#查看所有网络
[root@VM-0-7-centos ~]# docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
010db73bc452   bridge    bridge    local
7bb6e8a7bdb9   host      host      local
#添加成功
c9bf25797ca3   mynet     bridge    local
b57d61a5e430   none      null      local
```

![](https://langwenchong.gitee.io/figure-bed/20211128170151.png)

然后接下来我们创建两个容器为`tomcat-mynet-01`和`tomcat-mynet-02`并且不再默认加入到docker0网络下，而是我们自己新创建的自定义网络`mynet`，如下图输入指令

```shell
[root@VM-0-7-centos ~]# docker run -d -P --name tomcat-mynet-01 --net mynet tomcat
8bc67a95591891df5347385f91a36ab8fff46f6fe77a6a1b8ce36a295e98467d
[root@VM-0-7-centos ~]# docker run -d -P --name tomcat-mynet-02 --net mynet tomcat
14adf5f3a12c4b41ba61eb6886c3f4bfd83799372cee4374936274f2a0821f48

```

{% note info,

注意`-net`是设置容器加入的网络，默认情况下不写是加入到名为`bridge`的网络也就是docker0网络，但是docker0禁止了域名访问，只有使用`--link`才能打通。

%}

我们为了能够支持域名访问，因此创建了一个新的自定义网络，一个完整的默认的bridge桥接网络模式是支持域名访问的，因此此时我们发现`tomcat-mynet-01`是可以不用`--link`既可以使用`ping tomcat-mynet-02`连接tomcat-mynet-02容器的，即支持了域名访问，这比docker0要方便的多。

![](https://langwenchong.gitee.io/figure-bed/20211128171236.png)

同样tomcat-mynet-02肯定也是可以的，这里我们再查看一下tomcat-mynet-01容器的信息会发现他被分配的ip使用的子网确实使我们之前设置的。

![](https://langwenchong.gitee.io/figure-bed/20211128171413.png)

{%note info,

自定义的网络都已经自动帮我们维护好了ip和容器名的对应关系，因此推荐平时使用自定义网络而不要使用docker0

%}

同时我们使用自定义网络可以为不同的集群分配不同的自定义网络，保证各个功能模块集群互不干扰的工作，比如现在有一个redis集群和一个mysql集群，为他们分配到不同的自定义网络，那么不同种类的容器就会做到通信隔离，更加安全！

![](https://langwenchong.gitee.io/figure-bed/20211128172108.png)

但是两个集群也不能完全不通信呀😂，还是需要有一些容器有连通的（此时使用`--link`也做不到，因为他们不再同一个网段），因此接下来我们将学习网络连通。

#### 网络连通

接下来我们以docker0网络下的`tomcat01`和`tomcat02`以及mynet下的`tomcat01-mynet-01`和`tomcat-mynet-02`进行演示，首先我们创建`tomcat01`和`tomcat02`两个容器，然后尝试用tomcat-mynet-01容器去ping容器tomcat01发现无法实现：

![](https://langwenchong.gitee.io/figure-bed/20211128192720.png)

因此不同网络下的容器无法通信，但是实际上有时处于不同网络下的两个容器功能上需要进行连接通信，因此我们希望可以允许容器和另一个网络下的某个容器进行连通。首先两个网卡不能直接打通，这样会导致两个子网发生变化，应该是让一个容器和另一个子网的网卡连接即他进入到另一个子网下，也就是类似于一个人加入多个组织，他同时拥有多个网络的分配ip，这样他就可以和另一个子网的容器进行通信了，如下图：

![](https://langwenchong.gitee.io/figure-bed/20211128193232.png)

这里我们就会用到一个新指令即`docker network connect `,他的可选参数如下

```shell
[root@VM-0-7-centos ~]# docker network connect --help

Usage:  docker network connect [OPTIONS] NETWORK CONTAINER

Connect a container to a network

Options:
      --alias strings           Add network-scoped alias for the container
      --driver-opt strings      driver options for the network
      --ip string               IPv4 address (e.g., 172.30.100.104)
      --ip6 string              IPv6 address (e.g., 2001:db8::33)
      --link list               Add link to another container
      --link-local-ip strings   Add a link-local address for the container
```

现在我们就将容器tomcat01打通加入到mynet网络下

```shell
[root@VM-0-7-centos ~]# docker inspect tomcat01
```

![](https://langwenchong.gitee.io/figure-bed/20211128193745.png)

配置成功后我们发现正如之前的那个比喻所说，现在这个tomcat01容器同时属于两个网络了，因此他有两个ip分别对应docker0和mynet网络，因此此时tomcat-mynet-01容器可以ping通tomcat01了

![](https://langwenchong.gitee.io/figure-bed/20211128193942.png)

##### 思考：此时tomcat01能否使用ping+容器名的形式ping通其他容器？

![](https://langwenchong.gitee.io/figure-bed/20211128194259.png)

很显然结果应该是tomcat01只能使用ping+容器名的形式连通mynet下的容器，这就好比你假如了A组织和B组织，虽然此时你能与B组织交流了，但是在与A组织下的成员交流时还是要遵循之前A组织的规则，因此tomcat01在和tomcat02连通时还是要遵循docker0网络基于ip的规则，但是在和tomcat-mynet-01和tomcat-mynet-02容器连通时可以基于容器名。

{% note info,

但是如果此时tomcat02也用connect指令加入到了mynet网络下，那么此时tomcat01就可以和tomcat02使用ping+容器名的形式ping通了

%}

### 实战：部署redis集群

这部分博主还没有学习redis，暂时不写了，您可以参考这里学习

{% link redis集群部署实战, https://www.bilibili.com/video/BV1og4y1q7M4?p=38&spm_id_from=pageDriver %}

如果一个月内博主还没有更新，请@我督促我去学习😂

### SingBoot微服务打包Docker镜像

接下来我们学习一下如何将简单的SpringBoot项目打包成Docker镜像然后部署到服务器上，首先我们打开idea创建一个SpringBoot项目，选择Sping Initializer创建项目然后选择最简单web功能即可，这里我们新建一个Controller包进行测试，里面添加一个HelloController.java文件，内容如下

```java
package com.example.demo.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Author Lang wenchong
 * @Date 2021/11/28 20:21
 * @Version 1.0
 */

@RestController
public class HelloController {
    @RequestMapping("/hello")
    public String hello(){
        return "hello,wenchong😎";
    }
}

```

然后我们本地先测试一下，运行以后前往`http://localhost:8080/hello`查看能够正确返还字符串

![](https://langwenchong.gitee.io/figure-bed/20211128202631.png)

成功以后我们开始进行项目的打包，点击右侧Maven栏demo声明周期下的package选项进行打包

![](https://langwenchong.gitee.io/figure-bed/20211128203035.png)

然后我们进行DockerFile的编写，首先我们安装一下Docker的高亮插件直接在设置->插件中搜索Docker安装即可，安装完成以后我们在demo目录下新建一个`Dockerfile`文件，命名正确且插件安装成功后这个文件的小图标会有一个小鲸鱼，然后我们开始写Dockerfile脚本文件如下

```dockerfile
#引入项目需要的jdk基础环境
FROM java:8
#引入项目文件
COPY *.jar /app.jar
#设置及端口
CMD ["--server.port=8080"]
#项目在容器内暴露8080端口上运行
EXPOSE 8080
#启动项目
ENTRYPOINT ["java","-jar","/app.jar"]
```

然后我们打开xftp将jar包和Dockerfile上传到服务器的`/home/idea`下，然后我们在这个目录下进行打包，实际上就是运行Dockerfile创建镜像，如下图

![](https://langwenchong.gitee.io/figure-bed/20211128204308.png)

这样我们就打包完成了得到一个`springboot-project`镜像，然后我们运行镜像创建一个容器查看能否完美部署运行，为了方便测试我们将容器端口暴露映射到主机的8081端口上

![](https://langwenchong.gitee.io/figure-bed/20211128204515.png)

然后我们在浏览器中输入`http://服务器ip:8081/hello`即可查看到入口页面

![](https://langwenchong.gitee.io/figure-bed/20211128204622.png)

#### 思考：因此我们最终只需要给别人什么文件用来部署上线呢？

我们发现实际上还是要将项目打包成jar包，然后我们在编辑Dockerfile是引入了这个jar包来构建镜像，因此我们最终创建容器时这个容器会包含有这个项目并且自动部署运行，并且使用FROM引入了需要的jdk环境。因此我们实际上最终只需要给别人发送这个使用Dockerfile构建的镜像即可了，这个别人只需要pull这个镜像然后run创建并启动容器即可，剩下的环境配置容器会自动完成，非常简单！

### 总结

自此， 我们花费了大约1周的时间入门了Docker，剩下的进阶篇我们以后再更。相较于一周前我们对Docker的懵懂到如今基本掌握Docker应用，细细想来，这一路并不是很艰难，学习的过程并不仅仅充满了汗水与枯燥，实际上也伴随着学习新知识后的充实与快乐，希望你我都能坚持学习，不辜负自己的一片野心😊！