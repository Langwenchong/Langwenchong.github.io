---
title: 
layout: history
sidebar: []
comments: false
date: 2021-05-23 22:49:03
---

<fieldset class="elem-field field-title"><legend>雨中的博客：博客大事记</legend></fieldset>

<style>
    .field-title {
    margin: 10px 0 20px;
    border-width: 1px 0 0;
}
.elem-field {
    border-color: #e6e6e6;
    margin-bottom: 10px;
    padding: 0;
    border-style: solid;
}
fieldset {
    border: 1px solid silver;
    margin: 0 2px;
    padding: .35em .625em .75em;
}
    .elem-field legend {
    margin-left: 20px;
    padding: 0 10px;
    font-size: 20px;
    font-weight: 300;
}
</style>


{% timeline %}

{% timenode 很久很久以前 %}

**一个小白刚刚踏进CS的世界，被眼花缭乱的技术所吸引，他决定从有🖐️就能学的前端技术开始学起......**

{% endtimenode %}

{% timenode 2020-07-17 与hexo的渊源%}

**2020的盛夏，鹏鹏🤨发现了hexo大陆，并搭建了[pengpenglang](https://www.pengpenglang.vip)王国🏰，他极力邀请帅气的翀翀😎一同走入hexo大陆。但是翀翀对此嗤之以鼻🙃，就这样与hexo完美的错过...**

{% endtimenode %}

{% timenode 2020-10-13 博客搭建 %}

**伟大的真香定律终究发生了，翀翀最终使用next主题搭建了自己的第一个hexo博客🤣！**

{% endtimenode %}

{% timenode 2020-10-21 第一篇文章 %}

**博主发表重要讲话📢--《[序言--博客起航寄语](https://wenchong.space/2020/10/21/Helloworld/)》**

{% endtimenode %}

{% timenode 2020-11-27 域名更换 %}

**🎉域名正式更换为wenchong.space**

{% endtimenode %}

{% timenode 2020-12-17 页面优化 %}

**更新自定义友链页面，并发布第一片魔改教程[《hexo主题美化--友链编写》](https://wenchong.space/2020/12/07/friendlinks/)，自此翀翀的魔改生涯正式开始🍺~**

{% endtimenode %}

{% timenode 2021-02-10  页面优化 %}

**庆祝新年，喜迎新春，小破站挂上大🏮7天，博主勤奋的更新了迎春攻略[《Next主题添加🏮迎春攻略》](https://wenchong.space/2021/02/20/lantern/)，但是忘记发表年度总结与新年寄语😝（下次一定！）**

{% endtimenode %}

{% timenode 2021-03-05 页面优化 %}

**使用gitalk创建留言页面，感谢朋友的捧场💌**

{% endtimenode %}

{% timenode 2021-10-6 页面优化 %}

**更新自定义的关于页面，但是迟迟没有更新教程...（绝对不是懒🙈）**

{% endtimenode %}

{% timenode 2021-05-01 再起航%}

**加入volantis大家庭👪，并利用假期魔改成现在的样子（自我感觉满意🥰，第一次意识到学习前端后的用途）。**

{% endtimenode %}

{% timenode 2021-05-10 页面优化%}

**盛夏将至，博主斥💰为聊天室引入二手大空调🌡️**

{% endtimenode %}

{% timenode 2021-05-20 页面优化%}

**📸时光相册页面搭建成功并上传🤳！**

{% endtimenode %}

{% timenode 2021-06-05 博客迁移%}

**使用腾讯☁️服务器运行博客，翀翀成为真正意义上的站长👨‍🚀！**

{% endtimenode %}

{% timenode 2021-07-06 页面优化%}

**对水文章进行了清理，同时开设专栏来存储笔记和刷题日志，首页只显示总结性博文，同时配以文章头图装饰，使得博客整体更加有序整洁！**

{% endtimenode %}

{% timenode 2021-07-12面优化%}

**创建网址收藏百宝箱页面，大大提升工作效率！🚀**

{% endtimenode %}

{% endtimeline %}

<div id="cloud">
     <p>No <br>More!</p>
</div>
<style>
    #cloud{
        filter:brightness(104%);
        display:flex;
        justify-content:center;
        margin-top:50px;
        margin-bottom:50px;
    }
    #cloud p {
            position: relative;
            text-align: center;
            text-transform: uppercase;
            font-weight: bold;
            font-size: 15px;
            color: #774f38;
            background: #ece5ce;
            padding: 20px;
            box-shadow: 20px 20px #83af9b;
            border-radius: 11px;
			width:158px;
            animation: float 5s ease-in-out infinite;
        }


        #cloud p::after {
            content: '.';
            font-weight: bold;
            text-shadow: 22px 22px #83af9b;
            -webkit-text-fill-color: #ece5ce;
            text-align: left;
            font-size: 55px;
            width: 55px;
            height: 11px;
            line-height: 30px;
            border-radius: 11px;
            background: #ece5ce;
            position: absolute;
            bottom: -30px;
            left: 0;
            box-shadow: 22px 22px #83af9b;
            z-index:-2;
            animation:float2 5s ease-in-out infinite;
        }
    
        @keyframes float {
            0% {
                transform: translateY(0px);
            }
    
            50% {
                transform: translateY(-20px);
            }
    
            100% {
                transform: translateY(0px);
            }
        }
        @keyframes float2 {
            0%{
                line-height:30px;
                transform:translateY(0px);
            }
            55%{
                transform:translateY(-20px);
            }
            60%{
                line-height:10px;
            }
            100%{
                line-height:30px;
                transform: translateY(0px);
            }
        }
        @media screen and (max-width: 500px){
      		#cloud {
          margin-top:30px;
      }
    }

</style>



