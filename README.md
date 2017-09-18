# ActiveModel::Attribute [![Build Status](https://travis-ci.org/frodsan/active_model-attribute.svg)](https://travis-ci.org/frodsan/active_model-attribute)

Declares attributes for Active Model objects.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "active_model-attribute"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_model-attribute

## Usage

```ruby
class User
  include ActiveModel::Attribute

  attribute :name, :string
  attribute :position, :string
  attribute :age, :integer
  attribute :active, :boolean

  alias_attribute :full_name, :name
end

user = User.new(
  name: 'Bob',
  position: 'Developer',
  age: '42',
  active: false
)

user.age
# => 42

user.age.class
# => Integer

user.full_name
# => 'Bob'

user.active?
# => false
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
