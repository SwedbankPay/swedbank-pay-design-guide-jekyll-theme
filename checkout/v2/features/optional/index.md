---
title: Optional Features
description: |
  This section details the Checkout features that are optional.
permalink: /:path/
additional: true
menu_order: 1200
anchor_headings: false
card_list:
- title: Custom Logo
  description: How to add your own logo
  url: /checkout/v2/features/optional/custom-logo
  icon:
    content: copyright
    outlined: true
- title: Delegated Strong Consumer Authentication
  description: The Checkin alternative
  url: /checkout/v2/features/optional/dsca
  icon:
    content: verified
    outlined: true
- title: Recur
  description: Setting up subscriptions and recurring payments
  url:  /checkout/v2/features/optional/recur
  icon:
    content: cached
    outlined: true
- title: TRA Exemption
  description: Transaction Risk Analysis Exemption
  url:  /checkout/v2/features/optional/tra
  icon:
    content: verified
    outlined: true
- title: Verify
  description: Validating the payer's payment details
  url:  /checkout/v2/features/optional/verify
  icon:
    content: verified_user
    outlined: true
---

## Optional Features

{% include card-list.html card_list=page.card_list
    col_class="col-lg-4" %}
