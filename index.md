---
title: Index
description: The index page
---

Text can be **bold**, _italic_, or ~~strikethrough~~.

* [External absolute full link](https://www.wikipedia.org)
* [External protocol relative link](//www.wikipedia.org)
* [Internal absolute full link]({{ site.url }})
* [Internal explicit relative link](./page1)
* [Internal implicit relative link](page1)
* [Internal absolute link](/page1)

There should be whitespace between paragraphs.

There should be whitespace between paragraphs. We recommend including a README, or a file with information about your project.

## Header 2

This is a normal paragraph following a header. GitHub is a code hosting platform for version control and collaboration. It lets you and others work together on projects from anywhere.

> This is a blockquote following a header.
>
> When something is important enough, you do it even if the odds are not in your favor.

### Header 3

{:.code-header}
**JavaScript code with syntax highlighting.**

```js
var fun = function lang(l) {
  dateformat.i18n = require('./lang/' + l)
  return true;
}
```

{:.code-header}
**HTTP request**

```http
POST /psp/consumers HTTP/1.1
Host: api.externalintegration.payex.com
Authorization: Bearer <AccessToken>
Content-Type: application/json

{
    "operation": "initiate-consumer-session",
    "msisdn": "+4798765432",
    "email": "olivia.nyhuus@example.com",
    "consumerCountryCode": "NO",
    "nationalIdentifier": {
        "socialSecurityNumber": "26026708248",
        "countryCode": "NO"
    }
}
```

{:.code-header}
**Response**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "payment": "/psp/creditcard/payments/{{ page.payment_id }}",
    "authorization": {
        "direct": true,
        "cardBrand": "Visa",
        "cardType": "Credit",
        "issuingBank": "Utl. Visa",
        "paymentToken": "{{ page.payment_token }}",
        "maskedPan": "454778******3329",
        "expiryDate": "12/2020",
        "panToken": "cca2d98d-8bb3-4bd6-9cf3-365acbbaff96",
        "panEnrolled": true,
        "acquirerTransactionTime": "0001-01-01T00:00:00Z",
        "id": "/psp/creditcard/payments/7e6cdfc3-1276-44e9-9992-7cf4419750e1/authorizations/ec2a9b09-601a-42ae-8e33-a5737e1cf177",
        "transaction": {
            "id": "/psp/creditcard/payments/7e6cdfc3-1276-44e9-9992-7cf4419750e1/transactions/ec2a9b09-601a-42ae-8e33-a5737e1cf177",
            "created": "2020-03-10T13:15:01.9586254Z",
            "updated": "2020-03-10T13:15:02.0493818Z",
            "type": "Authorization",
            "state": "AwaitingActivity",
            "number": 70100366758,
            "amount": 4201,
            "vatAmount": 0,
            "description": "Test transaction",
            "payeeReference": "1583846100",
            "isOperational": true,
            "operations": [
                {
                    "method": "GET",
                    "href": "https://api.stage.payex.com/psp/creditcard/confined/payments/authorizations/authenticate/ec2a9b09-601a-42ae-8e33-a5737e1cf177",
                    "rel": "redirect-authentication"
                }
            ]
        }
    }
}
```

{:.code-header}
**JSON**

```json
{
    "operation": "initiate-consumer-session",
    "msisdn": "+4798765432",
    "email": "olivia.nyhuus@example.com",
    "consumerCountryCode": "NO",
    "nationalIdentifier": {
        "socialSecurityNumber": "26026708248",
        "countryCode": "NO"
    }
}
```

Here's some `<inline>`{:.language-html .highlight}
`{ "code": true }`{:.language-js .highlight}
that should `.be { highlighted: according; }`{:.language-css .highlight} to their
language.

#### Header 4

* This is an unordered list following a header.
* This is an unordered list following a header.
* This is an unordered list following a header.

##### Header 5

1. This is an ordered list following a header.
2. This is an ordered list following a header.
3. This is an ordered list following a header.

###### Header 6

Here's a nice, striped table.

{:.table .table-striped}
| head1        | head two          | three |
| :----------- | :---------------- | :---- |
| ok           | good swedish fish | nice  |
| out of stock | good and plenty   | nice  |
| ok           | good `oreos`      | hmm   |
| ok           | good `zoute` drop | yumm  |

## Mermaid

```mermaid
sequenceDiagram
    participant Merchant
    participant SwedbankPay

    activate SwedbankPay
        SwedbankPay->>Merchant: POST <callbackUrl>
        activate Merchant
            note right of SwedbankPay: Callback POST by SwedbankPay
            Merchant->>SwedbankPay: Callback response
        deactivate Merchant
    deactivate SwedbankPay

    activate Merchant
        Merchant->>SwedbankPay: GET <payment instrument> payment
        note left of Merchant: First API request
        activate SwedbankPay
            SwedbankPay-->>Merchant: payment resource
        deactivate SwedbankPay
    deactivate Merchant
```

## Alerts

{% include alert.html body='This is a standard alert.' %}

{% include alert.html type='success'
                      icon='check_circle'
                      body='This is a successful alert.' %}

{% include alert.html icon='info_outline'
                      header='**Informational** *alert*'
                      body='This is an **informational** alert *with* `<markdown/>`{:.language-html}.' %}

{% include alert.html type='warning'
                      icon='warning'
                      header='`{ "warning": "alert" }`{:.language-js}'
                      body='This is a **warning** alert with `<markdown/>`{:.language-html}.' %}

## Jumbotron

{% include jumbotron.html body='**PayEx Checkout** is a complete reimagination
of the checkout experience, integrating seamlessly into the merchant website
through highly customizable and flexible components.

Visit our [demoshop](https://ecom.externalintegration.payex.com/pspdemoshop)
and try out PayEx Checkout for yourself!' %}

## Iterator

{% include iterator.html next_href="page2" %}
{% include iterator.html prev_href="page1" %}
{% include iterator.html prev_href="page1"
                         prev_title="Go back"
                         next_href="page2"
                         next_title="Go forward" %}

## There's a horizontal rule below this

* * *

## Here is an unordered list

* Item foo
* Item bar
* Item baz
* Item zip

## And an ordered list

1. Item one
1. Item two
1. Item three
1. Item four

## And a nested list

* level 1 item
  * level 2 item
  * level 2 item
    * level 3 item
    * level 3 item
* level 1 item
  * level 2 item
  * level 2 item
  * level 2 item
* level 1 item
  * level 2 item
  * level 2 item
* level 1 item

## Small image

![Octocat](https://github.githubassets.com/images/icons/emoji/octocat.png)

## Large image

![Branching](https://guides.github.com/activities/hello-world/branching.png)

## Definition lists can be used with HTML syntax

<dl>
    <dt>Name</dt>
    <dd>Godzilla</dd>
    <dt>Born</dt>
    <dd>1952</dd>
    <dt>Birthplace</dt>
    <dd>Japan</dd>
    <dt>Color</dt>
    <dd>Green</dd>
</dl>

```
Long, single-line code blocks should not wrap. They should horizontally scroll if they are too long. This line should be long enough to demonstrate this.
```

```
The final element.
```

## Emoji support

:+1: :heavy_check_mark: :fire: 💡 :unicorn:

## Material design icons

{% icon check %} {% icon line_weight %} {% icon gavel %} {% icon visibility %}
{% icon work %}

## PlantUML

```plantuml
@startuml
actor client
node app
database db
db -> app
app -> client
@enduml
```

More complex example:

```plantuml
@startuml
    actor Payer
    participant Merchant
    participant SwedbankPay
    participant 3rdParty

    box
        note left of Payer: Checkin

        Payer --> Merchant: Start Checkin
        Merchant --> SwedbankPay: POST /psp/consumers
        deactivate Merchant
        SwedbankPay --> Merchant: rel:view-consumer-identification ①
        deactivate SwedbankPay
        Merchant --> Payer: Show Checkin on Merchant Page

        Payer -> Payer: Initiate Consumer Hosted View (open iframe) ②
        Payer -> SwedbankPay: Show Consumer UI page in iframe ③
        deactivate Payer
        SwedbankPay -> Payer: Consumer identification process
        activate Payer
        Payer -> SwedbankPay: Consumer identification process
        deactivate Payer
        SwedbankPay --> Payer: show consumer completed iframe
        activate Payer
        Payer ->> Payer: EVENT: onConsumerIdentified (consumerProfileRef) ④
        deactivate Payer
    end box

    box
        note left of Payer: Payment Menu
        Payer -> Merchant: Initiate Purchase
        deactivate Payer
        Merchant -> SwedbankPay: POST /psp/paymentorders (paymentUrl, consumerProfileRef)
        deactivate Merchant
        SwedbankPay --> Merchant: rel:view-paymentorder
        deactivate SwedbankPay
        Merchant --> Payer: Display Payment Menu on Merchant Page
        activate Payer
        Payer ->> Payer: Initiate Payment Menu Hosted View (open iframe)
        Payer --> SwedbankPay: Show Payment UI page in iframe
        deactivate Payer
        SwedbankPay -> Payer: Do payment logic
        deactivate SwedbankPay
        Payer ->> SwedbankPay: Do payment logic
        deactivate Payer

        opt Consumer perform payment out of iFrame
            Payer ->> Payer: Redirect to 3rd party
            Payer -> 3rdParty: Redirect to 3rdPartyUrl URL
            deactivate Payer
            3rdParty --> Payer: Redirect back to paymentUrl (merchant)
            deactivate 3rdParty
            Payer ->> Payer: Initiate Payment Menu Hosted View (open iframe)
            Payer -> SwedbankPay: Show Payment UI page in iframe
            deactivate Payer
        end

        SwedbankPay -->> Payer: Payment status

        alt If payment is completed
            activate Payer
            Payer ->> Payer: Event: onPaymentCompleted
            Payer -> Merchant: Check payment status
            deactivate Payer
            Merchant -> SwedbankPay: GET <paymentorder.id>
            deactivate Merchant
            SwedbankPay -> Merchant: rel: paid-paymentorder
            deactivate SwedbankPay
            opt Get PaymentOrder Details (if paid-paymentorder operation exist)
            activate Payer
            deactivate Payer
            Merchant -> SwedbankPay: GET rel: paid-paymentorder
            deactivate Merchant
            SwedbankPay -->> Merchant: Payment Details
            deactivate SwedbankPay
        end

    end box

    opt If payment is failed
        activate Payer
        Payer ->> Payer: Event: OnPaymentFailed
        Payer -> Merchant: Check payment status
        deactivate Payer
        Merchant -> SwedbankPay: GET {paymentorder.id}
        deactivate Merchant
        SwedbankPay --> Merchant: rel: failed-paymentorder

        deactivate SwedbankPay
        opt Get PaymentOrder Details (if failed-paymentorder operation exist)
            activate Payer
            deactivate Payer
            Merchant -> SwedbankPay: GET rel: failed-paymentorder
            deactivate Merchant
            SwedbankPay -->> Merchant: Payment Details
            deactivate SwedbankPay
        end
    end

    activate Merchant
    Merchant --> Payer: Show Purchase complete
    opt PaymentOrder Callback (if callbackUrls is set)
        activate Payer
        deactivate Payer
            SwedbankPay ->> Merchant: POST Payment Callback
    end

    box
        activate Merchant
        note left of Payer: Capture
        Merchant -> SwedbankPay: rel:create-paymentorder-capture
        deactivate Merchant
        SwedbankPay --> Merchant: Capture status
        note right of Merchant: Capture here only if the purchased<br/>goods don't require shipping.<br/>If shipping is required, perform capture<br/>after the goods have shipped.<br>Should only be used for <br>PaymentInstruments that support <br>Authorizations.
    end box
@enduml
```
