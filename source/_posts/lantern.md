---
title: volantis迎春攻略
comments: false
top: false
date: 2022-01-19 14:25:44
tags: [hexo,春节]
categories: 
	- [知识分享,魔改攻略]
headimg: https://langwenchong.gitee.io/figure-bed/20220118205901.png
---

灯花助春意，舞绶织欢心。新的一年，新的气象，快来为你的博客挂上漂漂亮亮的小🏮吧！哦对了，翀翀还斥巨资购买了大🎉，还不快进来看一看🥰~

<!-- more -->

hi！volantis的小伙伴们，你们好😁~春节快到了，为了喜迎新春，翀翀为大家购买了大灯笼和烟花来装饰博客，跟着我一起来为你的博客进行以下迎春前的装点吧！

{% note quote,

我的volantis版本是4.x，请确保你的volantis版本和我一致，版本不同会导致操作略有不同，如果不会可以线下联系我求助！

%}

### 挂灯笼

#### 一、创建festival.styl用来存放css

首先我们需要做一些准备，请在`volantis/source/css/style.styl`中加入如下代码：

```css
@import '_defines/*'

// Project
@import '_tag-plugins/*'
@import '_highlight'
@import '_plugins/index'
@import '_layout/*'
// 自定义样式，文件夹名称可根据喜好修改
@import '_mogai/*' 
```

然后在`volantis/source/css/`下创建`_mogai`文件夹，然后在下方创建`festival.styl`文件，目录结构如下：

