---
title: Page 2
menu_order: 2
front_page:
  title: design guide theme
  hero: Welcome to the Swedbank Pay
  show_merchants_bar: false
  start_heading: Let's get you started with easy, flexible and safe payments on your e-commerce website!
hide_from_sidebar: false
layout: front-page

header:
  - table_header: Data Ownership
  - table_header: SwedbankPay
    badge_type: default
  - table_header: Merchant Side
    badge_type: inactive
table_content:
  - icon: lock
    label: Authentication
    swedbankPay: true
    merchantSide: true 
  - icon: local_shipping
    label: Delivery Info
    swedbankPay: true
    merchantSide: true 
  - icon: assignment_ind
    label: Consumer Info
    swedbankPay: true
  - icon: monetization_on
    label: PSP
    swedbankPay: true
    merchantSide: true 

table_content_authenticated:
  - icon: lock
    label: Authentication
    merchantSide: true 
  - icon: local_shipping
    label: Delivery Info
    merchantSide: true 
  - icon: assignment_ind
    label: Consumer Info
    merchantSide: true 
  - icon: monetization_on
    label: PSP
    merchantSide: true 

---

{% include card-extended.html
  title='Get to know Checkout v3'
  no_icon=true
  button_content='Get started'
  text='All businesses have their own unique needs. Which is why we have made it possible for you to adapt to a variety of those needs, using only one integration. To help you get started we have made five implementation options to choose among. In that way you can utilize your checkin in just a few configurations, or switch into any other of our stand alone payment methods - if that suits you better. Intrigued yet? Let’s find out more!'
  button_type='primary'
  button_alignment='align-self-end'
  %}

{% include card-extended.html
  title='Want to try it yourself?'
  no_icon=true
  button_content='Visit our Demoshop'
  text='Experience what it would be like to pay as a costumer of yours in our demoshop.'
  button_type='primary'
  button_alignment='align-self-start'
  container_content='![demoshop](/assets/img/demoshop-image.svg)'

  %}

{%- capture table-content -%}
{%- endcapture -%}
{% include card-extended.html
  title='Standard'
  icon_content='shopping_cart'
  icon_outlined=true
  button_content='Proceed'
  text='We collect and verify the identity of your consumer. We also collect the billing and shipping address and we store the consumer information. With our PSP you are always able to choose one ore more payment methods.'
  table_content=page.table_content
  header=page.header
  button_type='secondary'
  button_alignment='align-self-end'
  to='/checkout'
  %}

{% include card-extended.html
  title='Authenticated'
  icon_content='shopping_cart'
  icon_outlined=true
  button_content='Proceed'
  text='We collect and verify the identity of your consumer. We also collect the billing and shipping address and we store the consumer information. With our PSP you are always able to choose one ore more payment methods.'
  table_content=page.table_content_authenticated
  header=page.header
  button_type='secondary'
  button_alignment='align-self-end'
  to='/checkout'
%}

{% contentfor release_notes %}
  <h2 id="front-page-release-notes" class="heading-line heading-line-green">What's new in the documentation</h2>
  {% include release_notes.html num_dates=3 %}
  <a href="/resources/release-notes">See full release notes</a>
{% endcontentfor %}

{% contentfor extras %}
  <h2 id="front-page-extra-resources" class="heading-line">Extra resources</h2>
  <div class="row mt-4">
      <div class="{{ card_col_class }}">
          {% include card.html title='OS development guidelines'
              text='This is how we create an inclusive environment'
              icon_content='account_circle'
              icon_outlined=true
              to=''
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='Test data'
              text='Get the required data for testing in our interfaces'
              icon_content='content_paste'
              to=''
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='Terminology'
          text='Get a better understanding of the terms we use'
          icon_content='menu_book'
          to=''
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='See all resources (7)'
              text='Data protection, public migration key etc'
              no_icon=true
              to=''
          %}
      </div>
  </div>
{% endcontentfor %}
