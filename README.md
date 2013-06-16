# Simple BDD

Simple BDD offers basic Behaviour Driven Development language syntax. It enables tests to take steps to become more declaritive than imperiative by hiding the implementation and revealing test intent. It can be used in any test framework as it's just a way to keep the collaborative business language within a test by calling methods which directly relate to the step in the test.


## Installation

Add this line to your application's Gemfile:

    gem 'simple_bdd'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_bdd

## Basic Usage

The following will call the 'something_happens' method in scope of the current class or module.  

	[Gg]iven "Some state" # calls some_state
	[Ww]hen "this happens" # calls this_happens
	[Tt]hen "this change occurs" #calls this_change_occurs
	[Aa]nd "this other side effect happens" #this_other_side_effect_happens

## Named Noun Usage

The named nouns feature lets you write more general functions to handle multiple
SimpleBDD test directives.

First, you set up your named nouns:

``` let_named!(:snape, :professor, FactoryGirl.create(:professor, name: 'Severus Snape')) ```

Then, when you use the word "Snape" in a test directive, SimpleBDD will look for methods matching
"snape" or methods matching "professor."  For instance:

```
describe MyClass do
    let_named!(:apple, :fruit, Apple.new)
    let_named!(:strawberry, :fruit, Strawberry.new)

    it "Apples burn strawberries" do
        Given "Apple is on fire" # calls apple_is_on_fire
        Then "Strawberry gets burned" # calls fruit_gets_burned
    end

    it "Strawberries burn strawberries" do
        Given "Strawberry is on fire" # calls fruit_is_on_fire
        Then "Strawberry gets burned" # calls fruit_gets_burned
    end

    def apple_is_on_fire
        # ...
    end

    # Take an options hash to see the named_nouns that
    # were passed to your method.
    def fruit_is_on_fire opts
        opts # => {fruit: <Strawberry>}
    end

    def fruit_gets_burned
        # ...
    end
end
```
	
## RSpec

You'll need to require SimpleBDD in the spec helper and include it into your tests like so:

	require 'simple_bdd'

	RSpec.configure do |config|
  	  config.include SimpleBdd
	end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
