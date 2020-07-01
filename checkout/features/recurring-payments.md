---
title:  Recurring payments
description: |
    See what other features you can implement for your checkout
menu-order: 2
---

## Recurring Payments

If you want to enable subsequent recurring – server-to-server – payments, you
need to create a **recurrence token**. This token will be utilized after the
initial payment order. **Recurring payments must be activated on the contract
with Swedbank Pay in order to work.**

### Recurrence Token

*   When initiating a `Purchase` payment order, you need to make sure that the
    field `generateRecurrenceToken` is set to `true`. This recurrence token
    will stored in the authorization transaction
    sub-resource on the underlying payment resource.
*   When initiating a `Verify` payment order, a recurrence token will be
    generated automatically. This recurrence token is stored in the
    verification  sub-resource on the underlying
    payment resource.

You can view the current payment resource, containg the recurrence token and
other payment instrument properties, by expanding the sub-resource
[`currentpayment`][current-payment] when doing a `GET` request on the
`paymentorders` resource.

{:.code-view-header}
**Request**

```http
GET /psp/paymentorders/{{ page.payment_order_id }}?$expand=currentpayment HTTP/1.1
Host: {{ page.api_host }}
```

### Creating Recurring Payments

When you have a `recurrenceToken` token safely tucked away, you can use this
token in a subsequent `Recur` payment order. This will be a server-to-server
affair, as we have tied all necessary payment instrument details related to the
recurrence token during the initial payment order.

## Recurring Payments 2

If you want to enable subsequent recurring – server-to-server – payments, you
need to create a **recurrence token**. This token will be utilized after the
initial payment order. **Recurring payments must be activated on the contract
with Swedbank Pay in order to work.**

### Recurrence Token 2

*   When initiating a `Purchase` payment order, you need to make sure that the
    field `generateRecurrenceToken` is set to `true`. This recurrence token
    will stored in the authorization transaction
    sub-resource on the underlying payment resource.
*   When initiating a `Verify` payment order, a recurrence token will be
    generated automatically. This recurrence token is stored in the
    verification sub-resource on the underlying
    payment resource.

You can view the current payment resource, containg the recurrence token and
other payment instrument properties, by expanding the sub-resource
[`currentpayment`][current-payment] when doing a `GET` request on the
`paymentorders` resource.

{:.code-view-header}
**Request**

```http
GET /psp/paymentorders/{{ page.payment_order_id }}?$expand=currentpayment HTTP/1.1
Host: {{ page.api_host }}
```

### Creating Recurring Payments 2

When you have a `recurrenceToken` token safely tucked away, you can use this
token in a subsequent `Recur` payment order. This will be a server-to-server
affair, as we have tied all necessary payment instrument details related to the
recurrence token during the initial payment order.

## Recurring Payments 3

If you want to enable subsequent recurring – server-to-server – payments, you
need to create a **recurrence token**. This token will be utilized after the
initial payment order. **Recurring payments must be activated on the contract
with Swedbank Pay in order to work.**

### Recurrence Token 3

*   When initiating a `Purchase` payment order, you need to make sure that the
    field `generateRecurrenceToken` is set to `true`. This recurrence token
    will stored in the authorization transaction
    sub-resource on the underlying payment resource.
*   When initiating a `Verify` payment order, a recurrence token will be
    generated automatically. This recurrence token is stored in the
    verification sub-resource on the underlying
    payment resource.

You can view the current payment resource, containg the recurrence token and
other payment instrument properties, by expanding the sub-resource
[`currentpayment`][current-payment] when doing a `GET` request on the
`paymentorders` resource.

{:.code-view-header}
**Request**

```http
GET /psp/paymentorders/{{ page.payment_order_id }}?$expand=currentpayment HTTP/1.1
Host: {{ page.api_host }}
```

### Creating Recurring Payments 3

When you have a `recurrenceToken` token safely tucked away, you can use this
token in a subsequent `Recur` payment order. This will be a server-to-server
affair, as we have tied all necessary payment instrument details related to the
recurrence token during the initial payment order.
