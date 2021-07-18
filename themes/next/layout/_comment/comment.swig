
{% block content %}
  {######################}
  {### LINKS BLOCK ###}
  {######################}
  <style>
    #comment{
        max-width:80%;
        margin:80px auto;
        position: relative;
        border: 2px solid #797979;
        border-top: 0;
        text-align: center;
        font-family: "Linux Biolinum","Noto Serif SC",Helvetica,Arial,Menlo,Monaco,monospace,sans-serif;
    }
    .poem-border{
        position:absolute;
        height:2px;
        width:27%;
        background-color:#797979;
    }
    .poem-left{
        left:0;
    }
    .poem-right{
        right:0;
    }
    #comment p{
        width: 70%;
        margin: auto;
        line-height: 30px;
        color: #797979;
        text-align: center;
    }
    #comment h1{
        font-weight:800;
        position: relative;
        margin-top: -20px;
        display: inline-block;
        letter-spacing: 4px;
        color: #797979;
        font-size: 30px;
        font-family: "Linux Biolinum","Noto Serif SC",Helvetica,Arial,Menlo,Monaco,monospace,sans-serif;
    }
    #comment #poem{
        font-size: 25px;
        text-align: center;
    }
    #comment #info{
        font-size: 15px;
        margin: 15px auto;
    }
    .comment{
        font-weight:700;
        width: 100%;
        margin: auto;
        line-height: 30px;
        margin-bottom:12px;
        color: #34495E;
        text-align: center;
        font-family: "Linux Biolinum","Noto Serif SC",Helvetica,Arial,Menlo,Monaco,monospace,sans-serif;
    }
  </style>
  <div id="comment">
    <div class="poem-border poem-left"></div>
    <div class="poem-border poem-right"></div>
    <h1>一言</h1>
    <p id="poem">世界之大为何我们相遇，难道是缘分，难道是天意。</p>
    <p id="info">曲婉婷 · 《 我的歌声里 》</p>
  </div>
    <p class="comment">这里是一个简单的留言板，由于gitalk的不稳定性，如果无法登陆请一段时间后再次尝试。</p>
    <p class="comment">1. 博客凌乱，希望标题达意，内容详略，愿君可于字句间有所收获。</p>
    <p class="comment">2. 本网站的各内容页都有版权标识，若能得欣赏，望转载标注来源。</p>
    <p class="comment">3. 反对抄袭与简单的复制粘贴，若发现本站有此现象，可严厉批评。</p>
    <p class="comment">4. 若见内容错漏、超链失效，愿寄言告，若愿分享君所得，将感泣。</p>
    <hr>
  
  {##########################}
  {### END LINKS BLOCK ###}
  {##########################}
{% endblock %}