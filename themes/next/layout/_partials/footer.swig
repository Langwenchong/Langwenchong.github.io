{%- if theme.footer.beian.enable %}
  <div class="beian">
    {{- next_url('https://beian.miit.gov.cn', theme.footer.beian.icp + ' ') }}
    {%- if theme.footer.beian.gongan_icon_url %}
      <img src="{{ url_for(theme.footer.beian.gongan_icon_url) }}" style="display: inline-block;">
    {%- endif %}
    {%- if theme.footer.beian.gongan_id and theme.footer.beian.gongan_num %}
      {{- next_url('http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=' + theme.footer.beian.gongan_id, theme.footer.beian.gongan_num + ' ') }}
    {%- endif %}
  </div>
{%- endif %}

<div class="copyright">
  {% set copyright_year = date(null, 'YYYY') %}
  &copy; {% if theme.footer.since and theme.footer.since != copyright_year %}{{ theme.footer.since }} – {% endif %}
  <span itemprop="copyrightYear">{{ copyright_year }}</span>
  <span class="with-love">
    <i class="{{ theme.footer.icon.name }}"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ theme.footer.copyright or author }}</span>
</div>
  <!--{%- if config.symbols_count_time.total_symbols %}
    <span class="post-meta-divider">|</span>
    <span class="post-meta-item-icon">
      <i class="fa fa-chart-area"></i>
    </span>
    {%- if theme.symbols_count_time.item_text_total %}
      <span class="post-meta-item-text">{{ __('symbols_count_time.count_total') + __('symbol.colon') }}</span>
    {%- endif %}
    <span title="{{ __('symbols_count_time.count_total') }}">{{ symbolsCountTotal(site) }}</span>
  {%- endif %}

  {%- if config.symbols_count_time.total_time %}
    <span class="post-meta-divider">|</span>
    <span class="post-meta-item-icon">
      <i class="fa fa-coffee"></i>
    </span>
    {%- if theme.symbols_count_time.item_text_total %}
      <span class="post-meta-item-text">{{ __('symbols_count_time.time_total') }} &asymp;</span>
    {%- endif %}
    <span title="{{ __('symbols_count_time.time_total') }}">{{ symbolsTimeTotal(site, config.symbols_count_time.awl, config.symbols_count_time.wpm, __('symbols_count_time.time_minutes')) }}</span>
  {%- endif %}
</div>-->

<!--{%- if theme.footer.powered %}
  <div class="powered-by">
    {%- set next_site = 'https://theme-next.org' %}
    {%- if theme.scheme !== 'Gemini' %}
      {%- set next_site = 'https://' + theme.scheme | lower + '.theme-next.org' %}
    {%- endif %}
    {{- __('footer.powered', next_url('https://hexo.io', 'Hexo', {class: 'theme-link'}) + ' & ' + next_url(next_site, 'NexT.' + theme.scheme, {class: 'theme-link'})) }}
  </div>
{%- endif %}-->

{%- if theme.footer.badge %}
<style>
  .github-badge {
      display:inline-block;
      border-radius:4px;
      text-shadow:none;
      font-size:13px;
      color:#fff;
      line-height:15px;
      margin-bottom:5px;
  }
  .github-badge a{
      display: inline-block;
      margin: 0 1px 5px;
      border:none!important;
  }
  .github-badge .badge-subject {
      display:inline-block;
      background-color:#4D4D4D;
      padding:4px 4px 4px 6px;
      border-top-left-radius:4px;
      border-bottom-left-radius:4px;
  }
  .github-badge .badge-value {
      display:inline-block;
      padding:4px 6px 4px 4px;
      border-top-right-radius:4px;
      border-bottom-right-radius:4px;
  }
  .github-badge .bg-brightgreen {
      background-color:#4DC820 !important;
  }
  .github-badge .bg-orange {
      background-color:#FFA500 !important;
  }
  .github-badge .bg-yellow {
      background-color:#D8B024 !important;
  }
  .github-badge .bg-blueviolet {
      background-color:#8833D7 !important;
  }
  .github-badge .bg-pink {
      background-color:#F26BAE !important;
  }
  .github-badge .bg-red {
      background-color:#e05d44 !important;
  }
  .github-badge .bg-blue {
      background-color:#007EC6 !important;
  }
  .github-badge .bg-lightgrey {
      background-color:#9F9F9F !important;
  }
  .github-badge .bg-grey, .github-badge .bg-gray {
      background-color:#555 !important;
  }
  .github-badge .bg-lightgrey, .github-badge .bg-lightgray {
      background-color:#9f9f9f !important;
  }
</style>
<div class="github-badge">
  <a style="color: #fff"  href="https://hexo.io/" target="_blank" title="由 Hexo 强力驱动">
    <span class="badge-subject">Powered</span><span class="badge-value bg-blue">Hexo</span>
  </a>
  <a style="color: #fff" href="https://cloud.tencent.com/" target="_blank" title="静态网页托管于 腾讯云" >
    <span class="badge-subject">Hosted</span><span class="badge-value bg-brightgreen">TencentCloud</span>
  </a>
  <a style="color: #fff" href="https://fontawesome.com/icons" target="_blank" title="本站所有icon图标来自于 fontawesome" >
    <span class="badge-subject">Decorated</span><span class="badge-value bg-orange">Fontawesome</span></a>
  <a style="color: #fff" href="https://github.com/next-theme/hexo-theme-next" target="_blank" title="站点使用 Nextv8.0 Muse 主题" >
    <span class="badge-subject">Theme</span><span class="badge-value bg-blue">Nextv8.0 Muse</span>
  </a>
  <a style="color: #fff" href="http://creativecommons.org/licenses/by-nc-sa/4.0/" target="_blank" title="本站点采用知识共享署名-非商业性使用-相同方式共享 4.0 国际许可协议进行许可">
    <span class="badge-subject"><i class="fa fa-copyright"></i></span><span class="badge-value bg-lightgrey">BY-NC-SA 4.0</span>
  </a>
</div>
{%- endif %}

{%- if theme.add_this_id %}
  <div class="addthis_inline_share_toolbox">
    <script src="//s7.addthis.com/js/300/addthis_widget.js#pubid={{ theme.add_this_id }}" async="async"></script>
  </div>
{%- endif %}

{{- next_inject('footer') }}
