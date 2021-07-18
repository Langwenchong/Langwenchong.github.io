---
layout: about
index: true
cover: true
sidebar: []
valine:
placeholder: 有什么想对我说的呢？
---

<div id="about">
    <link href="https://cdn.bootcss.com/botui/0.3.9/botui.min.css" rel="stylesheet">
<link href="https://cdn.bootcss.com/botui/0.3.9/botui-theme-default.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/echarts@5.0.2/dist/echarts.min.js"></script>
  <div id="me">
    <div class="item">
      <img src="https://gitee.com/Langwenchong/figure-bed/raw/master/author.jpeg">
    </div>
     <div id="hello-mashiro">
        <center>
            <p>
            </p>
            <h4>
                &nbsp;<ruby>
                    ⭐chongchong有话说 💬
                </ruby>
                </h4>
                <span style="font-size: xx-small; color:var(--font-color);">📱WiFi在线-5G</span>
            <p>
            </p>
        </center>
        <bot-ui>
      </bot-ui>
      <script data-pjax src="/js/about.js"></script>
      <script type="text/javascript">
       bot_ui_ini()
    </script>
    </div>
    <div id="disposition">
      <h4>&nbsp;<ruby>chongchong的人格类型 🔮</ruby></h4>
      <img width="80%" src="https://gitee.com/Langwenchong/figure-bed/raw/master/disposition.png">
      <small>@数据来源:<a href="https://www.16personalities.com/ch/%E4%BA%BA%E6%A0%BC%E6%B5%8B%E8%AF%95">16 Personalities</a></small>
    </div>
<div id="skills">
    <h4>&nbsp;<ruby>⭐chongchong的技术栈 🗂️</ruby></h4>
        {% echarts 450 '500px' %}
  			option = {
                legend: {
                    top: 'bottom'
                },
                toolbox: {
                    show: true,
                    feature: {
                        mark: { show: true },
                        dataView: { show: false, readOnly: true },
                        restore: { show: true },
                        saveAsImage: { show: false }
                    }
                },
                series: [
                    {
                        name: '',
                        type: 'pie',
                        radius: [30, 150],
                        center: ['50%', '50%'],
                        roseType: 'area',
                        itemStyle: {
                            borderRadius: 8
                        },
                        data: [
                            { value: 40, name: 'Html' },
                            { value: 38, name: 'Java' },
                            { value: 32, name: 'Vue' },
                            { value: 30, name: 'C/C++' },
                            { value: 28, name: 'Javascript' },
                            { value: 26, name: 'CSS' },
                            { value: 22, name: 'SQL' },
                            { value: 18, name: 'Verilog' }
                        ]
                    }
                ]
            };
      {% endecharts %}
  </div>
  <div class="container archive-calendar">
    <div class="card">
        <div id="post-calendar" class="card-content"></div>
    </div>
</div>
<div id="calendar">
    <h4>&nbsp;<ruby>⭐积跬步,成千里🗓️</ruby></h4>
    <div id="github_container"></div>







<style>
#me{
  flex-direction:column;
  padding:20px 15px;
  min-height:200px;
  display:flex;
  justify-content: space-around;
  align-items: center;
  margin-bottom:15px;
}
#about h4{
  margin:0!important;
    display:block;
    background:none;
}
#me #hello-mashiro{
  position:relative;
  top:-70px;
  width:80%;
  display:flex;
  flex-direction:column;
  justify-content: space-around;
  align-items: center;
}
	.botui-container {
    font-size: 14px;
    background-color: transparent!important;
    font-family: "Open Sans",sans-serif;
}
#calendar{
    position:relative;
    top:-70px;
  display:flex;
  flex-direction:column;
  justify-content:space-around;
  align-items:center;
  height:350px;
  border-radius:7px;
  padding:20px 15px;
}
#github_container{
  width:100%;
}
#disposition{
  top:-70px;
  display:flex;
  flex-direction:column;
  align-items:center;
  margin-bottom:120px;
}
#disposition img{
  width:100%;
}
#disposition small{
  align-self:flex-start;
}
#skills{
    top:-70px;
  position:relative;
  display:flex;
  flex-direction:column;
  justify-content:space-around;
  align-items:center;
  min-height:300px;
  border-radius:7px;
  margin-bottom:15px;
  width:100%;
    overflow:hidden;
}
.item{
  transition:.5s ;
  position: relative;
  width:200px;
  height:180px;
  display:flex;
  justify-content:center;
    align-items:center;
  border-radius: 60px;
  overflow: hidden;
}
.item:hover{
  transform:rotate(360deg);
}
.item img{
    width:120px;
    height:120px;;
    border-radius: 50%!important;
}
    @media screen and (max-width: 600px){
        #calendar{
            display:none;
        }
    }
@media screen and (max-width: 500px){
  #skills{
      display:none;
  }
}
</style>








