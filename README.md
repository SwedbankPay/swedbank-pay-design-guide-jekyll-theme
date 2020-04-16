# Swedbank Pay Design Guide Theme for Jekyll

![Swedbank Pay Design Guide Theme for Jekyll][opengraph-image]

This repository hosts the Swedbank Pay Design Guide theme for Jekyll, used for
[Swedbank Pay on GitHub][swedbankpay] among other things.

## Contributing

Bug reports and pull requests are welcome on [GitHub][repo]. This project is
intended to be a safe, welcoming space for collaboration, and contributors are
expected to adhere to the [Contributor Covenant][cc] code of conduct as well as
[PayEx Open Source Development Guidelines][dev-guide].

## Usage

To view this theme, browse to [swedbankpay.github.io][swedbankpay]. If you'd
like to host it locally on your computer, you have to options, manual install
or [Docker][docker]:

### Manual install

1. [Clone this repository][clone].
2. Jekyll is written in [Ruby][ruby], so you'll need to download and install
   that.
3. To install the [Ruby Gems][gems] this web site requires, you first need to
   install [Bundler][bundler].
4. Once Ruby and Bundler is in place, type `bundle install` inside the root
   folder of this repository.
5. Run `bundle exec jekyll serve` to start the website.
6. Open `http://localhost:4000` in a browser.

### Docker

1. Install [Docker][docker], using Linux containers.
   Make sure virtualization is enabled on your machine.
2. Open a console window at the root of the repository and run
   `docker-compose up --build`

### Required Visual Studio Code plugins

* `davidanson.vscode-markdownlint`, to lint Markdown files according to our
  defined set of rules.
* `shd101wyy.markdown-preview-enhanced`, to render Markdown to HTML in a
  preview window.
* `bpruitt-goddard.mermaid-markdown-syntax-highlighting`, to give syntax
  highlighting to Mermaid diagrams in Markdown files.
* `yzhang.markdown-all-in-one`, to enable a plethora of Markdown features,
  most importantly formatting of Markdown tables with VS Code's built-in
  format functionality.
* `stkb.rewrap`, to make line-breaking text at 80 characters easier.
* `supperchong.pretty-json` to format selected JSON snippets in code
  examples.
* `sissel.shopify-liquid` for syntax highlighting of [Liquid][liquid].
* [Set up a ruler at 80 characters][vsc-ruler] by
  adding `"editor.rulers": [80]` to its configuration.

Jekyll should now be fired up with this theme. You can now add pages, documents,
data, etc. like normal to test your theme's contents. As you make modifications
to your theme and to your content, the site will regenerate and you should see
the changes in the browser after a refresh, just like normal.

When the theme is released, only the files in `_layouts`, `_includes`, `_sass`
and `assets` tracked with Git will be bundled. To add a custom directory to your
theme-gem, please edit the regexp in `swedbankpay.gemspec` accordingly.

## License

This website is available as open source under the terms of the
[MIT License][license].

[bundler]: https://bundler.io/
[cc]: http://contributor-covenant.org
[clone]: https://help.github.com/articles/cloning-a-repository/
[dev-guide]: https://developer.swedbankpay.com/resources/development-guidelines/
[docker]: https://www.docker.com/
[gems]: <https://rubygems.org/>
[license]: <https://opensource.org/licenses/MIT>
[liquid]: <https://jekyllrb.com/docs/liquid/>
[opengraph-image]: <https://repository-images.githubusercontent.com/209270355/36818080-53ee-11ea-896c-082addb851a6>
[repo]: <https://github.com/SwedbankPay/swedbank-pay-design-guide-jekyll-theme/>
[ruby]: <https://www.ruby-lang.org/en/>
[swedbankpay]: <https://swedbankpay.github.io/swedbank-pay-design-guide-jekyll-theme/>
[vsc-ruler]: https://stackoverflow.com/questions/29968499/vertical-rulers-in-visual-studio-code
