{%- set js_vendors = {} %}
{%- set js_vendors = js_vendors | attr('anime', 'anime.min.js') %}

{%- if theme.pjax %}
  {%- set js_vendors = js_vendors | attr('pjax', 'pjax/pjax.min.js') %}
{%- endif %}

{%- if theme.fancybox %}
  {%- set js_vendors = js_vendors | attr('jquery', '//cdn.jsdelivr.net/npm/jquery@3/dist/jquery.min.js') %}
  {%- set js_vendors = js_vendors | attr('fancybox', '//cdn.jsdelivr.net/gh/fancyapps/fancybox@3/dist/jquery.fancybox.min.js') %}
{%- endif %}

{%- if theme.mediumzoom %}
  {%- set js_vendors = js_vendors | attr('mediumzoom', '//cdn.jsdelivr.net/npm/medium-zoom@1/dist/medium-zoom.min.js') %}
{%- endif %}

{%- if theme.lazyload %}
  {%- set js_vendors = js_vendors | attr('lazyload', '//cdn.jsdelivr.net/npm/lozad@1/dist/lozad.min.js') %}
{%- endif %}

{%- if theme.pangu %}
  {%- set js_vendors = js_vendors | attr('pangu', '//cdn.jsdelivr.net/npm/pangu@4/dist/browser/pangu.min.js') %}
{%- endif %}

{%- if theme.motion.enable %}
  {%- set js_vendors = js_vendors | attr('velocity', 'velocity/velocity.min.js') %}
  {%- set js_vendors = js_vendors | attr('velocity_ui', 'velocity/velocity.ui.min.js') %}
{%- endif %}

{%- if theme.canvas_nest.enable %}
  {%- if theme.canvas_nest.onmobile %}
    {%- set canvas_nest_uri = theme.vendors.canvas_nest or next_vendors('canvas-nest/canvas-nest.min.js') %}
  {% else %}
    {%- set canvas_nest_uri = theme.vendors.canvas_nest_nomobile or next_vendors('canvas-nest/canvas-nest-nomobile.min.js') %}
  {%- endif %}
  <script color='{{ theme.canvas_nest.color }}' opacity='{{ theme.canvas_nest.opacity }}' zIndex='{{ theme.canvas_nest.zIndex }}' count='{{ theme.canvas_nest.count }}' src="{{ canvas_nest_uri }}"></script>
{%- endif %}

{%- if theme.canvas_ribbon.enable %}
  {%- set canvas_ribbon_uri = theme.vendors.canvas_ribbon or next_vendors('canvas-ribbon/canvas-ribbon.js') %}
  <script size="{{ theme.canvas_ribbon.size }}" alpha="{{ theme.canvas_ribbon.alpha }}" zIndex="{{ theme.canvas_ribbon.zIndex }}" src="{{ canvas_ribbon_uri }}"></script>
{%- endif %}

{%- for name, internal in js_vendors %}
  {%- set internal_script = next_vendors(internal) %}
  <script src="{{ theme.vendors[name] or internal_script }}"></script>
{%- endfor %}

{# Customize darkmode.js - Declaration #}
{%- if theme.darkmode_js %}
  {# another way load js from CDN
  {%- set darkmode_js_uri = theme.vendors.darkmode_js %}
  <script src="{{ darkmode_js_uri }}"></script>
  #}
  {%- set js_vendors = js_vendors | attr('darkmode_js', 'darkmode-js/lib/darkmode-js.min.js') %}
  <style>
  {# fix bug that switch button can not be clicked #}
  button.darkmode-toggle {
  z-index: 9999;
  }
  {# fix bug that image color is also inverted #}
  img, .darkmode-ignore {
    isolation: isolate;
    display: block;
  }
  </style>
{%- endif %}

{%- for name, internal in js_vendors %}
  {%- set internal_script = next_vendors(internal) %}
  <script src="{{ theme.vendors[name] or internal_script }}"></script>
{%- endfor %}
{# Customize darkmode.js - Invokation #}
{%- if theme.darkmode_js %}
<script>
var options = {
  bottom: '64px', // default: '32px'
  right: '32px', // default: '32px'
  left: 'unset', // default: 'unset'
  time: '0.5s', // default: '0.3s'
  mixColor: '#fff', // default: '#fff'
  backgroundColor: '#fff',  // default: '#fff'
  buttonColorDark: '#100f2c',  // default: '#100f2c'
  buttonColorLight: '#fff', // default: '#fff'
  saveInCookies: false, // default: true,
  label: '🌓', // default: ''
  autoMatchOsTheme: true // default: true
}
const darkmode = new Darkmode(options);
darkmode.showWidget();
// window.onload = function(){
//   setTimeout(
//     function() {
//       document.getElementsByClassName('darkmode-toggle')[0].click();
//     },
//     550,
//   );
//   document.getElementsByClassName('darkmode-toggle')[0].click();
// }
</script>
{%- endif %}