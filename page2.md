---
title: Page 2
menu_order: 2
front_page:
  title: developer portal
  hero: Welcome to the Swedbank Pay
  ingress: Here you'll find the full toolbox for how to integrate our payment solutions and acquaint yourself with their different features and functionalities.
  show_merchants_bar: false
  start_heading: Let's get you started with easy, flexible and safe payments on your e-commerce website!
hide_from_sidebar: false
layout: front-page

---

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
