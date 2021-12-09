---
title: Cards
estimated_read: 30
description: Cards, cards and more cards!
menu_order: 0
card_overview: true
---

{% include card.html title='Default'
    text='This is a default card'
    icon_content='credit_card'
    to='deck1/card1'
%}
{% include card.html title='SDK'
    text='This is a .dx-card-sdk card'
    icon_content='settings'
    type='sdk'
    to='deck1/card1'
%}
{% include card.html title='module'
    text='This is a .dx-card-module card. This also has outlined icon'
    icon_content='build'
    icon_outlined=true
    type='module'
    to='/#cards'
%}
{% include card.html title='Horizontal'
    title_type='h3'
    text='This is a dx-card-horizontal card. Icons used with this card are just numbers'
    icon_content='01'
    horizontal=true
    to='/#cards'
%}
