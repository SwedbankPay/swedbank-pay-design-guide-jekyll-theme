---
section: Checkout v3
title: Get Started
description: |
  **Before moving on we would like to give you a brief introduction to what you need
  to consider before composing your checkout page, along with some prerequisites.**
menu_order: 300
checkout_v3: true

header:
  - table_header: Data Ownership
  - table_header: SwedbankPay
    badge_type: default
  - table_header: Merchant Side
    badge_type: inactive
table_content:
  - label: Authentication
    swedbankPay: true
  - label: Delivery Info
    swedbankPay: true
  - label: Consumer Info
    swedbankPay: true
  - label: PSP
    swedbankPay: true

table_content_authenticated:
  - label: Authentication
    swedbankPay: true
  - label: Delivery Info
    merchantSide: true 
  - label: Consumer Info
    swedbankPay: true
  - label: PSP
    swedbankPay: true
---

## Choose The Right Implementation For Your Business

Truth is, the customer journey varies a lot depending on your business
vertical. For example, if you're selling physical goods like clothes, shoes or
computers, you need to collect the address of the consumer for shipping
purposes. Unlike if you were selling digital goods, where that's simply not
necessary. But it also comes down to what you are able and wish to manage
yourself.

When building your checkout page you have two main paths. Either you let us
provide you with the entire checkout solution. This includes consumer
identification and payment menu, where your customer themselves can choose how
to pay. Or, you can choose to only use our payment option (also called the
payment menu), where you are in charge of collecting and storing the customer
data.

Regardless if you choose our checkout or payments only option, you will always
be able to decide which payment options are available for the consumer. Hence
you can show all available payment options for that specific market, or just one
or two if that makes more sense for your business.

-   **Consumer Info:** The consumer's personal data e.g. name, address, phone
    number etc.

-   **Authentication:** The process for verifying the consumer's identity via
    Strong Consumer Authentication (e.g. BankID).

-   **Delivery Info:** Information about where the goods should be delivered.

-   **PSP:** The service of providing payment methods in the checkout or payment
    menu.
