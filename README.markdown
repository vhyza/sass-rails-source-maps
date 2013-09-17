# Sass Rails Source Maps

This gem allows you to see your Rails 4 `.scss` source files in Google Chrome inspector, which can be useful for debugging.

`debug_info` option available in stable [sass](http://sass-lang.com/) gem is no longer working in Google Chrome, because Chrome now supports Source Map [v3](https://docs.google.com/document/d/1U1RGAehQwRypUTovF1KRlpiOFze0b-_2gc6fAH0KY0k) only.

## Installation

Add this to your application's Gemfile :

````ruby
group :development do
  gem 'sass-rails-source-maps'
end
````

And then execute:

    $ bundle update sass

to use `sass` gem with Source Maps v3 support, which is currently pre-release version.

After that, run:

    $ rm -rf tmp/cache/assets
    $ rm -rf public/assets

to make Rails regenerate assets. After assets regeneration, `assets/source_maps` containing `sass` source maps is created in `public` directory.

## Usage

To see something like this ![screenshot](https://www.evernote.com/shard/s36/sh/d0c3c46e-d9e7-47d0-b23b-118ca1c77add/d2268cefa01e273ecfda4aba600c8640/res/c14f6a6d-c418-4bdd-80c2-5025dc035221/skitch.png?resizeSmall&width=832) you need to enable source maps in Google Chrome.

To enable source maps open Chrome inspector go to [chrome://flags/#enable-devtools-experiments](chrome://flags/#enable-devtools-experiments) and `Enable Developer Tools experiments`. Then restart Google Chrome.

After restart, go to inspector `experimental` settings and enable `Sass stylesheet debugging` and finally in general settings check `Enable source maps`.

![experimental settings](https://www.evernote.com/shard/s36/sh/323d6df5-e5a5-467d-89bb-2e933800292a/aba9bcbf79b533e3ab625e9dc8961f61/res/f90634d7-2267-4a53-8a84-0e4baafd56d4/skitch.png?resizeSmall&width=832)

![general settings](https://www.evernote.com/shard/s36/sh/7fc204d3-b0b2-47a7-9df9-d2d03f08fb2c/46dab5f794b32ede79b9c482b21ca9fa/res/bc1ba16c-e08f-41b4-9417-23c1384b89d9/skitch.png?resizeSmall&width=832)

Enabling source maps may vary in different Chrome versions. For more info please see [Working with CSS Preprocessors](https://developers.google.com/chrome-developer-tools/docs/css-preprocessors); part _Using Sass with CSS source maps_.

## Notes
* This gem is Rails 4 compatible only
* If you wan't to see `coffeescript` files in Google Chrome inspector you can use [coffee-rails-source-maps](https://github.com/markbates/coffee-rails-source-maps) gem.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
