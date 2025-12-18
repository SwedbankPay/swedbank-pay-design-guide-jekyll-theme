---
title: Page 2
menu_order: 4
front_page:
  title: developer portal
  hero: Welcome to the Swedbank Pay
  ingress: Here you'll find the full toolbox for how to integrate our payment solutions and acquaint yourself with their different features and functionalities.
  show_merchants_bar: false
  start_heading: Let's get you started with easy, flexible and safe payments on your e-commerce website!
hide_from_sidebar: false
layout: front-page
sidebar_icon: filter_2

---

{% assign card_col_class="col-xl-6 col-lg-6" %}

{% contentfor release_notes %}
  <h2 id="front-page-release-notes">What's new in the documentation</h2>
  {% include release_notes.html num_of_releases_to_display=3 %}
  <a href="/resources/release-notes">See full release notes</a>
{% endcontentfor %}

{% contentfor extras %}
  <h2 id="front-page-extra-resources">Extra resources</h2>
  <div class="row mt-4">
      <div class="{{ card_col_class }}">
          {% include card.html title='OS development guidelines'
              description='This is how we create an inclusive environment'
              icon_content='at-account'
              url='#'
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='Test data'
              description='Get the required data for testing in our interfaces'
              icon_content='at-clipboard'
              url='#'
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='Terminology'
          description='Get a better understanding of the terms we use'
          icon_content='at-book'
          url='#'
          %}
      </div>
      <div class="{{ card_col_class }}">
          {% include card.html title='See all resources (7)'
              description='Data protection, public migration key etc'
              no_icon=true
              url='#'
          %}
      </div>
  </div>
{% endcontentfor %}
