{% comment -%}
TODO: Figure out how to use front matter with proper arrays instead of split
strings.
{%- endcomment -%}
{% assign design_guide_version_url = include.design_guide_version_url %}
{%- assign sizes = "57, 60, 72, 76, 114, 120, 144, 152, 167, 180, 1024" | split: ',' -%}
{%- for size in sizes -%}
    {%- include apple-touch-icon.html size=size design_guide_version_url=design_guide_version_url -%}
{%- endfor -%}
