# Sass Rails Source Maps

__NOTE__: This gem requires `sass-rails` version `5.0.0`

This gem allows you to see your Rails 4 `.scss` source files in Google Chrome inspector, which can be useful for debugging.

`debug_info` option available in stable [sass](http://sass-lang.com/) gem is no longer working in Google Chrome, because Chrome now supports Source Map [v3](https://docs.google.com/document/d/1U1RGAehQwRypUTovF1KRlpiOFze0b-_2gc6fAH0KY0k) only.

## Installation

Source Maps are supported by `sass` gem in version `3.3` and higher. Unfortunately, `sass-rails`, the `rails` dependency, freezes `sass` gem to version `~> 3.2.0`. To use this gem, you need to follow these steps:

* Add `sass-rails-source-maps` to your application's Gemfile :

````ruby
group :development do
  gem 'sass-rails-source-maps'
end
````

This branch depends on `sass-rails` version `5.0.0` which has more relaxed dependency for `sass` gem. So to avoid version conflict you need to:

* Unfreeze `sass-rails` gem in your Gemfile (delete version for `sass-rails`)

For example, in new `Rails 4.1.5` application change line

    gem 'sass-rails', '~> 4.0.3'

to

    gem 'sass-rails'

in your `Gemfile`.

* And then execute:

````
bundle update sass-rails
````

* After that, run:

````
rake assets:clobber
````

to make Rails regenerate assets. After assets regeneration, `assets/source_maps` containing `sass` source maps is created in `public` directory.

## Usage

If everything works fine, you should see something like this ![screenshot](https://dl.dropboxusercontent.com/u/21012539/screenshots/screenshot.png)

Enabling source maps may vary in different Chrome versions. For more info please see [Working with CSS Preprocessors](https://developer.chrome.com/devtools/docs/css-preprocessors#toc-enabling-css-source-maps).

## Notes
* This gem is not intended for production usage.
* This gem is Rails 4.x compatible only
* If you wan't to see `coffeescript` files in Google Chrome inspector you can use [coffee-rails-source-maps](https://github.com/markbates/coffee-rails-source-maps) gem.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
