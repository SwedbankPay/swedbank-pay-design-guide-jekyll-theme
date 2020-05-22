var tipuesearch = {"pages": [{
    "title": "After payment is completed",
    "text": "After paaaayment Payment is done? Great, here is what will happen now. First we’ll subtract the money from your account, then a wizard will attempt a grand spell to carry the money on the back of ants to transfer it to a safe place. A secret place. A place with a secret.",
    "tags": "",
    "url": "/pages/SwedbankPay/swedbank-pay-design-guide-jekyll-theme/checkout/after-payment.html"
  },{
    "title": "Creditting?",
    "text": "Don’t read this If you see this. It means you are credited.",
    "tags": "",
    "url": "/pages/SwedbankPay/swedbank-pay-design-guide-jekyll-theme/payments/credit.html"
  },{
    "title": "Checkout",
    "text": "You’d like to checko out Great! Just check in first and we’ll get you sorted.",
    "tags": "",
    "url": "/pages/SwedbankPay/swedbank-pay-design-guide-jekyll-theme/checkout/"
  },{
    "title": "Secret payments",
    "text": "How we do secret payments We don’t.",
    "tags": "",
    "url": "/pages/SwedbankPay/swedbank-pay-design-guide-jekyll-theme/payments/secrets/"
  },{
    "title": "Payments",
    "text": "Woah bby Here we list a few details about payment",
    "tags": "",
    "url": "/pages/SwedbankPay/swedbank-pay-design-guide-jekyll-theme/payments/"
  },{
    "title": "Index",
    "text": "Text can be bold, italic, or strikethrough. External absolute full link External protocol relative link Internal absolute full link Internal explicit relative link Internal implicit relative link Internal absolute link There should be whitespace between paragraphs. There should be whitespace between paragraphs. We recommend including a README, or a file with information about your project. Header 2 This is a normal paragraph following a header. GitHub is a code hosting platform for version control and collaboration. It lets you and others work together on projects from anywhere. This is a blockquote following a header. When something is important enough, you do it even if the odds are not in your favor. Header 3 JavaScript code with syntax highlighting. 1 2 3 4 var fun = function lang(l) { dateformat.i18n = require('./lang/' + l) return true; } HTTP request 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 POST /psp/consumers HTTP/1.1 Host: api.externalintegration.payex.com Authorization: Bearer &lt;AccessToken&gt; Content-Type: application/json { \"operation\": \"initiate-consumer-session\", \"msisdn\": \"+4798765432\", \"email\": \"olivia.nyhuus@example.com\", \"consumerCountryCode\": \"NO\", \"nationalIdentifier\": { \"socialSecurityNumber\": \"26026708248\", \"countryCode\": \"NO\" } } Response 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 HTTP/1.1 200 OK Content-Type: application/json { \"payment\": \"/psp/creditcard/payments/\", \"authorization\": { \"direct\": true, \"cardBrand\": \"Visa\", \"cardType\": \"Credit\", \"issuingBank\": \"Utl. Visa\", \"paymentToken\": \"\", \"maskedPan\": \"454778******3329\", \"expiryDate\": \"12/2020\", \"panToken\": \"cca2d98d-8bb3-4bd6-9cf3-365acbbaff96\", \"panEnrolled\": true, \"acquirerTransactionTime\": \"0001-01-01T00:00:00Z\", \"id\": \"/psp/creditcard/payments/7e6cdfc3-1276-44e9-9992-7cf4419750e1/authorizations/ec2a9b09-601a-42ae-8e33-a5737e1cf177\", \"transaction\": { \"id\": \"/psp/creditcard/payments/7e6cdfc3-1276-44e9-9992-7cf4419750e1/transactions/ec2a9b09-601a-42ae-8e33-a5737e1cf177\", \"created\": \"2020-03-10T13:15:01.9586254Z\", \"updated\": \"2020-03-10T13:15:02.0493818Z\", \"type\": \"Authorization\", \"state\": \"AwaitingActivity\", \"number\": 70100366758, \"amount\": 4201, \"vatAmount\": 0, \"description\": \"Test transaction\", \"payeeReference\": \"1583846100\", \"isOperational\": true, \"operations\": [ { \"method\": \"GET\", \"href\": \"https://api.stage.payex.com/psp/creditcard/confined/payments/authorizations/authenticate/ec2a9b09-601a-42ae-8e33-a5737e1cf177\", \"rel\": \"redirect-authentication\" } ] } } } JSON 1 2 3 4 5 6 7 8 9 10 { \"operation\": \"initiate-consumer-session\", \"msisdn\": \"+4798765432\", \"email\": \"olivia.nyhuus@example.com\", \"consumerCountryCode\": \"NO\", \"nationalIdentifier\": { \"socialSecurityNumber\": \"26026708248\", \"countryCode\": \"NO\" } } Here’s some &lt;inline&gt; { \"code\": true } that should .be { highlighted: according; } to their language. Header 4 This is an unordered list following a header. This is an unordered list following a header. This is an unordered list following a header. Header 5 This is an ordered list following a header. This is an ordered list following a header. This is an ordered list following a header. Header 6 Here’s a nice, striped table. head1 head two three ok good swedish fish nice out of stock good and plenty nice ok good oreos hmm ok good zoute drop yumm Mermaid sequenceDiagram participant Merchant participant SwedbankPay activate SwedbankPay SwedbankPay-&gt;&gt;Merchant: POST &lt;callbackUrl&gt; activate Merchant note right of SwedbankPay: Callback POST by SwedbankPay Merchant-&gt;&gt;SwedbankPay: Callback response deactivate Merchant deactivate SwedbankPay activate Merchant Merchant-&gt;&gt;SwedbankPay: GET &lt;payment instrument&gt; payment note left of Merchant: First API request activate SwedbankPay SwedbankPay--&gt;&gt;Merchant: payment resource deactivate SwedbankPay deactivate Merchant Alerts This is a standard alert. check_circle This is a successful alert. info_outline Informational alert This is an informational alert with &lt;markdown/&gt;. warning { \"warning\": \"alert\" } This is a warning alert with &lt;markdown/&gt;. Jumbotron PayEx Checkout is a complete reimagination of the checkout experience, integrating seamlessly into the merchant website through highly customizable and flexible components. Visit our demoshop and try out PayEx Checkout for yourself! Iterator Next Previous Go back Go forward There’s a horizontal rule below this Here is an unordered list Item foo Item bar Item baz Item zip And an ordered list Item one Item two Item three Item four And a nested list level 1 item level 2 item level 2 item level 3 item level 3 item level 1 item level 2 item level 2 item level 2 item level 1 item level 2 item level 2 item level 1 item Small image Large image Definition lists can be used with HTML syntax Name Godzilla Born 1952 Birthplace Japan Color Green 1 Long, single-line code blocks should not wrap. They should horizontally scroll if they are too long. This line should be long enough to demonstrate this. 1 The final element. Emoji support :+1: :heavy_check_mark: :fire: 💡 :unicorn: Material design icons check line_weight gavel visibility work PlantUML clientappdb",
    "tags": "",
    "url": "/pages/SwedbankPay/swedbank-pay-design-guide-jekyll-theme/"
  },{
    "title": "Invoicing",
    "text": "Invoices It’s a weird thing this invoice, some like it, most dont. I have no particularly strong feeling seeing that I am just text on a page.",
    "tags": "",
    "url": "/pages/SwedbankPay/swedbank-pay-design-guide-jekyll-theme/payments/invoice.html"
  },{
    "title": "Page 1",
    "text": "",
    "tags": "",
    "url": "/pages/SwedbankPay/swedbank-pay-design-guide-jekyll-theme/page1.html"
  },{
    "title": "Page 2",
    "text": "",
    "tags": "",
    "url": "/pages/SwedbankPay/swedbank-pay-design-guide-jekyll-theme/page2.html"
  },{
    "title": "Search",
    "text": "Hidden true.",
    "tags": "",
    "url": "/pages/SwedbankPay/swedbank-pay-design-guide-jekyll-theme/search.html"
  },{
    "title": "Secrets in payments",
    "text": "Don’t render this Payments have plenty of secrets due to it being secure and mostly encrypted. Only the end user and their bank can really see much data if any. We in between mostly see tokens.",
    "tags": "",
    "url": "/pages/SwedbankPay/swedbank-pay-design-guide-jekyll-theme/payments/secrets/super-secret.html"
  }]};
