{% block content %}
  {######################}
  {### LINKS BLOCK ###}
  {######################}
<div id="about">
  <link href="https://cdn.bootcss.com/botui/0.3.9/botui.min.css" rel="stylesheet">
  <link href="https://cdn.bootcss.com/botui/0.3.9/botui-theme-default.css" rel="stylesheet">
  <script src="/lib/githubcalendar.js"></script>
  <div id="me">
    <div class="item">
      <img src="https://wenchong.space/images/author.jpeg">
      <span>Langwenchong</span>
      <i class="fas fa-pencil-alt"></i>
    </div>
     <div id="hello-mashiro">
        <center>
            <p>
            </p>
            <h4>
                &nbsp;<ruby>
                    ?chongchong??? ??
                </ruby>
                </h4>
                <span style="font-size: xx-small; color:var(--font-color);">??WiFi??-5G</span>
            <p>
            </p>
        </center>
        <bot-ui>
      </bot-ui>
      <script src="/js/about.js"></script>
      <script type="text/javascript">
       bot_ui_ini()
    </script>
    </div>
  </div>
  <div id="skills">
    <h4>&nbsp;<ruby>?chongchong???? ???</ruby></h4>
    <div id="skill">
    </div>
    <script src="https://cdn.jsdelivr.net/npm/echarts@5.0.2/dist/echarts.min.js"></script>
  <script type="text/javascript">
            var myChart = echarts.init(document.getElementById('skill'));
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
                        radius: [20, 100],
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
            myChart.setOption(option);
    </script>
  </div>
  <div id="calendar">
    <h4>&nbsp;<ruby>????,??????</ruby></h4>
    <div id="github_container"></div>
  </div>
</div>
<style>
#me{
  flex-direction:column;
  border-radius:7px;
  padding:20px 15px;
  min-height:200px;
  display:flex;
  justify-content: space-around;
  align-items: center;
  box-shadow:0 1px 10px 5px rgba(0,0,0,0.1);
  margin-bottom:15px;
}
#about h4{
  margin:0;
}
#me #hello-mashiro{
  width:80%;
}
#calendar{
  display:flex;
  flex-direction:column;
  justify-content:space-around;
  align-items:center;
  height:350px;
  border-radius:7px;
  padding:20px 15px;
  box-shadow:0 1px 10px 5px rgba(0,0,0,0.1);
}
#github_container{
  width:100%;
}
#skills{
  display:flex;
  flex-direction:column;
  justify-content:space-around;
  align-items:center;
  min-height:300px;
  border-radius:7px;
  padding:20px 15px;
  box-shadow:0 1px 10px 5px rgba(0,0,0,0.1);
  margin-bottom:15px;
}
#skills #skill{
  display:flex;
  justify-content:center;
  align-items:center;
  width:100%;
  min-height:350px;
}
.item{
  transition:.3s ease-in-out;
  position: relative;
  border-radius: 60px;
  overflow: hidden;
}
.item:hover{
  width:320px;
  background:url("https://ae01.alicdn.com/kf/H3342af90d24b4d62b9bbfec9688ccc25M.gif");
}
.item span{
    font-size:25px;
    font-weight:600;
    font-family: 'Dancing Script';
    margin-left:120px;
    line-height: 120px;
}
.item img{
    width:120px;
    height:120px;;
    border-radius: 60px;
}

@media screen and (max-width: 500px){
  #skills{
    display:none;
  }
  #calendar{
    height:230px;
  }
}
</style>
  {##########################}
  {### END LINKS BLOCK ###}
  {##########################}
{% endblock %}