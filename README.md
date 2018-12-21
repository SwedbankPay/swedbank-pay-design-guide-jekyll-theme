# PayEx Design Guide Theme for Jekyll

This repository hosts the PayEx Design Guide theme for Jekyll, used for
[PayEx on GitHub][1] among other things.

## Usage

To view this theme, browse to [payex.github.io][1]. If you'd like to host it
locally on your computer, you need to do the following:

1. [Clone this repository][4].
2. Jekyll is written in [Ruby][5], so you'll need to download and install that.
3. To install the [Ruby Gems][6] this web site requires, you first need to
   install [Bundler][7].
4. Once Ruby and Bundler is in place, type `bundle install` inside the root
   folder of this repository.
5. Run `bundle exec jekyll serve` to start the website.
6. Open `http://localhost:4000` in a browser.

Jekyll should now be fired up with this theme. You can now add pages,
documents, data, etc. like normal to test your theme's contents. As you make
modifications to your theme and to your content, the site will regenerate and
you should see the changes in the browser after a refresh, just like normal.

When the theme is released, only the files in `_layouts`, `_includes`, `_sass`
and `assets` tracked with Git will be bundled. To add a custom directory to
your theme-gem, please edit the regexp in `payex.gemspec` accordingly.

## Contributing

Bug reports and pull requests are welcome on [GitHub][8]. This project is
intended to be a safe, welcoming space for collaboration, and contributors
are expected to adhere to the [Contributor Covenant][9] code of conduct as
well as [PayEx Open Source Development Guidelines][10].

## License

This website is available as open source under the terms of the
[MIT License][11].

[1]: https://payex.github.io
[2]: https://jekyllrb.com/
[3]: https://pages.github.com/
[4]: https://help.github.com/articles/cloning-a-repository/
[5]: https://www.ruby-lang.org/en/
[6]: https://rubygems.org/
[7]: https://bundler.io/
[8]: https://github.com/PayEx/payex.github.io/
[9]: http://contributor-covenant.org
[10]: https://developer.payex.com/xwiki/wiki/developer/view/Main/guidelines/open-source-development-guidelines/
[11]: https://opensource.org/licenses/MIT