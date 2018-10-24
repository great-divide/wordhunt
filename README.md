# Wordhunt

This little gem scrapes the Internet Archive's mirror of the Gutenberg Project for the full text of classic works of literature in the public domain. The user can then enter a word and then Wordhunt searches those texts for that word and returns the full sentences in which the word occurred. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wordhunt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wordhunt

## Usage

Locate the constant WORD_ARRAY to customize the list of vocabulary words that Wordhunt can search for. You can run the gem locally with the './bin/wordhunt' command. Some of the sentences will not be great, others will be memorable and potentially hilarious.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/wordhunt. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as under the terms of the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) license. (https://creativecommons.org/licenses/by-nc-sa/4.0/).

## Code of Conduct

Everyone interacting in the Wordhunt project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/wordhunt/blob/master/CODE_OF_CONDUCT.md).
