{%- assign design_guide_version_url = include.design_guide_version_url -%}
{%- capture startup_image_configs -%}
320,480,1,320x460
320,480,2,640x920
320,568,2,640x1096
375,667,2,750x1294
414,736,3,1182x2208,landscape
414,736,3,1242x2148,portrait
768,1024,1,748x1024,landscape
768,1024,1,768x1004,portrait
768,1024,2,1496x2048,landscape
768,1024,2,1536x2008,portrait
{%- endcapture -%}
{%- assign startup_image_configs = startup_image_configs | newline_to_br | split: '<br />' -%}
{%- for startup_image_config in startup_image_configs -%}
    {%- assign values = startup_image_config | split: ',' -%}
    {%- assign width = values[0] -%}
    {%- assign height = values[1] -%}
    {%- assign pixel_ratio = values[2] -%}
    {%- assign size = values[3] -%}
    {%- if values.size > 3 -%}
        {% assign orientation = values[4] -%}
    {%- endif -%}
    {%- include apple-touch-startup-image.html
        width=width
        height=height
        pixel_ratio=pixel_ratio
        size=size
        orientation=orientation
        design_guide_version_url=design_guide_version_url -%}
{%- endfor -%}
