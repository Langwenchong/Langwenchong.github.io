
{% block content %}
  {######################}
  {### LINKS BLOCK ###}
  {######################}
  <style>
        #links {
            display:flex;
            flex-direction:column;
        }
        #links .container{
            margin: 40px 0;
            display: flex;
            position: relative;
            align-items: center;
            width:100%;
            height:400px;
            overflow:hidden;
            cursor:pointer;
        }
        #links .card {
            cursor:pointer;
            position: absolute;
            width: 300px;
            height: 300px;
            background:#fff;
            box-shadow: 0 15px 35px rgba(0, 0, 0, .2);
            border-radius: 15px;
            display: flex;
            left:50%;
            transform:translateX(-50%);
            justify-content: center;
            align-items: center;
            backdrop-filter: blur(10px);
            transition:.5s;
            z-index:2;
        }
        #links .container:hover .card{
            background:rgb(22, 22, 35,.9);
            height:400px;
            left:0px;
            transform:translateX(0px);
        }
        #links .container .card-hidden{
            box-shadow: 0 15px 35px rgba(0, 0, 0, .2);
            position:absolute;
            width:450px;
            height:400px;
            left:100px;
            top:0px;
            border-radius: 15px;
            opacity:0;
            transition:.5s;
            transition-delay:.6s;
            overflow:hidden;
            z-index:1;
        }
        #links .container .card-hidden img{
            height:100%;
            object-fit:cover;
            border-radius: 15px;
        }
        #links .container:hover .card-hidden{
            opacity:1;
            left:300px;
        }
        #links .card .content {
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            opacity: .5;
            transition: .5s;
            padding:0px;
        }
        #links .container:hover .card .content {
            opacity: 1;
            transform:translateY(-20px);
        }
        #links .card .content .imgBx {
            position: relative;
            width: 150px;
            height: 150px;
            border-radius: 50%;
            overflow: hidden;
            border: 10px solid rgba(0, 0, 0, .25);
        }
        #links .card .content .imgBx img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition:.5s
        }
        #links .container:hover .content .imgBx img{
            transform:rotate(360deg);
        }
        #links .card .content .contentBx h3 {
            font-family: 'Poppins', sans-serif;
            margin:0px;
            padding:0px;
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 2px;
            font-weight: 500;
            font-size: 18px;
            text-align: center;
            margin: 20px 0 10px;
            line-height: 1.1em;
            color:#333;
            transition:.5s;
        }
        #links .container:hover .content .contentBx h3 {
            color:#fff;
        }
        #links .card .content .contentBx  span {
            font-family: 'Poppins', sans-serif;
            font-size: 12px;
            font-weight: 300;
            text-transform: initial;
            color:#333;
        }
        #links .container:hover .content .contentBx h3,#links .container:hover .content .contentBx span{
            color:#fff;
        }
        #links .card .sci {
            position: absolute;
            bottom: 50px;
            display: flex;
            padding:0px;
            margin:0px;
        }

        #links .card .sci li {
            margin:0px;
            padding:0px;
            list-style: none;
            margin: 0 10px;
            transform: translateY(40px);
            transition: .5s;
            opacity: 0;
            transition-delay: calc(0.1s * var(--i));
        }
        #links .container:hover .sci li {
            transform: translateY(0px);
            opacity: 1;
        }
        #links .card .sci li a {
            color: #fff;
            font-size: 24px;
            margin:0px;
            padding:0px;
            transition:.5s;
            text-decoration:none;
        }
        .lb a{
            border:0px!important;
        }
         h2{
            transition:.5s;
            cursor:pointer;
        }
         h2:hover{
            transform:translate(-15px,-9px);
        }
        .lb {
            margin:0 auto;
            width:90%;
            height: 200px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .lb a {
            display: block;
            position : relative;
            width: 100px;
            height: 100px;
            display: flex;
            justify-content: center;
            align-items : center;
            text-decoration: none!important;
        }
        .lb .icon {
            margin-right:20px;
            margin-left:20px;
            box-sizing:border-box;
            position: absolute;
            width: 80px;
            height: 80px;
            color: var(--color);
            display: flex;
            justify-content: center;
            align-items: center;
            transition : all .3s;
        }
        .lb a:hover .icon {
            transform: rotate(-30deg) skew(20deg);
        }

        .lb .icon::after {
            position: absolute;
            content  : '';
            box-sizing  : border-box;
            width : 80px;
            height  : 80px;
            border-radius: 10px;
            border: 2px solid var(--color);
        }
        .lb a:hover .icon::after {
            box-shadow: -1px 1px 3px var(--color);
        }
        .lb .icon i {
            font-size: 48px;
        }
        .lb .icon span {
            display : block;
            position : absolute;
            box-sizing : border-box;
            width : 80px;
            height : 80px;
            border-radius: 10px;
            border : 2px solid var(--color);
            transform : translateX(calc(var(--i) * -8px)) translateY(calc(var(--i) * 8px));
            opacity : 0;
            box-shadow : -1px 1px 3px var(--color);
            transition  : all 0.3s;
        }

        .lb a:hover .icon span {
            opacity: calc((4 - var(--i)) * 0.25);
        }
        .lb .text {
            position: absolute;
            bottom : 30px;
            font-size: 24px;
            color : var(--color);
            opacity : 0;
            transition: all 0.3s;
        }
        .lb a:hover .text {
            opacity: 1;
            bottom : -60px;
        }
    </style>
        <link href="https://cdn.bootcdn.net/ajax/libs/font-awesome/5.15.1/css/all.css" rel="stylesheet">
        <h2>「感谢你的出现，助我勇敢前行.」</h2>
        <div class="lb">
        <a href="https://github.com/" style="--color:#555">
            <div class="icon">
                <span style="--i:1"></span>
                <span style="--i:2"></span>
                <span style="--i:3"></span>
                <i class="fab fa-github"></i>
            </div>
            <div class="text">Github</div>
        </a>
        <a href="https://cloud.tencent.com/" style="--color:#FDCB6E">
            <div class="icon">
                <span style="--i:1"></span>
                <span style="--i:2"></span>
                <span style="--i:3"></span>
                <i class="fas fa-cloud"></i>
            </div>
            <div class="text">腾讯云</div>
        </a>
        <a href="https://www.superbed.cn/" style="--color:#FD79A8">
            <div class="icon">
                <span style="--i:1"></span>
                <span style="--i:2"></span>
                <span style="--i:3"></span>
                <i class="far fa-image"></i>
            </div>
            <div class="text">聚合图床</div>
        </a>
        <a href="https://hexo.io/zh-cn/index.html" style="--color:#0984E3">
            <div class="icon">
                <span style="--i:1"></span>
                <span style="--i:2"></span>
                <span style="--i:3"></span>
                <i class="fab fa-hackerrank"></i>
            </div>
            <div class="text">Hexo</div>
        </a>
        <a href="https://nodejs.org/en/" style="--color:#00B894">
            <div class="icon">
                <span style="--i:1"></span>
                <span style="--i:2"></span>
                <span style="--i:3"></span>
                <i class="fab fa-node"></i>
            </div>
            <div class="text">Node.js</div>
        </a>
        <a href="https://fontawesome.com/icons" style="--color:#E056FD">
            <div class="icon">
                <span style="--i:1"></span>
                <span style="--i:2"></span>
                <span style="--i:3"></span>
                <i class="fab fa-font-awesome-alt"></i>
            </div>
            <div class="text">FontAwesome</div>
        </a>
    </div>
        <h2>「我们各奔东西，然后，更高处见.」</h2>
        <div id="links">
        
        {% for link in theme.friendlinks %}
        <div class="container">
            <div class="card-hidden">
                <img src="{{link.background}}" alt="background"/>
            </div>
            <div class="card">
                <div class="content">
                    <div class="imgBx">
                        <img src="{{link.avatar}}" alt="{{link.name}}">
                    </div>
                    <div class="contentBx">
                        <h3>{{link.name}}
                            <br />
                            <span>-{{link.info}}-</span>
                        </h3>
                    </div>
                </div>
                <ul class="sci">
                    <li style="--i:1">
                        <a href="{{link.site}}">
                            <i class="fas fa-blog"></i>
                        </a>
                    </li>
                    <li style="--i:2">
                        <a href="{{link.warehouse}}">
                            <i class="fab fa-github"></i>
                        </a>
                    </li>
                    <li style="--i:3">
                        <a href="{{link.qq}}">
                            <i class="fab fa-qq"></i>
                        </a>
                    </li>
                </ul>
            </div>
            </div>
        {% endfor %}
        <hr>
        <div class="message">
            <b>申请要求</b>
            <ol>
                <li>内容持续更新且可以稳定访问</li>
                <li>网页整洁无繁杂广告推广</li>
            </ol>
            <b>友链声明</b>
            <ol>
                <li>本站会主动保存您的 HTTPS 形式的头像图片链接</li>
                <li>本站会定期清理无法访问的友链，如果更换了链接信息请至评论区留言，谢谢合作！</li>
                <li>本站会定期查看双方是否互为友链，如果取消本站友链，本站也会将您的友链移除</li>
            </ol>
            <b>申请方式</b>
            <p>先将本站的友链添加到您的友链，相关信息如下<br/>
               然后按照以下格式在本站留言区留言或者私信博主，待博主为您添上友链
            </p>
            <ul>
                <li>名称：Chong's Blog</li>
                <li>头像链接：http://wenchong.space/images/author.jpeg</li>
                <li>主页链接：http://www.wenchong.space/ </li>
                <li>主页介绍：回过头来看，那些让你寝食难安的事，大多败给了想象，加油干，没那么难 </li>
                <li>git仓库：https://wwww.github.com/Langwenchong</li>
                <li>QQ：1422257646</li>
            </ul>
        </div>

        </div>
  
  {##########################}
  {### END LINKS BLOCK ###}
  {##########################}
{% endblock %}