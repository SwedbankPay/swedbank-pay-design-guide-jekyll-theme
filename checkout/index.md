---
section: Checkout
title: Introduction
estimated_read: 10
description: |
    Swedbank Pay Checkout is a complete reimagination
    of the checkout experience, integrating seamlessly into the merchant website
    through highly customizable and flexible components.
menu_order: 4
card_list:
- card_title: Initiate session for consumer identification
  estimated_read: 15
  url: /checkout/checkin
- card_title: Display Swedbank Pay checkin module
  estimated_read: 10
  url: /checkout/checkin#step-2-display-swedbank-pay-checkin-module
- card_title: Create payment order
  estimated_read: 18
  url:
- card_title: Display the Payment Menu
  estimated_read: 13
  url:
- card_title: Capture the funds
  estimated_read: 10
  url:
---

{% comment %}
Examples on how site.pages can be filtered and used with
card-list/card-horizontal-list. Can also be used with pre-defined lists, such as
card_list in front matter above.
{% endcomment %}

{:.heading-line}
## Core implementation overview

{% assign core_card_list = site.pages | where: 'dir', page.dir | where: 'core', true |
where_exp: 'page', 'page.name != "index.md"' | sort: 'menu_order' %}

{% include card-horizontal-list.html card_list=page.card_list %}

{:.heading-line}
## Additional features

{% assign additional_card_list = site.pages |
where_exp: 'page', 'page.url != "/checkout/" and page.core != true and page.dir contains "/checkout/"'
| where: 'additional', true | sort: 'menu_order'
%}

{% include card-list.html card_list=additional_card_list
    col_class="col-lg-6 col-md-6 col-sm-6"
%}
