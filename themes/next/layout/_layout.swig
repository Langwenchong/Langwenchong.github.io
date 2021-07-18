<!DOCTYPE html>
<html lang="{{ config.language }}">
<head>
  {{ partial('_partials/head/head.swig', {}, {cache: theme.cache.enable}) }}
  {% include '_partials/head/head-unique.swig' %}
  {{- next_inject('head') }}
  <title>{% block title %}{% endblock %}</title>
  {{ partial('_third-party/analytics/index.swig', {}, {cache: theme.cache.enable}) }}
  {{ partial('_scripts/noscript.swig', {}, {cache: theme.cache.enable}) }}
  <script src="https://cdn.jsdelivr.net/npm/pjax@0.2.8/pjax.js"></script>
  <link rel="stylesheet" href="/css/animation.css">
  <script>
  window.onload=function(){
    document.getElementById("preloader").style.opacity="0.4";
    document.getElementById("preloader").style.height="0";
  }
  </script>
</head>

<div id="preloader">
        <h2>Chong's Blog</h2>
        <div class="set">
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/D7C3AF267B544C78F76B1E9579505756.png" alt=""></div>
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/33EC9F01B1ABE93A9375B8B162F3DC15.png" alt=""></div>
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/A50FF8533DFC80B0A17BAB00702098C0.png" alt=""></div>
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/7F6209D83239CDB2FF0D5F6B04E77FC5.png" alt=""></div>
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/D7C3AF267B544C78F76B1E9579505756.png" alt=""></div>
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/33EC9F01B1ABE93A9375B8B162F3DC15.png" alt=""></div>
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/A50FF8533DFC80B0A17BAB00702098C0.png" alt=""></div>
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/7F6209D83239CDB2FF0D5F6B04E77FC5.png" alt=""></div>
        </div>
        <div class="set set2">
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/D7C3AF267B544C78F76B1E9579505756.png" alt=""></div>
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/33EC9F01B1ABE93A9375B8B162F3DC15.png" alt=""></div>
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/A50FF8533DFC80B0A17BAB00702098C0.png" alt=""></div>
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/7F6209D83239CDB2FF0D5F6B04E77FC5.png" alt=""></div>
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/D7C3AF267B544C78F76B1E9579505756.png" alt=""></div>
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/33EC9F01B1ABE93A9375B8B162F3DC15.png" alt=""></div>
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/A50FF8533DFC80B0A17BAB00702098C0.png" alt=""></div>
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/7F6209D83239CDB2FF0D5F6B04E77FC5.png" alt=""></div>
        </div>
        <div class="set set3">
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/D7C3AF267B544C78F76B1E9579505756.png" alt=""></div>
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/33EC9F01B1ABE93A9375B8B162F3DC15.png" alt=""></div>
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/A50FF8533DFC80B0A17BAB00702098C0.png" alt=""></div>
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/7F6209D83239CDB2FF0D5F6B04E77FC5.png" alt=""></div>
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/D7C3AF267B544C78F76B1E9579505756.png" alt=""></div>
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/33EC9F01B1ABE93A9375B8B162F3DC15.png" alt=""></div>
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/A50FF8533DFC80B0A17BAB00702098C0.png" alt=""></div>
            <div><img src="https://gitee.com/Langwenchong/figure-bed/raw/master/7F6209D83239CDB2FF0D5F6B04E77FC5.png" alt=""></div>
        </div>
    </div>
<body itemscope itemtype="http://schema.org/WebPage">
  <div class="container{%- if theme.motion.enable %} use-motion{%- endif %}">
    <div class="headband"></div>
    <header class="header" itemscope itemtype="http://schema.org/WPHeader">
      <div class="header-inner">{% include '_partials/header/index.swig' %}</div>
    </header>

    {{ partial('_partials/widgets.swig', {}, {cache: theme.cache.enable}) }}

    <main class="main">
      <div class="main-inner">
        <div class="content-wrap">
          {% include '_partials/header/sub-menu.swig' %}
          <div class="content {% block class %}{% endblock %}">
            {% block content %}{% endblock %}
          </div>
          {% include '_partials/comments.swig' %}
        </div>
        {%- if theme.sidebar.display !== 'remove' %}
          {% block sidebar %}{% endblock %}
        {%- endif %}
      </div>
    </main>

    <footer class="footer">
      <div class="footer-inner">
        {% include '_partials/languages.swig' %}
        {{ partial('_partials/footer.swig', {}, {cache: theme.cache.enable}) }}
        {{ partial('_third-party/statistics/index.swig', {}, {cache: theme.cache.enable}) }}
      </div>
    </footer>
  </div>

  {{ partial('_scripts/index.swig', {}, {cache: theme.cache.enable}) }}
  {{ partial('_third-party/index.swig', {}, {cache: theme.cache.enable}) }}

  {%- if theme.pjax %}
    <div id="pjax">
  {%- endif %}
  {% include '_third-party/math/index.swig' %}
  {% include '_third-party/quicklink.swig' %}

  {{- next_inject('bodyEnd') }}
  {%- if theme.pjax %}
    </div>
  {%- endif %}

  {% if theme.canvas_nest %}

    <script type="text/javascript" src="//cdn.bootcss.com/canvas-nest.js/1.0.0/canvas-nest.min.js"></script>

  {% endif %}


  {% include '_custom/custom.swig' %}
   <link rel="stylesheet" href="/dist/APlayer.min.css">
   <div id="aplayer"></div>
<script type="text/javascript" src="/dist/APlayer.min.js"></script>
<script type="text/javascript" src="/dist/music.js"></script>
</body>
</html>
