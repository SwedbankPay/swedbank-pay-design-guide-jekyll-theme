---
section: Checkout v3
title: Get Started
description: |
  **To give you a hint of how to implement our checkout in a matter that will
  make the most sense for your business, this page aims to give you a brief
  introduction to our four implementation options.**
menu_order: 200
checkout_v3: true

header:
  - table_header: Data Ownership
  - table_header: Swedbank Pay
    badge_type: default
  - table_header: Merchant Side
    badge_type: inactive
table_content:
  - icon: lock
    label: Authentication
    swedbankPay: true
  - icon: local_shipping
    label: Delivery Info
    swedbankPay: true
  - icon: assignment_ind
    label: Payer Info
    swedbankPay: true
  - icon: monetization_on
    label: PSP
    swedbankPay: true

table_content_business:
  - icon: lock
    label: Authentication
    swedbankPay: true
  - icon: local_shipping
    label: Delivery Info
    merchantSide: true
  - icon: assignment_ind
    label: Payer Info
    swedbankPay: true
  - icon: monetization_on
    label: PSP
    swedbankPay: true

table_content_enterprise:
  - icon: lock
    label: Authentication
    merchantSide: true
  - icon: local_shipping
    label: Delivery Info
    merchantSide: true
  - icon: assignment_ind
    label: Payer Info
    swedbankPay: true
  - icon: monetization_on
    label: PSP
    swedbankPay: true

table_content_payments:
  - icon: lock
    label: Authentication
    merchantSide: true
  - icon: local_shipping
    label: Delivery Info
    merchantSide: true
  - icon: assignment_ind
    label: Payer Info
    merchantSide: true
  - icon: monetization_on
    label: PSP
    swedbankPay: true

---

## Choose The Right Implementation For Your Business

The customer journey varies a lot depending on your business vertical. For
example, if you're selling physical goods - like clothes, shoes or computers,
you need to collect a delivery address. Unlike if you are selling digital goods,
where that isn't needed. But this is also a matter of which data you can and/or
wish to collect and manage yourself.

Here, you can choose between two main paths. Either you let us provide you with
a **Full Checkout** solution (including both payer identification and payment
menu) - meaning the payer themselves can choose how they'd like to pay, or you
can decide to use the **Payments Only** option. This means that you are in
charge of collecting and storing the payer data and the payment instruments to
be presented.

Regardless of whether you choose to go with the full checkout or payments only,
we will supply you with a variety of payment instruments and features which
cater to your business needs.

-   **Authentication:** The process of verifying the payer's identity.

-   **Delivery Info:** Information about where the goods should be delivered.

-   **Payer Info:** The payer’s personal data e.g. name, address, card number
    etc.

-   **PSP:** The service of providing payment instruments in the checkout.

## What Are You Looking For?

{% capture tab1_intro %}

## Full Checkout

With the **Full Checkout**, you will get access to a number of payment
instruments. selected to support the needs of the local market. We help you
collect and safely store the payer's data. If the payer agrees, we will store
their information to have it prefilled the next time they shop.
{:.heading-line}
{% endcapture %}

{% capture tab2_intro %}

## Payments Only

With our payments only package, you collect the payer data and have the
flexibility to build your own checkout flow. This implementation supports our
full range of payment instruments.
{:.heading-line}
{% endcapture %}
