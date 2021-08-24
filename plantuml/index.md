---
title: PlantUML
description: PlantUML Diagrams
---

## Network Diagram

```plantuml
@startuml "Network"
    actor client
    node app
    database db
    queue queue
    cloud cloud
    usecase usecase
    rectangle rectangle
    package package
    folder folder
    frame frame
    card card
    file file

    db -> app
    app -> queue
    queue -> cloud
    cloud <- client
@enduml
```

## Sequence Diagrams

```plantuml
@startuml "Sequence"
    title "Checkout Sequence"
    $participant("payer", "Payer") as Payer
    $participant("merchant", "Merchant") as Merchant
    $participant("server", "Swedbank Pay") as SwedbankPay
    $participant("3rdparty", "3rd Party") as 3rdParty

    group Checkin
        Payer --> Merchant: Start Checkin
        activate Payer
            activate Merchant
                Merchant --> SwedbankPay: $code("POST /psp/consumers")
                activate SwedbankPay
                    SwedbankPay --> Merchant: $code("rel:view-consumer-identification") ①
                deactivate SwedbankPay
                Merchant --> Payer: Show Checkin on Merchant Page
            deactivate Merchant

            SwedbankPay <-> Payer: Consumer identification process
        deactivate Payer

        activate SwedbankPay
            SwedbankPay ->> Merchant: $code("onConsumerIdentified(consumerProfileRef)") ④
        deactivate SwedbankPay
        activate Merchant
        deactivate Merchant
    end group

    group#fff #ebf8f2 Payment Menu
        Payer -> Merchant: Initiate Purchase
        deactivate Payer
        Merchant -> SwedbankPay: $code("POST /psp/paymentorders { paymentUrl, consumerProfileRef }")
        deactivate Merchant
        SwedbankPay --> Merchant: $code("rel:view-paymentorder")
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
            opt#fff $brand_primary_light_2 Get PaymentOrder Details (if $code("paid-paymentorder") operation exist)
                activate Merchant
                    Merchant -> SwedbankPay: $code("GET rel:paid-paymentorder.href")
                    activate SwedbankPay
                        SwedbankPay -->> Merchant: Payment Details
                    deactivate SwedbankPay
                deactivate Merchant
            end
        end
    end group

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

    group Capture
        note left of Merchant
            Capture here only if the purchased goods don't require shipping.
            If shipping is required, perform capture after the goods have
            shipped. Should only be used for PaymentInstruments that support
            Authorizations.
        end note

        Merchant -> Merchant: Capture
        activate Merchant
            Merchant -> SwedbankPay: GET {paymentorder.id}
            activate SwedbankPay
                SwedbankPay --> Merchant: paymentorder
                Merchant -> SwedbankPay: rel:create-paymentorder-capture
                SwedbankPay --> Merchant: Capture status
            deactivate SwedbankPay
        deactivate Merchant
    end group
@enduml
```
