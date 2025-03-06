---
title: Cards
description: Cards, cards and more cards!
menu_order: 2
card_overview: true
sidebar_icon: dashboard
---

{% include card.html title='Default'
    description='This is a default card'
    icon_content='at-credit-card'
    url='deck1/card1'
%}
{% include card.html title='SDK'
    description='This is a .dx-card-sdk card'
    icon_content='at-settings'
    type='sdk'
    url='deck1/card1'
%}
{% include card.html title='module'
    description='This is a .dx-card-module card. This also has outlined icon'
    icon_content='at-build'
    type='module'
    url='/#cards'
%}
{% include card.html title='Use wide card'
    title_type='h3'
    description='This is a dx-card-horizontal card. Icons used with this card are just numbers'
    icon_content='01'
    use_wide=true
    url='/#cards'
%}
