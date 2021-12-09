<!-- lint disable no-undefined-references -->
{%- assign design_guide_url = include.design_guide_url -%}
{%- capture startup_image_configs -%}
640,1136,1,640x1136
750,1334,1,750x1334
828,1792,1,828x1792
1125,2436,1,1125x2436
1136,640,1,1136x640
1242,2208,1,1242x2208
1242,2688,1,1242x2688
1334,750,1,1334x750
1536,2048,1,1536x2048
1620,2160,1,1620x2160
1668,2224,1,1668x2224
1668,2388,1,1668x2388
1792,828,1,1792x828
2048,1536,1,2048x1536
2048,2732,1,2048x2732
2160,1620,1,2160x1620
2208,1242,1,2208x1242
2224,1668,1,2224x1668
2388,1668,1,2388x1668
2436,1125,1,2436x1125
2688,1242,1,2688x1242
2732,2048,1,2732x2048
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
        design_guide_url=design_guide_url -%}
{%- endfor -%}
