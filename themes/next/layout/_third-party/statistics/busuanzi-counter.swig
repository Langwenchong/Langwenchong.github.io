{%- if theme.busuanzi_count.enable %}
<div class="busuanzi-count">
  <script{{ pjax }} async src="https://busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"></script>
  {% if theme.busuanzi_count.enable %}
  <script async src="https://busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"></script>
  
  {%- if theme.busuanzi_count.total_visitors %}
    <span class="site-uv">
       {{ __('footer.total_visitors', '<span class="busuanzi-value" id="busuanzi_value_site_uv"></span>') }}
  {%- endif %}

  {%- if theme.busuanzi_count.total_views %}
    <span class="site-pv">
      {{ __('footer.total_views', '<span class="busuanzi-value" id="busuanzi_value_site_pv"></span>') }}
    </span>
  {%- endif %}
  {%- endif %}
</div>
{%- endif %}
