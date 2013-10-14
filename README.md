# RescueTimeApi

Ruby wrapper for the [RescueTime data API](https://www.rescuetime.com/anapi/setup/documentation)

## Installation

Add this line to your application's Gemfile:

    gem 'rescue_time_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rescue_time_api

## Usage

You'll need a key from RescueTime's [API Key Management](https://www.rescuetime.com/anapi/manage) page. Once you've got one, create a client instance like this:

```ruby
client = RescueTimeApi::Client.new(key: 'notanactualkey123456')
```

Make requests using the parameters described in [RescueTime's documentation](https://www.rescuetime.com/anapi/setup/documentation). Pass parameters as a hash with either strings or symbols as keys.

```ruby
client.request({
  prespective: 'interval',
  resolution_time: 'day'
})
```

The only transformations applied to the parameter hash is to add the `format` value (json), the `key` value, and to change any date type parameters into a correctly formatted day string (YYYY-MM-DD). So this will work:

```ruby
client.request({
  prespective: 'interval',
  restrict_begin: DateTime.now
})
```

The `#request` method returns a `RescueTimeApi::Response` object. Use its `#rows` method to access the returned data as an array of hashes with simplified keys:

```ruby
RescueTimeApi::Client > request({}).rows
=> [
    {"rank"=>1,
    "seconds"=>5887,
    "people"=>1,
    "activity"=>"sublime text",
    "categoty"=>"Editing & IDEs",
    "productivity"=>2},
   {"rank"=>2,
    "seconds"=>5668,
    "people"=>1,
    "activity"=>"iTerm",
    "categoty"=>"Systems Operations",
    "productivity"=>2},
   {"rank"=>3,
    "seconds"=>4131,
    "people"=>1,
    "activity"=>"github.com",
    "categoty"=>"General Software Development",
    "productivity"=>1},
    <...>
  ]
```

`date` keys are returned as `DateTime`s.

## REPL

You can launch a [Pry](http://pryrepl.org/) REPL to play with the client interactively:

  $ rescue_time_api notanactualkey123456

```ruby

RescueTimeApi::Client >
RescueTimeApi::Client > request({prespective: 'interval'})
=> #<RescueTimeApi::Response:0x007f976b143e58...
```

## Tests

They're in RSpec.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
