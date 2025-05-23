---
title: Core Features
description: |
  This section details the Checkout features that are essential for the payment
  process.
icon:
  content: remove_red_eye
additional: true
menu_order: 1100
card_list:
- title: 3-D Secure 2
  description: Authenticating the cardholder
  url:  /checkout/v3/dsca/features/core/3d-secure-2
  icon:
    content: 3d_rotation
- title: Cancel
  description: Cancelling the authorization and releasing the funds
  url: /checkout/v3/dsca/features/core/cancel
  icon:
    content: pan_tool
    outlined: true
- title: Capture
  description: Capturing the authorized funds
  url: /checkout/v3/dsca/features/core/payment-order-capture
  icon:
    content: compare_arrows
    outlined: true
- title: Reversal
  description: How to reverse a payment
  url: /checkout/v3/dsca/features/core/reversal
  icon:
    content: keyboard_return
    outlined: true
- title: Settlement & Reconciliation
  description: Balancing the books
  url:  /checkout/v3/dsca/features/core/settlement-reconciliation
  icon:
    content: description
    outlined: true
---

## Core Features

{% include card-list.html card_list=page.card_list
    col_class="col-lg-4" %}