![](https://langwenchong.gitee.io/figure-bed/20220118202106.png)

#### 二、加入灯笼的css样式

在刚刚新建的`festival.styl`中加入灯笼的css样式，代码如下：

{% folding 灯笼样式festival.styl %}

```css
.deng-box {
    position: fixed;
    top: -40px;
    right: 150px;
    z-index: 9999;
    pointer-events: none;
}

.deng-box1 {
    position: fixed;
    top: -30px;
    right: 10px;
    z-index: 9999;
    pointer-events: none
}

.deng-box2 {
    position: fixed;
    top: -40px;
    left: 150px;
    z-index: 9999;
    pointer-events: none
}

.deng-box3 {
    position: fixed;
    top: -30px;
    left: 10px;
    z-index: 9999;
    pointer-events: none
}

.deng-box1 .deng,
.deng-box3 .deng {
    position: relative;
    width: 120px;
    height: 90px;
    margin: 50px;
    background: #d8000f;
    background: rgba(216, 0, 15, .8);
    border-radius: 50% 50%;
    -webkit-transform-origin: 50% -100px;
    -webkit-animation: swing 5s infinite ease-in-out;
    box-shadow: -5px 5px 30px 4px #fc903d
}

.deng {
    position: relative;
    width: 120px;
    height: 90px;
    margin: 50px;
    background: #d8000f;
    background: rgba(216, 0, 15, .8);
    border-radius: 50% 50%;
    -webkit-transform-origin: 50% -100px;
    -webkit-animation: swing 3s infinite ease-in-out;
    box-shadow: -5px 5px 50px 4px #fa6c00
}

.deng-a {
    width: 100px;
    height: 90px;
    background: #d8000f;
    background: rgba(216, 0, 15, .1);
    margin: 12px 8px 8px 8px;
    border-radius: 50% 50%;
    border: 2px solid #dc8f03
}

.deng-b {
    width: 45px;
    height: 90px;
    background: #d8000f;
    background: rgba(216, 0, 15, .1);
    margin: -4px 8px 8px 26px;
    border-radius: 50% 50%;
    border: 2px solid #dc8f03
}

.xian {
    position: absolute;
    top: -20px;
    left: 60px;
    width: 2px;
    height: 20px;
    background: #dc8f03
}

.shui-a {
    position: relative;
    width: 5px;
    height: 20px;
    margin: -5px 0 0 59px;
    -webkit-animation: swing 4s infinite ease-in-out;
    -webkit-transform-origin: 50% -45px;
    background: orange;
    border-radius: 0 0 5px 5px
}

.shui-b {
    position: absolute;
    top: 14px;
    left: -2px;
    width: 10px;
    height: 10px;
    background: #dc8f03;
    border-radius: 50%
}

.shui-c {
    position: absolute;
    top: 18px;
    left: -2px;
    width: 10px;
    height: 35px;
    background: orange;
    border-radius: 0 0 0 5px
}

.deng:before {
    position: absolute;
    top: -7px;
    left: 29px;
    height: 12px;
    width: 60px;
    content: " ";
    display: block;
    z-index: 999;
    border-radius: 5px 5px 0 0;
    border: solid 1px #dc8f03;
    background: orange;
    background: linear-gradient(to right, #dc8f03, orange, #dc8f03, orange, #dc8f03)
}

.deng:after {
    position: absolute;
    bottom: -7px;
    left: 10px;
    height: 12px;
    width: 60px;
    content: " ";
    display: block;
    margin-left: 20px;
    border-radius: 0 0 5px 5px;
    border: solid 1px #dc8f03;
    background: orange;
    background: linear-gradient(to right, #dc8f03, orange, #dc8f03, orange, #dc8f03)
}

.deng-t {
    font-family:  Arial, Lucida Grande, Tahoma, sans-serif;
    font-size: 3.2rem;
    color: #dc8f03;
    font-weight: 700;
    line-height: 85px;
    text-align: center
}

.night .deng-box,
.night .deng-box1,
.night .deng-t {
    background: 0 0 !important
}

@-moz-keyframes swing {
    0% {
        -moz-transform: rotate(-10deg)
    }

    50% {
        -moz-transform: rotate(10deg)
    }

    100% {
        -moz-transform: rotate(-10deg)
    }
}

@-webkit-keyframes swing {
    0% {
        -webkit-transform: rotate(-10deg)
    }

    50% {
        -webkit-transform: rotate(10deg)
    }

    100% {
        -webkit-transform: rotate(-10deg)
    }
}

@keyframes swing {
    0% {
        -webkit-transform: rotate(-10deg)
    }

    50% {
        -webkit-transform: rotate(10deg)
    }

    100% {
        -webkit-transform: rotate(-10deg)
    }
}
```

{% endfolding %}

#### 三、添加灯笼的html代码

接下来我们引入灯笼的html代码，我们需要将以下代码加入到`volantis/layout/layout.ejs`中`<div id="l_body>"`上面如下所示：

{% folding 灯笼的结构html %}

```html
 <!-- 春节灯笼 -->
        <div class="deng-box2">
          <div class="deng">
            <div class="xian">

            </div>
            <div class="deng-a">
              <div class="deng-b">
                <div class="deng-t">年</div>
              </div>
            </div>
            <div class="shui shui-a">
              <div class="shui-c">

              </div>
              <div class="shui-b"></div>
            </div>
          </div>
        </div>
        <div class="deng-box3">
          <div class="deng">
            <div class="xian">

            </div>
            <div class="deng-a">
              <div class="deng-b">
                <div class="deng-t">新</div>
              </div>
            </div>
            <div class="shui shui-a">
              <div class="shui-c"></div>
              <div class="shui-b">

              </div>
            </div>
          </div>
        </div>
        <div class="deng-box1">
          <div class="deng">
            <div class="xian">

            </div>
            <div class="deng-a">
              <div class="deng-b">
                <div class="deng-t">乐</div>
              </div>
            </div>
            <div class="shui shui-a">
              <div class="shui-c"></div>
              <div class="shui-b"></div>
            </div>
          </div>
        </div>
        <div class="deng-box">
          <div class="deng">
            <div class="xian">

            </div>
            <div class="deng-a">
              <div class="deng-b">
                <div class="deng-t">快</div>
              </div>
            </div>
            <div class="shui shui-a">
              <div class="shui-c">

              </div>
              <div class="shui-b"></div>
            </div>
          </div>
        </div>
        <!-- 春节灯笼 -->

....
<div id="l_body">
```

{% endfolding %}

自此我们就完成了灯笼的引入了，你可以刷新你的博客看一看此时博客上已经挂上大灯笼啦😜！如下所示：

![](https://langwenchong.gitee.io/figure-bed/20220118203955.png)

### 夜间模式加入烟花

夜深人静了，正是放烟花的好时机啦！因此接下来我们引入烟花。

#### 一：加入canvas背景

我们前往`volantis/layout/layout.ejs`在`<div id="l_body">`的后面加入以下代码：

```html
...
<div id="l_body">

<canvas id="fireworks" style="position:fixed; height: 100%; width: 100%;"></canvas>
```

#### 二、装载烟花js

我们在`volantis/source/js/app.js`的最下方加入如下代码：

{% folding 装载烟花js %}

```js
$(function () {
  var canvas = $('#fireworks')[0];
  canvas.width = $(window).width();
  canvas.height = $(window).height();
  var ctx = canvas.getContext('2d');

  // resize
  $(window).on('resize', function () {
    canvas.width = $(window).width();
    canvas.height = $(window).height();
    ctx.fillStyle = '#000';
    ctx.fillRect(0, 0, canvas.width, canvas.height);
  });

  // init
  ctx.fillStyle = '#000';
  ctx.fillRect(0, 0, canvas.width, canvas.height);
  // objects
  var listFire = [];
  var listFirework = [];
  var fireNumber = 10;
  var center = { x: canvas.width / 2, y: canvas.height / 2 };
  var range = 100;
  for (var i = 0; i < fireNumber; i++) {
    var fire = {
      x: Math.random() * range / 2 - range / 4 + center.x,
      y: Math.random() * range * 2 + canvas.height,
      size: Math.random() + 0.5,
      fill: '#fd1',
      vx: Math.random() - 0.5,
      vy: -(Math.random() + 4),
      ax: Math.random() * 0.02 - 0.01,
      far: Math.random() * range + (center.y - range)
    };
    fire.base = {
      x: fire.x,
      y: fire.y,
      vx: fire.vx
    };
    //
    listFire.push(fire);
  }

  function randColor() {
    var r = Math.floor(Math.random() * 256);
    var g = Math.floor(Math.random() * 256);
    var b = Math.floor(Math.random() * 256);
    var color = 'rgb($r, $g, $b)';
    color = color.replace('$r', r);
    color = color.replace('$g', g);
    color = color.replace('$b', b);
    return color;
  }

  (function loop() {
    requestAnimationFrame(loop);
    update();
    draw();
  })();

  function update() {
    for (var i = 0; i < listFire.length; i++) {
      var fire = listFire[i];
      //
      if (fire.y <= fire.far) {
        // case add firework
        var color = randColor();
        for (var i = 0; i < fireNumber * 5; i++) {
          var firework = {
            x: fire.x,
            y: fire.y,
            size: Math.random() + 1.5,
            fill: color,
            vx: Math.random() * 5 - 2.5,
            vy: Math.random() * -5 + 1.5,
            ay: 0.05,
            alpha: 1,
            life: Math.round(Math.random() * range / 2) + range / 2
          };
          firework.base = {
            life: firework.life,
            size: firework.size
          };
          listFirework.push(firework);
        }
        // reset
        fire.y = fire.base.y;
        fire.x = fire.base.x;
        fire.vx = fire.base.vx;
        fire.ax = Math.random() * 0.02 - 0.01;
      }
      //
      fire.x += fire.vx;
      fire.y += fire.vy;
      fire.vx += fire.ax;
    }

    for (var i = listFirework.length - 1; i >= 0; i--) {
      var firework = listFirework[i];
      if (firework) {
        firework.x += firework.vx;
        firework.y += firework.vy;
        firework.vy += firework.ay;
        firework.alpha = firework.life / firework.base.life;
        firework.size = firework.alpha * firework.base.size;
        firework.alpha = firework.alpha > 0.6 ? 1 : firework.alpha;
        //
        firework.life--;
        if (firework.life <= 0) {
          listFirework.splice(i, 1);
        }
      }
    }
  }

  function draw() {
    // clear
    ctx.globalCompositeOperation = 'source-over';
    ctx.globalAlpha = 0.18;
    ctx.fillStyle = '#000';
    ctx.fillRect(0, 0, canvas.width, canvas.height);

    // re-draw
    ctx.globalCompositeOperation = 'screen';
    ctx.globalAlpha = 1;
    for (var i = 0; i < listFire.length; i++) {
      var fire = listFire[i];
      ctx.beginPath();
      ctx.arc(fire.x, fire.y, fire.size, 0, Math.PI * 2);
      ctx.closePath();
      ctx.fillStyle = fire.fill;
      ctx.fill();
    }

    for (var i = 0; i < listFirework.length; i++) {
      var firework = listFirework[i];
      ctx.globalAlpha = firework.alpha;
      ctx.beginPath();
      ctx.arc(firework.x, firework.y, firework.size, 0, Math.PI * 2);
      ctx.closePath();
      ctx.fillStyle = firework.fill;
      ctx.fill();
    }
  }
})()
```

{% endfolding %}

#### 三、夜间开启烟花

但是此时默认烟花是隐藏的，为了不扰民，我们只能在夜间偷偷放🎉,因此我们还需要在夜间模式中开启烟花，前往`volantis/source/css/_plugins/dark.styl`在最下方加入如下代码：

```css
#fireworks{
  display: block  
}
```

自此我们就完成了烟花的装载，现在刷新博客打开夜间模式滑动至最底方你就可以看到烟花啦，24h不间断燃放，经费全部由翀翀来出🤣。

![](https://langwenchong.gitee.io/figure-bed/20220118205031.png)

怎么样，是不是装饰完年味“nao”一下就出来啦~如果你喜欢此篇博客就快点安利给好朋友一起为自己的博客装点吧！最后的最后，翀翀提前祝愿屏幕前的大帅哥大美女新年快乐啦🧧！

